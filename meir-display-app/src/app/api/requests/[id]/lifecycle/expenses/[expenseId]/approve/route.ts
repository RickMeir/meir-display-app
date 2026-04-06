import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'

// POST /api/requests/[id]/lifecycle/expenses/[expenseId]/approve
// Approve or reject an additional expense request.
// Body: { action: 'approved' | 'rejected', note?: string }

export async function POST(
  request: NextRequest,
  { params }: { params: { id: string; expenseId: string } }
) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { id, expenseId } = params
    const body = await request.json()
    const { action, note } = body

    if (!action || !['approved', 'rejected'].includes(action)) {
      return NextResponse.json(
        { error: 'Action must be "approved" or "rejected"' },
        { status: 400 }
      )
    }

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

    // Get the expense
    const { data: expense, error: expError } = await serviceClient
      .from('additional_expenses')
      .select('*')
      .eq('id', expenseId)
      .eq('request_id', id)
      .single()

    if (expError || !expense) {
      return NextResponse.json({ error: 'Expense not found' }, { status: 404 })
    }

    if (expense.status !== 'proposed') {
      return NextResponse.json(
        { error: 'This expense has already been processed' },
        { status: 400 }
      )
    }

    // Update the expense
    const { data: updated, error: updateError } = await serviceClient
      .from('additional_expenses')
      .update({
        status: action,
        approved_by: userData.id,
        approved_at: new Date().toISOString(),
        approval_note: note || null,
      })
      .eq('id', expenseId)
      .select()
      .single()

    if (updateError) {
      console.error('Update expense error:', updateError)
      return NextResponse.json({ error: 'Failed to update expense' }, { status: 500 })
    }

    // Audit log
    await serviceClient.from('audit_log').insert({
      request_id: id,
      action: `additional_expense_${action}`,
      performed_by: userData.id,
      details: {
        expense_id: expenseId,
        category: expense.category,
        amount: Number(expense.amount),
        expense_round: expense.expense_round,
        note: note || null,
      },
    })

    return NextResponse.json(updated)
  } catch (error) {
    console.error('POST expense approve error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
