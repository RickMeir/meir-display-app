-- Migration 008: Post-installation lifecycle tracking
-- Adds lifecycle review check-ins (3/6/9/12 months), additional expense tracking,
-- forecast change logging, and expected performance schedules.
--
-- Design decisions:
--   - Ramp-up curve and seasonality models are NOT included yet (need historical data).
--     Expected performance uses simple linear proration for now (forecast_revenue / 12).
--   - The existing prevent_forecast_change trigger is replaced with a logging trigger
--     that allows managers+ to change forecasts but records every change.
--   - Additional expenses have their own approval workflow (routed same as display tier logic).
--   - Lifecycle reviews are generated automatically at 3/6/9/12 months post-installation.

-- ============================================================
-- ENUMS
-- ============================================================

CREATE TYPE lifecycle_interval AS ENUM ('3_month', '6_month', '9_month', '12_month');

CREATE TYPE expense_status AS ENUM (
  'proposed',        -- rep/manager has submitted additional expense request
  'approved',        -- approved by financial approver
  'rejected',        -- denied
  'cancelled'        -- withdrawn by requester
);

CREATE TYPE expense_category AS ENUM (
  'rep_hours',           -- additional rep visit time
  'gifts',               -- gifts to store/client
  'rebates',             -- additional rebate offered
  'discounts',           -- additional discount above original agreement
  'marketing',           -- advertising or promotional spend
  'catalogues',          -- additional catalogue/promotional material
  'other'                -- anything else, described in notes
);

-- ============================================================
-- EXPECTED PERFORMANCE (month-by-month targets per display)
-- ============================================================
-- One row per display per month. Initially populated with linear proration.
-- When ramp-up curve and seasonality models are built, the weights will
-- be updated and the expected_revenue recalculated.

CREATE TABLE expected_performance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id UUID NOT NULL REFERENCES display_requests(id) ON DELETE CASCADE,
  month_number INTEGER NOT NULL CHECK (month_number BETWEEN 1 AND 12),  -- 1 = first month after install
  calendar_month TEXT,              -- e.g. '2026-05' (set when installation_date is known)
  weight NUMERIC(5,4) NOT NULL DEFAULT 0.0833,  -- default = 1/12 (linear)
  expected_revenue NUMERIC(12,2) NOT NULL DEFAULT 0,
  ramp_up_factor NUMERIC(5,4),      -- future: from ramp-up curve model
  seasonality_factor NUMERIC(5,4),  -- future: from seasonality model
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

  UNIQUE(request_id, month_number)
);

CREATE INDEX idx_expected_perf_request ON expected_performance(request_id);

-- ============================================================
-- LIFECYCLE REVIEWS (3/6/9/12 month check-ins)
-- ============================================================

CREATE TABLE lifecycle_reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id UUID NOT NULL REFERENCES display_requests(id) ON DELETE CASCADE,
  interval lifecycle_interval NOT NULL,
  due_date DATE NOT NULL,                        -- when this review is due
  completed_at TIMESTAMPTZ,                      -- when it was actually completed
  completed_by UUID REFERENCES users(id),

  -- Performance snapshot at time of review
  expected_revenue_cumulative NUMERIC(12,2),     -- sum of expected up to this interval
  actual_revenue_cumulative NUMERIC(12,2),       -- sum of actuals up to this interval
  variance_pct NUMERIC(8,4),                     -- (actual - expected) / expected
  tracking_assessment tracking_status,           -- on_track, at_risk, off_track

  -- Thresholds used for classification (stored so they are auditable)
  on_track_threshold NUMERIC(5,4) DEFAULT 0.90,  -- >= 90% of expected = on_track
  at_risk_threshold NUMERIC(5,4) DEFAULT 0.70,   -- >= 70% of expected = at_risk, below = off_track

  -- Review notes and actions
  notes TEXT,
  action_taken TEXT,                              -- what was decided
  notification_sent_at TIMESTAMPTZ,              -- when the off-track alert was sent

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

  UNIQUE(request_id, interval)
);

CREATE INDEX idx_lifecycle_reviews_request ON lifecycle_reviews(request_id);
CREATE INDEX idx_lifecycle_reviews_due ON lifecycle_reviews(due_date);

-- ============================================================
-- ADDITIONAL EXPENSES (post-approval spend requests)
-- ============================================================

