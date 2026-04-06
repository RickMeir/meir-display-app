'use client'

import { useEffect, useState } from 'react'
import { createClient } from '@/lib/supabase/client'

interface ExportOption {
  type: string
  label: string
  description: string
}

const EXPORT_OPTIONS: ExportOption[] = [
  {
    type: 'requests',
    label: 'Display Requests',
    description: 'All display requests with store details, financial inputs, calculated fields, status, and tracking.',
  },
  {
    type: 'actuals',
    label: 'Monthly Actuals',
    description: 'Monthly revenue actuals per display, including source (manual or upload) and date.',
  },
  {
    type: 'skus',
    label: 'Display SKUs',
    description: 'All SKUs linked to each display request.',
  },
  {
    type: 'expenses',
    label: 'Additional Expenses',
    description: 'Post-approval additional expense requests with ROI impact, approval status, and spiral tracking.',
  },
  {
    type: 'forecast_changes',
    label: 'Forecast Changes',
    description: 'Audit trail of every forecast modification, with old/new values, percentage change, and reason.',
  },
  {
    type: 'lifecycle_reviews',
    label: 'Lifecycle Reviews',
    description: '3/6/9/12 month check-in records with expected vs actual revenue and tracking assessment.',
  },
  {
    type: 'expected_performance',
    label: 'Expected Performance',
    description: 'Month-by-month expected revenue schedule per display (based on forecast and installation date).',
  },
  {
    type: 'audit_log',
    label: 'Audit Log',
    description: 'Full audit trail of all actions: submissions, validations, approvals, overrides, forecast changes, expenses.',
  },
]

export default function ExportPage() {
  const [userRole, setUserRole] = useState<string>('')
  const [loading, setLoading] = useState(true)
  const [downloading, setDownloading] = useState<string | null>(null)

  useEffect(() => {
    async function checkAccess() {
      const supabase = createClient()
      const { data: { user } } = await supabase.auth.getUser()
      if (user?.email) {
        const { data } = await supabase
          .from('users')
          .select('role')
          .eq('email', user.email)
          .single()
        if (data) setUserRole(data.role)
      }
      setLoading(false)
    }
    checkAccess()
  }, [])

  async function handleExport(type: string) {
    setDownloading(type)
    try {
      const res = await fetch(`/api/export?type=${type}`)
      if (!res.ok) {
        const err = await res.json()
        alert(err.error || 'Export failed')
        return
      }

      const blob = await res.blob()
      const disposition = res.headers.get('Content-Disposition') || ''
      const filenameMatch = disposition.match(/filename="(.+)"/)
      const filename = filenameMatch ? filenameMatch[1] : `${type}_export.csv`

      const url = window.URL.createObjectURL(blob)
      const a = document.createElement('a')
      a.href = url
      a.download = filename
      document.body.appendChild(a)
      a.click()
      document.body.removeChild(a)
      window.URL.revokeObjectURL(url)
    } catch {
      alert('Export failed. Please try again.')
    } finally {
      setDownloading(null)
    }
  }

  if (loading) return <div className="text-center py-12 text-gray-400">Loading...</div>

  if (!['admin', 'coo', 'cfo', 'manager'].includes(userRole)) {
    return (
      <div className="max-w-3xl mx-auto py-12 text-center">
        <h1 className="text-2xl font-bold text-gray-100 mb-4">Data Export</h1>
        <p className="text-gray-400">You do not have permission to export data. Contact Rick if you need access.</p>
      </div>
    )
  }

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-gray-100">Data Export</h1>
        <p className="text-gray-400 mt-1">Download display data as CSV files. All exports include the full dataset.</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {EXPORT_OPTIONS.map((opt) => (
          <div key={opt.type} className="bg-gray-400 rounded-lg shadow p-5 flex flex-col justify-between">
            <div>
              <h3 className="font-semibold text-gray-900 text-lg">{opt.label}</h3>
              <p className="text-sm text-gray-600 mt-1">{opt.description}</p>
            </div>
            <button
              onClick={() => handleExport(opt.type)}
              disabled={downloading !== null}
              className="mt-4 w-full px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:bg-gray-500 transition text-sm font-medium"
            >
              {downloading === opt.type ? 'Downloading...' : 'Download CSV'}
            </button>
          </div>
        ))}
      </div>

      <div className="bg-gray-400 rounded-lg shadow p-5">
        <h3 className="font-semibold text-gray-900">About these exports</h3>
        <p className="text-sm text-gray-600 mt-2">
          Exports are generated live from the database. Each file includes all records with no date filtering.
          Files are standard CSV format and can be opened in Excel, Google Sheets, or any data tool.
          The audit log is capped at the most recent 5,000 entries.
        </p>
        <p className="text-sm text-gray-600 mt-2">
          Export access is restricted to admin, manager, CFO, and COO roles.
        </p>
      </div>
    </div>
  )
}
