'use client'

import { useEffect, useState } from 'react'
import { useParams } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/client'
import {
  LifecycleReview,
  ExpectedPerformance,
  AdditionalExpense,
  ForecastChange,
  MonthlyActual,
  TrackingStatus,
  INTERVAL_LABELS,
  EXPENSE_CATEGORY_LABELS,
  EXPENSE_STATUS_LABELS,
  EXPENSE_STATUS_COLOURS,
} from '@/lib/types'
import { formatCurrency, formatPercent } from '@/lib/calculations'

interface LifecycleData {
  request: {
    id: string
    store_name: string
    store_code: string
    rep_name: string
    forecast_revenue: number
    total_investment: number
    net_contribution: number
    net_margin: number
    profitability_flag: string
    installation_date: string | null
    tracking_status: TrackingStatus
    status: string
  }
  reviews: LifecycleReview[]
  expected_performance: ExpectedPerformance[]
  additional_expenses: AdditionalExpense[]
  forecast_changes: ForecastChange[]
  monthly_actuals: MonthlyActual[]
  summary: {
    months_elapsed: number
    total_forecast_revenue: number
    total_expected_revenue: number
    expected_revenue_to_date: number
    total_actual_revenue: number
    variance_to_date: number
    original_investment: number
    total_additional_spend: number
    total_investment_with_extras: number
    expense_rounds: number
    is_spiral: boolean
    forecast_change_count: number
  }
}

const TRACKING_COLOURS: Record<string, string> = {
  on_track: 'bg-green-100 text-green-800',
  at_risk: 'bg-yellow-100 text-yellow-800',
  off_track: 'bg-red-100 text-red-800',
  not_started: 'bg-gray-200 text-gray-600',
}

const TRACKING_LABELS: Record<string, string> = {
  on_track: 'On Track',
  at_risk: 'At Risk',
  off_track: 'Off Track',
  not_started: 'Not Started',
}