CREATE TABLE additional_expenses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id UUID NOT NULL REFERENCES display_requests(id) ON DELETE CASCADE,
  category expense_category NOT NULL,
  description TEXT NOT NULL,                     -- what the expense is for
  amount NUMERIC(12,2) NOT NULL,                 -- dollar amount
  rationale TEXT,                                -- why this additional spend is needed
  triggered_by_review UUID REFERENCES lifecycle_reviews(id),  -- which review prompted this (optional)

  -- Approval workflow
  status expense_status NOT NULL DEFAULT 'proposed',
  requested_by UUID NOT NULL REFERENCES users(id),
  requested_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  approved_by UUID REFERENCES users(id),
  approved_at TIMESTAMPTZ,
  approval_note TEXT,

  -- Impact assessment (calculated when proposed)
  original_total_investment NUMERIC(12,2),       -- total investment before this expense
  new_total_investment NUMERIC(12,2),            -- total investment after this expense
  original_required_revenue NUMERIC(12,2),       -- revenue needed before this expense
  new_required_revenue NUMERIC(12,2),            -- revenue needed after this expense
  original_net_margin NUMERIC(5,4),              -- net margin before
  new_net_margin NUMERIC(5,4),                   -- net margin after
  makes_unviable BOOLEAN DEFAULT false,          -- true if new ROI is negative/marginal

  -- Spiral tracking
  expense_round INTEGER NOT NULL DEFAULT 1,      -- 1st, 2nd, 3rd round of additional spend
  cumulative_additional_spend NUMERIC(12,2),     -- running total of all additional expenses

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_additional_expenses_request ON additional_expenses(request_id);
CREATE INDEX idx_additional_expenses_status ON additional_expenses(status);

-- ============================================================
-- FORECAST CHANGES (audit trail for forecast modifications)
-- ============================================================
-- Replaces the hard prevent_forecast_change trigger with a logging approach.
-- Managers+ can change the forecast, but every change is recorded and
-- notifications are sent to Rick and Paul.

CREATE TABLE forecast_changes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id UUID NOT NULL REFERENCES display_requests(id) ON DELETE CASCADE,
  changed_by UUID NOT NULL REFERENCES users(id),
  changed_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  old_forecast NUMERIC(12,2) NOT NULL,
  new_forecast NUMERIC(12,2) NOT NULL,
  change_pct NUMERIC(8,4),                       -- percentage change
  reason TEXT,                                    -- why the forecast was changed
  notification_sent_at TIMESTAMPTZ,              -- when Rick+Paul were notified

  -- Impact on financials (snapshot at time of change)
  old_net_contribution NUMERIC(12,2),
  new_net_contribution NUMERIC(12,2),
  old_net_margin NUMERIC(5,4),
  new_net_margin NUMERIC(5,4),
  old_profitability_flag profitability_flag,
  new_profitability_flag profitability_flag,

  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_forecast_changes_request ON forecast_changes(request_id);

-- ============================================================
-- REPLACE FORECAST IMMUTABILITY TRIGGER
-- ============================================================
-- Drop the old trigger that blocks ALL forecast changes.
-- Replace with one that:
--   1. Allows changes only by manager, cfo, coo, admin roles
--   2. Logs every change to forecast_changes table
--   3. Recalculates derived financial fields

DROP TRIGGER IF EXISTS enforce_immutable_forecast ON display_requests;
DROP FUNCTION IF EXISTS prevent_forecast_change();

CREATE OR REPLACE FUNCTION log_forecast_change()
RETURNS TRIGGER AS $$
DECLARE
  v_user_role user_role;
  v_user_id UUID;
  v_change_pct NUMERIC(8,4);
BEGIN
  -- Only fire if forecast_revenue actually changed
  IF OLD.forecast_revenue IS NOT DISTINCT FROM NEW.forecast_revenue THEN
    RETURN NEW;
  END IF;

  -- Check the role of the user making the change
  v_user_role := get_user_role();
  v_user_id := get_user_id();

  -- Only manager, cfo, coo, admin can change forecast
  IF v_user_role NOT IN ('manager', 'cfo', 'coo', 'admin') THEN
    RAISE EXCEPTION 'Only managers and above can modify the forecast revenue';
  END IF;

  -- Calculate percentage change
  IF OLD.forecast_revenue > 0 THEN
    v_change_pct := (NEW.forecast_revenue - OLD.forecast_revenue) / OLD.forecast_revenue;
  ELSE
    v_change_pct := NULL;
  END IF;

  -- Log the change
  INSERT INTO forecast_changes (
    request_id, changed_by, old_forecast, new_forecast, change_pct,
    old_net_contribution, old_net_margin, old_profitability_flag
  ) VALUES (
    NEW.id, v_user_id, OLD.forecast_revenue, NEW.forecast_revenue, v_change_pct,
    OLD.net_contribution, OLD.net_margin, OLD.profitability_flag
  );

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER log_forecast_change_trigger
  BEFORE UPDATE ON display_requests
  FOR EACH ROW
  EXECUTE FUNCTION log_forecast_change();

