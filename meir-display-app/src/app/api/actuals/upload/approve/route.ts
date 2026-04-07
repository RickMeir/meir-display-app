import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { completeTask } from '@/lib/tasks'

// POST: approve an upload — triggers refresh_monthly_actuals
export async function POST(request: NextRequest) {
  try {
    const supabase = await createClient()
    const {
      data: { user },
    } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const serviceClient = createServiceClient()
    const { data: userData } = await serviceClient
      .from('users')
      .select('id, role')
      .eq('email', user.email)
      .single()

    // Only admin (Rick) can approve uploads
    if (!userData || userData.role !== 'admin') {
      return NextResponse.json(
        { error: 'Only admin can approve uploads' },
        { status: 403 }
      )
    }

    const body = await request.json()
    const { uploadId } = body as { uploadId: string }

    if (!uploadId) {
      return NextResponse.json({ error: 'Missing uploadId' }, { status: 400 })
    }

    // Verify the upload exists and is pending approval
    const { data: upload, error: fetchErr } = await serviceClient
      .from('sales_uploads')
      .select('id, filename, approval_status, matched_rows')
      .eq('id', uploadId)
      .single()

    if (fetchErr || !upload) {
      return NextResponse.json({ error: 'Upload not found' }, { status: 404 })
    }

    if (upload.approval_status === 'approved') {
      return NextResponse.json({ error: 'Upload already approved' }, { status: 400 })
    }

    // Now commit: refresh monthly actuals from matched rows, then detect margin alerts
    if (upload.matched_rows > 0) {
      await serviceClient.rpc('refresh_monthly_actuals', { p_upload_id: uploadId })

      // Detect margin discrepancies (compares actual COGS% vs approved COGS%)
      const { data: alertCount } = await serviceClient.rpc('detect_margin_alerts', { p_upload_id: uploadId })
      if (alertCount && alertCount > 0) {
        console.log(`Margin alerts generated: ${alertCount} discrepancies found for upload ${uploadId}`)
      }
    }

    // Update the upload record
    await serviceClient
      .from('sales_uploads')
      .update({
        approval_status: 'approved',
        approved_by: userData.id,
        approved_at: new Date().toISOString(),
      })
      .eq('id', uploadId)

    // Complete any associated approval tasks
    const { data: tasks } = await serviceClient
      .from('user_tasks')
      .select('id')
      .eq('related_entity_type', 'sales_upload')
      .eq('related_entity_id', uploadId)
      .eq('task_type', 'approve_upload')
      .eq('status', 'pending')

    if (tasks) {
      for (const task of tasks) {
        await completeTask(task.id, userData.id)
      }
    }

    // Audit log
    await serviceClient.from('audit_log').insert({
      action: 'upload_approved',
      entity_type: 'sales_upload',
      entity_id: uploadId,
      user_id: userData.id,
      details: {
        filename: upload.filename,
        matched_rows: upload.matched_rows,
      },
    })

    return NextResponse.json({
      data: {
        approved: true,
        upload_id: uploadId,
        filename: upload.filename,
      },
    })
  } catch (err) {
    console.error('Approve upload error:', err)
    return NextResponse.json(
      { error: `Server error: ${err instanceof Error ? err.message : 'Unknown error'}` },
      { status: 500 }
    )
  }
}