export default function LifecyclePage() {
  const params = useParams()
  const [data, setData] = useState<LifecycleData | null>(null)
  const [userRole, setUserRole] = useState<string>('rep')
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  // Expense form state
  const [showExpenseForm, setShowExpenseForm] = useState(false)
  const [expenseForm, setExpenseForm] = useState({
    category: 'rep_hours',
    description: '',
    amount: '',
    rationale: '',
  })
  const [expenseSubmitting, setExpenseSubmitting] = useState(false)

  // Forecast change form state
  const [showForecastForm, setShowForecastForm] = useState(false)
  const [forecastForm, setForecastForm] = useState({
    new_forecast: '',
    reason: '',
  })
  const [forecastSubmitting, setForecastSubmitting] = useState(false)

  useEffect(() => {
    async function load() {
      const supabase = createClient()
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) return

      const { data: userData } = await supabase
        .from('users')
        .select('role')
        .eq('email', user.email)
        .single()

      if (userData) setUserRole(userData.role)

      const res = await fetch(`/api/requests/${params.id}/lifecycle`)
      if (res.ok) {
        setData(await res.json())
      } else {
        setError('Failed to load lifecycle data')
      }
      setLoading(false)
    }
    load()
  }, [params.id])

  async function handleExpenseSubmit(e: React.FormEvent) {
    e.preventDefault()
    setExpenseSubmitting(true)
    try {
      const res = await fetch(`/api/requests/${params.id}/lifecycle/expenses`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          category: expenseForm.category,
          description: expenseForm.description,
          amount: Number(expenseForm.amount),
          rationale: expenseForm.rationale,
        }),
      })
      if (res.ok) {
        setShowExpenseForm(false)
        setExpenseForm({ category: 'rep_hours', description: '', amount: '', rationale: '' })
        // Reload data
        const refreshRes = await fetch(`/api/requests/${params.id}/lifecycle`)
        if (refreshRes.ok) setData(await refreshRes.json())
      } else {
        const err = await res.json()
        alert(err.error || 'Failed to submit expense')
      }
    } finally {
      setExpenseSubmitting(false)
    }
  }

  async function handleForecastSubmit(e: React.FormEvent) {
    e.preventDefault()
    setForecastSubmitting(true)
    try {
      const res = await fetch(`/api/requests/${params.id}/lifecycle/forecast`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          new_forecast: Number(forecastForm.new_forecast),
          reason: forecastForm.reason,
        }),
      })
      if (res.ok) {
        setShowForecastForm(false)
        setForecastForm({ new_forecast: '', reason: '' })
        const refreshRes = await fetch(`/api/requests/${params.id}/lifecycle`)
        if (refreshRes.ok) setData(await refreshRes.json())
      } else {
        const err = await res.json()
        alert(err.error || 'Failed to change forecast')
      }
    } finally {
      setForecastSubmitting(false)
    }
  }

  async function handleExpenseAction(expenseId: string, action: 'approved' | 'rejected') {
    const note = prompt(`Add a note for this ${action === 'approved' ? 'approval' : 'rejection'} (optional):`)
    const res = await fetch(`/api/requests/${params.id}/lifecycle/expenses/${expenseId}/approve`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ action, note: note || '' }),
    })
    if (res.ok) {
      const refreshRes = await fetch(`/api/requests/${params.id}/lifecycle`)
      if (refreshRes.ok) setData(await refreshRes.json())
    }
  }

  async function handleCompleteReview(reviewId: string) {
    const notes = prompt('Review notes (optional):')
    const action_taken = prompt('Action taken (optional):')
    const res = await fetch(`/api/requests/${params.id}/lifecycle/reviews/${reviewId}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ notes: notes || '', action_taken: action_taken || '' }),
    })
    if (res.ok) {
      const refreshRes = await fetch(`/api/requests/${params.id}/lifecycle`)
      if (refreshRes.ok) setData(await refreshRes.json())
    }
  }

  if (loading) return <div className="text-center py-12 text-gray-400">Loading lifecycle data...</div>
  if (error) return <div className="text-center py-12 text-red-500">{error}</div>
  if (!data) return <div className="text-center py-12 text-red-500">No data available.</div>

  const { request: req, reviews, expected_performance, additional_expenses, forecast_changes, monthly_actuals, summary } = data
  const canManage = ['manager', 'cfo', 'coo', 'admin'].includes(userRole)

  return (
    <div className="max-w-5xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-100">{req.store_name}</h1>
          <p className="text-gray-400">{req.store_code} — Lifecycle Tracking</p>
        </div>
        <div className="flex items-center gap-3">
          <span className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-medium ${TRACKING_COLOURS[req.tracking_status]}`}>
            {TRACKING_LABELS[req.tracking_status]}
          </span>
          {summary.is_spiral && (
            <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-bold bg-red-200 text-red-900">
              SPIRAL ALERT — Round {summary.expense_rounds}
            </span>
          )}
        </div>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <div className="bg-gray-400 rounded-lg shadow p-4">
          <p className="text-xs text-gray-600 uppercase tracking-wide">Months Elapsed</p>
          <p className="text-2xl font-bold text-gray-900">{summary.months_elapsed} / 12</p>
        </div>
        <div className="bg-gray-400 rounded-lg shadow p-4">
          <p className="text-xs text-gray-600 uppercase tracking-wide">Actual vs Expected</p>
          <p className={`text-2xl font-bold ${summary.variance_to_date >= 0 ? 'text-green-700' : 'text-red-600'}`}>
            {summary.expected_revenue_to_date > 0
              ? formatPercent(summary.total_actual_revenue / summary.expected_revenue_to_date)
              : '—'}
          </p>
          <p className="text-xs text-gray-500 mt-1">
            {formatCurrency(summary.total_actual_revenue)} of {formatCurrency(summary.expected_revenue_to_date)} expected
          </p>
        </div>
        <div className="bg-gray-400 rounded-lg shadow p-4">
          <p className="text-xs text-gray-600 uppercase tracking-wide">Total Investment</p>
          <p className="text-2xl font-bold text-gray-900">{formatCurrency(summary.total_investment_with_extras)}</p>
          {summary.total_additional_spend > 0 && (
            <p className="text-xs text-orange-600 mt-1">
              +{formatCurrency(summary.total_additional_spend)} additional
            </p>
          )}
        </div>
        <div className="bg-gray-400 rounded-lg shadow p-4">
          <p className="text-xs text-gray-600 uppercase tracking-wide">Forecast Changes</p>
          <p className="text-2xl font-bold text-gray-900">{summary.forecast_change_count}</p>
          <p className="text-xs text-gray-500 mt-1">
            Current: {formatCurrency(summary.total_forecast_revenue)}
          </p>
        </div>
      </div>

      {/* No installation date warning */}
      {!req.installation_date && (
        <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-4 text-yellow-800">
          <p className="font-medium">No installation date recorded</p>
          <p className="text-sm mt-1">
            The lifecycle tracking clock has not started. Set the installation date on the request detail page to begin tracking.
          </p>
        </div>
      )}

      {/* Performance Chart — Monthly Expected vs Actual */}
      {expected_performance.length > 0 && (
        <div className="bg-gray-400 rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Monthly Performance</h2>
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b border-gray-300">
                  <th className="text-left py-2 text-gray-600">Month</th>
                  <th className="text-left py-2 text-gray-600">Calendar</th>
                  <th className="text-right py-2 text-gray-600">Expected</th>
                  <th className="text-right py-2 text-gray-600">Actual</th>
                  <th className="text-right py-2 text-gray-600">Variance</th>
                  <th className="text-center py-2 text-gray-600">Status</th>
                </tr>
              </thead>
              <tbody>
                {expected_performance.map((ep) => {
                  const actual = monthly_actuals.find(a => a.month_year === ep.calendar_month)
                  const actualRev = actual ? Number(actual.revenue) : 0
                  const expected = Number(ep.expected_revenue)
                  const variance = expected > 0 ? (actualRev - expected) / expected : 0
                  const isFuture = ep.month_number > summary.months_elapsed

                  return (
                    <tr key={ep.id} className={`border-b border-gray-300 ${isFuture ? 'opacity-40' : ''}`}>
                      <td className="py-2 font-medium text-gray-900">Month {ep.month_number}</td>
                      <td className="py-2 text-gray-700">{ep.calendar_month || '—'}</td>
                      <td className="py-2 text-right text-gray-700">{formatCurrency(expected)}</td>
                      <td className="py-2 text-right text-gray-900 font-medium">
                        {isFuture ? '—' : formatCurrency(actualRev)}
                      </td>
                      <td className={`py-2 text-right font-medium ${
                        isFuture ? 'text-gray-400' : variance >= 0 ? 'text-green-700' : 'text-red-600'
                      }`}>
                        {isFuture ? '—' : formatPercent(variance)}
                      </td>
                      <td className="py-2 text-center">
                        {isFuture ? (
                          <span className="text-gray-400 text-xs">Future</span>
                        ) : actualRev === 0 && !actual ? (
                          <span className="text-gray-400 text-xs">No data</span>
                        ) : variance >= -0.1 ? (
                          <span className="inline-block w-3 h-3 rounded-full bg-green-500" title="On track" />
                        ) : variance >= -0.3 ? (
                          <span className="inline-block w-3 h-3 rounded-full bg-yellow-500" title="At risk" />
                        ) : (
                          <span className="inline-block w-3 h-3 rounded-full bg-red-500" title="Off track" />
                        )}
                      </td>
                    </tr>
                  )
                })}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Lifecycle Reviews */}
      <div className="bg-gray-400 rounded-lg shadow p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Lifecycle Reviews</h2>
        {reviews.length === 0 ? (
          <p className="text-gray-500 text-sm">
            {req.installation_date
              ? 'Reviews will be generated when the installation date is recorded.'
              : 'Set an installation date to generate the review schedule.'}
          </p>
        ) : (
          <div className="space-y-4">
            {reviews.map((review) => (
              <div key={review.id} className="border border-gray-300 rounded-lg p-4">
                <div className="flex items-center justify-between mb-2">
                  <div className="flex items-center gap-3">
                    <h3 className="font-medium text-gray-900">{INTERVAL_LABELS[review.interval]}</h3>
                    {review.tracking_assessment && (
                      <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${TRACKING_COLOURS[review.tracking_assessment]}`}>
                        {TRACKING_LABELS[review.tracking_assessment]}
                      </span>
                    )}
                  </div>
                  <div className="text-sm text-gray-500">
                    Due: {new Date(review.due_date).toLocaleDateString('en-AU')}
                  </div>
                </div>

                {review.completed_at ? (
                  <div className="text-sm space-y-2">
                    <div className="grid grid-cols-3 gap-4">
                      <div>
                        <p className="text-gray-500">Expected (cumulative)</p>
                        <p className="font-medium">{review.expected_revenue_cumulative ? formatCurrency(review.expected_revenue_cumulative) : '—'}</p>
                      </div>
                      <div>
                        <p className="text-gray-500">Actual (cumulative)</p>
                        <p className="font-medium">{review.actual_revenue_cumulative ? formatCurrency(review.actual_revenue_cumulative) : '—'}</p>
                      </div>
                      <div>
                        <p className="text-gray-500">Variance</p>
                        <p className={`font-medium ${(review.variance_pct || 0) >= 0 ? 'text-green-700' : 'text-red-600'}`}>
                          {review.variance_pct != null ? formatPercent(review.variance_pct) : '—'}
                        </p>
                      </div>
                    </div>
                    {review.notes && (
                      <div className="mt-2 p-2 bg-gray-200 rounded">
                        <p className="text-gray-500 text-xs">Notes</p>
                        <p className="text-gray-800">{review.notes}</p>
                      </div>
                    )}
                    {review.action_taken && (
                      <div className="p-2 bg-gray-200 rounded">
                        <p className="text-gray-500 text-xs">Action Taken</p>
                        <p className="text-gray-800">{review.action_taken}</p>
                      </div>
                    )}
                    <p className="text-gray-400 text-xs">
                      Completed {new Date(review.completed_at).toLocaleString('en-AU')}
                    </p>
                  </div>
                ) : (
                  <div className="flex items-center justify-between">
                    <p className="text-sm text-gray-500">Pending review</p>
                    {canManage && (
                      <button
                        onClick={() => handleCompleteReview(review.id)}
                        className="px-3 py-1 bg-blue-600 text-white text-sm rounded hover:bg-blue-700 transition"
                      >
                        Complete Review
                      </button>
                    )}
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Additional Expenses */}
      <div className="bg-gray-400 rounded-lg shadow p-6">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900">Additional Expenses</h2>
          {req.status === 'approved' && (
            <button
              onClick={() => setShowExpenseForm(!showExpenseForm)}
              className="px-3 py-1 bg-orange-500 text-white text-sm rounded hover:bg-orange-600 transition"
            >
              {showExpenseForm ? 'Cancel' : 'Request Additional Expense'}
            </button>
          )}
        </div>

        {/* Spiral warning */}
        {summary.is_spiral && (
          <div className="mb-4 p-3 bg-red-50 border border-red-200 rounded text-sm text-red-800">
            <p className="font-bold">Spiral Alert: {summary.expense_rounds} rounds of additional expenses</p>
            <p className="mt-1">
              Original investment: {formatCurrency(summary.original_investment)}.
              Total additional spend: {formatCurrency(summary.total_additional_spend)}.
              Combined: {formatCurrency(summary.total_investment_with_extras)}.
            </p>
            <p className="mt-1">
              Consider whether continued investment is justified, or whether to cut losses and repurpose this display.
            </p>
          </div>
        )}

        {/* Expense form */}
        {showExpenseForm && (
          <form onSubmit={handleExpenseSubmit} className="mb-6 p-4 bg-gray-300 rounded-lg space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Category</label>
                <select
                  value={expenseForm.category}
                  onChange={e => setExpenseForm({ ...expenseForm, category: e.target.value })}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg bg-white"
                >
                  {Object.entries(EXPENSE_CATEGORY_LABELS).map(([key, label]) => (
                    <option key={key} value={key}>{label}</option>
                  ))}
                </select>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Amount ($)</label>
                <input
                  type="number"
                  step="0.01"
                  min="0.01"
                  value={expenseForm.amount}
                  onChange={e => setExpenseForm({ ...expenseForm, amount: e.target.value })}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg bg-white"
                  required
                />
              </div>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Description</label>
              <input
                type="text"
                value={expenseForm.description}
                onChange={e => setExpenseForm({ ...expenseForm, description: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg bg-white"
                required
                placeholder="What is this expense for?"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Rationale</label>
              <textarea
                value={expenseForm.rationale}
                onChange={e => setExpenseForm({ ...expenseForm, rationale: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg bg-white"
                rows={3}
                placeholder="Why is this additional spend necessary? What will it change?"
              />
            </div>
            <button
              type="submit"
              disabled={expenseSubmitting}
              className="px-4 py-2 bg-orange-600 text-white rounded-lg hover:bg-orange-700 disabled:bg-gray-400 transition"
            >
              {expenseSubmitting ? 'Submitting...' : 'Submit Expense Request'}
            </button>
          </form>
        )}

        {/* Expense list */}
        {additional_expenses.length === 0 ? (
          <p className="text-gray-500 text-sm">No additional expenses recorded.</p>
        ) : (
          <div className="space-y-3">
            {additional_expenses.map((exp) => (
              <div key={exp.id} className="border border-gray-300 rounded-lg p-4">
                <div className="flex items-center justify-between mb-2">
                  <div className="flex items-center gap-2">
                    <span className="font-medium text-gray-900">{EXPENSE_CATEGORY_LABELS[exp.category]}</span>
                    <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${EXPENSE_STATUS_COLOURS[exp.status]}`}>
                      {EXPENSE_STATUS_LABELS[exp.status]}
                    </span>
                    <span className="text-xs text-gray-500">Round {exp.expense_round}</span>
                  </div>
                  <span className="text-lg font-bold text-gray-900">{formatCurrency(exp.amount)}</span>
                </div>
                <p className="text-sm text-gray-700">{exp.description}</p>
                {exp.rationale && <p className="text-sm text-gray-500 mt-1">{exp.rationale}</p>}

                {exp.makes_unviable && (
                  <div className="mt-2 p-2 bg-red-50 border border-red-200 rounded text-xs text-red-800">
                    This expense makes the display financially unviable. New net margin: {exp.new_net_margin != null ? formatPercent(exp.new_net_margin) : '—'}
                  </div>
                )}

                {exp.status === 'proposed' && canManage && (
                  <div className="mt-3 flex gap-2">
                    <button
                      onClick={() => handleExpenseAction(exp.id, 'approved')}
                      className="px-3 py-1 bg-green-600 text-white text-sm rounded hover:bg-green-700 transition"
                    >
                      Approve
                    </button>
                    <button
                      onClick={() => handleExpenseAction(exp.id, 'rejected')}
                      className="px-3 py-1 bg-red-600 text-white text-sm rounded hover:bg-red-700 transition"
                    >
                      Reject
                    </button>
                  </div>
                )}

                {exp.approval_note && (
                  <div className="mt-2 p-2 bg-gray-200 rounded text-xs text-gray-600">
                    Approval note: {exp.approval_note}
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Forecast Changes */}
      <div className="bg-gray-400 rounded-lg shadow p-6">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900">Forecast History</h2>
          {canManage && (
            <button
              onClick={() => setShowForecastForm(!showForecastForm)}
              className="px-3 py-1 bg-blue-600 text-white text-sm rounded hover:bg-blue-700 transition"
            >
              {showForecastForm ? 'Cancel' : 'Change Forecast'}
            </button>
          )}
        </div>

        {/* Forecast change form */}
        {showForecastForm && (
          <form onSubmit={handleForecastSubmit} className="mb-6 p-4 bg-gray-300 rounded-lg space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                New Forecast Revenue ($)
              </label>
              <input
                type="number"
                step="0.01"
                min="0.01"
                value={forecastForm.new_forecast}
                onChange={e => setForecastForm({ ...forecastForm, new_forecast: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg bg-white"
                required
                placeholder={`Current: ${formatCurrency(summary.total_forecast_revenue)}`}
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Reason for change (required)
              </label>
              <textarea
                value={forecastForm.reason}
                onChange={e => setForecastForm({ ...forecastForm, reason: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg bg-white"
                rows={3}
                required
                minLength={10}
                placeholder="Why is the forecast being changed? What evidence supports the new figure?"
              />
            </div>
            <div className="text-sm text-gray-500">
              Rick and Paul will be notified of this change.
            </div>
            <button
              type="submit"
              disabled={forecastSubmitting}
              className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:bg-gray-400 transition"
            >
              {forecastSubmitting ? 'Updating...' : 'Update Forecast'}
            </button>
          </form>
        )}

        {forecast_changes.length === 0 ? (
          <p className="text-gray-500 text-sm">No forecast changes recorded. Original forecast: {formatCurrency(summary.total_forecast_revenue)}</p>
        ) : (
          <div className="space-y-3">
            {forecast_changes.map((fc) => (
              <div key={fc.id} className="border border-gray-300 rounded-lg p-4 text-sm">
                <div className="flex items-center justify-between mb-2">
                  <span className="text-gray-500">
                    {new Date(fc.changed_at).toLocaleString('en-AU')}
                  </span>
                  <span className={`font-bold ${(fc.change_pct || 0) >= 0 ? 'text-green-700' : 'text-red-600'}`}>
                    {fc.change_pct != null ? (fc.change_pct >= 0 ? '+' : '') + formatPercent(fc.change_pct) : ''}
                  </span>
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <p className="text-gray-500">Previous</p>
                    <p className="font-medium">{formatCurrency(fc.old_forecast)}</p>
                  </div>
                  <div>
                    <p className="text-gray-500">New</p>
                    <p className="font-medium">{formatCurrency(fc.new_forecast)}</p>
                  </div>
                </div>
                {fc.reason && (
                  <div className="mt-2 p-2 bg-gray-200 rounded">
                    <p className="text-gray-600">{fc.reason}</p>
                  </div>
                )}
                {fc.old_profitability_flag !== fc.new_profitability_flag && (
                  <div className="mt-2 text-xs">
                    Profitability flag changed from{' '}
                    <span className="font-medium">{fc.old_profitability_flag?.toUpperCase()}</span> to{' '}
                    <span className="font-medium">{fc.new_profitability_flag?.toUpperCase()}</span>
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Cut-Loss Decision Support */}
      {(summary.is_spiral || (summary.variance_to_date < -0.3 && summary.months_elapsed >= 3)) && (
        <div className="bg-red-50 border-2 border-red-300 rounded-lg p-6">
          <h2 className="text-lg font-bold text-red-900 mb-3">Cut-Loss Decision Support</h2>
          <div className="grid grid-cols-2 gap-4 text-sm mb-4">
            <div>
              <p className="text-red-700">Total invested to date</p>
              <p className="text-xl font-bold text-red-900">{formatCurrency(summary.total_investment_with_extras)}</p>
            </div>
            <div>
              <p className="text-red-700">Total actual revenue to date</p>
              <p className="text-xl font-bold text-red-900">{formatCurrency(summary.total_actual_revenue)}</p>
            </div>
            <div>
              <p className="text-red-700">Original 12 month forecast</p>
              <p className="font-medium text-red-800">{formatCurrency(summary.total_forecast_revenue)}</p>
            </div>
            <div>
              <p className="text-red-700">Performance at {summary.months_elapsed} months</p>
              <p className="font-medium text-red-800">
                {summary.expected_revenue_to_date > 0
                  ? formatPercent(summary.total_actual_revenue / summary.expected_revenue_to_date) + ' of expected'
                  : '—'}
              </p>
            </div>
          </div>
          <div className="p-3 bg-red-100 rounded text-sm text-red-900">
            <p className="font-medium">
              If this information had been known at the time of the original request, would this display have been approved?
            </p>
            <p className="mt-2">
              Consider whether to stop, cut losses, and repurpose this display elsewhere.
              Contact Rick and Paul to discuss next steps.
            </p>
          </div>
        </div>
      )}

      {/* Navigation */}
      <div className="flex justify-between text-sm">
        <Link href={`/requests/${req.id}`} className="text-blue-400 hover:underline">
          Back to request details
        </Link>
        <Link href="/requests" className="text-blue-400 hover:underline">
          All requests
        </Link>
      </div>
    </div>
  )
}