-- ============================================================
-- FUNCTION: Generate expected performance schedule
-- ============================================================
-- Called when installation_date is set. Creates 12 rows of expected
-- monthly performance using linear proration (1/12 per month).
-- When ramp-up and seasonality models are available, this function
-- will be updated to use those weights instead.

CREATE OR REPLACE FUNCTION generate_expected_performance(p_request_id UUID)
RETURNS void AS $$
DECLARE
  v_forecast NUMERIC(12,2);
  v_install_date DATE;
  v_month_weight NUMERIC(5,4) := 0.0833;  -- 1/12 rounded
  v_month INTEGER;
  v_cal_month TEXT;
BEGIN
  SELECT forecast_revenue, installation_date
    INTO v_forecast, v_install_date
    FROM display_requests
   WHERE id = p_request_id;

  IF v_forecast IS NULL OR v_install_date IS NULL THEN
    RAISE EXCEPTION 'Request must have forecast_revenue and installation_date set';
  END IF;

  -- Delete any existing schedule (in case of regeneration)
  DELETE FROM expected_performance WHERE request_id = p_request_id;

  -- Generate 12 months of expected performance
  FOR v_month IN 1..12 LOOP
    v_cal_month := TO_CHAR(v_install_date + ((v_month - 1) || ' months')::INTERVAL, 'YYYY-MM');

    INSERT INTO expected_performance (
      request_id, month_number, calendar_month, weight, expected_revenue
    ) VALUES (
      p_request_id, v_month, v_cal_month, v_month_weight,
      ROUND(v_forecast * v_month_weight, 2)
    );
  END LOOP;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- FUNCTION: Generate lifecycle review schedule
-- ============================================================
-- Called when installation_date is set. Creates 4 review records
-- (3/6/9/12 months) with due dates calculated from installation.

CREATE OR REPLACE FUNCTION generate_lifecycle_reviews(p_request_id UUID)
RETURNS void AS $$
DECLARE
  v_install_date DATE;
BEGIN
  SELECT installation_date INTO v_install_date
    FROM display_requests
   WHERE id = p_request_id;

  IF v_install_date IS NULL THEN
    RAISE EXCEPTION 'Request must have installation_date set';
  END IF;

  -- Delete any existing reviews (in case of regeneration)
  DELETE FROM lifecycle_reviews WHERE request_id = p_request_id AND completed_at IS NULL;

  -- Create the four interval reviews
  INSERT INTO lifecycle_reviews (request_id, interval, due_date)
  VALUES
    (p_request_id, '3_month',  v_install_date + INTERVAL '3 months'),
    (p_request_id, '6_month',  v_install_date + INTERVAL '6 months'),
    (p_request_id, '9_month',  v_install_date + INTERVAL '9 months'),
    (p_request_id, '12_month', v_install_date + INTERVAL '12 months')
  ON CONFLICT (request_id, interval) DO UPDATE SET
    due_date = EXCLUDED.due_date;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- TRIGGER: Auto-generate schedules when installation_date is set
-- ============================================================

CREATE OR REPLACE FUNCTION on_installation_date_set()
RETURNS TRIGGER AS $$
BEGIN
  -- Only fire when installation_date changes from NULL to a value
  IF OLD.installation_date IS NULL AND NEW.installation_date IS NOT NULL THEN
    PERFORM generate_expected_performance(NEW.id);
    PERFORM generate_lifecycle_reviews(NEW.id);
  END IF;

  -- If installation_date changes to a different date, regenerate
  IF OLD.installation_date IS NOT NULL
     AND NEW.installation_date IS NOT NULL
     AND OLD.installation_date IS DISTINCT FROM NEW.installation_date THEN
    PERFORM generate_expected_performance(NEW.id);
    PERFORM generate_lifecycle_reviews(NEW.id);
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER auto_generate_lifecycle
  AFTER UPDATE ON display_requests
  FOR EACH ROW
  EXECUTE FUNCTION on_installation_date_set();

-- ============================================================
-- FUNCTION: Calculate lifecycle review snapshot
-- ============================================================
-- Calculates cumulative expected vs actual revenue at a given interval
-- and determines tracking assessment.

CREATE OR REPLACE FUNCTION calculate_review_snapshot(p_review_id UUID)
RETURNS void AS $$
DECLARE
  v_request_id UUID;
  v_interval lifecycle_interval;
  v_months INTEGER;
  v_expected NUMERIC(12,2);
  v_actual NUMERIC(12,2);
  v_variance NUMERIC(8,4);
  v_assessment tracking_status;
  v_on_track_threshold NUMERIC(5,4);
  v_at_risk_threshold NUMERIC(5,4);
