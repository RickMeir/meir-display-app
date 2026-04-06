-- Migration 004: User tasks (action queue) and customer aliases (name matching)
-- Supports: in-app task notifications, upload approval workflow, customer name resolution

-- ============================================================
-- USER TASKS (personal action queue per user)
-- ============================================================

CREATE TABLE user_tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  assigned_to UUID NOT NULL REFERENCES users(id),
  task_type TEXT NOT NULL,
  -- Task types:
  --   'approve_upload'        → Rick reviews and approves uploaded actuals
  --   'fix_customer_name'     → Manager fixes a mismatched customer name
  --   'validate_customer_name'→ Manager confirms customer name matches Acumatica during approval
  --   'review_mismatches'     → After upload, unmatched names need attention
  --   (extensible for future task types)
  title TEXT NOT NULL,
  description TEXT,
  status TEXT NOT NULL DEFAULT 'pending',
  -- Statuses: 'pending', 'completed', 'dismissed'
  priority TEXT NOT NULL DEFAULT 'normal',
  -- Priorities: 'normal', 'high', 'urgent'

  -- What this task relates to (polymorphic reference)
  related_entity_type TEXT,   -- 'display_request', 'sales_upload', etc.
  related_entity_id UUID,

  -- Metadata for the task (flexible JSON for task-type-specific data)
  metadata JSONB DEFAULT '{}',

  -- Who created the task (NULL = system-generated)
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at TIMESTAMPTZ,
  completed_by UUID REFERENCES users(id),

  -- Email notification tracking
  email_sent BOOLEAN NOT NULL DEFAULT false,
  email_sent_at TIMESTAMPTZ
);

CREATE INDEX idx_tasks_assigned_to ON user_tasks(assigned_to) WHERE status = 'pending';
CREATE INDEX idx_tasks_type ON user_tasks(task_type);
CREATE INDEX idx_tasks_entity ON user_tasks(related_entity_type, related_entity_id);
CREATE INDEX idx_tasks_status ON user_tasks(status);

ALTER TABLE user_tasks ENABLE ROW LEVEL SECURITY;

-- Users can see their own tasks; admin/manager/cfo/coo can see all
CREATE POLICY tasks_select ON user_tasks
  FOR SELECT USING (
    assigned_to = get_user_id()
    OR get_user_role() IN ('admin', 'coo', 'cfo', 'manager')
  );

-- Tasks are created by the system (service role) or by admin/manager/cfo/coo
CREATE POLICY tasks_insert ON user_tasks
  FOR INSERT WITH CHECK (
    get_user_role() IN ('admin', 'coo', 'cfo', 'manager', 'validator')
  );

-- Users can complete their own tasks; admin can complete any
CREATE POLICY tasks_update ON user_tasks
  FOR UPDATE USING (
    assigned_to = get_user_id()
    OR get_user_role() = 'admin'
  );


-- ============================================================
-- CUSTOMER ALIASES (maps Acumatica names to display requests)
-- ============================================================

CREATE TABLE customer_aliases (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  acumatica_name TEXT NOT NULL,
  display_request_id UUID NOT NULL REFERENCES display_requests(id) ON DELETE CASCADE,
  created_by UUID NOT NULL REFERENCES users(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  notes TEXT,

  -- Prevent duplicate aliases for the same Acumatica name + display request
  UNIQUE(acumatica_name, display_request_id)
);

CREATE INDEX idx_aliases_acumatica ON customer_aliases(acumatica_name);
CREATE INDEX idx_aliases_request ON customer_aliases(display_request_id);

ALTER TABLE customer_aliases ENABLE ROW LEVEL SECURITY;

-- Readable by anyone with upload access; editable by manager and above
CREATE POLICY aliases_select ON customer_aliases
  FOR SELECT USING (get_user_role() IN ('admin', 'coo', 'cfo', 'manager', 'validator'));

CREATE POLICY aliases_insert ON customer_aliases
  FOR INSERT WITH CHECK (get_user_role() IN ('admin', 'coo', 'cfo', 'manager'));

CREATE POLICY aliases_update ON customer_aliases
  FOR UPDATE USING (get_user_role() IN ('admin', 'coo', 'cfo', 'manager'));

CREATE POLICY aliases_delete ON customer_aliases
  FOR DELETE USING (get_user_role() IN ('admin', 'coo', 'cfo'));


-- ============================================================
-- UPDATE SALES_UPLOADS: add approval workflow columns
-- ============================================================

ALTER TABLE sales_uploads
  ADD COLUMN IF NOT EXISTS approved_by UUID REFERENCES users(id),
  ADD COLUMN IF NOT EXISTS approved_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS approval_status TEXT NOT NULL DEFAULT 'pending_approval';
  -- approval_status: 'pending_approval', 'approved', 'rejected'
  -- When 'pending_approval', data is parsed and stored but NOT in monthly_actuals
  -- When 'approved', refresh_monthly_actuals is called
