-- Meir Display Request & Approval System
-- Initial schema migration

-- ============================================================
-- ENUMS
-- ============================================================

CREATE TYPE user_role AS ENUM (
  'rep',        -- Sales reps: submit requests, see own requests only
  'validator',  -- Brooke: validates inputs, sees ROI data
  'manager',    -- Michael: approves up to $5,000
  'cfo',        -- Elan: approves $5,001-$10,000
  'coo',        -- Paul: approves over $10,000
  'admin'       -- Rick: full visibility, receives override alerts
);

CREATE TYPE request_status AS ENUM (
  'submitted',          -- Rep has submitted, awaiting validation
  'validated',          -- Brooke confirmed inputs, routed to approver
  'queried',            -- Brooke flagged an issue
  'pending_approval',   -- Waiting for financial approver
  'approved',           -- Financially approved
  'rejected',           -- Financially rejected
  'cancelled'           -- Withdrawn
);

CREATE TYPE profitability_flag AS ENUM (
  'green',    -- Net Contribution >= $5,000 AND Net Margin >= 15%
  'review'    -- Below thresholds, needs careful consideration
);

CREATE TYPE tracking_status AS ENUM (
  'on_track',
  'at_risk',
  'off_track',
  'not_started'
);

-- ============================================================
-- USERS
-- ============================================================

CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  role user_role NOT NULL DEFAULT 'rep',
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Seed the known team
INSERT INTO users (email, name, role) VALUES
  ('rick@meir.com.au', 'Rick', 'admin'),
  ('brooke@meir.com.au', 'Brooke', 'validator'),
  ('michael@meir.com.au', 'Michael', 'manager'),
  ('elan@meir.com.au', 'Elan', 'cfo'),
  ('paul@meir.com.au', 'Paul', 'coo'),
  ('sophia@meir.com.au', 'Sophia', 'admin'),
  ('sales@meir.com.au', 'CS Team', 'rep');

-- ============================================================
-- DISPLAY REQUESTS
-- ============================================================

CREATE TABLE display_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Submission metadata
  submitted_by UUID NOT NULL REFERENCES users(id),
  submitted_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  status request_status NOT NULL DEFAULT 'submitted',

  -- Store details
  store_name TEXT NOT NULL,
  store_code TEXT NOT NULL,
  rep_name TEXT NOT NULL,
  brand_tier TEXT,
  display_type TEXT,
  display_reason TEXT,

  -- Financial inputs (entered by rep)
  rebate_pct NUMERIC(5,4) NOT NULL DEFAULT 0,        -- e.g. 0.05 = 5%
  cogs_pct NUMERIC(5,4) NOT NULL DEFAULT 0,           -- e.g. 0.60 = 60%
  board_labour_cost NUMERIC(12,2) NOT NULL DEFAULT 0,
  forecast_revenue NUMERIC(12,2) NOT NULL,             -- IMMUTABLE after submission
  rep_hours_monthly NUMERIC(6,2) NOT NULL DEFAULT 0,
  free_samples_cost NUMERIC(12,2) NOT NULL DEFAULT 0,
  catalogues_qty INTEGER NOT NULL DEFAULT 0,
  product_cogs NUMERIC(12,2) NOT NULL DEFAULT 0,
  photos_link TEXT,
  comments TEXT,

  -- Calculated fields (computed on submission, stored for speed)
  total_investment NUMERIC(12,2) NOT NULL DEFAULT 0,
  revenue_after_discount NUMERIC(12,2) NOT NULL DEFAULT 0,
  rebate_cost NUMERIC(12,2) NOT NULL DEFAULT 0,
  cogs_on_sales NUMERIC(12,2) NOT NULL DEFAULT 0,
  est_orders NUMERIC(12,2) NOT NULL DEFAULT 0,
  order_processing NUMERIC(12,2) NOT NULL DEFAULT 0,
  rep_visit_cost NUMERIC(12,2) NOT NULL DEFAULT 0,
  catalogue_cost NUMERIC(12,2) NOT NULL DEFAULT 0,
  total_costs NUMERIC(12,2) NOT NULL DEFAULT 0,
  gross_profit NUMERIC(12,2) NOT NULL DEFAULT 0,
  gross_margin NUMERIC(5,4) NOT NULL DEFAULT 0,
  net_contribution NUMERIC(12,2) NOT NULL DEFAULT 0,
  net_margin NUMERIC(5,4) NOT NULL DEFAULT 0,
  profitability_flag profitability_flag NOT NULL DEFAULT 'review',

  -- Approval routing
  routed_to UUID REFERENCES users(id),
  approval_tier TEXT,  -- 'manager', 'cfo', 'coo'

  -- Validation (Brooke)
  validated_by UUID REFERENCES users(id),
  validated_at TIMESTAMPTZ,
  validation_note TEXT,

  -- Financial approval
  approved_by UUID REFERENCES users(id),
  approved_at TIMESTAMPTZ,
  approval_note TEXT,
  was_override BOOLEAN NOT NULL DEFAULT false,  -- true if approved despite 'review' flag

  -- CS processing
  cs_reference TEXT,
  cs_processed_at TIMESTAMPTZ,

  -- Tracking
  tracking_status tracking_status NOT NULL DEFAULT 'not_started',

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Prevent modification of forecast_revenue after insert
CREATE OR REPLACE FUNCTION prevent_forecast_change()
RETURNS TRIGGER AS $$
BEGIN
  IF OLD.forecast_revenue IS DISTINCT FROM NEW.forecast_revenue THEN
    RAISE EXCEPTION 'Forecast revenue cannot be modified after submission';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_immutable_forecast
  BEFORE UPDATE ON display_requests
  FOR EACH ROW
  EXECUTE FUNCTION prevent_forecast_change();

