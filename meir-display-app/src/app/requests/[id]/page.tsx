'use client'

import { useEffect, useState } from 'react'
import { useParams } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/client'
import { DisplayRequest, STATUS_LABELS, STATUS_COLOURS } from '@/lib/types'
import { formatCurrency, formatPercent } from '@/lib/calculations'
import RequestOpportunity from '@/components/RequestOpportunity'

export default function RequestDetailPage() {
  const params = useParams()
  const [request, setRequest] = useState<DisplayRequest | null>(null)
  const [userRole, setUserRole] = useState<string>('rep')
  const [loading, setLoading] = useState(true)

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

      const res = await fetch(`/api/requests/${params.id}`)
      if (res.ok) {
        setRequest(await res.json())
      }
      setLoading(false)
    }
    load()
  }, [params.id])

  if (loading) return <div className="text-center py-12 text-gray-500">Loading...</div>
  if (!request) return <div className="text-center py-12 text-red-500">Request not found.</div>

  const canSeeFinancials = userRole !== 'rep'

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">{request.store_name}</h1>
          <p className="text-gray-500">{request.store_code} — Submitted by {request.rep_name}</p>
        </div>
        <span className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-medium ${STATUS_COLOURS[request.status]}`}>
          {STATUS_LABELS[request.status]}
        </span>
      </div>

      {/* Action buttons based on status and role */}
      <div className="flex gap-3">
        {request.status === 'submitted' && (userRole === 'validator' || userRole === 'admin') && (
          <Link href={`/requests/${request.id}/validate`} className="px-4 py-2 bg-orange-500 text-white rounded-lg hover:bg-orange-600 transition">
            Validate Inputs
          </Link>
        )}
        {request.status === 'pending_approval' && ['manager', 'cfo', 'coo', 'admin'].includes(userRole) && (
          <Link href={`/requests/${request.id}/approve`} className="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition">
            Review for Approval
          </Link>
        )}
      </div>

      {/* Store Details */}
      <div className="bg-gray-300 rounded-lg shadow p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Store Details</h2>
        <dl className="grid grid-cols-2 gap-4 text-sm">
          <div>
            <dt className="text-gray-500">Store Name</dt>
            <dd className="font-medium">{request.store_name}</dd>
          </div>
          <div>
            <dt className="text-gray-500">Store Code</dt>
            <dd className="font-medium">{request.store_code}</dd>
          </div>
          <div>
            <dt className="text-gray-500">Sales Rep</dt>
            <dd className="font-medium">{request.rep_name}</dd>
          </div>
          <div>
            <dt className="text-gray-500">Brand Tier</dt>
            <dd className="font-medium">{request.brand_tier || '—'}</dd>
          </div>
          <div>
            <dt className="text-gray-500">Display Type</dt>
            <dd className="font-medium">{request.display_type || '—'}</dd>
          </div>
          <div>
            <dt className="text-gray-500">Submitted</dt>
            <dd className="font-medium">{new Date(request.submitted_at).toLocaleDateString('en-AU')}</dd>
          </div>
          {request.display_reason && (
            <div className="col-span-2">
              <dt className="text-gray-500">Display Reason</dt>
              <dd className="font-medium">{request.display_reason}</dd>
            </div>
          )}
          {request.comments && (
            <div className="col-span-2">
              <dt className="text-gray-500">Comments</dt>
              <dd className="font-medium">{request.comments}</dd>
            </div>
          )}
        </dl>
      </div>

      {/* Opportunity, Initial Order, Photos */}
      <RequestOpportunity request={request} />

      {/* Financial Inputs (visible to all — these are what the rep entered) */}
      <div className="bg-gray-300 rounded-lg shadow p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Financial Inputs</h2>
        <dl className="grid grid-cols-2 gap-4 text-sm">
          <div>
            <dt className="text-gray-500">12 Month Sales Forecast</dt>
            <dd className="font-medium">{formatCurrency(request.forecast_revenue)}</dd>
          </div>
          <div>
            <dt className="text-gray-500">Total Investment</dt>
            <dd className="font-medium">{formatCurrency(request.total_investment)}</dd>
          </div>
          <div>
            <dt className="text-gray-500">Rebate %</dt>
            <dd className="font-medium">{formatPercent(request.rebate_pct)}</dd>
          </div>
          <div>
            <dt className="text-gray-500">COGS / Discount %</dt>
            <dd className="font-medium">{formatPercent(request.cogs_pct)}</dd>
          </div>
          <div>
            <dt className="text-gray-500">Board and Labour</dt>
            <dd className="font-medium">{formatCurrency(request.board_labour_cost)}</dd>
          </div>
          <div>
            <dt className="text-gray-500">Display Product COGS</dt>
            <dd className="font-medium">{formatCurrency(request.product_cogs)}</dd>
          </div>
          <div>
            <dt className="text-gray-500">Rep Hours per Month</dt>
            <dd className="font-medium">{request.rep_hours_monthly}</dd>
          </div>
          <div>
            <dt className="text-gray-500">Free Samples and Gifts</dt>
            <dd className="font-medium">{formatCurrency(request.free_samples_cost)}</dd>
          </div>
          <div>
            <dt className="text-gray-500">Catalogues per Year</dt>
            <dd className="font-medium">{request.catalogues_qty}</dd>
          </div>
        </dl>
      </div>

      {/* Financial Assessment — ONLY for non-rep roles */}
      {canSeeFinancials && (
        <div className="bg-gray-300 rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Financial Assessment</h2>

          <div className="mb-4">
            <span className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-bold ${
              request.profitability_flag === 'green'
                ? 'bg-green-100 text-green-800'
                : 'bg-yellow-100 text-yellow-800'
            }`}>
              {request.profitability_flag === 'green' ? 'GREEN — Viable' : 'REVIEW — Below Thresholds'}
            </span>
          </div>

          <dl className="grid grid-cols-2 gap-4 text-sm">
            <div>
              <dt className="text-gray-500">Net Contribution</dt>
              <dd className={`font-bold text-lg ${request.net_contribution >= 5000 ? 'text-green-700' : 'text-red-600'}`}>
                {formatCurrency(request.net_contribution)}
              </dd>
            </div>
            <div>
              <dt className="text-gray-500">Net Margin</dt>
              <dd className={`font-bold text-lg ${request.net_margin >= 0.15 ? 'text-green-700' : 'text-red-600'}`}>
                {formatPercent(request.net_margin)}
              </dd>
            </div>
            <div>
              <dt className="text-gray-500">Gross Profit</dt>
              <dd className="font-medium">{formatCurrency(request.gross_profit)}</dd>
            </div>
            <div>
              <dt className="text-gray-500">Gross Margin</dt>
              <dd className="font-medium">{formatPercent(request.gross_margin)}</dd>
            </div>
            <div>
              <dt className="text-gray-500">Revenue After Discount</dt>
              <dd className="font-medium">{formatCurrency(request.revenue_after_discount)}</dd>
            </div>
            <div>
              <dt className="text-gray-500">Total Costs</dt>
              <dd className="font-medium">{formatCurrency(request.total_costs)}</dd>
            </div>
          </dl>

          {request.approval_tier && (
            <div className="mt-4 pt-4 border-t border-gray-200">
              <p className="text-sm text-gray-500">
                Approval Tier: <span className="font-medium text-gray-900">{request.approval_tier.toUpperCase()}</span>
              </p>
            </div>
          )}

          {request.was_override && (
            <div className="mt-4 p-3 bg-yellow-50 border border-yellow-200 rounded text-sm text-yellow-800">
              This request was approved despite being below profitability thresholds.
            </div>
          )}
        </div>
      )}

      {/* SKUs */}
      {request.skus && request.skus.length > 0 && (
        <div className="bg-gray-300 rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">SKUs</h2>
          <div className="space-y-2">
            {request.skus.map((sku) => (
              <div key={sku.id} className="flex items-center gap-4 text-sm">
                <span className="font-mono bg-gray-200 px-2 py-1 rounded">{sku.sku_code}</span>
                <span className="text-gray-700">{sku.sku_name || '—'}</span>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Approval History */}
      {(request.validated_at || request.approved_at) && (
        <div className="bg-gray-300 rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">History</h2>
          <div className="space-y-3 text-sm">
            <div className="flex items-center gap-2">
              <span className="w-2 h-2 rounded-full bg-blue-500"></span>
              <span>Submitted {new Date(request.submitted_at).toLocaleString('en-AU')}</span>
            </div>
            {request.validated_at && (
              <div className="flex items-center gap-2">
                <span className="w-2 h-2 rounded-full bg-green-500"></span>
                <span>Validated {new Date(request.validated_at).toLocaleString('en-AU')}</span>
              </div>
            )}
            {request.validation_note && (
              <div className="ml-4 p-2 bg-gray-50 rounded text-gray-600">
                Note: {request.validation_note}
              </div>
            )}
            {request.approved_at && (
              <div className="flex items-center gap-2">
                <span className={`w-2 h-2 rounded-full ${request.status === 'approved' ? 'bg-green-500' : 'bg-red-500'}`}></span>
                <span>
                  {request.status === 'approved' ? 'Approved' : 'Rejected'} {new Date(request.approved_at).toLocaleString('en-AU')}
                </span>
              </div>
            )}
            {request.approval_note && (
              <div className="ml-4 p-2 bg-gray-50 rounded text-gray-600">
                Note: {request.approval_note}
              </div>
            )}
            {request.cs_reference && (
              <div className="flex items-center gap-2">
                <span className="w-2 h-2 rounded-full bg-purple-500"></span>
                <span>CS Reference: {request.cs_reference}</span>
              </div>
            )}
          </div>
        </div>
      )}

      <div className="text-center">
        <Link href="/requests" className="text-meir-600 hover:underline text-sm">
          Back to all requests
        </Link>
      </div>
    </div>
  )
}
