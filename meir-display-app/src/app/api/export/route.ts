import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'

// GET /api/export?type=requests|actuals|expenses|forecast_changes|lifecycle_reviews|audit_log
// Returns CSV data for the requested table. Admin and management only.

function toCsv(rows: Record<string, unknown>[]): string {
  if (rows.length === 0) return ''
  const headers = Object.keys(rows[0])
  const csvRows = [
    headers.join(','),
    ...rows.map(row =>
      headers.map(h => {
        const val = row[h]
        if (val === null || val === undefined) return ''
        const str = String(val)
        // Escape quotes and wrap in quotes if contains comma, quote, or newline
        if (str.includes(',') || str.includes('"') || str.includes('\n')) {
          return `"${str.replace(/"/g, '""')}"`
        }
        return str
      }).join(',')
    ),
  ]
  return csvRows.join('\n')
}

const ALLOWED_TYPES = [
  'requests',
  'actuals',
  'expenses',
  'forecast_changes',
  'lifecycle_reviews',
  'audit_log',
  'expected_performance',
  'skus',
] as const

type ExportType = typeof ALLOWED_TYPES[number]

export async function GET(request: NextRequest) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Check role — admin and management only
    const { data: userData } = await supabase
      .from('users')
      .select('role')
      .eq('email', user.email)
      .single()

    if (!userData || !['admin', 'coo', 'cfo', 'manager'].includes(userData.role)) {
      return NextResponse.json({ error: 'Insufficient permissions' }, { status: 403 })
    }

    const type = request.nextUrl.searchParams.get('type') as ExportType
    if (!type || !ALLOWED_TYPES.includes(type)) {
      return NextResponse.json(
        { error: `Invalid type. Must be one of: ${ALLOWED_TYPES.join(', ')}` },
        { status: 400 }
      )
    }

    const serviceClient = createServiceClient()
    let data: Record<string, unknown>[] = []
    let filename = ''

    switch (type) {
      case 'requests': {
        const { data: rows } = await serviceClient
          .from('display_requests')
          .select('id, status, store_name, store_code, rep_name, brand_tier, display_type, display_reason, opportunity_description, competitor_brands, is_new_or_replacement, planned_install_date, differentiation_plan, store_agreed_location, is_existing_client, existing_annual_revenue, baseline_revenue, incremental_revenue, has_initial_order, initial_order_value, initial_order_notes, rebate_pct, cogs_pct, board_labour_cost, product_cogs, forecast_revenue, rep_hours_monthly, free_samples_cost, catalogues_qty, total_investment, gross_profit, gross_margin, net_contribution, net_margin, roi_multiplier, verdict, profitability_flag, approval_tier, approved_by, was_override, tracking_status, installation_date, submitted_at, validated_at, approved_at, created_at')
          .order('created_at', { ascending: false })
        data = (rows || []) as Record<string, unknown>[]
        filename = 'display_requests'
        break
      }

      case 'actuals': {
        const { data: rows } = await serviceClient
          .from('monthly_actuals')
          .select('id, request_id, month_year, revenue, catalogues_used, source, acumatica_ref, entered_at')
          .order('month_year', { ascending: true })
        data = (rows || []) as Record<string, unknown>[]
        filename = 'monthly_actuals'
        break
      }

      case 'expenses': {
        const { data: rows } = await serviceClient
          .from('additional_expenses')
          .select('id, request_id, category, description, amount, rationale, status, requested_at, approved_at, approval_note, expense_round, cumulative_additional_spend, original_total_investment, new_total_investment, original_required_revenue, new_required_revenue, makes_unviable')
          .order('requested_at', { ascending: false })
        data = (rows || []) as Record<string, unknown>[]
        filename = 'additional_expenses'
        break
      }

      case 'forecast_changes': {
        const { data: rows } = await serviceClient
          .from('forecast_changes')
          .select('id, request_id, changed_at, old_forecast, new_forecast, change_pct, reason, old_net_contribution, new_net_contribution, old_net_margin, new_net_margin, old_profitability_flag, new_profitability_flag')
          .order('changed_at', { ascending: false })
        data = (rows || []) as Record<string, unknown>[]
        filename = 'forecast_changes'
        break
      }

      case 'lifecycle_reviews': {
        const { data: rows } = await serviceClient
          .from('lifecycle_reviews')
          .select('id, request_id, interval, due_date, completed_at, expected_revenue_cumulative, actual_revenue_cumulative, variance_pct, tracking_assessment, notes, action_taken')
          .order('due_date', { ascending: true })
        data = (rows || []) as Record<string, unknown>[]
        filename = 'lifecycle_reviews'
        break
      }

      case 'audit_log': {
        const { data: rows } = await serviceClient
          .from('audit_log')
          .select('id, request_id, action, performed_by, details, created_at')
          .order('created_at', { ascending: false })
          .limit(5000)
        data = (rows || []) as Record<string, unknown>[]
        filename = 'audit_log'
        break
      }

      case 'expected_performance': {
        const { data: rows } = await serviceClient
          .from('expected_performance')
          .select('id, request_id, month_number, calendar_month, weight, expected_revenue')
          .order('request_id', { ascending: true })
        data = (rows || []) as Record<string, unknown>[]
        filename = 'expected_performance'
        break
      }

      case 'skus': {
        const { data: rows } = await serviceClient
          .from('display_skus')
          .select('id, request_id, sku_code, sku_name, quantity, unit_cost, line_cost, sort_order')
          .order('request_id', { ascending: true })
        data = (rows || []) as Record<string, unknown>[]
        filename = 'display_skus'
        break
      }
    }

    const csv = toCsv(data)
    const timestamp = new Date().toISOString().split('T')[0]

    return new NextResponse(csv, {
      status: 200,
      headers: {
        'Content-Type': 'text/csv',
        'Content-Disposition': `attachment; filename="${filename}_${timestamp}.csv"`,
      },
    })
  } catch (error) {
    console.error('GET /api/export error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
