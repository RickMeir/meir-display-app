-- Migration 009: Fix calculations to match spreadsheet, add ROI/verdict,
-- add client baseline table, add COGS/margin to monthly_actuals,
-- add existing client fields to display_requests

-- ============================================================
-- 1. ADD NEW CALCULATED FIELDS TO DISPLAY_REQUESTS
-- ============================================================

-- Net revenue (Revenue After Discount minus Rebate Cost)
ALTER TABLE display_requests
  ADD COLUMN IF NOT EXISTS net_revenue NUMERIC(12,2) NOT NULL DEFAULT 0;

-- ROI multiplier and verdict
ALTER TABLE display_requests
  ADD COLUMN IF NOT EXISTS roi_multiplier NUMERIC(8,4),
  ADD COLUMN IF NOT EXISTS verdict TEXT;  -- 'worth_it', 'marginal', 'not_worth_it'

-- Existing client fields
ALTER TABLE display_requests
  ADD COLUMN IF NOT EXISTS is_existing_client BOOLEAN NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS existing_annual_revenue NUMERIC(12,2) DEFAULT 0,
  ADD COLUMN IF NOT EXISTS existing_orders INTEGER DEFAULT 0,
  ADD COLUMN IF NOT EXISTS existing_aov NUMERIC(12,2) DEFAULT 0,
  ADD COLUMN IF NOT EXISTS existing_cogs_pct NUMERIC(5,4) DEFAULT 0,
  ADD COLUMN IF NOT EXISTS baseline_revenue NUMERIC(12,2) DEFAULT 0,  -- existing + 15% growth
  ADD COLUMN IF NOT EXISTS incremental_revenue NUMERIC(12,2) DEFAULT 0;  -- forecast minus baseline

-- ============================================================
-- 2. ADD COGS/MARGIN FIELDS TO MONTHLY_ACTUALS
-- ============================================================

