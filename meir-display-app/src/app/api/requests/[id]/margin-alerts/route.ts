import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'

// GET /api/requests/[id]/margin-alerts — fetch margin discrepancy alerts for a display
export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { id } = params

    const { data: alerts, error } = await supabase
      .from('margin_alerts')
      .select('*')
      .eq('request_id', id)
      .order('month_year', { ascending: true })

    if (error) {
      console.error('Margin alerts query error:', error)
      return NextResponse.json({ error: 'Failed to fetch alerts' }, { status: 500 })
    }

    return NextResponse.json(alerts || [])
  } catch (error) {
    console.error('GET /api/requests/[id]/margin-alerts error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}

// POST /api/requests/[id]/margin-alerts/acknowledge — mark an alert as acknowledged
export async function POST(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Verify manager+
    const { data: userData } = await supabase
      .from('users')
      .select('id, role')
      .eq('email', user.email)
      .single()

    if (!userData || !['manager', 'cfo', 'coo', 'admin'].includes(userData.role)) {
      return NextResponse.json({ error: 'Manager access required' }, { status: 403 })
    }

    const body = await request.json()
    const { alert_id } = body

    if (!alert_id) {
      return NextResponse.json({ error: 'alert_id required' }, { status: 400 })
    }

    const serviceClient = createServiceClient()
    const { error } = await serviceClient
      .from('margin_alerts')
      .update({
        acknowledged_by: userData.id,
        acknowledged_at: new Date().toISOString(),
      })
      .eq('id', alert_id)
      .eq('request_id', params.id)

    if (error) {
      return NextResponse.json({ error: 'Failed to acknowledge alert' }, { status: 500 })
    }

    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('POST /api/requests/[id]/margin-alerts error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
