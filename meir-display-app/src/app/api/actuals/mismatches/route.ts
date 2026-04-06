import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'

// GET: list unmatched customers, optionally filtered by upload_id
export async function GET(request: NextRequest) {
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

    if (!userData || !['admin', 'coo', 'cfo', 'manager', 'validator'].includes(userData.role)) {
      return NextResponse.json({ error: 'Insufficient permissions' }, { status: 403 })
    }

    const { searchParams } = new URL(request.url)
    const uploadId = searchParams.get('upload_id')

    // Get unmatched raw rows, grouped by customer name
    let query = serviceClient
      .from('sales_actuals_raw')
      .select('customer_name, customer_code, customer_group, upload_id')
      .is('matched_request_id', null)

    if (uploadId) {
      query = query.eq('upload_id', uploadId)
    }

    const { data: rawRows, error } = await query

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    // Group by customer name and aggregate
    const grouped: Record<
      string,
      {
        customer_name: string
        customer_code: string
        customer_group: string
        row_count: number
        upload_ids: Set<string>
      }
    > = {}

    for (const row of rawRows || []) {
      const key = row.customer_name.toLowerCase().trim()
      if (!grouped[key]) {
        grouped[key] = {
          customer_name: row.customer_name,
          customer_code: row.customer_code || '',
          customer_group: row.customer_group || '',
          row_count: 0,
          upload_ids: new Set(),
        }
      }
      grouped[key].row_count++
      grouped[key].upload_ids.add(row.upload_id)
    }

    // Convert to array and sort by row count descending
    const unmatched = Object.values(grouped)
      .map((g) => ({
        customer_name: g.customer_name,
        customer_code: g.customer_code,
        customer_group: g.customer_group,
        row_count: g.row_count,
        upload_count: g.upload_ids.size,
      }))
      .sort((a, b) => b.row_count - a.row_count)

    // Also get all display requests for the assignment dropdown
    const { data: displays } = await serviceClient
      .from('display_requests')
      .select('id, store_name, store_code, status')
      .in('status', ['approved', 'validated', 'pending_approval', 'submitted'])
      .order('store_name')

    // Get existing aliases for context
    const { data: aliases } = await serviceClient
      .from('customer_aliases')
      .select('id, acumatica_name, display_request_id, created_at, notes')
      .order('created_at', { ascending: false })

    return NextResponse.json({
      data: {
        unmatched,
        displays: displays || [],
        aliases: aliases || [],
        total_unmatched_rows: (rawRows || []).length,
      },
    })
  } catch (err) {
    console.error('Mismatches GET error:', err)
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}

// POST: create an alias and re-match existing raw rows
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

    if (!userData || !['admin', 'coo', 'cfo', 'manager'].includes(userData.role)) {
      return NextResponse.json({ error: 'Insufficient permissions' }, { status: 403 })
    }

    const body = await request.json()
    const { customerName, displayRequestId, notes } = body as {
      customerName: string
      displayRequestId: string
      notes?: string
    }

    if (!customerName || !displayRequestId) {
      return NextResponse.json(
        { error: 'Missing customerName or displayRequestId' },
        { status: 400 }
      )
    }

    // Create the alias
    const { data: alias, error: aliasErr } = await serviceClient
      .from('customer_aliases')
      .upsert(
        {
          acumatica_name: customerName,
          display_request_id: displayRequestId,
          created_by: userData.id,
          notes: notes || null,
        },
        { onConflict: 'acumatica_name,display_request_id' }
      )
      .select('id')
      .single()

    if (aliasErr) {
      return NextResponse.json(
        { error: `Failed to create alias: ${aliasErr.message}` },
        { status: 500 }
      )
    }

    // Re-match existing unmatched raw rows with this customer name
    const { data: updated, error: updateErr } = await serviceClient
      .from('sales_actuals_raw')
      .update({
        matched_request_id: displayRequestId,
        match_method: 'alias',
      })
      .eq('customer_name', customerName)
      .is('matched_request_id', null)
      .select('id')

    if (updateErr) {
      console.error('Failed to re-match rows:', updateErr)
    }

    const rowsMatched = updated?.length || 0

    // Update the upload records' matched/unmatched counts
    // Get distinct upload_ids for the affected rows
    if (rowsMatched > 0) {
      const { data: affectedUploads } = await serviceClient
        .from('sales_actuals_raw')
        .select('upload_id')
        .eq('customer_name', customerName)
        .eq('match_method', 'alias')

      const uploadIds = Array.from(
        new Set((affectedUploads || []).map((r: { upload_id: string }) => r.upload_id))
      )

      for (const uid of uploadIds) {
        // Recount matched/unmatched for this upload
        const { count: matchedCount } = await serviceClient
          .from('sales_actuals_raw')
          .select('*', { count: 'exact', head: true })
          .eq('upload_id', uid)
          .not('matched_request_id', 'is', null)

        const { count: unmatchedCount } = await serviceClient
          .from('sales_actuals_raw')
          .select('*', { count: 'exact', head: true })
          .eq('upload_id', uid)
          .is('matched_request_id', null)

        await serviceClient
          .from('sales_uploads')
          .update({
            matched_rows: matchedCount || 0,
            unmatched_rows: unmatchedCount || 0,
          })
          .eq('id', uid)

        // If the upload is approved, refresh monthly actuals
        const { data: uploadRecord } = await serviceClient
          .from('sales_uploads')
          .select('approval_status')
          .eq('id', uid)
          .single()

        if (uploadRecord?.approval_status === 'approved') {
          await serviceClient.rpc('refresh_monthly_actuals', { p_upload_id: uid })
        }
      }
    }

    // Audit log
    await serviceClient.from('audit_log').insert({
      action: 'customer_alias_created',
      entity_type: 'customer_alias',
      entity_id: alias.id,
      user_id: userData.id,
      details: {
        acumatica_name: customerName,
        display_request_id: displayRequestId,
        rows_matched: rowsMatched,
      },
    })

    return NextResponse.json({
      data: {
        alias_id: alias.id,
        customer_name: customerName,
        rows_matched: rowsMatched,
      },
    })
  } catch (err) {
    console.error('Mismatches POST error:', err)
    return NextResponse.json(
      { error: `Server error: ${err instanceof Error ? err.message : 'Unknown error'}` },
      { status: 500 }
    )
  }
}

// DELETE: remove an alias
export async function DELETE(request: NextRequest) {
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

    if (!userData || !['admin', 'coo', 'cfo'].includes(userData.role)) {
      return NextResponse.json({ error: 'Only admin, COO, or CFO can delete aliases' }, { status: 403 })
    }

    const { searchParams } = new URL(request.url)
    const aliasId = searchParams.get('id')

    if (!aliasId) {
      return NextResponse.json({ error: 'Missing alias ID' }, { status: 400 })
    }

    const { error } = await serviceClient
      .from('customer_aliases')
      .delete()
      .eq('id', aliasId)

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    return NextResponse.json({ data: { deleted: true } })
  } catch (err) {
    console.error('Alias DELETE error:', err)
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
