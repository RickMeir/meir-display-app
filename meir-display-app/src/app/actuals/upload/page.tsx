'use client'

import { useState, useEffect, useCallback, useRef } from 'react'
import { useRouter } from 'next/navigation'
import { createBrowserClient } from '@supabase/ssr'
import { Upload, FileSpreadsheet, CheckCircle, AlertCircle, Clock, ArrowLeft, Trash2, Eye, Send } from 'lucide-react'
import Link from 'next/link'

interface PreviewData {
  filename: string
  total_rows: number
  matched: number
  unmatched: number
  match_rate: number
  date_range: { from: string | null; to: string | null }
  sheet_used: string
  total_net_sales: number
  total_cost: number
  total_margin: number
  top_customers: { name: string; rows: number; net_sales: number; matched: boolean; match_method: string }[]
  top_unmatched: { name: string; rows: number }[]
  duplicate_warning: string | null
}

interface UploadSummary {
  upload_id: string
  total_rows: number
  matched: number
  unmatched: number
  match_rate: number
  date_range: { from: string | null; to: string | null }
  sheet_used: string
  top_unmatched: { name: string; rows: number }[]
  duplicate_warning: string | null
}

interface PastUpload {
  id: string
  filename: string
  uploaded_at: string
  date_range_from: string | null
  date_range_to: string | null
  total_rows: number
  matched_rows: number
  unmatched_rows: number
  status: string
  approval_status: string
  approved_by: string | null
  approved_at: string | null
  summary: UploadSummary | null
}