BEGIN
  SELECT request_id, interval, on_track_threshold, at_risk_threshold
    INTO v_request_id, v_interval, v_on_track_threshold, v_at_risk_threshold
    FROM lifecycle_reviews
   WHERE id = p_review_id;

  -- Determine months covered
  v_months := CASE v_interval
    WHEN '3_month' THEN 3
    WHEN '6_month' THEN 6
    WHEN '9_month' THEN 9
    WHEN '12_month' THEN 12
  END;

  -- Sum expected revenue for months 1 through N
  SELECT COALESCE(SUM(expected_revenue), 0) INTO v_expected
    FROM expected_performance
   WHERE request_id = v_request_id
     AND month_number <= v_months;

  -- Sum actual revenue for corresponding calendar months
  SELECT COALESCE(SUM(ma.revenue), 0) INTO v_actual
    FROM monthly_actuals ma
    JOIN expected_performance ep ON ep.request_id = ma.request_id
     AND ep.calendar_month = ma.month_year
   WHERE ep.request_id = v_request_id
     AND ep.month_number <= v_months;

  -- Calculate variance
  IF v_expected > 0 THEN
    v_variance := (v_actual - v_expected) / v_expected;
  ELSE
    v_variance := 0;
  END IF;

  -- Determine assessment
  IF v_expected = 0 THEN
    v_assessment := 'not_started';
  ELSIF (v_actual / v_expected) >= v_on_track_threshold THEN
    v_assessment := 'on_track';
  ELSIF (v_actual / v_expected) >= v_at_risk_threshold THEN
    v_assessment := 'at_risk';
  ELSE
    v_assessment := 'off_track';
  END IF;

  -- Update the review record
  UPDATE lifecycle_reviews SET
    expected_revenue_cumulative = v_expected,
    actual_revenue_cumulative = v_actual,
    variance_pct = v_variance,
    tracking_assessment = v_assessment,
    updated_at = now()
  WHERE id = p_review_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- ROW-LEVEL SECURITY
-- ============================================================

ALTER TABLE expected_performance ENABLE ROW LEVEL SECURITY;
ALTER TABLE lifecycle_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE additional_expenses ENABLE ROW LEVEL SECURITY;
ALTER TABLE forecast_changes ENABLE ROW LEVEL SECURITY;

-- Expected performance: staff can view, admin can modify
CREATE POLICY expected_perf_select ON expected_performance
  FOR SELECT USING (
    get_user_role() IN ('admin', 'validator', 'manager', 'cfo', 'coo')
    OR request_id IN (SELECT id FROM display_requests WHERE submitted_by = get_user_id())
  );

CREATE POLICY expected_perf_admin ON expected_performance
  FOR ALL USING (get_user_role() = 'admin');

-- Lifecycle reviews: staff can view and update
CREATE POLICY lifecycle_reviews_select ON lifecycle_reviews
  FOR SELECT USING (
    get_user_role() IN ('admin', 'validator', 'manager', 'cfo', 'coo')
    OR request_id IN (SELECT id FROM display_requests WHERE submitted_by = get_user_id())
  );

CREATE POLICY lifecycle_reviews_update ON lifecycle_reviews
  FOR UPDATE USING (
    get_user_role() IN ('admin', 'manager', 'cfo', 'coo')
  );

-- Additional expenses: reps can propose (insert), staff can view and update
CREATE POLICY expenses_select ON additional_expenses
  FOR SELECT USING (
    get_user_role() IN ('admin', 'validator', 'manager', 'cfo', 'coo')
    OR request_id IN (SELECT id FROM display_requests WHERE submitted_by = get_user_id())
  );

CREATE POLICY expenses_insert ON additional_expenses
  FOR INSERT WITH CHECK (
    get_user_role() IN ('admin', 'rep', 'manager', 'cfo', 'coo')
  );

CREATE POLICY expenses_update ON additional_expenses
  FOR UPDATE USING (
    get_user_role() IN ('admin', 'manager', 'cfo', 'coo')
  );

-- Forecast changes: admin and approvers can view
CREATE POLICY forecast_changes_select ON forecast_changes
  FOR SELECT USING (
    get_user_role() IN ('admin', 'manager', 'cfo', 'coo')
  );

-- ============================================================
-- UPDATED_AT TRIGGERS
-- ============================================================

CREATE TRIGGER set_updated_at_expected_perf
  BEFORE UPDATE ON expected_performance
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER set_updated_at_lifecycle_reviews
  BEFORE UPDATE ON lifecycle_reviews
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER set_updated_at_additional_expenses
  BEFORE UPDATE ON additional_expenses
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();
