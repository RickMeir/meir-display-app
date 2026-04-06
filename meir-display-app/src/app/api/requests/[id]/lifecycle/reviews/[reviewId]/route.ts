import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'

// POST /api/requests/[id]/lifecycle/reviews/[reviewId]
// Complete a lifecycle review — calculates the performance snapshot
// and records notes and actions taken.
// Body: { notes?: string, action_taken?: string }

export async function POST(
  request: NextRequest,
  { params }: { params: { id: string; reviewId: string } }
) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { id, reviewId } = params
    const body = await request.json()
    const { notes, action_taken } = body

    // Verify user is a manager or above
    const { data: userData } = await supabase
      .from('users')
      .select('id, role')
      .eq('email', user.email)
      .single()

    if (!userData || !['manager', 'cfo', 'coo', 'admin'].includes(userData.role)) {
      return NextResponse.json({ error: 'Insufficient permissions' }, { status: 403 })
    }

    const serviceClient = createServiceClient()

    // Verify the review exists and belongs to this request
    const { data: review, error: revError } = await serviceClient
      .from('lifecycle_reviews')
      .select('*')
      .eq('id', reviewId)
      .eq('request_id', id)
      .single()

    if (revError || !review) {
      return NextResponse.json({ error: 'Review not found' }, { status: 404 })
    }

    if (review.completed_at) {
      return NextResponse.json(
        { error: 'This review has already been completed' },
        { status: 400 }
      )
    }

    // Calculate the performance snapshot
    await serviceClient.rpc('calculate_review_snapshot', { p_review_id: reviewId })

    // Fetch the updated review (with calculated values)
    const { data: updatedReview } = await serviceClient
      .from('lifecycle_reviews')
      .select('*')
      .eq('id', reviewId)
      .single()

    // Mark as completed with notes
    const { data: finalReview, error: updateError } = await serviceClient
      .from('lifecycle_reviews')
      .update({
        completed_at: new Date().toISOString(),
        completed_by: userData.id,
        notes: notes || null,
        action_taken: action_taken || null,
      })
      .eq('id', reviewId)
      .select()
      .single()

    if (updateError) {
      console.error('Update review error:', updateError)
      return NextResponse.json({ error: 'Failed to complete review' }, { status: 500 })
    }

    // Update the tracking_status on the display request based on this review
    if (updatedReview?.tracking_assessment) {
      await serviceClient
        .from('display_requests')
        .update({ tracking_status: updatedReview.tracking_assessment })
        .eq('id', id)
    }

    // Audit log
    await serviceClient.from('audit_log').insert({
      request_id: id,
      action: 'lifecycle_review_completed',
      performed_by: userData.id,
      details: {
        review_id: reviewId,
        interval: review.interval,
        tracking_assessment: updatedReview?.tracking_assessment,
        variance_pct: updatedReview?.variance_pct,
        expected_cumulative: updatedReview?.expected_revenue_cumulative,
        actual_cumulative: updatedReview?.actual_revenue_cumulative,
      },
    })

    // TODO: If off_track, send notification to rep, manager, and COO
    // This will use the existing Resend email infrastructure

    return NextResponse.json(finalReview)
  } catch (error) {
    console.error('POST lifecycle review error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}

// GET /api/requests/[id]/lifecycle/reviews/[reviewId]
// Get a single lifecycle review with its performance snapshot recalculated.

export async function GET(
  request: NextRequest,
  { params }: { params: { id: string; reviewId: string } }
) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { id, reviewId } = params
    const serviceClient = createServiceClient()

    // Recalculate snapshot before returning
    await serviceClient.rpc('calculate_review_snapshot', { p_review_id: reviewId })

    const { data: review, error } = await serviceClient
      .from('lifecycle_reviews')
      .select('*')
      .eq('id', reviewId)
      .eq('request_id', id)
      .single()

    if (error || !review) {
      return NextResponse.json({ error: 'Review not found' }, { status: 404 })
    }

    return NextResponse.json(review)
  } catch (error) {
    console.error('GET lifecycle review error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
