'use client'

import { useEffect, useState } from 'react'
import { useSearchParams } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/client'
import { DisplayRequest, STATUS_LABELS, STATUS_COLOURS } from '@/lib/types'
import { formatCurrency } from '@/lib/calculations'

export default function RequestsListPage() {
  const [requests, setRequests] = useState<DisplayRequest[]>([])
  const [userRole, setUserRole] = useState<string>('rep')
  const [loading, setLoading] = useState(true)
  const searchParams = useSearchParams()
  const success = searchParams.get('success')

  useEffect(() => {
    async function load() {
      const supabase = createClient()
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) return

      // Get role
      const { data: userData } = await supabase
        .from('users')
        .select('role')
        .eq('email', user.email)
        .single()

      if (userData) setUserRole(userData.role)

      // Fetch requests
      const res = await fetch('/api/requests')
      if (res.ok) {
        const data = await res.json()
        setRequests(data)
      }
      setLoading(false)
    }
    load()
  }, [])

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
          {userRole === 'rep' ? 'My Requests' : 'All Requests'}
        </h1>
        {(userRole === 'rep' || userRole === 'admin') && (
          <Link
            href="/requests/new"
            className="px-4 py-2 bg-meir-600 text-white rounded-lg hover:bg-meir-700 transition"
          >
            New Request
          </Link>
        )}
      </div>

      {requests.length === 0 ? (
        <div className="text-center py-12 text-gray-500">
          <p>No display requests found.</p>
          {userRole === 'rep' && (
            <Link href="/requests/new" className="text-meir-600 hover:underline mt-2 inline-block">
              Submit your first request
            </Link>
          )}
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow overflow-hidden">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Store</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Rep</th>
                {userRole !== 'rep' && (
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Investment</th>
                )}
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Action</th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {requests.map((req, i) => (
                <tr key={req.id} className={i % 2 === 0 ? 'bg-white' : 'bg-gray-50'}>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="font-medium text-gray-900">{req.store_name}</div>
                    <div className="text-sm text-gray-500">{req.store_code}</div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-700">{req.rep_name}</td>
                  {userRole !== 'rep' && (
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                      {formatCurrency(req.total_investment)}
                    </td>
                  )}
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${STATUS_COLOURS[req.status]}`}>
                      {STATUS_LABELS[req.status]}
                    </span>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    {new Date(req.submitted_at).toLocaleDateString('en-AU')}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm">
                    <Link href={`/requests/${req.id}`} className="text-meir-600 hover:text-meir-800">
                      View
                    </Link>
                    {req.status === 'submitted' && (userRole === 'validator' || userRole === 'admin') && (
                      <Link href={`/requests/${req.id}/validate`} className="ml-3 text-orange-600 hover:text-orange-800">
                        Validate
                      </Link>
                    )}
                    {req.status === 'pending_approval' && ['manager', 'cfo', 'coo', 'admin'].includes(userRole) && (
                      <Link href={`/requests/${req.id}/approve`} className="ml-3 text-green-600 hover:text-green-800">
                        Approve
                      </Link>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  )
}
