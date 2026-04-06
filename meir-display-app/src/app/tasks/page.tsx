'use client'

import { useState, useEffect, useCallback } from 'react'
import { useRouter } from 'next/navigation'
import { createBrowserClient } from '@supabase/ssr'
import {
  CheckCircle,
  Clock,
  AlertTriangle,
  ArrowRight,
  XCircle,
  FileSpreadsheet,
  Users,
  Shield,
} from 'lucide-react'
import Link from 'next/link'

interface Task {
  id: string
  task_type: string
  title: string
  description: string | null
  status: string
  priority: string
  related_entity_type: string | null
  related_entity_id: string | null
  metadata: Record<string, unknown>
  created_at: string
  completed_at: string | null
}

const TASK_ICONS: Record<string, typeof FileSpreadsheet> = {
  approve_upload: FileSpreadsheet,
  fix_customer_name: Users,
  validate_customer_name: Shield,
  review_mismatches: AlertTriangle,
}

const PRIORITY_STYLES: Record<string, string> = {
  urgent: 'border-l-4 border-l-red-500 bg-red-50',
  high: 'border-l-4 border-l-amber-500 bg-amber-50',
  normal: 'border-l-4 border-l-blue-500 bg-white',
}

function getTaskLink(task: Task): string | null {
  if (task.related_entity_type === 'sales_upload') {
    return '/actuals/upload'
  }
  if (task.related_entity_type === 'display_request' && task.related_entity_id) {
    if (task.task_type === 'validate_customer_name') {
      return `/requests/${task.related_entity_id}/validate`
    }
    return `/requests/${task.related_entity_id}`
  }
  return null
}

function formatTimeAgo(dateStr: string): string {
  const date = new Date(dateStr)
  const now = new Date()
  const diffMs = now.getTime() - date.getTime()
  const diffMins = Math.floor(diffMs / 60000)
  const diffHours = Math.floor(diffMins / 60)
  const diffDays = Math.floor(diffHours / 24)

  if (diffMins < 1) return 'Just now'
  if (diffMins < 60) return `${diffMins}m ago`
  if (diffHours < 24) return `${diffHours}h ago`
  if (diffDays < 7) return `${diffDays}d ago`
  return date.toLocaleDateString('en-AU', { day: 'numeric', month: 'short' })
}

export default function TasksPage() {
  const router = useRouter()
  const [loading, setLoading] = useState(true)
  const [pendingTasks, setPendingTasks] = useState<Task[]>([])
  const [recentTasks, setRecentTasks] = useState<Task[]>([])
  const [actionLoading, setActionLoading] = useState<string | null>(null)

  const fetchTasks = useCallback(async () => {
    try {
      const res = await fetch('/api/tasks')
      if (res.ok) {
        const data = await res.json()
        setPendingTasks(data.data.pending || [])
        setRecentTasks(data.data.recent || [])
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

      fetchTasks()
    }
    checkAuth()
  }, [router, fetchTasks])

  async function handleAction(taskId: string, action: 'complete' | 'dismiss') {
    setActionLoading(taskId)
    try {
      const res = await fetch('/api/tasks', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ taskId, action }),
      })

      if (res.ok) {
        fetchTasks() // Refresh
      }
    } catch {
      // Non-critical
    } finally {
      setActionLoading(null)
    }
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
      <div className="max-w-3xl mx-auto px-4 py-8">
        {/* Header */}
        <div className="mb-8">
          <h1 className="text-2xl font-bold text-gray-900">Your Tasks</h1>
          <p className="text-gray-600 mt-1">
            Actions the system needs you to take.
          </p>
        </div>

        {/* Pending tasks */}
        {pendingTasks.length === 0 ? (
          <div className="bg-white border border-gray-200 rounded-lg p-12 text-center">
            <CheckCircle className="w-12 h-12 text-green-400 mx-auto mb-3" />
            <p className="text-gray-600 text-lg">You are all caught up.</p>
            <p className="text-gray-400 text-sm mt-1">No pending tasks right now.</p>
          </div>
        ) : (
          <div className="space-y-3">
            {pendingTasks.map((task) => {
              const Icon = TASK_ICONS[task.task_type] || Clock
              const link = getTaskLink(task)
              const priorityStyle = PRIORITY_STYLES[task.priority] || PRIORITY_STYLES.normal

              return (
                <div
                  key={task.id}
                  className={`rounded-lg p-4 shadow-sm ${priorityStyle}`}
                >
                  <div className="flex items-start gap-3">
                    <Icon className="w-5 h-5 text-gray-500 mt-0.5 flex-shrink-0" />
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2">
                        <h3 className="font-medium text-gray-900">{task.title}</h3>
                        {task.priority === 'urgent' && (
                          <span className="text-xs bg-red-100 text-red-700 px-2 py-0.5 rounded">
                            Urgent
                          </span>
                        )}
                        {task.priority === 'high' && (
                          <span className="text-xs bg-amber-100 text-amber-700 px-2 py-0.5 rounded">
                            High
                          </span>
                        )}
                      </div>
                      {task.description && (
                        <p className="text-sm text-gray-600 mt-1">{task.description}</p>
                      )}
                      <p className="text-xs text-gray-400 mt-2">{formatTimeAgo(task.created_at)}</p>
                    </div>
                    <div className="flex items-center gap-2 flex-shrink-0">
                      {link && (
                        <Link
                          href={link}
                          className="inline-flex items-center gap-1 text-sm text-blue-600 hover:text-blue-800 font-medium"
                        >
                          Open <ArrowRight className="w-3 h-3" />
                        </Link>
                      )}
                      <button
                        onClick={() => handleAction(task.id, 'complete')}
                        disabled={actionLoading === task.id}
                        className="inline-flex items-center gap-1 text-sm text-green-600 hover:text-green-800 font-medium disabled:opacity-50"
                        title="Mark as done"
                      >
                        <CheckCircle className="w-4 h-4" />
                      </button>
                      <button
                        onClick={() => handleAction(task.id, 'dismiss')}
                        disabled={actionLoading === task.id}
                        className="inline-flex items-center gap-1 text-sm text-gray-400 hover:text-gray-600 disabled:opacity-50"
                        title="Dismiss"
                      >
                        <XCircle className="w-4 h-4" />
                      </button>
                    </div>
                  </div>
                </div>
              )
            })}
          </div>
        )}

        {/* Recently completed */}
        {recentTasks.length > 0 && (
          <div className="mt-10">
            <h2 className="text-sm font-medium text-gray-500 uppercase tracking-wide mb-3">
              Recently completed
            </h2>
            <div className="space-y-2">
              {recentTasks.map((task) => (
                <div
                  key={task.id}
                  className="bg-gray-50 border border-gray-100 rounded-lg p-3 flex items-center gap-3 opacity-60"
                >
                  <CheckCircle className="w-4 h-4 text-green-400 flex-shrink-0" />
                  <span className="text-sm text-gray-600 flex-1">{task.title}</span>
                  <span className="text-xs text-gray-400">
                    {task.completed_at ? formatTimeAgo(task.completed_at) : ''}
                  </span>
                </div>
              ))}
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
