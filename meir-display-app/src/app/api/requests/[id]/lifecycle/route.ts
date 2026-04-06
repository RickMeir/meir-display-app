import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

// GET /api/requests/[id]/lifecycle
// Returns the full lifecycle overview for a display request:
// - lifecycle reviews (3/6/9/12 month)
// - expected performance schedule
// - additional expenses
// - forecast changes
// - summary metrics (total additional spend, spiral count, etc.)

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

    // Verify request exists and user has access
    const { data: displayRequest, error: reqError } = await supabase
      .from('display_requests')
      .select('id, store_name, store_code, rep_name, forecast_revenue, total_investment, net_contribution, net_margin, profitability_flag, installation_date, tracking_status, status')
      .eq('id', id)
      .single()

    if (reqError || !displayRequest) {
      return NextResponse.json({ error: 'Request not found' }, { status: 404 })
    }

    // Fetch all lifecycle data in parallel
    const [reviewsRes, expectedRes, expensesRes, forecastRes, actualsRes] = await Promise.all([
      supabase
        .from('lifecycle_reviews')
        .select('*')
        .eq('request_id', id)
        .order('due_date', { ascending: true }),
      supabase
        .from('expected_performance')
        .select('*')
        .eq('request_id', id)
        .order('month_number', { ascending: true }),
      supabase
        .from('additional_expenses')
        .select('*')
        .eq('request_id', id)
        .order('requested_at', { ascending: true }),
      supabase
        .from('forecast_changes')
        .select('*')
        .eq('request_id', id)
        .order('changed_at', { ascending: true }),
      supabase
        .from('monthly_actuals')
        .select('*')
        .eq('request_id', id)
        .order('month_year', { ascending: true }),
    ])

    // Calculate summary metrics
    const expenses = expensesRes.data || []
    const approvedExpenses = expenses.filter(e => e.status === 'approved')
    const totalAdditionalSpend = approvedExpenses.reduce((sum, e) => sum + Number(e.amount), 0)
    const expenseRounds = Math.max(...expenses.map(e => e.expense_round || 1), 0)
    const totalInvestmentWithExtras = Number(displayRequest.total_investment) + totalAdditionalSpend

    const actuals = actualsRes.data || []
    const totalActualRevenue = actuals.reduce((sum, a) => sum + Number(a.revenue), 0)

    const expected = expectedRes.data || []
    const totalExpectedRevenue = expected.reduce((sum, e) => sum + Number(e.expected_revenue), 0)

    // Determine months elapsed since installation
    let monthsElapsed = 0
    if (displayRequest.installation_date) {
      const install = new Date(displayRequest.installation_date)
      const now = new Date()
      monthsElapsed = (now.getFullYear() - install.getFullYear()) * 12 + (now.getMonth() - install.getMonth())
      if (monthsElapsed < 0) monthsElapsed = 0
      if (monthsElapsed > 12) monthsElapsed = 12
    }

    // Cumulative expected revenue to date
    const expectedToDate = expected
      .filter(e => e.month_number <= monthsElapsed)
      .reduce((sum, e) => sum + Number(e.expected_revenue), 0)

    const summary = {
      months_elapsed: monthsElapsed,
      total_forecast_revenue: Number(displayRequest.forecast_revenue),
      total_expected_revenue: totalExpectedRevenue,
      expected_revenue_to_date: expectedToDate,
      total_actual_revenue: totalActualRevenue,
      variance_to_date: expectedToDate > 0 ? (totalActualRevenue - expectedToDate) / expectedToDate : 0,
      original_investment: Number(displayRequest.total_investment),
      total_additional_spend: totalAdditionalSpend,
      total_investment_with_extras: totalInvestmentWithExtras,
      expense_rounds: expenseRounds,
      is_spiral: expenseRounds >= 2,
      forecast_change_count: (forecastRes.data || []).length,
    }

    return NextResponse.json({
      request: displayRequest,
      reviews: reviewsRes.data || [],
      expected_performance: expected,
      additional_expenses: expenses,
      forecast_changes: forecastRes.data || [],
      monthly_actuals: actuals,
      summary,
    })
  } catch (error) {
    console.error('GET /api/requests/[id]/lifecycle error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
