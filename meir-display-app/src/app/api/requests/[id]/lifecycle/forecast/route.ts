import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { calculateFinancials } from '@/lib/calculations'

// POST /api/requests/[id]/lifecycle/forecast
// Change the forecast revenue for a display request.
// Only managers and above can do this. Every change is logged
// and Rick + Paul are notified.
// Body: { new_forecast: number, reason: string }

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

    const { id } = params
    const body = await request.json()
    const { new_forecast, reason } = body

    if (!new_forecast || new_forecast <= 0) {
      return NextResponse.json(
        { error: 'A positive forecast amount is required' },
        { status: 400 }
      )
    }

    if (!reason || reason.trim().length < 10) {
      return NextResponse.json(
        { error: 'A reason for the forecast change is required (at least 10 characters)' },
        { status: 400 }
      )
    }

    // Verify user is a manager or above
    const { data: userData } = await supabase
      .from('users')
      .select('id, role, name')
      .eq('email', user.email)
      .single()

    if (!userData || !['manager', 'cfo', 'coo', 'admin'].includes(userData.role)) {
      return NextResponse.json(
        { error: 'Only managers and above can change the forecast' },
        { status: 403 }
      )
    }

    const serviceClient = createServiceClient()

    // Get current request data
    const { data: displayReq, error: reqError } = await serviceClient
      .from('display_requests')
      .select('*')
      .eq('id', id)
      .single()

    if (reqError || !displayReq) {
      return NextResponse.json({ error: 'Request not found' }, { status: 404 })
    }

    if (!['approved', 'pending_approval'].includes(displayReq.status)) {
      return NextResponse.json(
        { error: 'Forecast can only be changed on approved or pending requests' },
        { status: 400 }
      )
    }

    const oldForecast = Number(displayReq.forecast_revenue)
    const newForecast = Number(new_forecast)

    if (oldForecast === newForecast) {
      return NextResponse.json(
        { error: 'New forecast is the same as the current forecast' },
        { status: 400 }
      )
    }

    // Recalculate financials with the new forecast
    const recalcInput = {
      store_name: displayReq.store_name,
      store_code: displayReq.store_code,
      rep_name: displayReq.rep_name,
      brand_tier: displayReq.brand_tier || '',
      display_type: displayReq.display_type || '',
      display_reason: displayReq.display_reason || '',
      opportunity_description: displayReq.opportunity_description || '',
      competitor_brands: displayReq.competitor_brands || '',
      brand_perception_impact: displayReq.brand_perception_impact || '',
      planned_install_date: displayReq.planned_install_date || '',
      is_new_or_replacement: displayReq.is_new_or_replacement || '',
      differentiation_plan: displayReq.differentiation_plan || '',
      store_agreed_location: displayReq.store_agreed_location || false,
      is_existing_client: displayReq.is_existing_client || false,
      rebate_pct: Number(displayReq.rebate_pct) * 100,
      cogs_pct: Number(displayReq.cogs_pct) * 100,
      board_labour_cost: Number(displayReq.board_labour_cost),
      forecast_revenue: newForecast,
      rep_hours_monthly: Number(displayReq.rep_hours_monthly),
      free_samples_cost: Number(displayReq.free_samples_cost),
      catalogues_qty: Number(displayReq.catalogues_qty),
      product_cogs: Number(displayReq.product_cogs),
      photos_link: displayReq.photos_link || '',
      comments: displayReq.comments || '',
      has_initial_order: displayReq.has_initial_order || false,
      initial_order_value: Number(displayReq.initial_order_value) || 0,
      initial_order_notes: displayReq.initial_order_notes || '',
      skus: [],
    }

    // Build existing client data if applicable
    let existingClientData = null
    if (displayReq.is_existing_client) {
      existingClientData = {
        annual_revenue: Number(displayReq.existing_annual_revenue) || 0,
        order_count: Number(displayReq.existing_orders) || 0,
        avg_order_value: Number(displayReq.existing_aov) || 0,
        cogs_pct: Number(displayReq.existing_cogs_pct) || 0,
      }
    }

    const newCalc = calculateFinancials(recalcInput, existingClientData)

    // The trigger on display_requests will handle logging to forecast_changes.
    // But we need to use the service client to bypass RLS, and the trigger uses
    // get_user_role() which reads from auth context. So we log manually here too.
    const changePct = oldForecast > 0 ? (newForecast - oldForecast) / oldForecast : null

    // Log the forecast change explicitly (the DB trigger may also fire,
    // but the trigger uses auth context which may not resolve with service client)
    await serviceClient.from('forecast_changes').insert({
      request_id: id,
      changed_by: userData.id,
      old_forecast: oldForecast,
      new_forecast: newForecast,
      change_pct: changePct ? Math.round(changePct * 10000) / 10000 : null,
      reason,
      old_net_contribution: Number(displayReq.net_contribution),
      new_net_contribution: newCalc.net_contribution,
      old_net_margin: Number(displayReq.net_margin),
      new_net_margin: newCalc.net_margin,
      old_profitability_flag: displayReq.profitability_flag,
      new_profitability_flag: newCalc.profitability_flag,
    })

    // Update the display request with new forecast and recalculated financials
    // Using service client to bypass the forecast change trigger (we logged manually above)
    const { error: updateError } = await serviceClient
      .from('display_requests')
      .update({
        forecast_revenue: newForecast,
        ...newCalc,
      })
      .eq('id', id)

    if (updateError) {
      console.error('Update forecast error:', updateError)
      return NextResponse.json({ error: 'Failed to update forecast' }, { status: 500 })
    }

    // Regenerate expected performance if installation date exists
    if (displayReq.installation_date) {
      await serviceClient.rpc('generate_expected_performance', { p_request_id: id })
    }

    // Audit log
    await serviceClient.from('audit_log').insert({
      request_id: id,
      action: 'forecast_changed',
      performed_by: userData.id,
      details: {
        old_forecast: oldForecast,
        new_forecast: newForecast,
        change_pct: changePct,
        reason,
        old_profitability_flag: displayReq.profitability_flag,
        new_profitability_flag: newCalc.profitability_flag,
      },
    })

    // TODO: Send notification to Rick and Paul
    // This will use the existing email infrastructure (Resend)
    // For now, the notification is logged in the audit trail

    return NextResponse.json({
      success: true,
      old_forecast: oldForecast,
      new_forecast: newForecast,
      change_pct: changePct,
      new_net_contribution: newCalc.net_contribution,
      new_net_margin: newCalc.net_margin,
      new_profitability_flag: newCalc.profitability_flag,
    })
  } catch (error) {
    console.error('POST /api/requests/[id]/lifecycle/forecast error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
