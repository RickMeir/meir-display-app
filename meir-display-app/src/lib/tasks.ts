import { createServiceClient } from './supabase/server'

// ============================================================
// Task creation helper — used by server-side code
// ============================================================

export type TaskType =
  | 'approve_upload'
  | 'fix_customer_name'
  | 'validate_customer_name'
  | 'review_mismatches'

interface CreateTaskParams {
  assignedTo: string // user ID
  taskType: TaskType
  title: string
  description?: string
  priority?: 'normal' | 'high' | 'urgent'
  relatedEntityType?: string
  relatedEntityId?: string
  metadata?: Record<string, unknown>
  createdBy?: string // user ID, null = system
  sendEmail?: boolean
}

/**
 * Create a task and optionally send an email notification.
 * Returns the created task or null on error.
 */
export async function createTask(params: CreateTaskParams) {
  const serviceClient = createServiceClient()

  const { data: task, error } = await serviceClient
    .from('user_tasks')
    .insert({
      assigned_to: params.assignedTo,
      task_type: params.taskType,
      title: params.title,
      description: params.description || null,
      priority: params.priority || 'normal',
      related_entity_type: params.relatedEntityType || null,
      related_entity_id: params.relatedEntityId || null,
      metadata: params.metadata || {},
      created_by: params.createdBy || null,
    })
    .select('id')
    .single()

  if (error) {
    console.error('Failed to create task:', error)
    return null
  }

  // Send email notification if requested
  if (params.sendEmail !== false) {
    await sendTaskNotificationEmail(params.assignedTo, task.id)
  }

  return task
}

/**
 * Complete a task by ID
 */
export async function completeTask(taskId: string, completedBy: string) {
  const serviceClient = createServiceClient()

  const { error } = await serviceClient
    .from('user_tasks')
    .update({
      status: 'completed',
      completed_at: new Date().toISOString(),
      completed_by: completedBy,
    })
    .eq('id', taskId)

  if (error) {
    console.error('Failed to complete task:', error)
    return false
  }

  return true
}

/**
 * Dismiss a task (not completed, just acknowledged)
 */
export async function dismissTask(taskId: string, dismissedBy: string) {
  const serviceClient = createServiceClient()

  const { error } = await serviceClient
    .from('user_tasks')
    .update({
      status: 'dismissed',
      completed_at: new Date().toISOString(),
      completed_by: dismissedBy,
    })
    .eq('id', taskId)

  if (error) {
    console.error('Failed to dismiss task:', error)
    return false
  }

  return true
}

/**
 * Get pending task count for a user (for badge display)
 */
export async function getPendingTaskCount(userId: string): Promise<number> {
  const serviceClient = createServiceClient()

  const { count, error } = await serviceClient
    .from('user_tasks')
    .select('*', { count: 'exact', head: true })
    .eq('assigned_to', userId)
    .eq('status', 'pending')

  if (error) return 0
  return count || 0
}

/**
 * Send a simple task notification email
 */
async function sendTaskNotificationEmail(userId: string, taskId: string) {
  try {
    const serviceClient = createServiceClient()

    // Get user email
    const { data: user } = await serviceClient
      .from('users')
      .select('email, name')
      .eq('id', userId)
      .single()

    if (!user) return

    const APP_URL = process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000'
    const taskUrl = `${APP_URL}/tasks`

    // Use the existing email infrastructure
    const { Resend } = await import('resend')
    const key = process.env.RESEND_API_KEY
    if (!key || key.startsWith('re_placeholder')) return

    const resend = new Resend(key)
    const FROM_EMAIL = 'Meir Displays <displays@meir.com.au>'
    const TEST_RECIPIENT = process.env.EMAIL_TEST_RECIPIENT || ''

    const actualTo = TEST_RECIPIENT || user.email
    const subject = TEST_RECIPIENT
      ? `[TEST → ${user.email}] You have a new task in the display app`
      : 'You have a new task in the display app'

    const html = `
      <div style="font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;max-width:600px;margin:0 auto;padding:20px;color:#333;">
        ${TEST_RECIPIENT ? `<p style="background:#fff3cd;padding:8px;border:1px solid #ffc107;border-radius:4px;font-size:12px;"><strong>TEST MODE:</strong> This email would normally go to <strong>${user.email}</strong></p>` : ''}
        <p>Hi ${user.name},</p>
        <p>You have a new task in the display app.</p>
        <p><a href="${taskUrl}" style="display:inline-block;padding:12px 24px;background:#0074c5;color:#fff;text-decoration:none;border-radius:6px;">View your tasks</a></p>
        <hr style="margin-top:30px;border:none;border-top:1px solid #ddd;"/>
        <p style="color:#999;font-size:12px;">Meir Display Management System</p>
      </div>
    `

    await resend.emails.send({
      from: FROM_EMAIL,
      to: actualTo,
      subject,
      html,
    })

    // Mark email as sent on the task
    await serviceClient
      .from('user_tasks')
      .update({ email_sent: true, email_sent_at: new Date().toISOString() })
      .eq('id', taskId)
  } catch (err) {
    console.error('Failed to send task notification email:', err)
    // Non-critical — task still exists in the app
  }
}