export default function UploadActualsPage() {
  const router = useRouter()
  const [userRole, setUserRole] = useState<string | null>(null)
  const [loading, setLoading] = useState(true)
  const [previewing, setPreviewing] = useState(false)
  const [uploading, setUploading] = useState(false)
  const [preview, setPreview] = useState<PreviewData | null>(null)
  const [result, setResult] = useState<UploadSummary | null>(null)
  const [error, setError] = useState<string | null>(null)
  const [pastUploads, setPastUploads] = useState<PastUpload[]>([])
  const [dragOver, setDragOver] = useState(false)
  const [deleteConfirm, setDeleteConfirm] = useState<PastUpload | null>(null)
  const [deleting, setDeleting] = useState(false)
  const [approving, setApproving] = useState<string | null>(null)
  const pendingFileRef = useRef<File | null>(null)

  const fetchUploads = useCallback(async () => {
    try {
      const res = await fetch('/api/actuals/upload')
      if (res.ok) {
        const data = await res.json()
        setPastUploads(data.data || [])
      }
    } catch {
      // Non-critical
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

      if (!userData || !['admin', 'manager', 'cfo', 'coo'].includes(userData.role)) {
        router.push('/dashboard')
        return
      }

      setUserRole(userData.role)
      setLoading(false)
      fetchUploads()
    }
    checkAuth()
  }, [router, fetchUploads])

  // Step 1: Preview the file (parse only, no database writes)
  async function handlePreview(file: File) {
    setPreviewing(true)
    setError(null)
    setResult(null)
    setPreview(null)
    pendingFileRef.current = file

    const formData = new FormData()
    formData.append('file', file)

    try {
      const res = await fetch('/api/actuals/upload/preview', {
        method: 'POST',
        body: formData,
      })

      const data = await res.json()

      if (!res.ok) {
        setError(data.error || 'Preview failed')
        pendingFileRef.current = null
      } else {
        setPreview(data.data)
      }
    } catch {
      setError('Network error. Please try again.')
      pendingFileRef.current = null
    } finally {
      setPreviewing(false)
    }
  }

  // Step 2: Confirm and commit the upload
  async function handleConfirmUpload() {
    const file = pendingFileRef.current
    if (!file) return

    setUploading(true)
    setError(null)

    const formData = new FormData()
    formData.append('file', file)

    try {
      const res = await fetch('/api/actuals/upload', {
        method: 'POST',
        body: formData,
      })

      const data = await res.json()

      if (!res.ok) {
        setError(data.error || 'Upload failed')
      } else {
        setResult(data.data)
        setPreview(null)
        pendingFileRef.current = null
        fetchUploads()
      }
    } catch {
      setError('Network error. Please try again.')
    } finally {
      setUploading(false)
    }
  }

  function handleCancel() {
    setPreview(null)
    pendingFileRef.current = null
    setError(null)
  }

  function handleFileSelect(e: React.ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0]
    if (file) handlePreview(file)
    // Reset input so the same file can be re-selected
    e.target.value = ''
  }

  function handleDrop(e: React.DragEvent) {
    e.preventDefault()
    setDragOver(false)
    const file = e.dataTransfer.files?.[0]
    if (file) handlePreview(file)
  }

  async function handleApprove(uploadId: string) {
    setApproving(uploadId)
    setError(null)

    try {
      const res = await fetch('/api/actuals/upload/approve', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ uploadId }),
      })

      const data = await res.json()

      if (!res.ok) {
        setError(data.error || 'Approval failed')
      } else {
        fetchUploads()
      }
    } catch {
      setError('Network error. Please try again.')
    } finally {
      setApproving(null)
    }
  }

  async function handleDelete(upload: PastUpload) {
    setDeleting(true)
    setError(null)

    try {
      const res = await fetch(`/api/actuals/upload?id=${upload.id}`, {
        method: 'DELETE',
      })

      const data = await res.json()

      if (!res.ok) {
        setError(data.error || 'Delete failed')
      } else {
        setDeleteConfirm(null)
        fetchUploads()
      }
    } catch {
      setError('Network error. Please try again.')
    } finally {
      setDeleting(false)
    }
  }

  function formatCurrency(n: number) {
    return new Intl.NumberFormat('en-AU', { style: 'currency', currency: 'AUD', minimumFractionDigits: 0, maximumFractionDigits: 0 }).format(n)
  }

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <p className="text-gray-500">Loading...</p>
      </div>
    )
  }

  if (!userRole) return null

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-4xl mx-auto px-4 py-8">
        {/* Header */}
        <div className="mb-8">
          <Link
            href="/requests"
            className="text-sm text-blue-600 hover:text-blue-800 flex items-center gap-1 mb-4"
          >
            <ArrowLeft className="w-4 h-4" />
            Back to Register
          </Link>
          <div className="flex items-center justify-between">
            <h1 className="text-2xl font-bold text-gray-900">Upload Sales Actuals</h1>
            <Link
              href="/actuals/mismatches"
              className="text-sm text-blue-600 hover:text-blue-800 font-medium"
            >
              Resolve mismatches
            </Link>
          </div>
          <p className="text-gray-600 mt-1">
            Upload an Acumatica &quot;Daily Sales Profitability (Detailed)&quot; export to update
            actual sales data for tracked displays.
          </p>
        </div>

        {/* Upload area — hidden when preview or result is showing */}
        {!preview && !result && (
          <div
            className={`border-2 border-dashed rounded-lg p-12 text-center transition-colors ${
              dragOver
                ? 'border-blue-500 bg-blue-50'
                : previewing
                ? 'border-gray-300 bg-gray-50'
                : 'border-gray-300 hover:border-gray-400'
            }`}
            onDragOver={(e) => {
              e.preventDefault()
              setDragOver(true)
            }}
            onDragLeave={() => setDragOver(false)}
            onDrop={handleDrop}
          >
            {previewing ? (
              <div className="flex flex-col items-center gap-3">
                <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-blue-600"></div>
                <p className="text-gray-600">Analysing file... This may take a moment.</p>
              </div>
            ) : (
              <div className="flex flex-col items-center gap-3">
                <Upload className="w-12 h-12 text-gray-400" />
                <p className="text-gray-600">
                  Drag and drop your Excel file here, or{' '}
                  <label className="text-blue-600 hover:text-blue-800 cursor-pointer underline">
                    browse
                    <input
                      type="file"
                      accept=".xlsx,.xls"
                      className="hidden"
                      onChange={handleFileSelect}
                    />
                  </label>
                </p>
                <p className="text-sm text-gray-400">Accepts .xlsx and .xls files</p>
              </div>
            )}
          </div>
        )}

        {/* Error */}
        {error && (
          <div className="mt-4 p-4 bg-red-50 border border-red-200 rounded-lg flex items-start gap-3">
            <AlertCircle className="w-5 h-5 text-red-500 mt-0.5 flex-shrink-0" />
            <div>
              <p className="text-red-800 font-medium">Error</p>
              <p className="text-red-600 text-sm mt-1">{error}</p>
            </div>
          </div>
        )}

        {/* Preview — step 1 result, before committing */}
        {preview && !result && (
          <div className="mt-6 bg-gray-300 border border-blue-200 rounded-lg p-6">
            <div className="flex items-center gap-2 mb-2">
              <Eye className="w-5 h-5 text-blue-500" />
              <h2 className="text-lg font-semibold text-gray-900">Upload Preview</h2>
            </div>
            <p className="text-sm text-gray-500 mb-4">
              Review the data below. Nothing has been saved yet. Click <strong>Confirm Upload</strong> to commit this data, or <strong>Cancel</strong> to discard.
            </p>

            {preview.duplicate_warning && (
              <div className="mb-4 p-3 bg-amber-50 border border-amber-200 rounded-lg flex items-start gap-2">
                <AlertCircle className="w-4 h-4 text-amber-500 mt-0.5 flex-shrink-0" />
                <p className="text-sm text-amber-800">{preview.duplicate_warning}</p>
              </div>
            )}

            {/* Summary stats */}
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
              <div className="bg-gray-50 rounded p-3">
                <p className="text-sm text-gray-500">Total Rows</p>
                <p className="text-xl font-bold">{preview.total_rows.toLocaleString()}</p>
              </div>
              <div className="bg-green-50 rounded p-3">
                <p className="text-sm text-gray-500">Will Match</p>
                <p className="text-xl font-bold text-green-700">{preview.matched.toLocaleString()}</p>
              </div>
              <div className="bg-amber-50 rounded p-3">
                <p className="text-sm text-gray-500">Unmatched</p>
                <p className="text-xl font-bold text-amber-700">{preview.unmatched.toLocaleString()}</p>
              </div>
              <div className="bg-blue-50 rounded p-3">
                <p className="text-sm text-gray-500">Match Rate</p>
                <p className="text-xl font-bold text-blue-700">{preview.match_rate}%</p>
              </div>
            </div>

            {/* Financial totals */}
            <div className="grid grid-cols-3 gap-4 mb-6">
              <div className="bg-gray-50 rounded p-3">
                <p className="text-sm text-gray-500">Total Net Sales</p>
                <p className="text-lg font-semibold">{formatCurrency(preview.total_net_sales)}</p>
              </div>
              <div className="bg-gray-50 rounded p-3">
                <p className="text-sm text-gray-500">Total Cost</p>
                <p className="text-lg font-semibold">{formatCurrency(preview.total_cost)}</p>
              </div>
              <div className="bg-gray-50 rounded p-3">
                <p className="text-sm text-gray-500">Total Margin</p>
                <p className="text-lg font-semibold">{formatCurrency(preview.total_margin)}</p>
              </div>
            </div>

            {preview.date_range.from && preview.date_range.to && (
              <p className="text-sm text-gray-500 mb-4">
                Data covers <strong>{preview.date_range.from}</strong> to <strong>{preview.date_range.to}</strong> (from sheet &quot;{preview.sheet_used}&quot;)
              </p>
            )}

            {/* Top customers table */}
            {preview.top_customers.length > 0 && (
              <div className="mb-6">
                <h3 className="text-sm font-medium text-gray-700 mb-2">
                  Top customers by revenue (showing {Math.min(preview.top_customers.length, 30)} of{' '}
                  {Object.keys(preview.top_customers).length}):
                </h3>
                <div className="bg-gray-50 rounded p-3 max-h-64 overflow-y-auto">
                  <table className="w-full text-sm">
                    <thead>
                      <tr className="text-left text-gray-500">
                        <th className="pb-1">Customer</th>
                        <th className="pb-1 text-right">Rows</th>
                        <th className="pb-1 text-right">Net Sales</th>
                        <th className="pb-1 text-center">Match</th>
                      </tr>
                    </thead>
                    <tbody>
                      {preview.top_customers.map((c) => (
                        <tr key={c.name} className="border-t border-gray-100">
                          <td className="py-1 text-gray-700">{c.name}</td>
                          <td className="py-1 text-right text-gray-500">{c.rows}</td>
                          <td className="py-1 text-right text-gray-700">{formatCurrency(c.net_sales)}</td>
                          <td className="py-1 text-center">
                            {c.matched ? (
                              <span className="inline-flex items-center gap-1 text-green-700 bg-green-50 px-2 py-0.5 rounded text-xs">
                                <CheckCircle className="w-3 h-3" />
                                {c.match_method === 'exact_name' ? 'Name' : c.match_method === 'alias' ? 'Alias' : c.match_method === 'exact_code' ? 'Code' : 'Group'}
                              </span>
                            ) : (
                              <span className="text-amber-600 text-xs">No match</span>
                            )}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            )}

            {/* Action buttons */}
            <div className="flex gap-3 justify-end pt-4 border-t border-gray-200">
              <button
                onClick={handleCancel}
                disabled={uploading}
                className="px-4 py-2 text-sm text-gray-700 bg-gray-200 hover:bg-gray-300 rounded-lg transition-colors"
              >
                Cancel
              </button>
              <button
                onClick={handleConfirmUpload}
                disabled={uploading}
                className="px-5 py-2 text-sm text-white bg-blue-600 hover:bg-blue-700 rounded-lg transition-colors disabled:opacity-50 flex items-center gap-2"
              >
                {uploading ? (
                  <>
                    <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                    Uploading...
                  </>
                ) : (
                  <>
                    <Send className="w-4 h-4" />
                    Confirm Upload
                  </>
                )}
              </button>
            </div>
          </div>
        )}

        {/* Committed result */}
        {result && (
          <div className="mt-6 bg-gray-300 border border-gray-200 rounded-lg p-6">
            <div className="flex items-center gap-2 mb-2">
              <CheckCircle className="w-5 h-5 text-green-500" />
              <h2 className="text-lg font-semibold text-gray-900">Upload Complete</h2>
            </div>
            <p className="text-sm text-amber-700 bg-amber-50 border border-amber-200 rounded px-3 py-2 mb-4">
              This upload is awaiting approval before the data flows into monthly actuals.
            </p>

            <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
              <div className="bg-gray-50 rounded p-3">
                <p className="text-sm text-gray-500">Total Rows</p>
                <p className="text-xl font-bold">{result.total_rows.toLocaleString()}</p>
              </div>
              <div className="bg-green-50 rounded p-3">
                <p className="text-sm text-gray-500">Matched</p>
                <p className="text-xl font-bold text-green-700">
                  {result.matched.toLocaleString()}
                </p>
              </div>
              <div className="bg-amber-50 rounded p-3">
                <p className="text-sm text-gray-500">Unmatched</p>
                <p className="text-xl font-bold text-amber-700">
                  {result.unmatched.toLocaleString()}
                </p>
              </div>
              <div className="bg-blue-50 rounded p-3">
                <p className="text-sm text-gray-500">Match Rate</p>
                <p className="text-xl font-bold text-blue-700">{result.match_rate}%</p>
              </div>
            </div>

            {result.duplicate_warning && (
              <div className="mb-4 p-3 bg-amber-50 border border-amber-200 rounded-lg flex items-start gap-2">
                <AlertCircle className="w-4 h-4 text-amber-500 mt-0.5 flex-shrink-0" />
                <p className="text-sm text-amber-800">{result.duplicate_warning}</p>
              </div>
            )}

            {result.date_range.from && result.date_range.to && (
              <p className="text-sm text-gray-500 mb-4">
                Data covers {result.date_range.from} to {result.date_range.to} (from sheet &quot;{result.sheet_used}&quot;)
              </p>
            )}

            {result.top_unmatched.length > 0 && (
              <div>
                <h3 className="text-sm font-medium text-gray-700 mb-2">
                  Top unmatched customers:
                </h3>
                <div className="bg-gray-50 rounded p-3 max-h-48 overflow-y-auto">
                  <table className="w-full text-sm">
                    <thead>
                      <tr className="text-left text-gray-500">
                        <th className="pb-1">Customer</th>
                        <th className="pb-1 text-right">Rows</th>
                      </tr>
                    </thead>
                    <tbody>
                      {result.top_unmatched.map((c) => (
                        <tr key={c.name} className="border-t border-gray-100">
                          <td className="py-1 text-gray-700">{c.name}</td>
                          <td className="py-1 text-right text-gray-500">{c.rows}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            )}

            <div className="mt-4 pt-4 border-t border-gray-200">
              <button
                onClick={() => {
                  setResult(null)
                  setError(null)
                }}
                className="text-sm text-blue-600 hover:text-blue-800"
              >
                Upload another file
              </button>
            </div>
          </div>
        )}

        {/* Past uploads */}
        {pastUploads.length > 0 && (
          <div className="mt-8">
            <h2 className="text-lg font-semibold text-gray-900 mb-4">Upload History</h2>
            <div className="bg-gray-300 border border-gray-200 rounded-lg overflow-hidden">
              <table className="w-full text-sm">
                <thead className="bg-gray-400">
                  <tr>
                    <th className="text-left px-4 py-3 text-gray-500 font-medium">File</th>
                    <th className="text-left px-4 py-3 text-gray-500 font-medium">Date Range</th>
                    <th className="text-right px-4 py-3 text-gray-500 font-medium">Rows</th>
                    <th className="text-right px-4 py-3 text-gray-500 font-medium">Matched</th>
                    <th className="text-center px-4 py-3 text-gray-500 font-medium">Status</th>
                    <th className="text-center px-4 py-3 text-gray-500 font-medium">Approval</th>
                    <th className="text-right px-4 py-3 text-gray-500 font-medium">Uploaded</th>
                    {userRole && ['admin', 'coo', 'cfo'].includes(userRole) && (
                      <th className="text-center px-4 py-3 text-gray-500 font-medium w-16"></th>
                    )}
                  </tr>
                </thead>
                <tbody>
                  {pastUploads.map((u) => (
                    <tr key={u.id} className="border-t border-gray-100">
                      <td className="px-4 py-3">
                        <div className="flex items-center gap-2">
                          <FileSpreadsheet className="w-4 h-4 text-green-600" />
                          <span className="text-gray-700">{u.filename}</span>
                        </div>
                      </td>
                      <td className="px-4 py-3 text-gray-500">
                        {u.date_range_from && u.date_range_to
                          ? `${u.date_range_from} — ${u.date_range_to}`
                          : '—'}
                      </td>
                      <td className="px-4 py-3 text-right text-gray-700">
                        {u.total_rows.toLocaleString()}
                      </td>
                      <td className="px-4 py-3 text-right text-gray-700">
                        {u.matched_rows.toLocaleString()}
                      </td>
                      <td className="px-4 py-3 text-center">
                        {u.status === 'completed' ? (
                          <span className="inline-flex items-center gap-1 text-green-700 bg-green-50 px-2 py-0.5 rounded text-xs">
                            <CheckCircle className="w-3 h-3" /> Done
                          </span>
                        ) : u.status === 'failed' ? (
                          <span className="inline-flex items-center gap-1 text-red-700 bg-red-50 px-2 py-0.5 rounded text-xs">
                            <AlertCircle className="w-3 h-3" /> Failed
                          </span>
                        ) : (
                          <span className="inline-flex items-center gap-1 text-amber-700 bg-amber-50 px-2 py-0.5 rounded text-xs">
                            <Clock className="w-3 h-3" /> Processing
                          </span>
                        )}
                      </td>
                      <td className="px-4 py-3 text-center">
                        {u.approval_status === 'approved' ? (
                          <span className="inline-flex items-center gap-1 text-green-700 bg-green-50 px-2 py-0.5 rounded text-xs">
                            <CheckCircle className="w-3 h-3" /> Approved
                          </span>
                        ) : u.approval_status === 'rejected' ? (
                          <span className="inline-flex items-center gap-1 text-red-700 bg-red-50 px-2 py-0.5 rounded text-xs">
                            <AlertCircle className="w-3 h-3" /> Rejected
                          </span>
                        ) : u.status === 'completed' ? (
                          userRole === 'admin' ? (
                            <button
                              onClick={() => handleApprove(u.id)}
                              disabled={approving === u.id}
                              className="inline-flex items-center gap-1 text-sm text-blue-600 hover:text-blue-800 bg-blue-50 hover:bg-blue-100 px-3 py-1 rounded font-medium transition-colors disabled:opacity-50"
                            >
                              {approving === u.id ? 'Approving...' : 'Approve'}
                            </button>
                          ) : (
                            <span className="inline-flex items-center gap-1 text-amber-700 bg-amber-50 px-2 py-0.5 rounded text-xs">
                              <Clock className="w-3 h-3" /> Awaiting approval
                            </span>
                          )
                        ) : (
                          <span className="text-gray-400 text-xs">—</span>
                        )}
                      </td>
                      <td className="px-4 py-3 text-right text-gray-500">
                        {new Date(u.uploaded_at).toLocaleDateString('en-AU', {
                          day: 'numeric',
                          month: 'short',
                          year: 'numeric',
                        })}
                      </td>
                      {userRole && ['admin', 'coo', 'cfo'].includes(userRole) && (
                        <td className="px-4 py-3 text-center">
                          <button
                            onClick={() => setDeleteConfirm(u)}
                            className="text-gray-400 hover:text-red-600 transition-colors"
                            title="Delete upload"
                          >
                            <Trash2 className="w-4 h-4" />
                          </button>
                        </td>
                      )}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* Delete confirmation modal */}
        {deleteConfirm && (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
            <div className="bg-gray-300 rounded-lg p-6 max-w-md mx-4 shadow-xl">
              <div className="flex items-start gap-3 mb-4">
                <AlertCircle className="w-6 h-6 text-red-500 flex-shrink-0 mt-0.5" />
                <div>
                  <h3 className="text-lg font-semibold text-gray-900">Delete upload?</h3>
                  <p className="text-gray-600 mt-1">
                    This will permanently remove <strong>{deleteConfirm.filename}</strong> and
                    all {deleteConfirm.total_rows.toLocaleString()} transaction rows associated
                    with it. Monthly actuals for affected displays will be recalculated from any
                    remaining data.
                  </p>
                  <p className="text-sm text-red-600 mt-2 font-medium">
                    This action cannot be undone.
                  </p>
                </div>
              </div>
              <div className="flex gap-3 justify-end">
                <button
                  onClick={() => setDeleteConfirm(null)}
                  disabled={deleting}
                  className="px-4 py-2 text-sm text-gray-700 bg-gray-200 hover:bg-gray-300 rounded-lg transition-colors"
                >
                  Cancel
                </button>
                <button
                  onClick={() => handleDelete(deleteConfirm)}
                  disabled={deleting}
                  className="px-4 py-2 text-sm text-white bg-red-600 hover:bg-red-700 rounded-lg transition-colors disabled:opacity-50"
                >
                  {deleting ? 'Deleting...' : 'Yes, delete'}
                </button>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
