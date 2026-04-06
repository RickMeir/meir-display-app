'use client'

import { useState, useEffect, useCallback } from 'react'
import { useRouter } from 'next/navigation'
import { createBrowserClient } from '@supabase/ssr'
import {
  ArrowLeft,
  CheckCircle,
  AlertTriangle,
  Link2,
  Search,
  Trash2,
} from 'lucide-react'
import Link from 'next/link'

interface UnmatchedCustomer {
  customer_name: string
  customer_code: string
  customer_group: string
  row_count: number
  upload_count: number
}

interface DisplayOption {
  id: string
  store_name: string
  store_code: string
  status: string
}

interface Alias {
  id: string
  acumatica_name: string
  display_request_id: string
  created_at: string
  notes: string | null
}

export default function MismatchesPage() {
  const router = useRouter()
  const [loading, setLoading] = useState(true)
  const [userRole, setUserRole] = useState<string | null>(null)
  const [unmatched, setUnmatched] = useState<UnmatchedCustomer[]>([])
  const [displays, setDisplays] = useState<DisplayOption[]>([])
  const [aliases, setAliases] = useState<Alias[]>([])
  const [totalUnmatchedRows, setTotalUnmatchedRows] = useState(0)
  const [searchFilter, setSearchFilter] = useState('')
  const [assigning, setAssigning] = useState<string | null>(null)
  const [selectedDisplay, setSelectedDisplay] = useState<Record<string, string>>({})
  const [displaySearch, setDisplaySearch] = useState<Record<string, string>>({})
  const [successMessage, setSuccessMessage] = useState<string | null>(null)
  const [error, setError] = useState<string | null>(null)

  const fetchData = useCallback(async () => {
    try {
      const res = await fetch('/api/actuals/mismatches')
      if (res.ok) {
        const data = await res.json()
        setUnmatched(data.data.unmatched || [])
        setDisplays(data.data.displays || [])
        setAliases(data.data.aliases || [])
        setTotalUnmatchedRows(data.data.total_unmatched_rows || 0)
      }
    } catch {
      // Non-critical
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => {
    async function checkAuth() {
      const supabase = createBrowserClient(
        process.env.NEXT_PUBLIC_SUPABASE_URL!,
        process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
      )
      const {
        data: { user },
      } = await supabase.auth.getUser()

      if (!user) {
        router.push('/login')
        return
      }

      const { data: userData } = await supabase
        .from('users')
        .select('role')
        .eq('email', user.email)
        .single()

      if (!userData || !['admin', 'manager', 'cfo', 'coo', 'validator'].includes(userData.role)) {
        router.push('/dashboard')
        return
      }

      setUserRole(userData.role)
      fetchData()
    }
    checkAuth()
  }, [router, fetchData])

  async function handleAssign(customerName: string) {
    const displayId = selectedDisplay[customerName]
    if (!displayId) return

    setAssigning(customerName)
    setError(null)
    setSuccessMessage(null)

    try {
      const res = await fetch('/api/actuals/mismatches', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          customerName,
          displayRequestId: displayId,
        }),
      })

      const data = await res.json()

      if (!res.ok) {
        setError(data.error || 'Failed to create alias')
      } else {
        const display = displays.find((d) => d.id === displayId)
        setSuccessMessage(
          `Mapped "${customerName}" to "${display?.store_name || '?'}" — ${data.data.rows_matched} rows matched.`
        )
        // Clear the selection for this customer
        setSelectedDisplay((prev) => {
          const next = { ...prev }
          delete next[customerName]
          return next
        })
        setDisplaySearch((prev) => {
          const next = { ...prev }
          delete next[customerName]
          return next
        })
        fetchData() // Refresh
      }
    } catch {
      setError('Network error. Please try again.')
    } finally {
      setAssigning(null)
    }
  }

  async function handleDeleteAlias(aliasId: string) {
    try {
      const res = await fetch(`/api/actuals/mismatches?id=${aliasId}`, {
        method: 'DELETE',
      })

      if (res.ok) {
        fetchData()
      }
    } catch {
      // Non-critical
    }
  }

  const filteredUnmatched = unmatched.filter((c) =>
    searchFilter
      ? c.customer_name.toLowerCase().includes(searchFilter.toLowerCase()) ||
        c.customer_code.toLowerCase().includes(searchFilter.toLowerCase()) ||
        c.customer_group.toLowerCase().includes(searchFilter.toLowerCase())
      : true
  )

  function getFilteredDisplays(customerName: string): DisplayOption[] {
    const search = (displaySearch[customerName] || '').toLowerCase()
    if (!search) return displays
    return displays.filter(
      (d) =>
        d.store_name.toLowerCase().includes(search) ||
        d.store_code.toLowerCase().includes(search)
    )
  }

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <p className="text-gray-500">Loading...</p>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-5xl mx-auto px-4 py-8">
        {/* Header */}
        <div className="mb-8">
          <Link
            href="/actuals/upload"
            className="text-sm text-blue-600 hover:text-blue-800 flex items-center gap-1 mb-4"
          >
            <ArrowLeft className="w-4 h-4" />
            Back to Uploads
          </Link>
          <h1 className="text-2xl font-bold text-gray-900">Customer Name Mismatches</h1>
          <p className="text-gray-600 mt-1">
            These Acumatica customer names could not be matched to any display request.
            Assign each one to the correct display to create a permanent alias.
          </p>
        </div>

        {/* Summary bar */}
        <div className="bg-gray-300 border border-gray-300 rounded-lg p-4 mb-6 flex items-center gap-6">
          <div>
            <p className="text-sm text-gray-500">Unmatched customers</p>
            <p className="text-2xl font-bold text-amber-600">{unmatched.length}</p>
          </div>
          <div>
            <p className="text-sm text-gray-500">Unmatched rows</p>
            <p className="text-2xl font-bold text-amber-600">{totalUnmatchedRows.toLocaleString()}</p>
          </div>
          <div>
            <p className="text-sm text-gray-500">Active aliases</p>
            <p className="text-2xl font-bold text-green-600">{aliases.length}</p>
          </div>
        </div>

        {/* Messages */}
        {successMessage && (
          <div className="mb-4 p-4 bg-green-50 border border-green-200 rounded-lg flex items-start gap-3">
            <CheckCircle className="w-5 h-5 text-green-500 mt-0.5 flex-shrink-0" />
            <p className="text-green-800">{successMessage}</p>
          </div>
        )}

        {error && (
          <div className="mb-4 p-4 bg-red-50 border border-red-200 rounded-lg flex items-start gap-3">
            <AlertTriangle className="w-5 h-5 text-red-500 mt-0.5 flex-shrink-0" />
            <p className="text-red-800">{error}</p>
          </div>
        )}

        {/* Unmatched list */}
        {unmatched.length === 0 ? (
          <div className="bg-gray-300 border border-gray-300 rounded-lg p-12 text-center">
            <CheckCircle className="w-12 h-12 text-green-400 mx-auto mb-3" />
            <p className="text-gray-600 text-lg">All customers are matched.</p>
            <p className="text-gray-400 text-sm mt-1">No unresolved mismatches.</p>
          </div>
        ) : (
          <>
            {/* Search filter */}
            <div className="mb-4 relative">
              <Search className="w-4 h-4 text-gray-400 absolute left-3 top-3" />
              <input
                type="text"
                value={searchFilter}
                onChange={(e) => setSearchFilter(e.target.value)}
                placeholder="Filter by customer name, code, or group..."
                className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              />
            </div>

            <div className="space-y-3">
              {filteredUnmatched.map((customer) => {
                const filtered = getFilteredDisplays(customer.customer_name)

                return (
                  <div
                    key={customer.customer_name}
                    className="bg-gray-300 border border-gray-300 rounded-lg p-4"
                  >
                    <div className="flex items-start gap-4">
                      {/* Customer info */}
                      <div className="flex-1 min-w-0">
                        <p className="font-medium text-gray-900">{customer.customer_name}</p>
                        <div className="flex gap-4 mt-1 text-xs text-gray-500">
                          {customer.customer_code && (
                            <span>Code: {customer.customer_code}</span>
                          )}
                          {customer.customer_group && (
                            <span>Group: {customer.customer_group}</span>
                          )}
                          <span>{customer.row_count} rows</span>
                          <span>
                            {customer.upload_count} upload{customer.upload_count !== 1 ? 's' : ''}
                          </span>
                        </div>
                      </div>

                      {/* Assignment controls */}
                      <div className="flex items-center gap-2 flex-shrink-0">
                        <div className="relative">
                          <input
                            type="text"
                            placeholder="Search displays..."
                            value={displaySearch[customer.customer_name] || ''}
                            onChange={(e) =>
                              setDisplaySearch((prev) => ({
                                ...prev,
                                [customer.customer_name]: e.target.value,
                              }))
                            }
                            className="w-48 text-sm border border-gray-300 rounded-lg px-3 py-1.5 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                          />
                          {(displaySearch[customer.customer_name] || '').length > 0 && filtered.length > 0 && !selectedDisplay[customer.customer_name] && (
                            <div className="absolute z-10 mt-1 w-72 bg-white border border-gray-200 rounded-lg shadow-lg max-h-48 overflow-y-auto">
                              {filtered.slice(0, 10).map((d) => (
                                <button
                                  key={d.id}
                                  onClick={() => {
                                    setSelectedDisplay((prev) => ({
                                      ...prev,
                                      [customer.customer_name]: d.id,
                                    }))
                                    setDisplaySearch((prev) => ({
                                      ...prev,
                                      [customer.customer_name]: d.store_name,
                                    }))
                                  }}
                                  className="w-full text-left px-3 py-2 hover:bg-blue-50 text-sm border-b border-gray-100 last:border-0"
                                >
                                  <span className="font-medium text-gray-900">{d.store_name}</span>
                                  {d.store_code && (
                                    <span className="text-gray-500 ml-2">({d.store_code})</span>
                                  )}
                                </button>
                              ))}
                            </div>
                          )}
                        </div>

                        <button
                          onClick={() => handleAssign(customer.customer_name)}
                          disabled={
                            !selectedDisplay[customer.customer_name] ||
                            assigning === customer.customer_name
                          }
                          className="inline-flex items-center gap-1 text-sm bg-blue-600 hover:bg-blue-700 text-white px-3 py-1.5 rounded-lg font-medium transition-colors disabled:bg-gray-300 disabled:cursor-not-allowed"
                        >
                          <Link2 className="w-3 h-3" />
                          {assigning === customer.customer_name ? 'Mapping...' : 'Map'}
                        </button>
                      </div>
                    </div>
                  </div>
                )
              })}
            </div>
          </>
        )}

        {/* Existing aliases */}
        {aliases.length > 0 && (
          <div className="mt-10">
            <h2 className="text-lg font-semibold text-gray-900 mb-4">Active Aliases</h2>
            <p className="text-sm text-gray-500 mb-3">
              These mappings are applied automatically on every upload. Future uploads will
              match these Acumatica names to the assigned display request.
            </p>
            <div className="bg-gray-300 border border-gray-300 rounded-lg overflow-hidden">
              <table className="w-full text-sm">
                <thead className="bg-gray-400">
                  <tr>
                    <th className="text-left px-4 py-3 text-gray-500 font-medium">
                      Acumatica Name
                    </th>
                    <th className="text-left px-4 py-3 text-gray-500 font-medium">
                      Mapped To
                    </th>
                    <th className="text-right px-4 py-3 text-gray-500 font-medium">
                      Created
                    </th>
                    {userRole && ['admin', 'coo', 'cfo'].includes(userRole) && (
                      <th className="text-center px-4 py-3 text-gray-500 font-medium w-16"></th>
                    )}
                  </tr>
                </thead>
                <tbody>
                  {aliases.map((alias) => {
                    const display = displays.find((d) => d.id === alias.display_request_id)
                    return (
                      <tr key={alias.id} className="border-t border-gray-100">
                        <td className="px-4 py-3 text-gray-700 font-medium">
                          {alias.acumatica_name}
                        </td>
                        <td className="px-4 py-3 text-gray-700">
                          {display ? (
                            <span>
                              {display.store_name}
                              {display.store_code && (
                                <span className="text-gray-400 ml-1">
                                  ({display.store_code})
                                </span>
                              )}
                            </span>
                          ) : (
                            <span className="text-gray-400 italic">Unknown display</span>
                          )}
                        </td>
                        <td className="px-4 py-3 text-right text-gray-500">
                          {new Date(alias.created_at).toLocaleDateString('en-AU', {
                            day: 'numeric',
                            month: 'short',
                            year: 'numeric',
                          })}
                        </td>
                        {userRole && ['admin', 'coo', 'cfo'].includes(userRole) && (
                          <td className="px-4 py-3 text-center">
                            <button
                              onClick={() => handleDeleteAlias(alias.id)}
                              className="text-gray-400 hover:text-red-600 transition-colors"
                              title="Remove alias"
                            >
                              <Trash2 className="w-4 h-4" />
                            </button>
                          </td>
                        )}
                      </tr>
                    )
                  })}
                </tbody>
              </table>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
