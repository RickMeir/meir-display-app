import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import { completeTask, dismissTask } from '@/lib/tasks'

// GET: list tasks for the current user
export async function GET() {
  try {
    const supabase = await createClient()
    const {
      data: { user },
    } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const serviceClient = createServiceClient()

    // Get the internal user record
    const { data: userData } = await serviceClient
      .from('users')
      .select('id, role')
      .eq('email', user.email)
      .single()

    if (!userData) {
      return NextResponse.json({ error: 'User not found' }, { status: 404 })
    }

    // Get pending tasks for this user
    const { data: tasks, error } = await serviceClient
      .from('user_tasks')
      .select('*')
      .eq('assigned_to', userData.id)
      .eq('status', 'pending')
      .order('priority', { ascending: true }) // urgent first
      .order('created_at', { ascending: false })

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    // Also get recently completed tasks (last 7 days) for context
    const sevenDaysAgo = new Date()
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7)

    const { data: recentCompleted } = await serviceClient
      .from('user_tasks')
      .select('*')
      .eq('assigned_to', userData.id)
      .in('status', ['completed', 'dismissed'])
      .gte('completed_at', sevenDaysAgo.toISOString())
      .order('completed_at', { ascending: false })
      .limit(10)

    return NextResponse.json({
      data: {
        pending: tasks || [],
        recent: recentCompleted || [],
        pending_count: (tasks || []).length,
      },
    })
  } catch (err) {
    console.error('Tasks GET error:', err)
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}

// PATCH: complete or dismiss a task
export async function PATCH(request: NextRequest) {
  try {
    const supabase = await createClient()
    const {
      data: { user },
    } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const serviceClient = createServiceClient()
    const { data: userData } = await serviceClient
      .from('users')
      .select('id, role')
      .eq('email', user.email)
      .single()

    if (!userData) {
      return NextResponse.json({ error: 'User not found' }, { status: 404 })
    }

    const body = await request.json()
    const { taskId, action } = body as { taskId: string; action: 'complete' | 'dismiss' }

    if (!taskId || !action) {
      return NextResponse.json({ error: 'Missing taskId or action' }, { status: 400 })
    }

    // Verify the task belongs to this user (or user is admin)
    const { data: task } = await serviceClient
      .from('user_tasks')
      .select('id, assigned_to, task_type, related_entity_type, related_entity_id')
      .eq('id', taskId)
      .single()

    if (!task) {
      return NextResponse.json({ error: 'Task not found' }, { status: 404 })
    }

    if (task.assigned_to !== userData.id && userData.role !== 'admin') {
      return NextResponse.json({ error: 'Not your task' }, { status: 403 })
    }

    let success: boolean
    if (action === 'complete') {
      success = await completeTask(taskId, userData.id)
    } else {
      success = await dismissTask(taskId, userData.id)
    }

    if (!success) {
      return NextResponse.json({ error: 'Failed to update task' }, { status: 500 })
    }

    return NextResponse.json({ data: { updated: true, taskId, action } })
  } catch (err) {
    console.error('Tasks PATCH error:', err)
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
