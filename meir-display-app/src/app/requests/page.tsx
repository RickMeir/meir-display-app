'use client'

import { useEffect, useState } from 'react'
import { useSearchParams } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/client'
import { DisplayRequest, STATUS_LABELS, STATUS_COLOURS } from '@/lib/types'
import { formatCurrency, formatPercent } from '@/lib/calculations'

type SortField = 'submitted_at' | 'store_name' | 'total_investment' | 'status'
type SortDir = 'asc' | 'desc'

export default function RequestsListPage() {
  const [requests, setRequests] = useState<DisplayRequest[]>([])
  const [userRole, setUserRole] = useState<string>('rep')
  const [loading, setLoading] = useState(true)
  const [statusFilter, setStatusFilter] = useState<string>('all')
  const [sortField, setSortField] = useState<SortField>('submitted_at')
  const [sortDir, setSortDir] = useState<SortDir>('desc')
  const searchParams = useSearchParams()
  const success = searchParams.get('success')

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

      const res = await fetch('/api/requests')
      if (res.ok) {
        const json = await res.json()
        setRequests(json.data || [])
      }
      setLoading(false)
    }
    load()
  }, [])

  const canViewFinancials = userRole !== 'rep'
  const isAdmin = userRole === 'admin'
  const isValidator = userRole === 'validator' || userRole === 'admin'
  const isApprover = ['manager', 'cfo', 'coo', 'admin'].includes(userRole)

  // Filter
  const filtered = statusFilter === 'all'
    ? requests
    : requests.filter((r) => r.status === statusFilter)

  // Sort
  const sorted = [...filtered].sort((a, b) => {
    let cmp = 0
    switch (sortField) {
      case 'submitted_at':
        cmp = new Date(a.submitted_at).getTime() - new Date(b.submitted_at).getTime()
        break
      case 'store_name':
        cmp = (a.store_name || '').localeCompare(b.store_name || '')
        break
      case 'total_investment':
        cmp = (a.total_investment || 0) - (b.total_investment || 0)
        break
      case 'status':
        cmp = (a.status || '').localeCompare(b.status || '')
        break
    }
    return sortDir === 'asc' ? cmp : -cmp
  })

  const toggleSort = (field: SortField) => {
    if (sortField === field) {
      setSortDir(sortDir === 'asc' ? 'desc' : 'asc')
    } else {
      setSortField(field)
      setSortDir('desc')
    }
  }

  const sortIcon = (field: SortField) => {
    if (sortField !== field) return ''
    return sortDir === 'asc' ? ' \u2191' : ' \u2193'
  }

  // Summary stats
  const totalActive = requests.filter((r) => r.status === 'approved').length
  const totalInvestment = requests
    .filter((r) => r.status === 'approved')
    .reduce((sum, r) => sum + (r.total_investment || 0), 0)
  const pendingValidation = requests.filter((r) => r.status === 'submitted').length
  const pendingApproval = requests.filter((r) => r.status === 'pending_approval').length

  if (loading) {
    return <div className="text-center py-12 text-gray-500">Loading requests...</div>
  }

  return (
    <div>
      {success && (
        <div className="mb-6 p-4 bg-green-50 border border-green-200 rounded-lg text-green-800">
          Request submitted successfully. It has been sent to Brooke for validation.
        </div>
      )}

      <div className="flex items-center justify-between mb-6">
        <h1 className="text-2xl font-bold text-gray-900">
          {userRole === 'rep' ? 'My Requests' : 'Display Register'}
        </h1>
        {(userRole === 'rep' || userRole === 'admin') && (
          <Link
            href="/requests/new"
            className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition"
          >
            New Request
          </Link>
        )}
      </div>

      {/* Summary cards for admin/validator */}
      {canViewFinancials && (
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
          <div className="bg-white rounded-lg shadow p-4">
            <p className="text-xs text-gray-500 uppercase tracking-wide">Active Displays</p>
            <p className="text-2xl font-bold text-gray-900">{totalActive}</p>
          </div>
          <div className="bg-white rounded-lg shadow p-4">
            <p className="text-xs text-gray-500 uppercase tracking-wide">Total Investment</p>
            <p className="text-2xl font-bold text-gray-900">{formatCurrency(totalInvestment)}</p>
          </div>
          <div className="bg-white rounded-lg shadow p-4">
            <p className="text-xs text-gray-500 uppercase tracking-wide">Pending Validation</p>
            <p className="text-2xl font-bold text-orange-600">{pendingValidation}</p>
          </div>
          <div className="bg-white rounded-lg shadow p-4">
            <p className="text-xs text-gray-500 uppercase tracking-wide">Pending Approval</p>
            <p className="text-2xl font-bold text-purple-600">{pendingApproval}</p>
          </div>
        </div>
      )}

      {/* Status filter */}
      <div className="flex gap-2 mb-4 flex-wrap">
        {['all', 'submitted', 'validated', 'pending_approval', 'approved', 'rejected', 'queried'].map((s) => (
          <button
            key={s}
            onClick={() => setStatusFilter(s)}
            className={`px-3 py-1 rounded-full text-xs font-medium transition ${
              statusFilter === s
                ? 'bg-blue-600 text-white'
                : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
            }`}
          >
            {s === 'all' ? `All (${requests.length})` : `${STATUS_LABELS[s as keyof typeof STATUS_LABELS] || s} (${requests.filter((r) => r.status === s).length})`}
          </button>
        ))}
      </div>

      {sorted.length === 0 ? (
        <div className="text-center py-12 text-gray-500">
          <p>No display requests found.</p>
          {userRole === 'rep' && (
            <Link href="/requests/new" className="text-blue-600 hover:underline mt-2 inline-block">
              Submit your first request
            </Link>
          )}
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow overflow-hidden">
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th
                    className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:text-gray-700"
                    onClick={() => toggleSort('store_name')}
                  >
                    Store{sortIcon('store_name')}
                  </th>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Rep</th>
                  {canViewFinancials && (
                    <>
                      <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Forecast Revenue</th>
                      <th
                        className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:text-gray-700"
                        onClick={() => toggleSort('total_investment')}
                      >
                        Investment{sortIcon('total_investment')}
                      </th>
                      <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Net Margin</th>
                      <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Flag</th>
                      <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tier</th>
                    </>
                  )}
                  <th
                    className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:text-gray-700"
                    onClick={() => toggleSort('status')}
                  >
                    Status{sortIcon('status')}
                  </th>
                  <th
                    className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:text-gray-700"
                    onClick={() => toggleSort('submitted_at')}
                  >
                    Date{sortIcon('submitted_at')}
                  </th>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Action</th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {sorted.map((req, i) => {
                  const flagColour = req.profitability_flag === 'green'
                    ? 'bg-green-100 text-green-800'
                    : 'bg-red-100 text-red-800'

                  return (
                    <tr key={req.id} className={i % 2 === 0 ? 'bg-white' : 'bg-gray-50'}>
                      <td className="px-4 py-3 whitespace-nowrap">
                        <div className="font-medium text-gray-900 text-sm">{req.store_name}</div>
                        <div className="text-xs text-gray-500">{req.store_code}</div>
                      </td>
                      <td className="px-4 py-3 whitespace-nowrap text-sm text-gray-700">{req.rep_name}</td>
                      {canViewFinancials && (
                        <>
                          <td className="px-4 py-3 whitespace-nowrap text-sm text-gray-700">
                            {formatCurrency(req.forecast_revenue)}
                          </td>
                          <td className="px-4 py-3 whitespace-nowrap text-sm text-gray-700">
                            {formatCurrency(req.total_investment)}
                          </td>
                          <td className="px-4 py-3 whitespace-nowrap text-sm text-gray-700">
                            {formatPercent(req.net_margin)}
                          </td>
                          <td className="px-4 py-3 whitespace-nowrap">
                            <span className={`inline-flex items-center px-2 py-0.5 rounded text-xs font-medium ${flagColour}`}>
                              {req.profitability_flag === 'green' ? 'Green' : 'Review'}
                            </span>
                          </td>
                          <td className="px-4 py-3 whitespace-nowrap text-xs text-gray-500 uppercase">
                            {req.approval_tier || '-'}
                          </td>
                        </>
                      )}
                      <td className="px-4 py-3 whitespace-nowrap">
                        <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${STATUS_COLOURS[req.status]}`}>
                          {STATUS_LABELS[req.status]}
                        </span>
                      </td>
                      <td className="px-4 py-3 whitespace-nowrap text-sm text-gray-500">
                        {new Date(req.submitted_at).toLocaleDateString('en-AU')}
                      </td>
                      <td className="px-4 py-3 whitespace-nowrap text-sm">
                        <Link href={`/requests/${req.id}`} className="text-blue-600 hover:text-blue-800">
                          View
                        </Link>
                        {req.status === 'submitted' && isValidator && (
                          <Link href={`/requests/${req.id}/validate`} className="ml-3 text-orange-600 hover:text-orange-800">
                            Validate
                          </Link>
                        )}
                        {req.status === 'pending_approval' && isApprover && (
                          <Link href={`/requests/${req.id}/approve`} className="ml-3 text-green-600 hover:text-green-800">
                            Approve
                          </Link>
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
    </div>
  )
}