-- ============================================================
-- SKUs (linked to display requests)
-- ============================================================

CREATE TABLE display_skus (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id UUID NOT NULL REFERENCES display_requests(id) ON DELETE CASCADE,
  sku_code TEXT NOT NULL,
  sku_name TEXT,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_skus_request ON display_skus(request_id);

-- ============================================================
-- MONTHLY ACTUALS (one row per request per month)
-- ============================================================

CREATE TABLE monthly_actuals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id UUID NOT NULL REFERENCES display_requests(id) ON DELETE CASCADE,
  month_year TEXT NOT NULL,  -- e.g. '2026-04'
  revenue NUMERIC(12,2) NOT NULL DEFAULT 0,
  catalogues_used INTEGER NOT NULL DEFAULT 0,
  source TEXT DEFAULT 'manual',  -- 'manual' or 'acumatica'
  acumatica_ref TEXT,
  entered_by UUID REFERENCES users(id),
  entered_at TIMESTAMPTZ NOT NULL DEFAULT now(),

  UNIQUE(request_id, month_year)
);

CREATE INDEX idx_actuals_request ON monthly_actuals(request_id);

-- ============================================================
-- AUDIT LOG
-- ============================================================

CREATE TABLE audit_log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id UUID REFERENCES display_requests(id) ON DELETE SET NULL,
  action TEXT NOT NULL,          -- 'submitted', 'validated', 'queried', 'approved', 'rejected', 'override_alert', etc.
  performed_by UUID REFERENCES users(id),
  details JSONB,                 -- flexible payload for context
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_audit_request ON audit_log(request_id);
CREATE INDEX idx_audit_action ON audit_log(action);

-- ============================================================
-- NOTIFICATIONS (email queue + history)
-- ============================================================

CREATE TABLE notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id UUID REFERENCES display_requests(id) ON DELETE SET NULL,
  recipient_email TEXT NOT NULL,
  subject TEXT NOT NULL,
  body TEXT NOT NULL,
  sent_at TIMESTAMPTZ,
  error TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ============================================================
-- ROW-LEVEL SECURITY
-- ============================================================

ALTER TABLE display_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE display_skus ENABLE ROW LEVEL SECURITY;
ALTER TABLE monthly_actuals ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- Helper: get current user's role from their auth email
CREATE OR REPLACE FUNCTION get_user_role()
RETURNS user_role AS $$
  SELECT role FROM users WHERE email = auth.jwt() ->> 'email' LIMIT 1;
$$ LANGUAGE sql SECURITY DEFINER STABLE;

CREATE OR REPLACE FUNCTION get_user_id()
RETURNS UUID AS $$
  SELECT id FROM users WHERE email = auth.jwt() ->> 'email' LIMIT 1;
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- Reps: see only their own requests
CREATE POLICY reps_own_requests ON display_requests
  FOR SELECT USING (
    get_user_role() IN ('admin', 'validator', 'manager', 'cfo', 'coo')
    OR submitted_by = get_user_id()
  );

-- Reps can insert new requests
CREATE POLICY reps_insert ON display_requests
  FOR INSERT WITH CHECK (submitted_by = get_user_id());

-- Only validators, approvers, and admins can update
CREATE POLICY staff_update ON display_requests
  FOR UPDATE USING (
    get_user_role() IN ('admin', 'validator', 'manager', 'cfo', 'coo')
  );

-- SKUs follow the same pattern as their parent request
CREATE POLICY skus_select ON display_skus
  FOR SELECT USING (
    get_user_role() IN ('admin', 'validator', 'manager', 'cfo', 'coo')
    OR request_id IN (SELECT id FROM display_requests WHERE submitted_by = get_user_id())
  );

CREATE POLICY skus_insert ON display_skus
  FOR INSERT WITH CHECK (
    request_id IN (SELECT id FROM display_requests WHERE submitted_by = get_user_id())
  );

-- Actuals: staff only
CREATE POLICY actuals_select ON monthly_actuals
  FOR SELECT USING (get_user_role() IN ('admin', 'validator', 'manager', 'cfo', 'coo'));

CREATE POLICY actuals_insert ON monthly_actuals
  FOR INSERT WITH CHECK (get_user_role() IN ('admin', 'validator', 'manager', 'cfo', 'coo'));

-- Audit log: admin and validator only
CREATE POLICY audit_select ON audit_log
  FOR SELECT USING (get_user_role() IN ('admin', 'validator'));

-- Notifications: admin only
CREATE POLICY notifications_select ON notifications
  FOR SELECT USING (get_user_role() = 'admin');

-- ============================================================
-- UPDATED_AT TRIGGER
-- ============================================================

CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_updated_at
  BEFORE UPDATE ON display_requests
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER set_updated_at_users
  BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();
