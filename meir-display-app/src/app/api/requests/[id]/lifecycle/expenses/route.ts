import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'

// POST /api/requests/[id]/lifecycle/expenses
// Submit a new additional expense request for a display.
// Calculates impact on ROI and determines expense round (spiral tracking).

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

    // Validate required fields
    const { category, description, amount, rationale, triggered_by_review } = body
    if (!category || !description || !amount || amount <= 0) {
      return NextResponse.json(
        { error: 'Category, description, and a positive amount are required' },
        { status: 400 }
      )
    }

    // Get user info
    const { data: userData } = await supabase
      .from('users')
      .select('id, role')
      .eq('email', user.email)
      .single()

    if (!userData) {
      return NextResponse.json({ error: 'User not found' }, { status: 404 })
    }

    // Get the display request with current financials
    const serviceClient = createServiceClient()
    const { data: displayReq, error: reqError } = await serviceClient
      .from('display_requests')
      .select('id, forecast_revenue, total_investment, net_contribution, net_margin, total_costs, status')
      .eq('id', id)
      .single()

    if (reqError || !displayReq) {
      return NextResponse.json({ error: 'Request not found' }, { status: 404 })
    }

    if (displayReq.status !== 'approved') {
      return NextResponse.json(
        { error: 'Additional expenses can only be added to approved requests' },
        { status: 400 }
      )
    }

    // Count existing expense rounds for spiral tracking
    const { data: existingExpenses } = await serviceClient
      .from('additional_expenses')
      .select('expense_round, amount, status')
      .eq('request_id', id)
      .order('expense_round', { ascending: false })

    const previousApproved = (existingExpenses || []).filter((e: { status: string }) => e.status === 'approved')
    const cumulativeApprovedSpend = previousApproved.reduce((sum: number, e: { amount: number }) => sum + Number(e.amount), 0)
    const currentRound = existingExpenses && existingExpenses.length > 0
      ? Math.max(...existingExpenses.map((e: { expense_round: number }) => e.expense_round)) + 1
      : 1

    // Calculate ROI impact
    const originalTotalInvestment = Number(displayReq.total_investment) + cumulativeApprovedSpend
    const newTotalInvestment = originalTotalInvestment + Number(amount)
    const forecastRevenue = Number(displayReq.forecast_revenue)

    // Simplified ROI recalculation — the new expense increases total costs
    const originalNetContrib = Number(displayReq.net_contribution) - cumulativeApprovedSpend
    const newNetContrib = originalNetContrib - Number(amount)
    const originalNetMargin = forecastRevenue > 0 ? originalNetContrib / forecastRevenue : 0
    const newNetMargin = forecastRevenue > 0 ? newNetContrib / forecastRevenue : 0
    const makesUnviable = newNetContrib < 0 || newNetMargin < 0.15

    // Revenue required to maintain 15% margin with new costs
    // net_contribution = forecast_revenue - total_costs
    // We need: new_net_contribution / new_forecast >= 0.15
    // This is informational — shows what the new target would need to be
    const originalRequiredRevenue = forecastRevenue
    const totalCostsExcludingRevBased = Number(displayReq.total_costs) + cumulativeApprovedSpend + Number(amount)
    const newRequiredRevenue = totalCostsExcludingRevBased / 0.85  // rough: to get 15% margin

    const { data: expense, error: insertError } = await serviceClient
      .from('additional_expenses')
      .insert({
        request_id: id,
        category,
        description,
        amount: Number(amount),
        rationale: rationale || null,
        triggered_by_review: triggered_by_review || null,
        status: 'proposed',
        requested_by: userData.id,
        expense_round: currentRound,
        cumulative_additional_spend: cumulativeApprovedSpend + Number(amount),
        original_total_investment: originalTotalInvestment,
        new_total_investment: newTotalInvestment,
        original_required_revenue: originalRequiredRevenue,
        new_required_revenue: Math.round(newRequiredRevenue * 100) / 100,
        original_net_margin: Math.round(originalNetMargin * 10000) / 10000,
        new_net_margin: Math.round(newNetMargin * 10000) / 10000,
        makes_unviable: makesUnviable,
      })
      .select()
      .single()

    if (insertError) {
      console.error('Insert expense error:', insertError)
      return NextResponse.json({ error: 'Failed to create expense request' }, { status: 500 })
    }

    // Log to audit trail
    await serviceClient.from('audit_log').insert({
      request_id: id,
      action: 'additional_expense_proposed',
      performed_by: userData.id,
      details: {
        expense_id: expense.id,
        category,
        amount: Number(amount),
        expense_round: currentRound,
        makes_unviable: makesUnviable,
        is_spiral: currentRound >= 2,
      },
    })

    return NextResponse.json(expense, { status: 201 })
  } catch (error) {
    console.error('POST /api/requests/[id]/lifecycle/expenses error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