ALTER TABLE monthly_actuals
  ADD COLUMN IF NOT EXISTS cogs NUMERIC(12,2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS gross_profit NUMERIC(12,2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS gross_margin_pct NUMERIC(8,4) DEFAULT 0,
  ADD COLUMN IF NOT EXISTS order_count INTEGER NOT NULL DEFAULT 0;

-- ============================================================
-- 3. UPDATE refresh_monthly_actuals TO INCLUDE COGS/MARGIN
-- ============================================================

CREATE OR REPLACE FUNCTION refresh_monthly_actuals(p_upload_id UUID)
RETURNS void AS $$
BEGIN
  INSERT INTO monthly_actuals (
    request_id, month_year, revenue, cogs, gross_profit, gross_margin_pct,
    order_count, source, acumatica_ref, entered_at
  )
  SELECT
    matched_request_id,
    TO_CHAR(doc_date, 'YYYY-MM') AS month_year,
    SUM(net_sales) AS revenue,
    SUM(cost) AS cogs,
    SUM(margin) AS gross_profit,
    CASE WHEN SUM(net_sales) > 0
      THEN SUM(margin) / SUM(net_sales)
      ELSE 0
    END AS gross_margin_pct,
    COUNT(DISTINCT ref_nbr) AS order_count,
    'upload' AS source,
    p_upload_id::TEXT AS acumatica_ref,
    now()
  FROM sales_actuals_raw
  WHERE upload_id = p_upload_id
    AND matched_request_id IS NOT NULL
  GROUP BY matched_request_id, TO_CHAR(doc_date, 'YYYY-MM')
  ON CONFLICT (request_id, month_year)
  DO UPDATE SET
    revenue = EXCLUDED.revenue,
    cogs = EXCLUDED.cogs,
    gross_profit = EXCLUDED.gross_profit,
    gross_margin_pct = EXCLUDED.gross_margin_pct,
    order_count = EXCLUDED.order_count,
    source = 'upload',
    acumatica_ref = EXCLUDED.acumatica_ref,
    entered_at = now();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- 4. CLIENT BASELINE TABLE (from Acumatica / Sales Data)
-- ============================================================

CREATE TABLE client_baseline (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_group TEXT NOT NULL,       -- matches Customer Group / store name
  customer_code TEXT,                  -- Acumatica customer code if known
  net_sales NUMERIC(12,2) NOT NULL DEFAULT 0,
  cogs NUMERIC(12,2) NOT NULL DEFAULT 0,
  cogs_pct NUMERIC(5,4) NOT NULL DEFAULT 0,
  rebate_pct NUMERIC(5,4) NOT NULL DEFAULT 0,
  rebate_amount NUMERIC(12,2) NOT NULL DEFAULT 0,
  order_count INTEGER NOT NULL DEFAULT 0,
  avg_order_value NUMERIC(12,2) NOT NULL DEFAULT 0,
  fulfilment_cost NUMERIC(12,2) NOT NULL DEFAULT 0,
  display_costs NUMERIC(12,2) NOT NULL DEFAULT 0,
  margin_before_ops NUMERIC(12,2) NOT NULL DEFAULT 0,
  margin_pct NUMERIC(8,4) NOT NULL DEFAULT 0,
  display_roi NUMERIC(8,4) DEFAULT 0,
  roi_rating TEXT,                     -- '★ Low', '★★ Medium', '★★★ High'
  period_start DATE,                   -- start of the 12-month period
  period_end DATE,                     -- end of the 12-month period
  source TEXT NOT NULL DEFAULT 'manual',  -- 'manual', 'acumatica', 'spreadsheet'
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(customer_group)
);

CREATE INDEX idx_baseline_customer ON client_baseline(customer_group);
CREATE INDEX idx_baseline_code ON client_baseline(customer_code);

ALTER TABLE client_baseline ENABLE ROW LEVEL SECURITY;

CREATE POLICY baseline_select ON client_baseline
  FOR SELECT USING (true);  -- everyone can read (needed for form dropdown)

CREATE POLICY baseline_insert ON client_baseline
  FOR INSERT WITH CHECK (get_user_role() IN ('admin', 'manager', 'cfo', 'coo'));

CREATE POLICY baseline_update ON client_baseline
  FOR UPDATE USING (get_user_role() IN ('admin', 'manager', 'cfo', 'coo'));

-- updated_at trigger
CREATE TRIGGER baseline_updated_at
  BEFORE UPDATE ON client_baseline
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- 5. MARGIN ALERT TABLE (detects discrepancy between approved
--    and actual margin per display per month)
-- ============================================================

CREATE TABLE margin_alerts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id UUID NOT NULL REFERENCES display_requests(id) ON DELETE CASCADE,
  month_year TEXT NOT NULL,
  approved_cogs_pct NUMERIC(5,4) NOT NULL,   -- from display_requests.cogs_pct
  actual_cogs_pct NUMERIC(5,4) NOT NULL,     -- from actuals: cogs/revenue
  variance_pct NUMERIC(5,4) NOT NULL,        -- actual minus approved (positive = worse)
  approved_margin_pct NUMERIC(5,4) NOT NULL,
  actual_margin_pct NUMERIC(5,4) NOT NULL,
  revenue NUMERIC(12,2) NOT NULL,
  impact_amount NUMERIC(12,2) NOT NULL,      -- revenue * variance (how much margin lost)
  acknowledged_by UUID REFERENCES users(id),
  acknowledged_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(request_id, month_year)
);

CREATE INDEX idx_margin_alerts_request ON margin_alerts(request_id);

ALTER TABLE margin_alerts ENABLE ROW LEVEL SECURITY;

CREATE POLICY margin_alerts_select ON margin_alerts
  FOR SELECT USING (get_user_role() IN ('admin', 'manager', 'cfo', 'coo', 'rep'));

CREATE POLICY margin_alerts_insert ON margin_alerts
  FOR INSERT WITH CHECK (get_user_role() IN ('admin', 'manager', 'cfo', 'coo'));

CREATE POLICY margin_alerts_update ON margin_alerts
  FOR UPDATE USING (get_user_role() IN ('admin', 'manager', 'cfo', 'coo'));

-- ============================================================
-- 6. FUNCTION: Detect margin discrepancies after actuals upload
--    Call after refresh_monthly_actuals to check each display
-- ============================================================

CREATE OR REPLACE FUNCTION detect_margin_alerts(p_upload_id UUID)
RETURNS INTEGER AS $$
DECLARE
  v_alert_count INTEGER := 0;
  v_threshold NUMERIC := 0.03;  -- 3% variance triggers alert
BEGIN
  INSERT INTO margin_alerts (
    request_id, month_year,
    approved_cogs_pct, actual_cogs_pct, variance_pct,
    approved_margin_pct, actual_margin_pct,
    revenue, impact_amount
  )
  SELECT
    ma.request_id,
    ma.month_year,
    dr.cogs_pct AS approved_cogs_pct,
    CASE WHEN ma.revenue > 0 THEN ma.cogs / ma.revenue ELSE 0 END AS actual_cogs_pct,
    CASE WHEN ma.revenue > 0
      THEN (ma.cogs / ma.revenue) - dr.cogs_pct
      ELSE 0
    END AS variance_pct,
    (1 - dr.cogs_pct) AS approved_margin_pct,
    ma.gross_margin_pct AS actual_margin_pct,
    ma.revenue,
    CASE WHEN ma.revenue > 0
      THEN ma.revenue * ((ma.cogs / ma.revenue) - dr.cogs_pct)
      ELSE 0
    END AS impact_amount
  FROM monthly_actuals ma
  JOIN display_requests dr ON dr.id = ma.request_id
  WHERE ma.acumatica_ref = p_upload_id::TEXT
    AND ma.revenue > 0
    AND ma.cogs > 0
    -- Only alert if actual COGS% exceeds approved by more than threshold
    AND (ma.cogs / ma.revenue) - dr.cogs_pct > v_threshold
  ON CONFLICT (request_id, month_year)
  DO UPDATE SET
    actual_cogs_pct = EXCLUDED.actual_cogs_pct,
    variance_pct = EXCLUDED.variance_pct,
    actual_margin_pct = EXCLUDED.actual_margin_pct,
    revenue = EXCLUDED.revenue,
    impact_amount = EXCLUDED.impact_amount,
    acknowledged_by = NULL,
    acknowledged_at = NULL;

  GET DIAGNOSTICS v_alert_count = ROW_COUNT;
  RETURN v_alert_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- 7. UPDATE calculate_review_snapshot TO INCLUDE MARGIN TRACKING
-- ============================================================

CREATE OR REPLACE FUNCTION calculate_review_snapshot(v_request_id UUID, v_months INTEGER)
RETURNS JSONB AS $$
DECLARE
  v_expected NUMERIC := 0;
  v_actual NUMERIC := 0;
  v_actual_cogs NUMERIC := 0;
  v_actual_gp NUMERIC := 0;
  v_approved_cogs_pct NUMERIC := 0;
  v_baseline_revenue NUMERIC := 0;
  v_result JSONB;
BEGIN
  -- Get approved COGS% and baseline
  SELECT cogs_pct, COALESCE(baseline_revenue, 0)
    INTO v_approved_cogs_pct, v_baseline_revenue
    FROM display_requests WHERE id = v_request_id;

  -- Sum expected revenue for months 1..v_months
  SELECT COALESCE(SUM(expected_revenue), 0) INTO v_expected
    FROM expected_performance
   WHERE request_id = v_request_id
     AND month_number <= v_months;

  -- Sum actual revenue and margin for corresponding calendar months
  SELECT
    COALESCE(SUM(ma.revenue), 0),
    COALESCE(SUM(ma.cogs), 0),
    COALESCE(SUM(ma.gross_profit), 0)
    INTO v_actual, v_actual_cogs, v_actual_gp
    FROM monthly_actuals ma
    JOIN expected_performance ep ON ep.request_id = ma.request_id
     AND ep.calendar_month = ma.month_year
   WHERE ep.request_id = v_request_id
     AND ep.month_number <= v_months;

  v_result := jsonb_build_object(
    'months_elapsed', v_months,
    'expected_revenue', v_expected,
    'actual_revenue', v_actual,
    'variance', v_actual - v_expected,
    'variance_pct', CASE WHEN v_expected > 0 THEN (v_actual - v_expected) / v_expected ELSE 0 END,
    'assessment', CASE
      WHEN v_actual >= v_expected THEN 'on_track'
      ELSE 'off_track'
    END,
    -- Margin tracking
    'actual_cogs', v_actual_cogs,
    'actual_gross_profit', v_actual_gp,
    'actual_margin_pct', CASE WHEN v_actual > 0 THEN v_actual_gp / v_actual ELSE 0 END,
    'approved_margin_pct', 1 - v_approved_cogs_pct,
    'margin_assessment', CASE
      WHEN v_actual = 0 THEN 'no_data'
      WHEN v_actual > 0 AND (v_actual_gp / v_actual) >= (1 - v_approved_cogs_pct - 0.03) THEN 'on_track'
      ELSE 'off_track'
    END,
    -- Baseline-adjusted (incremental only)
    'baseline_prorated', v_baseline_revenue * v_months / 12,
    'incremental_actual', v_actual - (v_baseline_revenue * v_months / 12)
  );

  RETURN v_result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
