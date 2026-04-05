-- Migration 003: Upload Actuals infrastructure + installation_date
-- Adds the ability to upload Acumatica sales exports and track installation dates

-- ============================================================
-- ADD INSTALLATION DATE TO DISPLAY REQUESTS
-- ============================================================

ALTER TABLE display_requests
  ADD COLUMN IF NOT EXISTS installation_date DATE,
  ADD COLUMN IF NOT EXISTS installation_confirmed_by UUID REFERENCES users(id),
  ADD COLUMN IF NOT EXISTS installation_confirmed_at TIMESTAMPTZ;

-- ============================================================
-- SALES UPLOADS (one row per uploaded file)
-- ============================================================

CREATE TABLE sales_uploads (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  filename TEXT NOT NULL,
  uploaded_by UUID NOT NULL REFERENCES users(id),
  uploaded_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  date_range_from DATE,
  date_range_to DATE,
  total_rows INTEGER NOT NULL DEFAULT 0,
  matched_rows INTEGER NOT NULL DEFAULT 0,
  unmatched_rows INTEGER NOT NULL DEFAULT 0,
  status TEXT NOT NULL DEFAULT 'processing',  -- 'processing', 'completed', 'failed'
  error TEXT,
  summary JSONB  -- store processing summary for UI display
);

ALTER TABLE sales_uploads ENABLE ROW LEVEL SECURITY;

CREATE POLICY uploads_select ON sales_uploads
  FOR SELECT USING (get_user_role() IN ('admin', 'manager', 'cfo', 'coo'));

CREATE POLICY uploads_insert ON sales_uploads
  FOR INSERT WITH CHECK (get_user_role() IN ('admin', 'manager', 'cfo', 'coo'));

CREATE POLICY uploads_update ON sales_uploads
  FOR UPDATE USING (get_user_role() IN ('admin', 'manager', 'cfo', 'coo'));

-- ============================================================
-- SALES ACTUALS RAW (individual transaction rows from uploads)
-- ============================================================

CREATE TABLE sales_actuals_raw (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  upload_id UUID NOT NULL REFERENCES sales_uploads(id) ON DELETE CASCADE,

  -- Raw data from the export
  customer_code TEXT,
  customer_name TEXT NOT NULL,
  customer_group TEXT,
  doc_date DATE NOT NULL,
  doc_type TEXT,           -- 'Invoice', 'Credit Memo', etc.
  ref_nbr TEXT,
  order_type TEXT,
  order_nbr TEXT,
  net_sales NUMERIC(12,2) NOT NULL DEFAULT 0,
  cost NUMERIC(12,2) NOT NULL DEFAULT 0,
  margin NUMERIC(12,2) NOT NULL DEFAULT 0,
  margin_pct NUMERIC(8,4),

  -- Matching
  matched_request_id UUID REFERENCES display_requests(id),
  match_method TEXT,       -- 'exact_name', 'exact_code', 'group', 'fuzzy', 'unmatched'

  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_raw_upload ON sales_actuals_raw(upload_id);
CREATE INDEX idx_raw_request ON sales_actuals_raw(matched_request_id);
CREATE INDEX idx_raw_customer ON sales_actuals_raw(customer_name);
CREATE INDEX idx_raw_date ON sales_actuals_raw(doc_date);

ALTER TABLE sales_actuals_raw ENABLE ROW LEVEL SECURITY;

CREATE POLICY raw_select ON sales_actuals_raw
  FOR SELECT USING (get_user_role() IN ('admin', 'manager', 'cfo', 'coo'));

CREATE POLICY raw_insert ON sales_actuals_raw
  FOR INSERT WITH CHECK (get_user_role() IN ('admin', 'manager', 'cfo', 'coo'));

-- ============================================================
-- UPDATE POLICY ON MONTHLY_ACTUALS (allow updates, not just inserts)
-- ============================================================

CREATE POLICY actuals_update ON monthly_actuals
  FOR UPDATE USING (get_user_role() IN ('admin', 'manager', 'cfo', 'coo'));

-- ============================================================
-- HELPER: Aggregate raw sales into monthly_actuals
-- Call this after an upload is processed to roll up matched
-- transactions into the monthly_actuals table per display.
-- ============================================================

CREATE OR REPLACE FUNCTION refresh_monthly_actuals(p_upload_id UUID)
RETURNS void AS $$
BEGIN
  -- Upsert monthly totals from matched raw rows
  INSERT INTO monthly_actuals (request_id, month_year, revenue, source, acumatica_ref, entered_at)
  SELECT
    matched_request_id,
    TO_CHAR(doc_date, 'YYYY-MM') AS month_year,
    SUM(net_sales) AS revenue,
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
    source = 'upload',
    acumatica_ref = EXCLUDED.acumatica_ref,
    entered_at = now();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
