-- Seed 179 display_requests + 2148 monthly_actuals
-- Source: Sales & Margin Analysis 31.03.2026 v6.xlsx
-- All values clamped to fit existing column constraints. No schema changes needed.
-- Skipped 50 rows with bad source data

DO $$
DECLARE
  admin_id UUID;
  req_id UUID;
BEGIN
  SELECT id INTO admin_id FROM users WHERE email = 'rick@meir.com.au' LIMIT 1;
  IF admin_id IS NULL THEN
    RAISE EXCEPTION 'Admin user rick@meir.com.au not found';
  END IF;

  -- [1/179] Harvey Norman
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Harvey Norman', '', '',
    true, 3900418.3300000085, 4713, 827.59, 0.4254,
    4485481.08, -585062.75,
    0.15, 0.4254,
    166497.89, 0, 0,
    3900418.3300000085, 2, 100,
    166497.89, 2241043.06, 336156.46, 1904886.6, 810405.82,
    1094480.78, 0.5746, 4713, 226224,
    1500.0, 500.0, 394721.89,
    699758.89, 0.3673, 'green', 'admin',
    8.5872, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 325034.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 325034.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 325034.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 325034.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 325034.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 325034.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 325034.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 325034.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 325034.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 325034.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 325034.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 325034.86, 0, 'spreadsheet_seed');

  -- [2/179] Beaumont Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Beaumont Tiles', '', '',
    true, 1939440.0599999987, 3360, 577.21, 0.3719,
    2230356.07, -290916.01,
    0.08, 0.3719,
    122668.2, 0, 0,
    1939440.0599999987, 2, 100,
    122668.2, 1218132.08, 97450.57, 1120681.51, 416798.92,
    703882.59, 0.6281, 3360, 161280,
    1500.0, 500.0, 285948.2,
    417934.39, 0.3729, 'green', 'admin',
    8.6029, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 161620.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 161620.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 161620.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 161620.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 161620.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 161620.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 161620.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 161620.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 161620.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 161620.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 161620.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 161620.0, 0, 'spreadsheet_seed');

  -- [3/179] SIBO Trading
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'SIBO Trading', '', '',
    true, 1897269.02, 230, 8249.0, 0.6742,
    2181859.37, -284590.35,
    0.0, 0.6742,
    10583.36, 0, 0,
    1897269.02, 2, 100,
    10583.36, 618066.03, 0.0, 618066.03, 416721.04,
    201344.99, 0.3258, 230, 11040,
    1500.0, 500.0, 23623.36,
    177721.63, 0.2875, 'green', 'cfo',
    57.3566, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 158105.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 158105.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 158105.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 158105.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 158105.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 158105.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 158105.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 158105.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 158105.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 158105.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 158105.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 158105.75, 0, 'spreadsheet_seed');

  -- [4/179] United Spaces Pty Ltd (The Blue Space)
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'United Spaces Pty Ltd (The Blue Space)', '', '',
    true, 870916.2500000002, 812, 1072.56, 0.3225,
    1001553.69, -130637.44,
    0.0, 0.3225,
    6988.12, 0, 0,
    870916.2500000002, 2, 100,
    6988.12, 590070.52, 0.0, 590070.52, 190280.97,
    399789.55, 0.6775, 812, 38976,
    1500.0, 500.0, 47964.12,
    351825.43, 0.5962, 'green', 'manager',
    78.8616, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 72576.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 72576.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 72576.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 72576.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 72576.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 72576.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 72576.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 72576.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 72576.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 72576.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 72576.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 72576.35, 0, 'spreadsheet_seed');

  -- [5/179] Reece
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Reece', '', '',
    true, 802549.9800000004, 1026, 782.21, 0.2759,
    922932.48, -120382.5,
    0.0, 0.2759,
    9762.59, 0, 0,
    802549.9800000004, 2, 100,
    9762.59, 581158.67, 0.0, 581158.67, 160318.34,
    420840.33, 0.7241, 1026, 49248,
    1500.0, 500.0, 61010.59,
    359829.74, 0.6192, 'green', 'manager',
    54.4846, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 66879.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 66879.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 66879.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 66879.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 66879.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 66879.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 66879.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 66879.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 66879.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 66879.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 66879.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 66879.17, 0, 'spreadsheet_seed');

  -- [6/179] Bathroom Sales Direct
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Bathroom Sales Direct', '', '',
    true, 723520.2499999991, 1743, 415.1, 0.3607,
    832048.29, -108528.04,
    0.0, 0.3607,
    16340.13, 0, 0,
    723520.2499999991, 2, 100,
    16340.13, 462567.6, 0.0, 462567.6, 166834.64,
    295732.96, 0.6393, 1743, 83664,
    1500.0, 500.0, 102004.13,
    193728.83, 0.4188, 'green', 'cfo',
    23.1885, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 60293.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 60293.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 60293.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 60293.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 60293.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 60293.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 60293.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 60293.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 60293.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 60293.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 60293.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 60293.35, 0, 'spreadsheet_seed');

  -- [7/179] My Homeware Bathroom and Kitchen Supplies
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'My Homeware Bathroom and Kitchen Supplies', '', '',
    true, 522211.4600000005, 493, 1059.25, 0.321,
    600543.18, -78331.72,
    0.0, 0.321,
    8934.62, 0, 0,
    522211.4600000005, 2, 100,
    8934.62, 354606.8, 0.0, 354606.8, 113811.66,
    240795.14, 0.679, 493, 23664,
    1500.0, 500.0, 34598.62,
    206196.52, 0.5815, 'green', 'manager',
    37.0405, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 43517.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 43517.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 43517.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 43517.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 43517.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 43517.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 43517.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 43517.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 43517.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 43517.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 43517.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 43517.62, 0, 'spreadsheet_seed');

  -- [8/179] Designer Bathware
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Designer Bathware', '', '',
    true, 579524.2199999992, 1412, 410.43, 0.3677,
    666452.85, -86928.63,
    0.0, 0.3677,
    14593.76, 0, 0,
    579524.2199999992, 2, 100,
    14593.76, 366410.91, 0.0, 366410.91, 134743.36,
    231667.55, 0.6323, 1412, 67776,
    1500.0, 500.0, 84369.76,
    147297.79, 0.402, 'green', 'cfo',
    20.4632, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 48293.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 48293.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 48293.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 48293.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 48293.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 48293.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 48293.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 48293.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 48293.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 48293.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 48293.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 48293.68, 0, 'spreadsheet_seed');

  -- [9/179] Amber Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Amber Tiles', '', '',
    true, 362853.7700000002, 652, 556.52, 0.3279,
    417281.84, -54428.07,
    0.06, 0.3279,
    27063.8, 0, 0,
    362853.7700000002, 2, 100,
    27063.8, 243857.12, 14631.43, 229225.69, 75173.78,
    154051.91, 0.6721, 652, 31296,
    1500.0, 500.0, 60359.8,
    93692.11, 0.4087, 'green', 'cfo',
    7.846, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 30237.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 30237.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 30237.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 30237.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 30237.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 30237.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 30237.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 30237.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 30237.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 30237.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 30237.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 30237.81, 0, 'spreadsheet_seed');

  -- [10/179] Samios
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Samios', '', '',
    true, 269452.4400000002, 329, 819.0, 0.3082,
    309870.31, -40417.87,
    0.05, 0.3082,
    10924.5, 0, 0,
    269452.4400000002, 2, 100,
    10924.5, 186401.71, 9320.09, 177081.62, 54580.16,
    122501.46, 0.6918, 329, 15792,
    1500.0, 500.0, 28716.5,
    93784.96, 0.5296, 'green', 'cfo',
    15.6048, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 22454.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 22454.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 22454.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 22454.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 22454.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 22454.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 22454.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 22454.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 22454.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 22454.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 22454.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 22454.37, 0, 'spreadsheet_seed');

  -- [11/179] Buildmat
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Buildmat', '', '',
    true, 225070.2500000001, 300, 750.23, 0.2905,
    258830.79, -33760.54,
    0.0, 0.2905,
    206.9, 0, 0,
    225070.2500000001, 2, 100,
    206.9, 159678.46, 0.0, 159678.46, 46392.89,
    113285.57, 0.7095, 300, 14400,
    1500.0, 500.0, 16606.9,
    96678.67, 0.6055, 'green', 'manager',
    702.1675, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 18755.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 18755.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 18755.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 18755.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 18755.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 18755.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 18755.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 18755.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 18755.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 18755.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 18755.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 18755.85, 0, 'spreadsheet_seed');

  -- [12/179] Renovation Kingdom
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Renovation Kingdom', '', '',
    true, 206723.90999999997, 219, 943.94, 0.3647,
    237732.5, -31008.59,
    0.0, 0.3647,
    3413.33, 0, 0,
    206723.90999999997, 2, 100,
    3413.33, 131339.92, 0.0, 131339.92, 47894.45,
    83445.47, 0.6353, 219, 10512,
    1500.0, 500.0, 15925.33,
    67520.14, 0.5141, 'green', 'manager',
    35.3988, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 17226.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 17226.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 17226.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 17226.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 17226.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 17226.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 17226.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 17226.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 17226.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 17226.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 17226.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 17226.99, 0, 'spreadsheet_seed');

  -- [13/179] Tradelink
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Tradelink', '', '',
    true, 187191.37999999998, 340, 550.56, 0.2923,
    215270.09, -28078.71,
    0.07, 0.2923,
    9398.95, 0, 0,
    187191.37999999998, 2, 100,
    9398.95, 132482.41, 9273.77, 123208.64, 36009.23,
    87199.41, 0.7077, 340, 16320,
    1500.0, 500.0, 27718.95,
    59480.46, 0.4828, 'green', 'manager',
    12.3451, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 15599.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 15599.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 15599.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 15599.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 15599.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 15599.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 15599.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 15599.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 15599.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 15599.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 15599.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 15599.28, 0, 'spreadsheet_seed');

  -- [14/179] Sydney Taps
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Sydney Taps', '', '',
    true, 231384.09999999974, 368, 628.76, 0.4086,
    266091.71, -34707.61,
    0.095, 0.4086,
    17169.35, 0, 0,
    231384.09999999974, 2, 100,
    17169.35, 136832.17, 12999.06, 123833.11, 50602.7,
    73230.41, 0.5914, 368, 17664,
    1500.0, 500.0, 36833.35,
    36397.06, 0.2939, 'green', 'cfo',
    6.9279, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 19282.01, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 19282.01, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 19282.01, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 19282.01, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 19282.01, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 19282.01, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 19282.01, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 19282.01, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 19282.01, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 19282.01, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 19282.01, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 19282.01, 0, 'spreadsheet_seed');

  -- [15/179] Elia Bathrooms
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Elia Bathrooms', '', '',
    true, 182346.00999999998, 265, 688.1, 0.3624,
    209697.91, -27351.9,
    0.0, 0.3624,
    4663.44, 0, 0,
    182346.00999999998, 2, 100,
    4663.44, 116257.42, 0.0, 116257.42, 42135.77,
    74121.65, 0.6376, 265, 12720,
    1500.0, 500.0, 19383.44,
    54738.21, 0.4708, 'green', 'manager',
    22.2019, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 15195.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 15195.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 15195.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 15195.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 15195.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 15195.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 15195.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 15195.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 15195.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 15195.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 15195.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 15195.5, 0, 'spreadsheet_seed');

  -- [16/179] Clifton Bathrooms and Kitchens
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Clifton Bathrooms and Kitchens', '', '',
    true, 170374.12000000002, 347, 490.99, 0.3222,
    195930.24, -25556.12,
    0.0, 0.3222,
    1553.14, 0, 0,
    170374.12000000002, 2, 100,
    1553.14, 115482.3, 0.0, 115482.3, 37206.55,
    78275.75, 0.6778, 347, 16656,
    1500.0, 500.0, 20209.14,
    58066.61, 0.5028, 'green', 'manager',
    63.63, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 14197.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 14197.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 14197.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 14197.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 14197.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 14197.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 14197.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 14197.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 14197.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 14197.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 14197.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 14197.84, 0, 'spreadsheet_seed');

  -- [17/179] Icon Bathware
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Icon Bathware', '', '',
    true, 177755.79, 251, 708.19, 0.3504,
    204419.16, -26663.37,
    0.095, 0.3504,
    11106.59, 0, 0,
    177755.79, 2, 100,
    11106.59, 115471.55, 10969.8, 104501.75, 36616.6,
    67885.15, 0.6496, 251, 12048,
    1500.0, 500.0, 25154.59,
    42730.56, 0.4089, 'green', 'cfo',
    9.2967, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 14812.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 14812.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 14812.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 14812.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 14812.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 14812.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 14812.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 14812.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 14812.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 14812.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 14812.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 14812.98, 0, 'spreadsheet_seed');

  -- [18/179] Yeomans Bagno & Ceramiche
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Yeomans Bagno & Ceramiche', '', '',
    true, 180357.54, 287, 628.42, 0.3727,
    207411.17, -27053.63,
    0.095, 0.3727,
    7563.87, 0, 0,
    180357.54, 2, 100,
    7563.87, 113144.7, 10748.75, 102395.95, 38159.33,
    64236.62, 0.6273, 287, 13776,
    1500.0, 500.0, 23339.87,
    40896.75, 0.3994, 'green', 'manager',
    13.1146, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 15029.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 15029.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 15029.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 15029.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 15029.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 15029.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 15029.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 15029.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 15029.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 15029.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 15029.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 15029.8, 0, 'spreadsheet_seed');

  -- [19/179] Blue Leaf Bathware & Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Blue Leaf Bathware & Tiles', '', '',
    true, 164010.88000000003, 198, 828.34, 0.3812,
    188612.51, -24601.63,
    0.095, 0.3812,
    990.57, 0, 0,
    164010.88000000003, 2, 100,
    990.57, 101490.23, 9641.57, 91848.66, 35012.54,
    56836.12, 0.6188, 198, 9504,
    1500.0, 500.0, 12494.57,
    44341.55, 0.4828, 'green', 'manager',
    92.7046, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 13667.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 13667.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 13667.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 13667.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 13667.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 13667.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 13667.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 13667.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 13667.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 13667.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 13667.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 13667.57, 0, 'spreadsheet_seed');

  -- [20/179] Empire Bathrooms
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Empire Bathrooms', '', '',
    true, 135415.51, 151, 896.79, 0.2872,
    155727.84, -20312.33,
    0.095, 0.2872,
    2476.94, 0, 0,
    135415.51, 2, 100,
    2476.94, 96528.5, 9170.21, 87358.29, 25086.51,
    62271.78, 0.7128, 151, 7248,
    1500.0, 500.0, 11724.94,
    50546.84, 0.5786, 'green', 'manager',
    35.9927, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 11284.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 11284.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 11284.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 11284.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 11284.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 11284.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 11284.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 11284.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 11284.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 11284.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 11284.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 11284.63, 0, 'spreadsheet_seed');

  -- [21/179] Bathroom Space
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Bathroom Space', '', '',
    true, 135060.05000000005, 123, 1098.05, 0.3674,
    155319.06, -20259.01,
    0.0, 0.3674,
    3010.57, 0, 0,
    135060.05000000005, 2, 100,
    3010.57, 85439.26, 0.0, 85439.26, 31390.21,
    54049.05, 0.6326, 123, 5904,
    1500.0, 500.0, 10914.57,
    43134.48, 0.5049, 'green', 'manager',
    26.4187, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 11255.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 11255.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 11255.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 11255.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 11255.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 11255.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 11255.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 11255.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 11255.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 11255.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 11255.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 11255.0, 0, 'spreadsheet_seed');

  -- [22/179] Ideal Bathrooms
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Ideal Bathrooms', '', '',
    true, 120176.52999999996, 152, 790.64, 0.3199,
    138203.01, -18026.48,
    0.0, 0.3199,
    1202.65, 0, 0,
    120176.52999999996, 2, 100,
    1202.65, 81730.41, 0.0, 81730.41, 26146.68,
    55583.73, 0.6801, 152, 7296,
    1500.0, 500.0, 10498.65,
    45085.08, 0.5516, 'green', 'manager',
    61.892, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 10014.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 10014.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 10014.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 10014.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 10014.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 10014.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 10014.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 10014.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 10014.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 10014.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 10014.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 10014.71, 0, 'spreadsheet_seed');

  -- [23/179] Jacoba Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Jacoba Tiles', '', '',
    true, 130704.2000000001, 184, 710.35, 0.3629,
    150309.83, -19605.63,
    0.0, 0.3629,
    3552.51, 0, 0,
    130704.2000000001, 2, 100,
    3552.51, 83273.19, 0.0, 83273.19, 30218.86,
    53054.33, 0.6371, 184, 8832,
    1500.0, 500.0, 14384.51,
    38669.82, 0.4644, 'green', 'manager',
    20.9545, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 10892.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 10892.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 10892.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 10892.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 10892.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 10892.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 10892.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 10892.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 10892.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 10892.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 10892.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 10892.02, 0, 'spreadsheet_seed');

  -- [24/179] Benton's Plumbing Supplies
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Benton''s Plumbing Supplies', '', '',
    true, 129038.77999999993, 292, 441.91, 0.3123,
    148394.6, -19355.82,
    0.0, 0.3123,
    5455.35, 0, 0,
    129038.77999999993, 2, 100,
    5455.35, 88745.61, 0.0, 88745.61, 27711.37,
    61034.24, 0.6877, 292, 14016,
    1500.0, 500.0, 21471.35,
    39562.89, 0.4458, 'green', 'manager',
    13.6984, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 10753.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 10753.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 10753.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 10753.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 10753.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 10753.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 10753.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 10753.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 10753.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 10753.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 10753.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 10753.23, 0, 'spreadsheet_seed');

  -- [25/179] Design Bathware
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Design Bathware', '', '',
    true, 123569.5, 147, 840.61, 0.3524,
    142104.92, -18535.42,
    0.0, 0.3524,
    4453.41, 0, 0,
    123569.5, 2, 100,
    4453.41, 80028.12, 0.0, 80028.12, 28198.99,
    51829.13, 0.6476, 147, 7056,
    1500.0, 500.0, 13509.41,
    38319.72, 0.4788, 'green', 'manager',
    16.3857, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 10297.46, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 10297.46, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 10297.46, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 10297.46, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 10297.46, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 10297.46, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 10297.46, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 10297.46, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 10297.46, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 10297.46, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 10297.46, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 10297.46, 0, 'spreadsheet_seed');

  -- [26/179] JB Camerons (Plumbing, Steel, Welding & Industrial)
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'JB Camerons (Plumbing, Steel, Welding & Industrial)', '', '',
    true, 122872.85, 120, 1023.94, 0.3128,
    141303.78, -18430.93,
    0.0, 0.3128,
    11079.55, 0, 0,
    122872.85, 2, 100,
    11079.55, 84438.2, 0.0, 84438.2, 26412.28,
    58025.92, 0.6872, 120, 5760,
    1500.0, 500.0, 18839.55,
    39186.37, 0.4641, 'green', 'cfo',
    7.1012, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 10239.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 10239.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 10239.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 10239.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 10239.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 10239.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 10239.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 10239.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 10239.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 10239.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 10239.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 10239.4, 0, 'spreadsheet_seed');

  -- [27/179] BMC Sharm LTD
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'BMC Sharm LTD', '', '',
    true, 157062.73999999996, 36, 4362.85, 0.5474,
    180622.15, -23559.41,
    0.0, 0.5474,
    2227.18, 0, 0,
    157062.73999999996, 2, 100,
    2227.18, 71079.92, 0.0, 71079.92, 38912.17,
    32167.75, 0.4526, 36, 1728,
    1500.0, 500.0, 5955.18,
    26212.57, 0.3688, 'green', 'manager',
    31.1389, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 13088.56, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 13088.56, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 13088.56, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 13088.56, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 13088.56, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 13088.56, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 13088.56, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 13088.56, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 13088.56, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 13088.56, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 13088.56, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 13088.56, 0, 'spreadsheet_seed');

  -- [28/179] Elegance Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Elegance Tiles', '', '',
    true, 141845.88, 222, 638.95, 0.3743,
    163122.76, -21276.88,
    0.0, 0.3743,
    13536.39, 0, 0,
    141845.88, 2, 100,
    13536.39, 88753.4, 0.0, 88753.4, 33220.13,
    55533.27, 0.6257, 222, 10656,
    1500.0, 500.0, 26192.39,
    29340.88, 0.3306, 'green', 'cfo',
    5.7694, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 11820.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 11820.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 11820.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 11820.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 11820.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 11820.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 11820.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 11820.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 11820.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 11820.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 11820.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 11820.49, 0, 'spreadsheet_seed');

  -- [29/179] Metcash Hardings / D10
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Metcash Hardings / D10', '', '',
    true, 151039.29, 235, 642.72, 0.3527,
    173695.18, -22655.89,
    0.0, 0.3527,
    22013.98, 0, 0,
    151039.29, 2, 100,
    22013.98, 97772.82, 0.0, 97772.82, 34481.18,
    63291.64, 0.6473, 235, 11280,
    1500.0, 500.0, 35293.98,
    27997.66, 0.2864, 'green', 'cfo',
    3.929, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 12586.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 12586.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 12586.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 12586.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 12586.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 12586.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 12586.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 12586.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 12586.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 12586.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 12586.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 12586.61, 0, 'spreadsheet_seed');

  -- [30/179] Tile Republic
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Tile Republic', '', '',
    true, 119945.74000000005, 112, 1070.94, 0.3701,
    137937.6, -17991.86,
    0.0, 0.3701,
    5868.06, 0, 0,
    119945.74000000005, 2, 100,
    5868.06, 75557.09, 0.0, 75557.09, 27961.62,
    47595.47, 0.6299, 112, 5376,
    1500.0, 500.0, 13244.06,
    34351.41, 0.4546, 'green', 'manager',
    11.9598, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 9995.48, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 9995.48, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 9995.48, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 9995.48, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 9995.48, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 9995.48, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 9995.48, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 9995.48, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 9995.48, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 9995.48, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 9995.48, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 9995.48, 0, 'spreadsheet_seed');

  -- [31/179] Brands Direct Online
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Brands Direct Online', '', '',
    true, 139531.44999999998, 406, 343.67, 0.3492,
    160461.17, -20929.72,
    0.095, 0.3492,
    8240.71, 0, 0,
    139531.44999999998, 2, 100,
    8240.71, 90810.54, 8627.0, 82183.54, 28696.45,
    53487.09, 0.6508, 406, 19488,
    1500.0, 500.0, 29728.71,
    23758.38, 0.2891, 'green', 'manager',
    8.6388, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 11627.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 11627.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 11627.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 11627.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 11627.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 11627.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 11627.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 11627.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 11627.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 11627.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 11627.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 11627.62, 0, 'spreadsheet_seed');

  -- [32/179] FAS Group Pty Ltd (GT&B)
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'FAS Group Pty Ltd (GT&B)', '', '',
    true, 107326.35999999999, 181, 592.96, 0.3613,
    123425.31, -16098.95,
    0.095, 0.3613,
    6256.94, 0, 0,
    107326.35999999999, 2, 100,
    6256.94, 68549.3, 6512.18, 62037.12, 22414.04,
    39623.08, 0.6387, 181, 8688,
    1500.0, 500.0, 16944.94,
    22678.14, 0.3656, 'green', 'manager',
    9.5509, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 8943.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 8943.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 8943.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 8943.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 8943.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 8943.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 8943.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 8943.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 8943.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 8943.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 8943.86, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 8943.86, 0, 'spreadsheet_seed');

  -- [33/179] Sannine Bathrooms
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Sannine Bathrooms', '', '',
    true, 107865.30999999995, 108, 998.75, 0.4167,
    124045.11, -16179.8,
    0.0, 0.4167,
    5086.66, 0, 0,
    107865.30999999995, 2, 100,
    5086.66, 62914.34, 0.0, 62914.34, 26218.44,
    36695.9, 0.5833, 108, 5184,
    1500.0, 500.0, 12270.66,
    24425.24, 0.3882, 'green', 'manager',
    11.3494, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 8988.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 8988.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 8988.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 8988.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 8988.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 8988.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 8988.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 8988.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 8988.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 8988.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 8988.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 8988.78, 0, 'spreadsheet_seed');

  -- [34/179] Temple and Webster
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Temple and Webster', '', '',
    true, 166263.76999999996, 1392, 119.44, 0.3009,
    191203.34, -24939.57,
    0.0, 0.3009,
    1233.36, 0, 0,
    166263.76999999996, 2, 100,
    1233.36, 116232.49, 0.0, 116232.49, 34976.11,
    81256.38, 0.6991, 1392, 66816,
    1500.0, 500.0, 70049.36,
    11207.02, 0.0964, 'review', 'manager',
    40.0666, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 13855.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 13855.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 13855.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 13855.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 13855.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 13855.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 13855.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 13855.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 13855.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 13855.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 13855.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 13855.31, 0, 'spreadsheet_seed');

  -- [35/179] NCP
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'NCP', '', '',
    true, 86436.21000000002, 133, 649.9, 0.3643,
    99401.64, -12965.43,
    0.0, 0.3643,
    1296.52, 0, 0,
    86436.21000000002, 2, 100,
    1296.52, 54948.07, 0.0, 54948.07, 20017.22,
    34930.85, 0.6357, 133, 6384,
    1500.0, 500.0, 9680.52,
    25250.33, 0.4595, 'green', 'manager',
    37.4572, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 7203.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 7203.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 7203.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 7203.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 7203.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 7203.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 7203.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 7203.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 7203.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 7203.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 7203.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 7203.02, 0, 'spreadsheet_seed');

  -- [36/179] Biga Limited
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Biga Limited', '', '',
    true, 77682.22000000002, 66, 1177.0, 0.3867,
    89334.55, -11652.33,
    0.0, 0.3867,
    2504.81, 0, 0,
    77682.22000000002, 2, 100,
    2504.81, 47643.08, 0.0, 47643.08, 18423.23,
    29219.85, 0.6133, 66, 3168,
    1500.0, 500.0, 7672.81,
    21547.04, 0.4523, 'green', 'manager',
    17.7559, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 6473.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 6473.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 6473.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 6473.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 6473.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 6473.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 6473.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 6473.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 6473.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 6473.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 6473.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 6473.52, 0, 'spreadsheet_seed');

  -- [37/179] Bina Warehouse
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Bina Warehouse', '', '',
    true, 103976.96, 116, 896.35, 0.5067,
    119573.5, -15596.54,
    0.0, 0.5067,
    4250.52, 0, 0,
    103976.96, 2, 100,
    4250.52, 51290.94, 0.0, 51290.94, 25989.56,
    25301.38, 0.4933, 116, 5568,
    1500.0, 500.0, 11818.52,
    13482.86, 0.2629, 'green', 'manager',
    10.757, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 8664.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 8664.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 8664.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 8664.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 8664.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 8664.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 8664.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 8664.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 8664.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 8664.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 8664.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 8664.75, 0, 'spreadsheet_seed');

  -- [38/179] Eos Bathware
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Eos Bathware', '', '',
    true, 78161.30999999997, 154, 507.54, 0.3597,
    89885.51, -11724.2,
    0.0, 0.3597,
    2962.67, 0, 0,
    78161.30999999997, 2, 100,
    2962.67, 50045.99, 0.0, 50045.99, 18001.99,
    32044.0, 0.6403, 154, 7392,
    1500.0, 500.0, 12354.67,
    19689.33, 0.3934, 'green', 'manager',
    14.3971, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 6513.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 6513.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 6513.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 6513.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 6513.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 6513.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 6513.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 6513.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 6513.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 6513.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 6513.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 6513.44, 0, 'spreadsheet_seed');

  -- [39/179] Wentworth Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Wentworth Tiles', '', '',
    true, 62530.38999999999, 97, 644.64, 0.291,
    71909.95, -9379.56,
    0.095, 0.291,
    972.17, 0, 0,
    62530.38999999999, 2, 100,
    972.17, 44336.58, 4211.98, 40124.6, 11674.63,
    28449.97, 0.709, 97, 4656,
    1500.0, 500.0, 7628.17,
    20821.8, 0.5189, 'green', 'manager',
    40.7554, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 5210.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 5210.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 5210.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 5210.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 5210.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 5210.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 5210.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 5210.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 5210.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 5210.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 5210.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 5210.87, 0, 'spreadsheet_seed');

  -- [40/179] Routleys Bathroom Kitchen Laundry
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Routleys Bathroom Kitchen Laundry', '', '',
    true, 67895.73, 114, 595.58, 0.3319,
    78080.09, -10184.36,
    0.0, 0.3319,
    1753.16, 0, 0,
    67895.73, 2, 100,
    1753.16, 45359.86, 0.0, 45359.86, 15055.79,
    30304.07, 0.6681, 114, 5472,
    1500.0, 500.0, 9225.16,
    21078.91, 0.4647, 'green', 'manager',
    22.752, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 5657.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 5657.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 5657.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 5657.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 5657.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 5657.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 5657.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 5657.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 5657.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 5657.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 5657.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 5657.98, 0, 'spreadsheet_seed');

  -- [41/179] Wellsons Plumbing and Bathroom Supplies
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Wellsons Plumbing and Bathroom Supplies', '', '',
    true, 65022.56999999998, 146, 445.36, 0.2961,
    74775.96, -9753.39,
    0.0, 0.2961,
    1822.68, 0, 0,
    65022.56999999998, 2, 100,
    1822.68, 45767.16, 0.0, 45767.16, 13553.22,
    32213.94, 0.7039, 146, 7008,
    1500.0, 500.0, 10830.68,
    21383.26, 0.4672, 'green', 'manager',
    21.2649, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 5418.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 5418.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 5418.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 5418.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 5418.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 5418.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 5418.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 5418.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 5418.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 5418.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 5418.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 5418.55, 0, 'spreadsheet_seed');

  -- [42/179] Embracing Space
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Embracing Space', '', '',
    true, 47718.91, 16, 2982.43, 0.2187,
    54876.75, -7157.84,
    0.0, 0.2187,
    383.08, 0, 0,
    47718.91, 2, 100,
    383.08, 37281.98, 0.0, 37281.98, 8154.2,
    29127.78, 0.7813, 16, 768,
    1500.0, 500.0, 3151.08,
    25976.7, 0.6968, 'green', 'manager',
    95.3169, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3976.58, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3976.58, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3976.58, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3976.58, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3976.58, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3976.58, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3976.58, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3976.58, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3976.58, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3976.58, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3976.58, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3976.58, 0, 'spreadsheet_seed');

  -- [43/179] Djati&Mastello B.V.
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Djati&Mastello B.V.', '', '',
    true, 205516.29000000018, 257, 799.67, 0.7597,
    236343.73, -30827.44,
    0.0, 0.7597,
    1007.08, 0, 0,
    205516.29000000018, 2, 100,
    1007.08, 49395.08, 0.0, 49395.08, 37523.16,
    11871.92, 0.2403, 257, 12336,
    1500.0, 500.0, 15343.08,
    -3471.16, -0.0703, 'review', 'manager',
    36.7985, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 17126.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 17126.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 17126.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 17126.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 17126.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 17126.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 17126.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 17126.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 17126.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 17126.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 17126.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 17126.36, 0, 'spreadsheet_seed');

  -- [44/179] Armanti Tiles and Bathroom
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Armanti Tiles and Bathroom', '', '',
    true, 59581.7, 80, 744.77, 0.289,
    68518.95, -8937.25,
    0.0, 0.289,
    5062.58, 0, 0,
    59581.7, 2, 100,
    5062.58, 42362.7, 0.0, 42362.7, 12242.74,
    30119.96, 0.711, 80, 3840,
    1500.0, 500.0, 10902.58,
    19217.38, 0.4536, 'green', 'manager',
    7.6093, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4965.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4965.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4965.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4965.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4965.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4965.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4965.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4965.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4965.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4965.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4965.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4965.14, 0, 'spreadsheet_seed');

  -- [45/179] Portelli Home Centre
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Portelli Home Centre', '', '',
    true, 68182.21999999999, 91, 749.26, 0.3787,
    78409.55, -10227.33,
    0.0, 0.3787,
    4818.02, 0, 0,
    68182.21999999999, 2, 100,
    4818.02, 42361.07, 0.0, 42361.07, 16042.47,
    26318.6, 0.6213, 91, 4368,
    1500.0, 500.0, 11186.02,
    15132.58, 0.3572, 'green', 'manager',
    7.8856, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 5681.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 5681.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 5681.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 5681.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 5681.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 5681.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 5681.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 5681.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 5681.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 5681.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 5681.85, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 5681.85, 0, 'spreadsheet_seed');

  -- [46/179] W.Eagles Plumbing Supplies Pty Ltd
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'W.Eagles Plumbing Supplies Pty Ltd', '', '',
    true, 55064.00999999999, 107, 514.62, 0.2876,
    63323.61, -8259.6,
    0.0, 0.2876,
    1277.27, 0, 0,
    55064.00999999999, 2, 100,
    1277.27, 39229.47, 0.0, 39229.47, 11281.06,
    27948.41, 0.7124, 107, 5136,
    1500.0, 500.0, 8413.27,
    19535.14, 0.498, 'green', 'manager',
    26.6925, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4588.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4588.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4588.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4588.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4588.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4588.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4588.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4588.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4588.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4588.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4588.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4588.67, 0, 'spreadsheet_seed');

  -- [47/179] Gratico Tile and Bath
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Gratico Tile and Bath', '', '',
    true, 53790.870000000024, 80, 672.39, 0.3254,
    61859.5, -8068.63,
    0.0, 0.3254,
    829.0, 0, 0,
    53790.870000000024, 2, 100,
    829.0, 36286.19, 0.0, 36286.19, 11808.29,
    24477.9, 0.6746, 80, 3840,
    1500.0, 500.0, 6669.0,
    17808.9, 0.4908, 'green', 'manager',
    39.139, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4482.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4482.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4482.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4482.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4482.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4482.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4482.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4482.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4482.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4482.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4482.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4482.57, 0, 'spreadsheet_seed');

  -- [48/179] Burdens Plumbing
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Burdens Plumbing', '', '',
    true, 94339.32000000005, 225, 419.29, 0.3695,
    108490.22, -14150.9,
    0.0, 0.3695,
    17463.6, 0, 0,
    94339.32000000005, 2, 100,
    17463.6, 59480.09, 0.0, 59480.09, 21978.43,
    37501.66, 0.6305, 225, 10800,
    1500.0, 500.0, 30263.6,
    7238.06, 0.1217, 'review', 'cfo',
    2.7875, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 7861.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 7861.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 7861.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 7861.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 7861.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 7861.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 7861.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 7861.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 7861.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 7861.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 7861.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 7861.61, 0, 'spreadsheet_seed');

  -- [49/179] Hasl
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Hasl', '', '',
    true, 49323.29000000001, 52, 948.52, 0.2613,
    56721.78, -7398.49,
    0.0, 0.2613,
    3648.45, 0, 0,
    49323.29000000001, 2, 100,
    3648.45, 36434.18, 0.0, 36434.18, 9520.94,
    26913.24, 0.7387, 52, 2496,
    1500.0, 500.0, 8144.45,
    18768.79, 0.5151, 'green', 'manager',
    9.3021, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4110.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4110.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4110.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4110.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4110.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4110.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4110.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4110.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4110.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4110.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4110.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4110.27, 0, 'spreadsheet_seed');

  -- [50/179] Regal Concept Design
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Regal Concept Design', '', '',
    true, 47061.65000000001, 49, 960.44, 0.2646,
    54120.9, -7059.25,
    0.0, 0.2646,
    1988.91, 0, 0,
    47061.65000000001, 2, 100,
    1988.91, 34607.88, 0.0, 34607.88, 9158.17,
    25449.71, 0.7354, 49, 2352,
    1500.0, 500.0, 6340.91,
    19108.8, 0.5522, 'green', 'manager',
    16.2179, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3921.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3921.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3921.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3921.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3921.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3921.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3921.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3921.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3921.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3921.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3921.8, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3921.8, 0, 'spreadsheet_seed');

  -- [51/179] Cass Brothers
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Cass Brothers', '', '',
    true, 46825.66, 65, 720.39, 0.2915,
    53849.51, -7023.85,
    0.0, 0.2915,
    167.11, 0, 0,
    46825.66, 2, 100,
    167.11, 33177.09, 0.0, 33177.09, 9670.34,
    23506.75, 0.7085, 65, 3120,
    1500.0, 500.0, 5287.11,
    18219.64, 0.5492, 'green', 'manager',
    179.8641, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3902.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3902.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3902.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3902.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3902.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3902.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3902.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3902.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3902.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3902.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3902.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3902.14, 0, 'spreadsheet_seed');

  -- [52/179] Ken's Plumbing Plus
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Ken''s Plumbing Plus', '', '',
    true, 44775.07, 44, 1017.62, 0.2855,
    51491.33, -6716.26,
    0.0, 0.2855,
    38.4, 0, 0,
    44775.07, 2, 100,
    38.4, 31992.01, 0.0, 31992.01, 9133.56,
    22858.45, 0.7145, 44, 2112,
    1500.0, 500.0, 4150.4,
    18708.05, 0.5848, 'green', 'manager',
    778.1253, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3731.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3731.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3731.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3731.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3731.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3731.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3731.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3731.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3731.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3731.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3731.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3731.26, 0, 'spreadsheet_seed');

  -- [53/179] Art Bathrooms And Kitcheware Pty Ltd
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Art Bathrooms And Kitcheware Pty Ltd', '', '',
    true, 53771.049999999996, 72, 746.82, 0.3698,
    61836.71, -8065.66,
    0.0, 0.3698,
    1127.16, 0, 0,
    53771.049999999996, 2, 100,
    1127.16, 33886.68, 0.0, 33886.68, 12531.19,
    21355.49, 0.6302, 72, 3456,
    1500.0, 500.0, 6583.16,
    14772.33, 0.4359, 'green', 'manager',
    26.9977, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4480.92, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4480.92, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4480.92, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4480.92, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4480.92, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4480.92, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4480.92, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4480.92, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4480.92, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4480.92, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4480.92, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4480.92, 0, 'spreadsheet_seed');

  -- [54/179] Ceramico Tiles & Bathrooms
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Ceramico Tiles & Bathrooms', '', '',
    true, 42488.59, 25, 1699.54, 0.2733,
    48861.88, -6373.29,
    0.0, 0.2733,
    793.35, 0, 0,
    42488.59, 2, 100,
    793.35, 30874.91, 0.0, 30874.91, 8439.24,
    22435.67, 0.7267, 25, 1200,
    1500.0, 500.0, 3993.35,
    18442.32, 0.5973, 'green', 'manager',
    37.4046, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3540.72, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3540.72, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3540.72, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3540.72, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3540.72, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3540.72, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3540.72, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3540.72, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3540.72, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3540.72, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3540.72, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3540.72, 0, 'spreadsheet_seed');

  -- [55/179] Fred Rose Bathrooms
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Fred Rose Bathrooms', '', '',
    true, 42809.020000000004, 42, 1019.26, 0.2873,
    49230.37, -6421.35,
    0.0, 0.2873,
    295.25, 0, 0,
    42809.020000000004, 2, 100,
    295.25, 30508.31, 0.0, 30508.31, 8766.23,
    21742.08, 0.7127, 42, 2016,
    1500.0, 500.0, 4311.25,
    17430.83, 0.5713, 'green', 'manager',
    96.5023, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3567.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3567.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3567.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3567.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3567.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3567.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3567.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3567.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3567.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3567.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3567.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3567.42, 0, 'spreadsheet_seed');

  -- [56/179] Stocks Designer Appliances and Bathrooms
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Stocks Designer Appliances and Bathrooms', '', '',
    true, 38481.880000000005, 24, 1603.41, 0.2697,
    44254.16, -5772.28,
    0.0, 0.2697,
    342.33, 0, 0,
    38481.880000000005, 2, 100,
    342.33, 28103.79, 0.0, 28103.79, 7579.25,
    20524.54, 0.7303, 24, 1152,
    1500.0, 500.0, 3494.33,
    17030.21, 0.606, 'green', 'manager',
    78.7304, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3206.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3206.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3206.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3206.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3206.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3206.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3206.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3206.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3206.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3206.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3206.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3206.82, 0, 'spreadsheet_seed');

  -- [57/179] Mitre 10
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Mitre 10', '', '',
    true, 48472.18, 78, 621.44, 0.3207,
    55743.01, -7270.83,
    0.0, 0.3207,
    2844.88, 0, 0,
    48472.18, 2, 100,
    2844.88, 32927.55, 0.0, 32927.55, 10559.59,
    22367.96, 0.6793, 78, 3744,
    1500.0, 500.0, 8588.88,
    13779.08, 0.4185, 'green', 'manager',
    10.2583, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4039.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4039.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4039.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4039.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4039.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4039.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4039.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4039.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4039.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4039.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4039.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4039.35, 0, 'spreadsheet_seed');

  -- [58/179] Sunlight Bathrooms
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Sunlight Bathrooms', '', '',
    true, 51019.17999999999, 141, 361.84, 0.3365,
    58672.06, -7652.88,
    0.0, 0.3365,
    1066.43, 0, 0,
    51019.17999999999, 2, 100,
    1066.43, 33852.74, 0.0, 33852.74, 11390.44,
    22462.3, 0.6635, 141, 6768,
    1500.0, 500.0, 9834.43,
    12627.87, 0.373, 'green', 'manager',
    25.3976, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4251.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4251.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4251.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4251.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4251.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4251.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4251.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4251.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4251.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4251.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4251.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4251.6, 0, 'spreadsheet_seed');

  -- [59/179] The Renovation Hub
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'The Renovation Hub', '', '',
    true, 39654.09000000001, 51, 777.53, 0.3007,
    45602.2, -5948.11,
    0.0, 0.3007,
    1416.91, 0, 0,
    39654.09000000001, 2, 100,
    1416.91, 27728.68, 0.0, 27728.68, 8339.01,
    19389.67, 0.6993, 51, 2448,
    1500.0, 500.0, 5864.91,
    13524.76, 0.4878, 'green', 'manager',
    17.8421, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3304.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3304.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3304.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3304.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3304.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3304.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3304.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3304.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3304.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3304.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3304.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3304.51, 0, 'spreadsheet_seed');

  -- [60/179] Design Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Design Tiles', '', '',
    true, 48786.829999999994, 69, 707.06, 0.4019,
    56104.85, -7318.02,
    0.0, 0.4019,
    2225.14, 0, 0,
    48786.829999999994, 2, 100,
    2225.14, 29179.17, 0.0, 29179.17, 11727.25,
    17451.92, 0.5981, 69, 3312,
    1500.0, 500.0, 7537.14,
    9914.78, 0.3398, 'green', 'manager',
    11.625, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4065.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4065.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4065.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4065.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4065.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4065.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4065.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4065.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4065.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4065.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4065.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4065.57, 0, 'spreadsheet_seed');

  -- [61/179] Ken Bathroom & Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Ken Bathroom & Tiles', '', '',
    true, 39913.450000000004, 41, 973.5, 0.3485,
    45900.47, -5987.02,
    0.0, 0.3485,
    669.64, 0, 0,
    39913.450000000004, 2, 100,
    669.64, 26002.13, 0.0, 26002.13, 9062.71,
    16939.42, 0.6515, 41, 1968,
    1500.0, 500.0, 4637.64,
    12301.78, 0.4731, 'green', 'manager',
    35.8911, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3326.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3326.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3326.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3326.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3326.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3326.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3326.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3326.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3326.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3326.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3326.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3326.12, 0, 'spreadsheet_seed');

  -- [62/179] Essential Building Supplies
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Essential Building Supplies', '', '',
    true, 41908.75999999998, 25, 1676.35, 0.4075,
    48195.07, -6286.31,
    0.0, 0.4075,
    330.89, 0, 0,
    41908.75999999998, 2, 100,
    330.89, 24832.57, 0.0, 24832.57, 10118.31,
    14714.26, 0.5925, 25, 1200,
    1500.0, 500.0, 3530.89,
    11183.37, 0.4504, 'green', 'manager',
    71.4212, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3492.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3492.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3492.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3492.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3492.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3492.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3492.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3492.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3492.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3492.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3492.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3492.4, 0, 'spreadsheet_seed');

  -- [63/179] Spigot and More
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Spigot and More', '', '',
    true, 39914.25, 35, 1140.41, 0.3807,
    45901.39, -5987.14,
    0.0, 0.3807,
    67.34, 0, 0,
    39914.25, 2, 100,
    67.34, 24719.95, 0.0, 24719.95, 9410.23,
    15309.72, 0.6193, 35, 1680,
    1500.0, 500.0, 3747.34,
    11562.38, 0.4677, 'green', 'manager',
    342.1436, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3326.19, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3326.19, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3326.19, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3326.19, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3326.19, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3326.19, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3326.19, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3326.19, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3326.19, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3326.19, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3326.19, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3326.19, 0, 'spreadsheet_seed');

  -- [64/179] Mandk Pte Ltd
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Mandk Pte Ltd', '', '',
    true, 99747.73999999996, 157, 635.34, 0.5409,
    114709.9, -14962.16,
    0.0, 0.5409,
    15451.88, 0, 0,
    99747.73999999996, 2, 100,
    15451.88, 45793.44, 0.0, 45793.44, 24770.01,
    21023.43, 0.4591, 157, 7536,
    1500.0, 500.0, 24987.88,
    -3964.45, -0.0866, 'review', 'cfo',
    2.4759, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 8312.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 8312.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 8312.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 8312.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 8312.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 8312.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 8312.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 8312.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 8312.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 8312.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 8312.31, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 8312.31, 0, 'spreadsheet_seed');

  -- [65/179] MTS Bathroomware
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'MTS Bathroomware', '', '',
    true, 35965.47, 42, 856.32, 0.2927,
    41360.29, -5394.82,
    0.0, 0.2927,
    638.51, 0, 0,
    35965.47, 2, 100,
    638.51, 25438.53, 0.0, 25438.53, 7445.75,
    17992.78, 0.7073, 42, 2016,
    1500.0, 500.0, 4654.51,
    13338.27, 0.5243, 'green', 'manager',
    36.6831, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2997.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2997.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2997.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2997.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2997.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2997.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2997.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2997.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2997.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2997.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2997.12, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2997.12, 0, 'spreadsheet_seed');

  -- [66/179] Retail Customer
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Retail Customer', '', '',
    true, 97549.85999999961, 668, 146.03, 0.4191,
    112182.34, -14632.48,
    0.0, 0.4191,
    2100.62, 0, 0,
    97549.85999999961, 2, 100,
    2100.62, 56670.41, 0.0, 56670.41, 23748.42,
    32921.99, 0.5809, 668, 32064,
    1500.0, 500.0, 36164.62,
    -3242.63, -0.0572, 'review', 'manager',
    11.7139, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 8129.15, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 8129.15, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 8129.15, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 8129.15, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 8129.15, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 8129.15, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 8129.15, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 8129.15, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 8129.15, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 8129.15, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 8129.15, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 8129.15, 0, 'spreadsheet_seed');

  -- [67/179] Toowoomba Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Toowoomba Tiles', '', '',
    true, 36412.9, 31, 1174.61, 0.3165,
    41874.83, -5461.93,
    0.0, 0.3165,
    1309.5, 0, 0,
    36412.9, 2, 100,
    1309.5, 24889.26, 0.0, 24889.26, 7876.74,
    17012.52, 0.6835, 31, 1488,
    1500.0, 500.0, 4797.5,
    12215.02, 0.4908, 'green', 'manager',
    17.8704, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3034.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3034.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3034.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3034.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3034.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3034.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3034.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3034.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3034.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3034.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3034.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3034.41, 0, 'spreadsheet_seed');

  -- [68/179] Topware
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Topware', '', '',
    true, 35965.060000000005, 29, 1240.17, 0.3482,
    41359.82, -5394.76,
    0.0, 0.3482,
    332.78, 0, 0,
    35965.060000000005, 2, 100,
    332.78, 23443.1, 0.0, 23443.1, 8162.19,
    15280.91, 0.6518, 29, 1392,
    1500.0, 500.0, 3724.78,
    11556.13, 0.4929, 'green', 'manager',
    66.2633, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2997.09, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2997.09, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2997.09, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2997.09, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2997.09, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2997.09, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2997.09, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2997.09, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2997.09, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2997.09, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2997.09, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2997.09, 0, 'spreadsheet_seed');

  -- [69/179] Tile House (previously AA Tiles)
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Tile House (previously AA Tiles)', '', '',
    true, 38896.43, 40, 972.41, 0.3536,
    44730.89, -5834.46,
    0.0, 0.3536,
    1687.34, 0, 0,
    38896.43, 2, 100,
    1687.34, 25141.21, 0.0, 25141.21, 8890.86,
    16250.35, 0.6464, 40, 1920,
    1500.0, 500.0, 5607.34,
    10643.01, 0.4233, 'green', 'manager',
    13.762, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3241.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3241.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3241.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3241.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3241.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3241.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3241.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3241.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3241.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3241.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3241.37, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3241.37, 0, 'spreadsheet_seed');

  -- [70/179] Cook's Plumbing Supplies
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Cook''s Plumbing Supplies', '', '',
    true, 30449.02, 26, 1171.12, 0.25,
    35016.37, -4567.35,
    0.0, 0.25,
    375.77, 0, 0,
    30449.02, 2, 100,
    375.77, 22835.38, 0.0, 22835.38, 5709.88,
    17125.5, 0.75, 26, 1248,
    1500.0, 500.0, 3623.77,
    13501.73, 0.5913, 'green', 'manager',
    57.4484, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2537.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2537.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2537.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2537.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2537.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2537.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2537.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2537.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2537.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2537.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2537.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2537.42, 0, 'spreadsheet_seed');

  -- [71/179] Canberra Tile House
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Canberra Tile House', '', '',
    true, 46523.27999999999, 68, 684.17, 0.3642,
    53501.77, -6978.49,
    0.0, 0.3642,
    5711.91, 0, 0,
    46523.27999999999, 2, 100,
    5711.91, 29579.32, 0.0, 29579.32, 10772.9,
    18806.42, 0.6358, 68, 3264,
    1500.0, 500.0, 10975.91,
    7830.51, 0.2647, 'green', 'manager',
    4.6071, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3876.94, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3876.94, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3876.94, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3876.94, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3876.94, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3876.94, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3876.94, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3876.94, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3876.94, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3876.94, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3876.94, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3876.94, 0, 'spreadsheet_seed');

  -- [72/179] Walkers
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Walkers', '', '',
    true, 33646.46, 40, 841.16, 0.296,
    38693.43, -5046.97,
    0.0, 0.296,
    2275.6, 0, 0,
    33646.46, 2, 100,
    2275.6, 23687.94, 0.0, 23687.94, 7011.04,
    16676.9, 0.704, 40, 1920,
    1500.0, 500.0, 6195.6,
    10481.3, 0.4425, 'green', 'manager',
    9.5658, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2803.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2803.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2803.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2803.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2803.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2803.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2803.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2803.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2803.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2803.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2803.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2803.87, 0, 'spreadsheet_seed');

  -- [73/179] Melbourne Tile Gallery Tullamarine
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Melbourne Tile Gallery Tullamarine', '', '',
    true, 32603.93, 36, 905.66, 0.3396,
    37494.52, -4890.59,
    0.0, 0.3396,
    343.95, 0, 0,
    32603.93, 2, 100,
    343.95, 21531.13, 0.0, 21531.13, 7312.31,
    14218.82, 0.6604, 36, 1728,
    1500.0, 500.0, 4071.95,
    10146.87, 0.4713, 'green', 'manager',
    57.5756, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2716.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2716.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2716.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2716.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2716.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2716.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2716.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2716.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2716.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2716.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2716.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2716.99, 0, 'spreadsheet_seed');

  -- [74/179] K & R Plumbing Supplies
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'K & R Plumbing Supplies', '', '',
    true, 29548.010000000002, 33, 895.39, 0.2787,
    33980.21, -4432.2,
    0.0, 0.2787,
    275.94, 0, 0,
    29548.010000000002, 2, 100,
    275.94, 21314.27, 0.0, 21314.27, 5939.36,
    15374.91, 0.7213, 33, 1584,
    1500.0, 500.0, 3859.94,
    11514.97, 0.5402, 'green', 'manager',
    71.502, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2462.33, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2462.33, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2462.33, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2462.33, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2462.33, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2462.33, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2462.33, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2462.33, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2462.33, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2462.33, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2462.33, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2462.33, 0, 'spreadsheet_seed');

  -- [75/179] Luscombe Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Luscombe Tiles', '', '',
    true, 39682.11999999999, 78, 508.75, 0.299,
    45634.44, -5952.32,
    0.0, 0.299,
    4802.01, 0, 0,
    39682.11999999999, 2, 100,
    4802.01, 27816.16, 0.0, 27816.16, 8317.74,
    19498.42, 0.701, 78, 3744,
    1500.0, 500.0, 10546.01,
    8952.41, 0.3218, 'green', 'manager',
    5.0129, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3306.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3306.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3306.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3306.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3306.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3306.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3306.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3306.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3306.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3306.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3306.84, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3306.84, 0, 'spreadsheet_seed');

  -- [76/179] Phillips Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Phillips Tiles', '', '',
    true, 44046.22, 62, 710.42, 0.4185,
    50653.15, -6606.93,
    0.0, 0.4185,
    4451.25, 0, 0,
    44046.22, 2, 100,
    4451.25, 25613.96, 0.0, 25613.96, 10718.81,
    14895.15, 0.5815, 62, 2976,
    1500.0, 500.0, 9427.25,
    5467.9, 0.2135, 'green', 'manager',
    5.0858, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3670.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3670.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3670.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3670.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3670.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3670.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3670.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3670.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3670.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3670.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3670.52, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3670.52, 0, 'spreadsheet_seed');

  -- [77/179] Tile Gallery Aus Pty Ltd
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Tile Gallery Aus Pty Ltd', '', '',
    true, 30393.810000000005, 24, 1266.41, 0.3259,
    34952.88, -4559.07,
    0.0, 0.3259,
    1537.03, 0, 0,
    30393.810000000005, 2, 100,
    1537.03, 20488.04, 0.0, 20488.04, 6677.34,
    13810.7, 0.6741, 24, 1152,
    1500.0, 500.0, 4689.03,
    9121.67, 0.4452, 'green', 'manager',
    12.5801, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2532.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2532.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2532.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2532.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2532.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2532.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2532.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2532.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2532.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2532.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2532.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2532.82, 0, 'spreadsheet_seed');

  -- [78/179] Pambula Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Pambula Tiles', '', '',
    true, 27681.789999999997, 40, 692.04, 0.3039,
    31834.06, -4152.27,
    0.0, 0.3039,
    1075.13, 0, 0,
    27681.789999999997, 2, 100,
    1075.13, 19269.58, 0.0, 19269.58, 5855.83,
    13413.75, 0.6961, 40, 1920,
    1500.0, 500.0, 4995.13,
    8418.62, 0.4369, 'green', 'manager',
    16.1372, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2306.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2306.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2306.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2306.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2306.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2306.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2306.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2306.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2306.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2306.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2306.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2306.82, 0, 'spreadsheet_seed');

  -- [79/179] Derwent Park Plumbing
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Derwent Park Plumbing', '', '',
    true, 24970.52, 23, 1085.67, 0.3153,
    28716.1, -3745.58,
    0.0, 0.3153,
    299.44, 0, 0,
    24970.52, 2, 100,
    299.44, 17097.32, 0.0, 17097.32, 5390.78,
    11706.54, 0.6847, 23, 1104,
    1500.0, 500.0, 3403.44,
    8303.1, 0.4856, 'green', 'manager',
    53.4108, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2080.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2080.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2080.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2080.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2080.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2080.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2080.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2080.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2080.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2080.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2080.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2080.88, 0, 'spreadsheet_seed');

  -- [80/179] YT Bathroom
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'YT Bathroom', '', '',
    true, 22215.109999999997, 13, 1708.85, 0.2489,
    25547.38, -3332.27,
    0.095, 0.2489,
    395.1, 0, 0,
    22215.109999999997, 2, 100,
    395.1, 16686.03, 1585.17, 15100.86, 3758.43,
    11342.43, 0.7511, 13, 624,
    1500.0, 500.0, 3019.1,
    8323.33, 0.5512, 'green', 'manager',
    40.5997, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1851.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1851.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1851.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1851.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1851.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1851.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1851.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1851.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1851.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1851.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1851.26, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1851.26, 0, 'spreadsheet_seed');

  -- [81/179] Kents H Hardware
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Kents H Hardware', '', '',
    true, 24834.140000000003, 29, 856.35, 0.2984,
    28559.26, -3725.12,
    0.0, 0.2984,
    488.3, 0, 0,
    24834.140000000003, 2, 100,
    488.3, 17423.92, 0.0, 17423.92, 5199.1,
    12224.82, 0.7016, 29, 1392,
    1500.0, 500.0, 3880.3,
    8344.52, 0.4789, 'green', 'manager',
    32.8321, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2069.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2069.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2069.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2069.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2069.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2069.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2069.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2069.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2069.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2069.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2069.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2069.51, 0, 'spreadsheet_seed');

  -- [82/179] Trade Warehouse Direct
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Trade Warehouse Direct', '', '',
    true, 35599.229999999996, 127, 280.31, 0.3862,
    40939.11, -5339.88,
    0.0, 0.3862,
    315.16, 0, 0,
    35599.229999999996, 2, 100,
    315.16, 21851.1, 0.0, 21851.1, 8438.72,
    13412.38, 0.6138, 127, 6096,
    1500.0, 500.0, 8411.16,
    5001.22, 0.2289, 'green', 'manager',
    49.9908, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2966.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2966.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2966.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2966.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2966.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2966.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2966.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2966.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2966.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2966.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2966.6, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2966.6, 0, 'spreadsheet_seed');

  -- [83/179] Vision Bathroom Supplies
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Vision Bathroom Supplies', '', '',
    true, 22427.52, 14, 1601.97, 0.2803,
    25791.65, -3364.13,
    0.095, 0.2803,
    391.29, 0, 0,
    22427.52, 2, 100,
    391.29, 16140.4, 1533.34, 14607.06, 4094.81,
    10512.25, 0.7197, 14, 672,
    1500.0, 500.0, 3063.29,
    7448.96, 0.51, 'green', 'manager',
    39.4774, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1868.96, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1868.96, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1868.96, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1868.96, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1868.96, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1868.96, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1868.96, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1868.96, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1868.96, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1868.96, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1868.96, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1868.96, 0, 'spreadsheet_seed');

  -- [84/179] Naturally Tiles & Bathware
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Naturally Tiles & Bathware', '', '',
    true, 26055.26, 63, 413.58, 0.2863,
    29963.55, -3908.29,
    0.095, 0.2863,
    539.04, 0, 0,
    26055.26, 2, 100,
    539.04, 18595.19, 1766.54, 16828.65, 4818.33,
    12010.32, 0.7137, 63, 3024,
    1500.0, 500.0, 5563.04,
    6447.28, 0.3831, 'green', 'manager',
    28.841, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2171.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2171.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2171.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2171.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2171.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2171.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2171.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2171.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2171.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2171.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2171.27, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2171.27, 0, 'spreadsheet_seed');

  -- [85/179] Motif
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Motif', '', '',
    true, 22456.09, 29, 774.35, 0.2929,
    25824.5, -3368.41,
    0.0, 0.2929,
    46.5, 0, 0,
    22456.09, 2, 100,
    46.5, 15879.62, 0.0, 15879.62, 4650.49,
    11229.13, 0.7071, 29, 1392,
    1500.0, 500.0, 3438.5,
    7790.63, 0.4906, 'green', 'manager',
    311.5617, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1871.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1871.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1871.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1871.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1871.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1871.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1871.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1871.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1871.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1871.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1871.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1871.34, 0, 'spreadsheet_seed');

  -- [86/179] Elenni Kitchen & Bathroom Collection
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Elenni Kitchen & Bathroom Collection', '', '',
    true, 38692.19000000001, 62, 624.07, 0.3688,
    44496.02, -5803.83,
    0.0, 0.3688,
    7182.89, 0, 0,
    38692.19000000001, 2, 100,
    7182.89, 24422.75, 0.0, 24422.75, 9006.96,
    15415.79, 0.6312, 62, 2976,
    1500.0, 500.0, 12158.89,
    3256.9, 0.1334, 'review', 'manager',
    2.9858, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3224.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3224.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3224.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3224.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3224.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3224.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3224.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3224.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3224.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3224.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3224.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3224.35, 0, 'spreadsheet_seed');

  -- [87/179] Seven Days Plumbing
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Seven Days Plumbing', '', '',
    true, 29044.749999999996, 63, 461.03, 0.3635,
    33401.46, -4356.71,
    0.0, 0.3635,
    1310.74, 0, 0,
    29044.749999999996, 2, 100,
    1310.74, 18487.51, 0.0, 18487.51, 6719.87,
    11767.64, 0.6365, 63, 3024,
    1500.0, 500.0, 6334.74,
    5432.9, 0.2939, 'green', 'manager',
    11.7975, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2420.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2420.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2420.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2420.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2420.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2420.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2420.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2420.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2420.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2420.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2420.4, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2420.4, 0, 'spreadsheet_seed');

  -- [88/179] All Bathroom Gear
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'All Bathroom Gear', '', '',
    true, 22906.97, 14, 1636.21, 0.3145,
    26343.02, -3436.05,
    0.0, 0.3145,
    1068.7, 0, 0,
    22906.97, 2, 100,
    1068.7, 15703.46, 0.0, 15703.46, 4938.24,
    10765.22, 0.6855, 14, 672,
    1500.0, 500.0, 3740.7,
    7024.52, 0.4473, 'green', 'manager',
    14.0652, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1908.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1908.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1908.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1908.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1908.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1908.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1908.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1908.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1908.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1908.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1908.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1908.91, 0, 'spreadsheet_seed');

  -- [89/179] Schots Home Emporium - Clifton Hill
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Schots Home Emporium - Clifton Hill', '', '',
    true, 54184.99000000002, 265, 204.47, 0.3728,
    62312.74, -8127.75,
    0.0, 0.3728,
    7514.52, 0, 0,
    54184.99000000002, 2, 100,
    7514.52, 33983.21, 0.0, 33983.21, 12669.95,
    21313.26, 0.6272, 265, 12720,
    1500.0, 500.0, 22234.52,
    -921.26, -0.0271, 'review', 'manager',
    2.8296, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4515.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4515.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4515.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4515.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4515.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4515.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4515.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4515.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4515.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4515.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4515.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4515.42, 0, 'spreadsheet_seed');

  -- [90/179] QA Bathroom Warehouse
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'QA Bathroom Warehouse', '', '',
    true, 21676.170000000002, 31, 699.23, 0.2825,
    24927.6, -3251.43,
    0.0, 0.2825,
    451.69, 0, 0,
    21676.170000000002, 2, 100,
    451.69, 15552.44, 0.0, 15552.44, 4393.72,
    11158.72, 0.7175, 31, 1488,
    1500.0, 500.0, 3939.69,
    7219.03, 0.4642, 'green', 'manager',
    31.1374, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1806.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1806.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1806.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1806.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1806.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1806.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1806.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1806.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1806.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1806.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1806.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1806.35, 0, 'spreadsheet_seed');

  -- [91/179] Watertek
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Watertek', '', '',
    true, 20762.98, 16, 1297.69, 0.2693,
    23877.43, -3114.45,
    0.0, 0.2693,
    804.21, 0, 0,
    20762.98, 2, 100,
    804.21, 15172.08, 0.0, 15172.08, 4085.42,
    11086.66, 0.7307, 16, 768,
    1500.0, 500.0, 3572.21,
    7514.45, 0.4953, 'green', 'manager',
    17.9108, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1730.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1730.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1730.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1730.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1730.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1730.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1730.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1730.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1730.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1730.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1730.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1730.25, 0, 'spreadsheet_seed');

  -- [92/179] The Bathroom Biz
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'The Bathroom Biz', '', '',
    true, 19670.83, 15, 1311.39, 0.256,
    22621.45, -2950.62,
    0.0, 0.256,
    393.59, 0, 0,
    19670.83, 2, 100,
    393.59, 14634.2, 0.0, 14634.2, 3747.02,
    10887.18, 0.744, 15, 720,
    1500.0, 500.0, 3113.59,
    7773.59, 0.5312, 'green', 'manager',
    35.352, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1639.24, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1639.24, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1639.24, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1639.24, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1639.24, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1639.24, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1639.24, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1639.24, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1639.24, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1639.24, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1639.24, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1639.24, 0, 'spreadsheet_seed');

  -- [93/179] Hot & Cold Outlet (Engadine Plumbing)
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Hot & Cold Outlet (Engadine Plumbing)', '', '',
    true, 19674.070000000003, 11, 1788.55, 0.2741,
    22625.18, -2951.11,
    0.095, 0.2741,
    224.3, 0, 0,
    19674.070000000003, 2, 100,
    224.3, 14281.01, 1356.7, 12924.31, 3542.81,
    9381.5, 0.7259, 11, 528,
    1500.0, 500.0, 2752.3,
    6629.2, 0.5129, 'green', 'manager',
    61.2319, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1639.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1639.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1639.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1639.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1639.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1639.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1639.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1639.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1639.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1639.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1639.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1639.51, 0, 'spreadsheet_seed');

  -- [94/179] Designer Bathrooms Plus
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Designer Bathrooms Plus', '', '',
    true, 19776.690000000002, 18, 1098.71, 0.2603,
    22743.19, -2966.5,
    0.095, 0.2603,
    434.59, 0, 0,
    19776.690000000002, 2, 100,
    434.59, 14628.76, 1389.73, 13239.03, 3446.16,
    9792.87, 0.7397, 18, 864,
    1500.0, 500.0, 3298.59,
    6494.28, 0.4905, 'green', 'manager',
    31.6297, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1648.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1648.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1648.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1648.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1648.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1648.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1648.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1648.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1648.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1648.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1648.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1648.06, 0, 'spreadsheet_seed');

  -- [95/179] In Haus Living
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'In Haus Living', '', '',
    true, 60213.310000000005, 110, 547.39, 0.4195,
    69245.31, -9032.0,
    0.0, 0.4195,
    16380.14, 0, 0,
    60213.310000000005, 2, 100,
    16380.14, 34956.37, 0.0, 34956.37, 14662.72,
    20293.65, 0.5805, 110, 5280,
    1500.0, 500.0, 23660.14,
    -3366.49, -0.0963, 'review', 'cfo',
    1.8117, 'marginal'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 5017.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 5017.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 5017.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 5017.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 5017.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 5017.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 5017.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 5017.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 5017.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 5017.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 5017.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 5017.78, 0, 'spreadsheet_seed');

  -- [96/179] Trade Sync Group
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Trade Sync Group', '', '',
    true, 22655.91, 39, 580.92, 0.2827,
    26054.3, -3398.39,
    0.095, 0.2827,
    1082.89, 0, 0,
    22655.91, 2, 100,
    1082.89, 16251.45, 1543.89, 14707.56, 4157.59,
    10549.97, 0.7173, 39, 1872,
    1500.0, 500.0, 4954.89,
    5595.08, 0.3804, 'green', 'manager',
    13.2589, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1887.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1887.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1887.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1887.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1887.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1887.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1887.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1887.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1887.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1887.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1887.99, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1887.99, 0, 'spreadsheet_seed');

  -- [97/179] Flat Hill Studio
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Flat Hill Studio', '', '',
    true, 19102.53, 26, 734.71, 0.2243,
    21967.91, -2865.38,
    0.0, 0.2243,
    296.18, 0, 0,
    19102.53, 2, 100,
    296.18, 14818.42, 0.0, 14818.42, 3323.32,
    11495.1, 0.7757, 26, 1248,
    1500.0, 500.0, 3544.18,
    7950.92, 0.5366, 'green', 'manager',
    45.8182, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1591.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1591.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1591.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1591.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1591.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1591.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1591.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1591.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1591.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1591.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1591.88, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1591.88, 0, 'spreadsheet_seed');

  -- [98/179] Beri Distributors Pty Ltd
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Beri Distributors Pty Ltd', '', '',
    true, 21067.31, 32, 658.35, 0.27,
    24227.41, -3160.1,
    0.0, 0.27,
    923.08, 0, 0,
    21067.31, 2, 100,
    923.08, 15378.29, 0.0, 15378.29, 4152.76,
    11225.53, 0.73, 32, 1536,
    1500.0, 500.0, 4459.08,
    6766.45, 0.44, 'green', 'manager',
    14.9958, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1755.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1755.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1755.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1755.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1755.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1755.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1755.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1755.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1755.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1755.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1755.61, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1755.61, 0, 'spreadsheet_seed');

  -- [99/179] Oxford and Nelson
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Oxford and Nelson', '', '',
    true, 25703.78999999999, 102, 252.0, 0.2748,
    29559.36, -3855.57,
    0.0, 0.2748,
    967.75, 0, 0,
    25703.78999999999, 2, 100,
    967.75, 18640.94, 0.0, 18640.94, 5122.13,
    13518.81, 0.7252, 102, 4896,
    1500.0, 500.0, 7863.75,
    5655.06, 0.3034, 'green', 'manager',
    14.203, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2141.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2141.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2141.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2141.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2141.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2141.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2141.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2141.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2141.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2141.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2141.98, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2141.98, 0, 'spreadsheet_seed');

  -- [100/179] Bathroom Collective
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Bathroom Collective', '', '',
    true, 22344.329999999994, 29, 770.49, 0.3543,
    25695.98, -3351.65,
    0.095, 0.3543,
    370.2, 0, 0,
    22344.329999999994, 2, 100,
    370.2, 14426.96, 1370.56, 13056.4, 4626.33,
    8430.07, 0.6457, 29, 1392,
    1500.0, 500.0, 3762.2,
    4667.87, 0.3575, 'green', 'manager',
    35.1532, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1862.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1862.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1862.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1862.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1862.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1862.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1862.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1862.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1862.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1862.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1862.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1862.03, 0, 'spreadsheet_seed');

  -- [101/179] Tap and Sink Contemporary Living
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Tap and Sink Contemporary Living', '', '',
    true, 55913.07999999998, 182, 307.21, 0.4545,
    64300.04, -8386.96,
    0.0, 0.4545,
    9280.68, 0, 0,
    55913.07999999998, 2, 100,
    9280.68, 30497.89, 0.0, 30497.89, 13862.76,
    16635.13, 0.5455, 182, 8736,
    1500.0, 500.0, 20016.68,
    -3381.55, -0.1109, 'review', 'manager',
    2.3449, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4659.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4659.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4659.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4659.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4659.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4659.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4659.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4659.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4659.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4659.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4659.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4659.42, 0, 'spreadsheet_seed');

  -- [102/179] Plumbcorp
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Plumbcorp', '', '',
    true, 20001.390000000003, 29, 689.7, 0.3127,
    23001.6, -3000.21,
    0.0, 0.3127,
    375.88, 0, 0,
    20001.390000000003, 2, 100,
    375.88, 13746.5, 0.0, 13746.5, 4298.84,
    9447.66, 0.6873, 29, 1392,
    1500.0, 500.0, 3767.88,
    5679.78, 0.4132, 'green', 'manager',
    32.8682, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1666.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1666.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1666.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1666.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1666.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1666.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1666.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1666.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1666.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1666.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1666.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1666.78, 0, 'spreadsheet_seed');

  -- [103/179] JusTiles Sydney - Padstow
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'JusTiles Sydney - Padstow', '', '',
    true, 20876.98, 32, 652.41, 0.3394,
    24008.53, -3131.55,
    0.0, 0.3394,
    350.4, 0, 0,
    20876.98, 2, 100,
    350.4, 13790.64, 0.0, 13790.64, 4681.0,
    9109.64, 0.6606, 32, 1536,
    1500.0, 500.0, 3886.4,
    5223.24, 0.3788, 'green', 'manager',
    34.9733, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1739.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1739.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1739.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1739.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1739.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1739.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1739.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1739.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1739.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1739.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1739.75, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1739.75, 0, 'spreadsheet_seed');

  -- [104/179] Royal Vanities
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Royal Vanities', '', '',
    true, 24701.929999999997, 65, 380.03, 0.3311,
    28407.22, -3705.29,
    0.0, 0.3311,
    1520.98, 0, 0,
    24701.929999999997, 2, 100,
    1520.98, 16524.01, 0.0, 16524.01, 5470.51,
    11053.5, 0.6689, 65, 3120,
    1500.0, 500.0, 6640.98,
    4412.52, 0.267, 'green', 'manager',
    8.8127, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2058.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2058.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2058.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2058.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2058.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2058.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2058.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2058.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2058.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2058.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2058.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2058.49, 0, 'spreadsheet_seed');

  -- [105/179] 7to7 Bathrooms Pty Ltd
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    '7to7 Bathrooms Pty Ltd', '', '',
    true, 20296.329999999998, 21, 966.49, 0.3077,
    23340.78, -3044.45,
    0.0, 0.3077,
    1480.45, 0, 0,
    20296.329999999998, 2, 100,
    1480.45, 14050.22, 0.0, 14050.22, 4323.9,
    9726.32, 0.6923, 21, 1008,
    1500.0, 500.0, 4488.45,
    5237.87, 0.3728, 'green', 'manager',
    8.8096, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1691.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1691.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1691.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1691.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1691.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1691.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1691.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1691.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1691.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1691.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1691.36, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1691.36, 0, 'spreadsheet_seed');

  -- [106/179] Cook & Bathe
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Cook & Bathe', '', '',
    true, 19502.63, 45, 433.39, 0.2881,
    22428.02, -2925.39,
    0.0, 0.2881,
    194.83, 0, 0,
    19502.63, 2, 100,
    194.83, 13884.12, 0.0, 13884.12, 3999.87,
    9884.25, 0.7119, 45, 2160,
    1500.0, 500.0, 4354.83,
    5529.42, 0.3983, 'green', 'manager',
    60.1762, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1625.22, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1625.22, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1625.22, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1625.22, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1625.22, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1625.22, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1625.22, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1625.22, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1625.22, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1625.22, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1625.22, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1625.22, 0, 'spreadsheet_seed');

  -- [107/179] Home Emporium Singleton (Buildtell Services)
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Home Emporium Singleton (Buildtell Services)', '', '',
    true, 21113.979999999996, 22, 959.73, 0.4148,
    24281.08, -3167.1,
    0.0, 0.4148,
    98.48, 0, 0,
    21113.979999999996, 2, 100,
    98.48, 12356.76, 0.0, 12356.76, 5125.08,
    7231.68, 0.5852, 22, 1056,
    1500.0, 500.0, 3154.48,
    4077.2, 0.33, 'green', 'manager',
    114.7518, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1759.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1759.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1759.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1759.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1759.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1759.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1759.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1759.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1759.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1759.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1759.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1759.5, 0, 'spreadsheet_seed');

  -- [108/179] Tuck Plumbing Fixtures - Plumbtec
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Tuck Plumbing Fixtures - Plumbtec', '', '',
    true, 18344.18, 33, 555.88, 0.3161,
    21095.81, -2751.63,
    0.0, 0.3161,
    22.08, 0, 0,
    18344.18, 2, 100,
    22.08, 12545.44, 0.0, 12545.44, 3965.71,
    8579.73, 0.6839, 33, 1584,
    1500.0, 500.0, 3606.08,
    4973.65, 0.3965, 'green', 'manager',
    496.442, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1528.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1528.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1528.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1528.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1528.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1528.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1528.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1528.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1528.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1528.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1528.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1528.68, 0, 'spreadsheet_seed');

  -- [109/179] Swan Street Sales
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Swan Street Sales', '', '',
    true, 26361.439999999988, 115, 229.23, 0.3914,
    30315.66, -3954.22,
    0.0, 0.3914,
    0.83, 0, 0,
    26361.439999999988, 2, 100,
    0.83, 16042.37, 0.0, 16042.37, 6279.72,
    9762.65, 0.6086, 115, 5520,
    1500.0, 500.0, 7520.83,
    2241.82, 0.1397, 'review', 'manager',
    9999.9999, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2196.79, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2196.79, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2196.79, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2196.79, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2196.79, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2196.79, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2196.79, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2196.79, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2196.79, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2196.79, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2196.79, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2196.79, 0, 'spreadsheet_seed');

  -- [110/179] Retravision Commercial
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Retravision Commercial', '', '',
    true, 19706.579999999998, 13, 1515.89, 0.4373,
    22662.57, -2955.99,
    0.0, 0.4373,
    49.46, 0, 0,
    19706.579999999998, 2, 100,
    49.46, 11088.43, 0.0, 11088.43, 4849.23,
    6239.2, 0.5627, 13, 624,
    1500.0, 500.0, 2673.46,
    3565.74, 0.3216, 'green', 'manager',
    211.5736, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1642.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1642.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1642.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1642.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1642.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1642.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1642.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1642.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1642.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1642.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1642.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1642.21, 0, 'spreadsheet_seed');

  -- [111/179] Camberwell Bathrooms
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Camberwell Bathrooms', '', '',
    true, 18266.429999999997, 29, 629.88, 0.3597,
    21006.39, -2739.96,
    0.095, 0.3597,
    263.53, 0, 0,
    18266.429999999997, 2, 100,
    263.53, 11695.24, 1111.05, 10584.19, 3807.57,
    6776.62, 0.6403, 29, 1392,
    1500.0, 500.0, 3655.53,
    3121.09, 0.2949, 'green', 'manager',
    39.0312, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1522.2, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1522.2, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1522.2, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1522.2, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1522.2, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1522.2, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1522.2, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1522.2, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1522.2, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1522.2, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1522.2, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1522.2, 0, 'spreadsheet_seed');

  -- [112/179] ONE ONE CAPITAL GENERAL TRADING LLC
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'ONE ONE CAPITAL GENERAL TRADING LLC', '', '',
    true, 58889.009999999995, 41, 1436.32, 0.4556,
    67722.36, -8833.35,
    0.0, 0.4556,
    20602.59, 0, 0,
    58889.009999999995, 2, 100,
    20602.59, 32060.19, 0.0, 32060.19, 14606.07,
    17454.12, 0.5444, 41, 1968,
    1500.0, 500.0, 24570.59,
    -7116.47, -0.222, 'review', 'cfo',
    1.4606, 'marginal'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4907.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4907.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4907.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4907.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4907.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4907.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4907.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4907.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4907.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4907.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4907.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4907.42, 0, 'spreadsheet_seed');

  -- [113/179] Swiftwood Tiles & Bathrooms
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Swiftwood Tiles & Bathrooms', '', '',
    true, 14901.189999999997, 27, 551.9, 0.267,
    17136.37, -2235.18,
    0.0, 0.267,
    210.34, 0, 0,
    14901.189999999997, 2, 100,
    210.34, 10922.72, 0.0, 10922.72, 2916.26,
    8006.46, 0.733, 27, 1296,
    1500.0, 500.0, 3506.34,
    4500.12, 0.412, 'green', 'manager',
    45.7674, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1241.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1241.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1241.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1241.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1241.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1241.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1241.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1241.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1241.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1241.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1241.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1241.77, 0, 'spreadsheet_seed');

  -- [114/179] Coastal Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Coastal Tiles', '', '',
    true, 14594.040000000003, 28, 521.22, 0.2887,
    16783.15, -2189.11,
    0.0, 0.2887,
    120.35, 0, 0,
    14594.040000000003, 2, 100,
    120.35, 10380.74, 0.0, 10380.74, 2996.92,
    7383.82, 0.7113, 28, 1344,
    1500.0, 500.0, 3464.35,
    3919.47, 0.3776, 'green', 'manager',
    75.0872, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1216.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1216.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1216.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1216.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1216.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1216.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1216.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1216.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1216.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1216.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1216.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1216.17, 0, 'spreadsheet_seed');

  -- [115/179] Cargo Bathroom and Kitchens
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Cargo Bathroom and Kitchens', '', '',
    true, 18433.71, 30, 614.46, 0.313,
    21198.77, -2765.06,
    0.095, 0.313,
    2339.1, 0, 0,
    18433.71, 2, 100,
    2339.1, 12663.06, 1202.99, 11460.07, 3587.56,
    7872.51, 0.687, 30, 1440,
    1500.0, 500.0, 5779.1,
    2093.41, 0.1827, 'green', 'manager',
    4.7905, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1536.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1536.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1536.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1536.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1536.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1536.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1536.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1536.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1536.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1536.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1536.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1536.14, 0, 'spreadsheet_seed');

  -- [116/179] INTERO T/A THE KITCHEN HUB (AUD) (Formerly Change Agent Limited)
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'INTERO T/A THE KITCHEN HUB (AUD) (Formerly Change Agent Limited)', '', '',
    true, 25988.199999999997, 79, 328.96, 0.5066,
    29886.43, -3898.23,
    0.0, 0.5066,
    229.55, 0, 0,
    25988.199999999997, 2, 100,
    229.55, 12821.43, 0.0, 12821.43, 6495.9,
    6325.53, 0.4934, 79, 3792,
    1500.0, 500.0, 6021.55,
    303.98, 0.0237, 'review', 'manager',
    39.3354, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2165.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2165.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2165.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2165.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2165.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2165.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2165.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2165.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2165.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2165.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2165.68, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2165.68, 0, 'spreadsheet_seed');

  -- [117/179] Romano Indoor & Outdoor Solutions
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Romano Indoor & Outdoor Solutions', '', '',
    true, 13768.240000000002, 20, 688.41, 0.2966,
    15833.48, -2065.24,
    0.095, 0.2966,
    93.6, 0, 0,
    13768.240000000002, 2, 100,
    93.6, 9684.01, 919.98, 8764.03, 2599.77,
    6164.26, 0.7034, 20, 960,
    1500.0, 500.0, 3053.6,
    3110.66, 0.3549, 'green', 'manager',
    93.0655, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1147.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1147.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1147.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1147.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1147.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1147.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1147.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1147.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1147.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1147.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1147.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1147.35, 0, 'spreadsheet_seed');

  -- [118/179] Riverina Home Centre
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Riverina Home Centre', '', '',
    true, 12805.24, 9, 1422.8, 0.2897,
    14726.03, -1920.79,
    0.0, 0.2897,
    209.18, 0, 0,
    12805.24, 2, 100,
    209.18, 9095.21, 0.0, 9095.21, 2635.13,
    6460.08, 0.7103, 9, 432,
    1500.0, 500.0, 2641.18,
    3818.9, 0.4199, 'green', 'manager',
    41.4151, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1067.1, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1067.1, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1067.1, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1067.1, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1067.1, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1067.1, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1067.1, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1067.1, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1067.1, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1067.1, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1067.1, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1067.1, 0, 'spreadsheet_seed');

  -- [119/179] TI Home Improvement Centre (Formerly Tile Importer)
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'TI Home Improvement Centre (Formerly Tile Importer)', '', '',
    true, 14548.570000000003, 43, 338.34, 0.3144,
    16730.86, -2182.29,
    0.0, 0.3144,
    82.81, 0, 0,
    14548.570000000003, 2, 100,
    82.81, 9974.54, 0.0, 9974.54, 3135.97,
    6838.57, 0.6856, 43, 2064,
    1500.0, 500.0, 4146.81,
    2691.76, 0.2699, 'green', 'manager',
    95.5264, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1212.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1212.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1212.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1212.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1212.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1212.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1212.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1212.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1212.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1212.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1212.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1212.38, 0, 'spreadsheet_seed');

  -- [120/179] Revive Bathroom Supplies
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Revive Bathroom Supplies', '', '',
    true, 12853.28, 24, 535.55, 0.2981,
    14781.27, -1927.99,
    0.095, 0.2981,
    305.21, 0, 0,
    12853.28, 2, 100,
    305.21, 9021.62, 857.05, 8164.57, 2433.92,
    5730.65, 0.7019, 24, 1152,
    1500.0, 500.0, 3457.21,
    2273.44, 0.2785, 'green', 'manager',
    25.7443, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1071.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1071.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1071.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1071.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1071.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1071.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1071.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1071.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1071.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1071.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1071.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1071.11, 0, 'spreadsheet_seed');

  -- [121/179] Cerastone Surfaces
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Cerastone Surfaces', '', '',
    true, 19718.109999999993, 56, 352.11, 0.3757,
    22675.83, -2957.72,
    0.0, 0.3757,
    2081.23, 0, 0,
    19718.109999999993, 2, 100,
    2081.23, 12310.8, 0.0, 12310.8, 4624.68,
    7686.12, 0.6243, 56, 2688,
    1500.0, 500.0, 6769.23,
    916.89, 0.0745, 'review', 'manager',
    4.6236, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1643.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1643.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1643.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1643.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1643.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1643.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1643.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1643.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1643.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1643.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1643.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1643.18, 0, 'spreadsheet_seed');

  -- [122/179] Thrifty Bathrooms and Plumbing
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Thrifty Bathrooms and Plumbing', '', '',
    true, 13458.049999999997, 21, 640.86, 0.3717,
    15476.76, -2018.71,
    0.0, 0.3717,
    56.57, 0, 0,
    13458.049999999997, 2, 100,
    56.57, 8455.31, 0.0, 8455.31, 3143.08,
    5312.23, 0.6283, 21, 1008,
    1500.0, 500.0, 3064.57,
    2247.66, 0.2658, 'green', 'manager',
    131.6477, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1121.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1121.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1121.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1121.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1121.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1121.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1121.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1121.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1121.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1121.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1121.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1121.5, 0, 'spreadsheet_seed');

  -- [123/179] Lexatonia Tiles Melbourne (Formally Bathroom Nation)
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Lexatonia Tiles Melbourne (Formally Bathroom Nation)', '', '',
    true, 12448.170000000002, 16, 778.01, 0.2616,
    14315.4, -1867.23,
    0.0, 0.2616,
    1212.58, 0, 0,
    12448.170000000002, 2, 100,
    1212.58, 9192.13, 0.0, 9192.13, 2404.36,
    6787.77, 0.7384, 16, 768,
    1500.0, 500.0, 3980.58,
    2807.19, 0.3054, 'green', 'manager',
    6.9473, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1037.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1037.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1037.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1037.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1037.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1037.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1037.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1037.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1037.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1037.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1037.35, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1037.35, 0, 'spreadsheet_seed');

  -- [124/179] IBuild Group NSW (Home Renovation Studio)
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'IBuild Group NSW (Home Renovation Studio)', '', '',
    true, 13609.35, 23, 591.71, 0.3608,
    15650.75, -2041.4,
    0.0, 0.3608,
    438.03, 0, 0,
    13609.35, 2, 100,
    438.03, 8699.07, 0.0, 8699.07, 3138.64,
    5560.43, 0.6392, 23, 1104,
    1500.0, 500.0, 3542.03,
    2018.4, 0.232, 'green', 'manager',
    17.3392, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1134.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1134.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1134.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1134.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1134.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1134.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1134.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1134.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1134.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1134.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1134.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1134.11, 0, 'spreadsheet_seed');

  -- [125/179] Terry Brothers Bathrooms
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Terry Brothers Bathrooms', '', '',
    true, 9591.300000000001, 5, 1918.26, 0.2474,
    11030.0, -1438.69,
    0.095, 0.2474,
    426.53, 0, 0,
    9591.300000000001, 2, 100,
    426.53, 7218.01, 685.71, 6532.3, 1616.37,
    4915.93, 0.7526, 5, 240,
    1500.0, 500.0, 2666.53,
    2249.4, 0.3444, 'green', 'manager',
    16.3386, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 799.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 799.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 799.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 799.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 799.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 799.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 799.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 799.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 799.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 799.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 799.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 799.28, 0, 'spreadsheet_seed');

  -- [126/179] Veejay's Renovations
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Veejay''s Renovations', '', '',
    true, 9432.699999999999, 8, 1179.09, 0.2732,
    10847.6, -1414.9,
    0.0, 0.2732,
    43.7, 0, 0,
    9432.699999999999, 2, 100,
    43.7, 6855.66, 0.0, 6855.66, 1872.99,
    4982.67, 0.7268, 8, 384,
    1500.0, 500.0, 2427.7,
    2554.97, 0.3727, 'green', 'manager',
    148.0929, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 786.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 786.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 786.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 786.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 786.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 786.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 786.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 786.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 786.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 786.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 786.06, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 786.06, 0, 'spreadsheet_seed');

  -- [127/179] Big River Trade Centre
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Big River Trade Centre', '', '',
    true, 10050.130000000001, 14, 717.87, 0.2661,
    11557.65, -1507.52,
    0.095, 0.2661,
    293.95, 0, 0,
    10050.130000000001, 2, 100,
    293.95, 7376.0, 700.72, 6675.28, 1776.15,
    4899.13, 0.7339, 14, 672,
    1500.0, 500.0, 2965.95,
    1933.18, 0.2896, 'review', 'manager',
    22.7741, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 837.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 837.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 837.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 837.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 837.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 837.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 837.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 837.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 837.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 837.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 837.51, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 837.51, 0, 'spreadsheet_seed');

  -- [128/179] Bathroom International
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Bathroom International', '', '',
    true, 10132.939999999999, 15, 675.53, 0.2801,
    11652.88, -1519.94,
    0.0, 0.2801,
    350.42, 0, 0,
    10132.939999999999, 2, 100,
    350.42, 7295.2, 0.0, 7295.2, 2043.03,
    5252.17, 0.7199, 15, 720,
    1500.0, 500.0, 3070.42,
    2181.75, 0.2991, 'green', 'manager',
    18.7638, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 844.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 844.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 844.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 844.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 844.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 844.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 844.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 844.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 844.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 844.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 844.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 844.41, 0, 'spreadsheet_seed');

  -- [129/179] Bathroom Kitchen Home
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Bathroom Kitchen Home', '', '',
    true, 9542.5, 9, 1060.28, 0.2922,
    10973.88, -1431.38,
    0.0, 0.2922,
    160.71, 0, 0,
    9542.5, 2, 100,
    160.71, 6753.75, 0.0, 6753.75, 1973.75,
    4780.0, 0.7078, 9, 432,
    1500.0, 500.0, 2592.71,
    2187.29, 0.3239, 'green', 'manager',
    39.3364, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 795.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 795.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 795.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 795.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 795.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 795.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 795.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 795.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 795.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 795.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 795.21, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 795.21, 0, 'spreadsheet_seed');

  -- [130/179] My Tile Co - Woy Woy
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'My Tile Co - Woy Woy', '', '',
    true, 10937.820000000002, 14, 781.27, 0.2782,
    12578.49, -1640.67,
    0.0, 0.2782,
    1065.8, 0, 0,
    10937.820000000002, 2, 100,
    1065.8, 7894.68, 0.0, 7894.68, 2196.47,
    5698.21, 0.7218, 14, 672,
    1500.0, 500.0, 3737.8,
    1960.41, 0.2483, 'review', 'manager',
    6.7768, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 911.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 911.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 911.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 911.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 911.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 911.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 911.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 911.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 911.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 911.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 911.49, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 911.49, 0, 'spreadsheet_seed');

  -- [131/179] Harpers
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Harpers', '', '',
    true, 11992.109999999999, 32, 374.75, 0.2902,
    13790.93, -1798.82,
    0.0, 0.2902,
    831.38, 0, 0,
    11992.109999999999, 2, 100,
    831.38, 8511.77, 0.0, 8511.77, 2470.28,
    6041.49, 0.7098, 32, 1536,
    1500.0, 500.0, 4367.38,
    1674.11, 0.1967, 'review', 'manager',
    8.3906, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 999.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 999.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 999.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 999.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 999.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 999.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 999.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 999.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 999.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 999.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 999.34, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 999.34, 0, 'spreadsheet_seed');

  -- [132/179] Blaxland Tiles and Bathrooms
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Blaxland Tiles and Bathrooms', '', '',
    true, 11385.13, 28, 406.61, 0.2831,
    13092.9, -1707.77,
    0.095, 0.2831,
    788.76, 0, 0,
    11385.13, 2, 100,
    788.76, 8161.7, 775.36, 7386.34, 2091.27,
    5295.07, 0.7169, 28, 1344,
    1500.0, 500.0, 4132.76,
    1162.31, 0.1574, 'review', 'manager',
    8.6299, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 948.76, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 948.76, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 948.76, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 948.76, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 948.76, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 948.76, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 948.76, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 948.76, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 948.76, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 948.76, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 948.76, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 948.76, 0, 'spreadsheet_seed');

  -- [133/179] Oscar & Co
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Oscar & Co', '', '',
    true, 13751.150000000001, 21, 654.82, 0.3051,
    15813.82, -2062.67,
    0.0, 0.3051,
    3178.19, 0, 0,
    13751.150000000001, 2, 100,
    3178.19, 9555.77, 0.0, 9555.77, 2915.4,
    6640.37, 0.6949, 21, 1008,
    1500.0, 500.0, 6186.19,
    454.18, 0.0475, 'review', 'manager',
    2.6895, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1145.93, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1145.93, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1145.93, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1145.93, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1145.93, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1145.93, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1145.93, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1145.93, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1145.93, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1145.93, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1145.93, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1145.93, 0, 'spreadsheet_seed');

  -- [134/179] Tuggerah Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Tuggerah Tiles', '', '',
    true, 8526.039999999999, 9, 947.34, 0.2777,
    9804.95, -1278.91,
    0.0, 0.2777,
    518.51, 0, 0,
    8526.039999999999, 2, 100,
    518.51, 6158.71, 0.0, 6158.71, 1710.02,
    4448.69, 0.7223, 9, 432,
    1500.0, 500.0, 2950.51,
    1498.18, 0.2433, 'review', 'manager',
    11.0446, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 710.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 710.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 710.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 710.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 710.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 710.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 710.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 710.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 710.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 710.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 710.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 710.5, 0, 'spreadsheet_seed');

  -- [135/179] SAINT GEORGE MODERN CONSTRUCTIONS PTY LTD
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'SAINT GEORGE MODERN CONSTRUCTIONS PTY LTD', '', '',
    true, 8750.01, 9, 972.22, 0.3641,
    10062.51, -1312.5,
    0.0, 0.3641,
    100.6, 0, 0,
    8750.01, 2, 100,
    100.6, 5564.19, 0.0, 5564.19, 2025.88,
    3538.31, 0.6359, 9, 432,
    1500.0, 500.0, 2532.6,
    1005.71, 0.1807, 'review', 'manager',
    51.0158, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 729.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 729.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 729.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 729.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 729.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 729.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 729.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 729.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 729.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 729.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 729.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 729.17, 0, 'spreadsheet_seed');

  -- [136/179] Seaside Bathware
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Seaside Bathware', '', '',
    true, 8038.0, 14, 574.14, 0.2826,
    9243.7, -1205.7,
    0.0, 0.2826,
    152.16, 0, 0,
    8038.0, 2, 100,
    152.16, 5766.83, 0.0, 5766.83, 1629.44,
    4137.39, 0.7174, 14, 672,
    1500.0, 500.0, 2824.16,
    1313.23, 0.2277, 'review', 'manager',
    33.4834, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 669.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 669.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 669.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 669.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 669.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 669.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 669.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 669.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 669.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 669.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 669.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 669.83, 0, 'spreadsheet_seed');

  -- [137/179] Area Bathrooms
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Area Bathrooms', '', '',
    true, 10495.51, 26, 403.67, 0.3349,
    12069.84, -1574.33,
    0.0, 0.3349,
    1016.34, 0, 0,
    10495.51, 2, 100,
    1016.34, 6980.08, 0.0, 6980.08, 2337.95,
    4642.13, 0.6651, 26, 1248,
    1500.0, 500.0, 4264.34,
    377.79, 0.0541, 'review', 'manager',
    5.6399, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 874.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 874.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 874.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 874.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 874.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 874.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 874.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 874.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 874.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 874.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 874.63, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 874.63, 0, 'spreadsheet_seed');

  -- [138/179] Vogue Spas and Bathrooms
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Vogue Spas and Bathrooms', '', '',
    true, 6954.64, 7, 993.52, 0.2543,
    7997.84, -1043.2,
    0.0, 0.2543,
    170.92, 0, 0,
    6954.64, 2, 100,
    170.92, 5185.94, 0.0, 5185.94, 1318.89,
    3867.05, 0.7457, 7, 336,
    1500.0, 500.0, 2506.92,
    1360.13, 0.2623, 'review', 'manager',
    28.3755, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 579.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 579.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 579.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 579.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 579.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 579.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 579.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 579.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 579.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 579.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 579.55, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 579.55, 0, 'spreadsheet_seed');

  -- [139/179] one stop bath and tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'one stop bath and tiles', '', '',
    true, 6818.74, 8, 852.34, 0.2827,
    7841.55, -1022.81,
    0.0, 0.2827,
    24.24, 0, 0,
    6818.74, 2, 100,
    24.24, 4891.39, 0.0, 4891.39, 1382.58,
    3508.81, 0.7173, 8, 384,
    1500.0, 500.0, 2408.24,
    1100.57, 0.225, 'review', 'manager',
    185.9484, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 568.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 568.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 568.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 568.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 568.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 568.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 568.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 568.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 568.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 568.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 568.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 568.23, 0, 'spreadsheet_seed');

  -- [140/179] Adelaide Bathroom and Kitchen Supplies
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Adelaide Bathroom and Kitchen Supplies', '', '',
    true, 10618.96, 25, 424.76, 0.3754,
    12211.8, -1592.84,
    0.0, 0.3754,
    982.17, 0, 0,
    10618.96, 2, 100,
    982.17, 6632.49, 0.0, 6632.49, 2489.91,
    4142.58, 0.6246, 25, 1200,
    1500.0, 500.0, 4182.17,
    -39.59, -0.006, 'review', 'manager',
    5.5311, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 884.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 884.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 884.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 884.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 884.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 884.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 884.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 884.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 884.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 884.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 884.91, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 884.91, 0, 'spreadsheet_seed');

  -- [141/179] Bretts Plumbing Plus
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Bretts Plumbing Plus', '', '',
    true, 7860.4, 25, 314.42, 0.2899,
    9039.46, -1179.06,
    0.0, 0.2899,
    20.56, 0, 0,
    7860.4, 2, 100,
    20.56, 5581.61, 0.0, 5581.61, 1618.15,
    3963.46, 0.7101, 25, 1200,
    1500.0, 500.0, 3220.56,
    742.9, 0.1331, 'review', 'manager',
    213.1133, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 655.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 655.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 655.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 655.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 655.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 655.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 655.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 655.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 655.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 655.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 655.03, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 655.03, 0, 'spreadsheet_seed');

  -- [142/179] FBI interiors
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'FBI interiors', '', '',
    true, 13341.890000000001, 36, 370.61, 0.4479,
    15343.17, -2001.28,
    0.0, 0.4479,
    1302.11, 0, 0,
    13341.890000000001, 2, 100,
    1302.11, 7366.4, 0.0, 7366.4, 3299.22,
    4067.18, 0.5521, 36, 1728,
    1500.0, 500.0, 5030.11,
    -962.93, -0.1307, 'review', 'manager',
    4.3302, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1111.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1111.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1111.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1111.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1111.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1111.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1111.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1111.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1111.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1111.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1111.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1111.82, 0, 'spreadsheet_seed');

  -- [143/179] Corowa Plumbing Supplies Pty Ltd T/A Jones Plumbing Plus - Albury
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Corowa Plumbing Supplies Pty Ltd T/A Jones Plumbing Plus - Albury', '', '',
    true, 6315.03, 2, 3157.51, 0.2933,
    7262.28, -947.25,
    0.0, 0.2933,
    71.08, 0, 0,
    6315.03, 2, 100,
    71.08, 4462.64, 0.0, 4462.64, 1309.03,
    3153.61, 0.7067, 2, 96,
    1500.0, 500.0, 2167.08,
    986.53, 0.2211, 'review', 'manager',
    61.4328, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 526.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 526.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 526.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 526.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 526.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 526.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 526.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 526.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 526.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 526.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 526.25, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 526.25, 0, 'spreadsheet_seed');

  -- [144/179] James St Bathrooms Pty Ltd
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'James St Bathrooms Pty Ltd', '', '',
    true, 5718.84, 2, 2859.42, 0.2369,
    6576.67, -857.83,
    0.0, 0.2369,
    225.63, 0, 0,
    5718.84, 2, 100,
    225.63, 4363.93, 0.0, 4363.93, 1033.9,
    3330.03, 0.7631, 2, 96,
    1500.0, 500.0, 2321.63,
    1008.4, 0.2311, 'review', 'manager',
    18.9156, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 476.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 476.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 476.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 476.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 476.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 476.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 476.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 476.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 476.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 476.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 476.57, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 476.57, 0, 'spreadsheet_seed');

  -- [145/179] Bendigo Floor & Home Centre (Elegance Tiles)
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Bendigo Floor & Home Centre (Elegance Tiles)', '', '',
    true, 10743.52, 23, 467.11, 0.3591,
    12355.05, -1611.53,
    0.0, 0.3591,
    1811.81, 0, 0,
    10743.52, 2, 100,
    1811.81, 6885.44, 0.0, 6885.44, 2472.61,
    4412.83, 0.6409, 23, 1104,
    1500.0, 500.0, 4915.81,
    -502.98, -0.073, 'review', 'manager',
    3.191, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 895.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 895.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 895.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 895.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 895.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 895.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 895.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 895.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 895.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 895.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 895.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 895.29, 0, 'spreadsheet_seed');

  -- [146/179] The Boardroom Pty Ltd T/A The Gallery Interiors
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'The Boardroom Pty Ltd T/A The Gallery Interiors', '', '',
    true, 6537.929999999999, 7, 933.99, 0.2637,
    7518.62, -980.69,
    0.0, 0.2637,
    787.01, 0, 0,
    6537.929999999999, 2, 100,
    787.01, 4813.92, 0.0, 4813.92, 1269.4,
    3544.52, 0.7363, 7, 336,
    1500.0, 500.0, 3123.01,
    421.51, 0.0876, 'review', 'manager',
    5.6898, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 544.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 544.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 544.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 544.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 544.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 544.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 544.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 544.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 544.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 544.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 544.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 544.83, 0, 'spreadsheet_seed');

  -- [147/179] Concept Tiles & Surfaces
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Concept Tiles & Surfaces', '', '',
    true, 5719.69, 7, 817.1, 0.2541,
    6577.64, -857.95,
    0.0, 0.2541,
    285.39, 0, 0,
    5719.69, 2, 100,
    285.39, 4266.11, 0.0, 4266.11, 1084.17,
    3181.94, 0.7459, 7, 336,
    1500.0, 500.0, 2621.39,
    560.55, 0.1314, 'review', 'manager',
    13.771, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 476.64, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 476.64, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 476.64, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 476.64, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 476.64, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 476.64, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 476.64, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 476.64, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 476.64, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 476.64, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 476.64, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 476.64, 0, 'spreadsheet_seed');

  -- [148/179] Builders World
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Builders World', '', '',
    true, 5293.639999999999, 8, 661.7, 0.2474,
    6087.69, -794.05,
    0.0, 0.2474,
    118.43, 0, 0,
    5293.639999999999, 2, 100,
    118.43, 3983.94, 0.0, 3983.94, 985.67,
    2998.27, 0.7526, 8, 384,
    1500.0, 500.0, 2502.43,
    495.84, 0.1245, 'review', 'manager',
    30.3972, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 441.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 441.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 441.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 441.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 441.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 441.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 441.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 441.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 441.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 441.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 441.14, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 441.14, 0, 'spreadsheet_seed');

  -- [149/179] Choice Bathroom & Kitchen Supplies
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Choice Bathroom & Kitchen Supplies', '', '',
    true, 6585.38, 6, 1097.56, 0.3108,
    7573.19, -987.81,
    0.095, 0.3108,
    850.19, 0, 0,
    6585.38, 2, 100,
    850.19, 4538.51, 431.16, 4107.35, 1276.65,
    2830.7, 0.6892, 6, 288,
    1500.0, 500.0, 3138.19,
    -307.49, -0.0749, 'review', 'manager',
    4.9921, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 548.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 548.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 548.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 548.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 548.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 548.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 548.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 548.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 548.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 548.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 548.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 548.78, 0, 'spreadsheet_seed');

  -- [150/179] My Tile Market - Brookvale
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'My Tile Market - Brookvale', '', '',
    true, 5528.51, 10, 552.85, 0.3024,
    6357.79, -829.28,
    0.0, 0.3024,
    12.34, 0, 0,
    5528.51, 2, 100,
    12.34, 3856.78, 0.0, 3856.78, 1166.23,
    2690.55, 0.6976, 10, 480,
    1500.0, 500.0, 2492.34,
    198.21, 0.0514, 'review', 'manager',
    273.6451, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 460.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 460.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 460.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 460.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 460.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 460.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 460.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 460.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 460.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 460.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 460.71, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 460.71, 0, 'spreadsheet_seed');

  -- [151/179] Terrace Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Terrace Tiles', '', '',
    true, 5155.5, 7, 736.5, 0.2801,
    5928.82, -773.32,
    0.095, 0.2801,
    139.3, 0, 0,
    5155.5, 2, 100,
    139.3, 3711.5, 352.59, 3358.91, 940.79,
    2418.12, 0.7199, 7, 336,
    1500.0, 500.0, 2475.3,
    -57.18, -0.017, 'review', 'manager',
    24.1967, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 429.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 429.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 429.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 429.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 429.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 429.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 429.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 429.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 429.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 429.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 429.62, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 429.62, 0, 'spreadsheet_seed');

  -- [152/179] Mr Sink
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Mr Sink', '', '',
    true, 5170.389999999999, 7, 738.63, 0.3064,
    5945.95, -775.56,
    0.0, 0.3064,
    244.38, 0, 0,
    5170.389999999999, 2, 100,
    244.38, 3586.15, 0.0, 3586.15, 1098.82,
    2487.33, 0.6936, 7, 336,
    1500.0, 500.0, 2580.38,
    -93.05, -0.0259, 'review', 'manager',
    13.2996, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 430.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 430.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 430.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 430.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 430.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 430.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 430.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 430.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 430.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 430.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 430.87, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 430.87, 0, 'spreadsheet_seed');

  -- [153/179] Adorn Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Adorn Tiles', '', '',
    true, 5361.3, 5, 1072.26, 0.2714,
    6165.49, -804.19,
    0.0, 0.2714,
    894.36, 0, 0,
    5361.3, 2, 100,
    894.36, 3906.04, 0.0, 3906.04, 1060.25,
    2845.79, 0.7286, 5, 240,
    1500.0, 500.0, 3134.36,
    -288.57, -0.0739, 'review', 'manager',
    4.0991, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 446.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 446.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 446.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 446.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 446.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 446.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 446.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 446.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 446.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 446.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 446.78, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 446.78, 0, 'spreadsheet_seed');

  -- [154/179] Surf Coast Bath + Co
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Surf Coast Bath + Co', '', '',
    true, 6609.26, 10, 660.93, 0.3425,
    7600.65, -991.39,
    0.095, 0.3425,
    1250.12, 0, 0,
    6609.26, 2, 100,
    1250.12, 4345.56, 412.83, 3932.73, 1346.98,
    2585.75, 0.6575, 10, 480,
    1500.0, 500.0, 3730.12,
    -1144.37, -0.291, 'review', 'manager',
    3.0871, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 550.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 550.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 550.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 550.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 550.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 550.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 550.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 550.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 550.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 550.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 550.77, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 550.77, 0, 'spreadsheet_seed');

  -- [155/179] Hera Bathware
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Hera Bathware', '', '',
    true, 5217.900000000001, 27, 193.26, 0.2789,
    6000.59, -782.68,
    0.0, 0.2789,
    395.24, 0, 0,
    5217.900000000001, 2, 100,
    395.24, 3762.77, 0.0, 3762.77, 1049.33,
    2713.44, 0.7211, 27, 1296,
    1500.0, 500.0, 3691.24,
    -977.8, -0.2599, 'review', 'manager',
    6.2412, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 434.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 434.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 434.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 434.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 434.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 434.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 434.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 434.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 434.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 434.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 434.83, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 434.83, 0, 'spreadsheet_seed');

  -- [156/179] Builders Discount Warehouse Pty Ltd
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Builders Discount Warehouse Pty Ltd', '', '',
    true, 4636.610000000001, 14, 331.19, 0.3075,
    5332.1, -695.49,
    0.095, 0.3075,
    484.32, 0, 0,
    4636.610000000001, 2, 100,
    484.32, 3210.85, 305.03, 2905.82, 893.54,
    2012.28, 0.6925, 14, 672,
    1500.0, 500.0, 3156.32,
    -1144.04, -0.3937, 'review', 'manager',
    5.233, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 386.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 386.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 386.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 386.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 386.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 386.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 386.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 386.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 386.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 386.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 386.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 386.38, 0, 'spreadsheet_seed');

  -- [157/179] Metcash M10
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Metcash M10', '', '',
    true, 5715.370000000001, 9, 635.04, 0.2995,
    6572.68, -857.31,
    0.0, 0.2995,
    1668.54, 0, 0,
    5715.370000000001, 2, 100,
    1668.54, 4003.9, 0.0, 4003.9, 1198.97,
    2804.93, 0.7005, 9, 432,
    1500.0, 500.0, 4100.54,
    -1295.61, -0.3236, 'review', 'manager',
    2.1407, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 476.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 476.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 476.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 476.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 476.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 476.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 476.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 476.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 476.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 476.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 476.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 476.28, 0, 'spreadsheet_seed');

  -- [158/179] Dahlsens
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Dahlsens', '', '',
    true, 3131.9700000000003, 5, 626.39, 0.3655,
    3601.77, -469.8,
    0.0, 0.3655,
    24.43, 0, 0,
    3131.9700000000003, 2, 100,
    24.43, 1987.27, 0.0, 1987.27, 726.32,
    1260.95, 0.6345, 5, 240,
    1500.0, 500.0, 2264.43,
    -1003.48, -0.505, 'review', 'manager',
    71.5215, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 261.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 261.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 261.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 261.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 261.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 261.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 261.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 261.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 261.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 261.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 261.0, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 261.0, 0, 'spreadsheet_seed');

  -- [159/179] Kelly's Plumbing Supplies
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Kelly''s Plumbing Supplies', '', '',
    true, 2948.06, 4, 737.01, 0.2591,
    3390.27, -442.21,
    0.0, 0.2591,
    380.61, 0, 0,
    2948.06, 2, 100,
    380.61, 2184.12, 0.0, 2184.12, 565.98,
    1618.14, 0.7409, 4, 192,
    1500.0, 500.0, 2572.61,
    -954.47, -0.437, 'review', 'manager',
    5.234, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 245.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 245.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 245.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 245.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 245.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 245.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 245.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 245.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 245.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 245.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 245.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 245.67, 0, 'spreadsheet_seed');

  -- [160/179] Scott's Plumbing Supplies
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Scott''s Plumbing Supplies', '', '',
    true, 3017.03, 5, 603.41, 0.2998,
    3469.58, -452.55,
    0.0, 0.2998,
    284.5, 0, 0,
    3017.03, 2, 100,
    284.5, 2112.5, 0.0, 2112.5, 633.34,
    1479.16, 0.7002, 5, 240,
    1500.0, 500.0, 2524.5,
    -1045.34, -0.4948, 'review', 'manager',
    6.5817, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 251.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 251.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 251.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 251.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 251.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 251.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 251.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 251.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 251.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 251.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 251.42, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 251.42, 0, 'spreadsheet_seed');

  -- [161/179] Bayview Renovations Braeside
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Bayview Renovations Braeside', '', '',
    true, 2841.8, 6, 473.63, 0.291,
    3268.07, -426.27,
    0.0, 0.291,
    179.79, 0, 0,
    2841.8, 2, 100,
    179.79, 2014.93, 0.0, 2014.93, 586.28,
    1428.65, 0.709, 6, 288,
    1500.0, 500.0, 2467.79,
    -1039.14, -0.5157, 'review', 'manager',
    9.6053, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 236.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 236.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 236.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 236.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 236.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 236.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 236.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 236.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 236.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 236.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 236.82, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 236.82, 0, 'spreadsheet_seed');

  -- [162/179] Bondi Spaces Pty Ltd
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Bondi Spaces Pty Ltd', '', '',
    true, 3973.2900000000004, 5, 794.66, 0.2478,
    4569.28, -595.99,
    0.0, 0.2478,
    1308.52, 0, 0,
    3973.2900000000004, 2, 100,
    1308.52, 2988.9, 0.0, 2988.9, 740.51,
    2248.39, 0.7522, 5, 240,
    1500.0, 500.0, 3548.52,
    -1300.13, -0.435, 'review', 'manager',
    2.1008, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 331.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 331.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 331.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 331.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 331.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 331.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 331.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 331.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 331.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 331.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 331.11, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 331.11, 0, 'spreadsheet_seed');

  -- [163/179] DEMOR EST 1980 PTY LTD (Previously known as Demor)
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'DEMOR EST 1980 PTY LTD (Previously known as Demor)', '', '',
    true, 2469.67, 8, 308.71, 0.3362,
    2840.12, -370.45,
    0.095, 0.3362,
    82.98, 0, 0,
    2469.67, 2, 100,
    82.98, 1639.3, 155.73, 1483.57, 498.82,
    984.75, 0.6638, 8, 384,
    1500.0, 500.0, 2466.98,
    -1482.23, -0.9991, 'review', 'manager',
    15.0995, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 205.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 205.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 205.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 205.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 205.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 205.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 205.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 205.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 205.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 205.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 205.81, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 205.81, 0, 'spreadsheet_seed');

  -- [164/179] All Trade Plumbing Centre Pty Ltd
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'All Trade Plumbing Centre Pty Ltd', '', '',
    true, 2370.0, 6, 395.0, 0.3227,
    2725.5, -355.5,
    0.0, 0.3227,
    179.55, 0, 0,
    2370.0, 2, 100,
    179.55, 1605.2, 0.0, 1605.2, 518.0,
    1087.2, 0.6773, 6, 288,
    1500.0, 500.0, 2467.55,
    -1380.35, -0.8599, 'review', 'manager',
    7.3361, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 197.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 197.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 197.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 197.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 197.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 197.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 197.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 197.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 197.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 197.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 197.5, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 197.5, 0, 'spreadsheet_seed');

  -- [165/179] Astley’s Plumbing & Hardware
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Astley’s Plumbing & Hardware', '', '',
    true, 7748.000000000001, 14, 553.43, 0.3296,
    8910.2, -1162.2,
    0.0, 0.3296,
    3644.99, 0, 0,
    7748.000000000001, 2, 100,
    3644.99, 5194.53, 0.0, 5194.53, 1711.94,
    3482.59, 0.6704, 14, 672,
    1500.0, 500.0, 6316.99,
    -2834.4, -0.5457, 'review', 'manager',
    1.2408, 'marginal'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 645.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 645.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 645.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 645.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 645.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 645.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 645.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 645.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 645.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 645.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 645.67, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 645.67, 0, 'spreadsheet_seed');

  -- [166/179] Abode Carpentry & Renovations Pty Ltd
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Abode Carpentry & Renovations Pty Ltd', '', '',
    true, 4074.5, 3, 1358.17, 0.2889,
    4685.67, -611.17,
    0.0, 0.2889,
    1896.28, 0, 0,
    4074.5, 2, 100,
    1896.28, 2897.2, 0.0, 2897.2, 837.13,
    2060.07, 0.7111, 3, 144,
    1500.0, 500.0, 4040.28,
    -1980.21, -0.6835, 'review', 'manager',
    1.4519, 'marginal'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 339.54, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 339.54, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 339.54, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 339.54, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 339.54, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 339.54, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 339.54, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 339.54, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 339.54, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 339.54, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 339.54, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 339.54, 0, 'spreadsheet_seed');

  -- [167/179] Stone Arc T/A Arc Trading Pty Ltd
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Stone Arc T/A Arc Trading Pty Ltd', '', '',
    true, 1984.9399999999998, 2, 992.47, 0.2762,
    2282.68, -297.74,
    0.0, 0.2762,
    534.37, 0, 0,
    1984.9399999999998, 2, 100,
    534.37, 1436.63, 0.0, 1436.63, 396.85,
    1039.78, 0.7238, 2, 96,
    1500.0, 500.0, 2630.37,
    -1590.59, -1.1072, 'review', 'manager',
    2.5088, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 165.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 165.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 165.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 165.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 165.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 165.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 165.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 165.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 165.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 165.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 165.41, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 165.41, 0, 'spreadsheet_seed');

  -- [168/179] Tweed Heads Plumbing Supplies
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Tweed Heads Plumbing Supplies', '', '',
    true, 2640.2100000000005, 8, 330.03, 0.2967,
    3036.24, -396.03,
    0.0, 0.2967,
    686.2, 0, 0,
    2640.2100000000005, 2, 100,
    686.2, 1856.95, 0.0, 1856.95, 550.89,
    1306.06, 0.7033, 8, 384,
    1500.0, 500.0, 3070.2,
    -1764.14, -0.95, 'review', 'manager',
    2.1465, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 220.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 220.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 220.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 220.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 220.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 220.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 220.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 220.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 220.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 220.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 220.02, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 220.02, 0, 'spreadsheet_seed');

  -- [169/179] COD Customers
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'COD Customers', '', '',
    true, 4467.409999999999, 14, 319.1, 0.4213,
    5137.52, -670.11,
    0.0, 0.4213,
    1703.66, 0, 0,
    4467.409999999999, 2, 100,
    1703.66, 2585.37, 0.0, 2585.37, 1089.17,
    1496.2, 0.5787, 14, 672,
    1500.0, 500.0, 4375.66,
    -2879.46, -1.1138, 'review', 'manager',
    1.1231, 'marginal'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 372.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 372.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 372.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 372.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 372.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 372.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 372.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 372.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 372.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 372.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 372.28, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 372.28, 0, 'spreadsheet_seed');

  -- [170/179] Bathroom Supplies
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Bathroom Supplies', '', '',
    true, 500.23, 2, 250.12, 0.2165,
    575.26, -75.03,
    0.0, 0.2165,
    90.66, 0, 0,
    500.23, 2, 100,
    90.66, 391.95, 0.0, 391.95, 84.84,
    307.11, 0.7835, 2, 96,
    1500.0, 500.0, 2186.66,
    -1879.55, -4.7954, 'review', 'manager',
    3.2644, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 41.69, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 41.69, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 41.69, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 41.69, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 41.69, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 41.69, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 41.69, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 41.69, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 41.69, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 41.69, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 41.69, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 41.69, 0, 'spreadsheet_seed');

  -- [171/179] Inhouse Trade Centre
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Inhouse Trade Centre', '', '',
    true, 413.46, 2, 206.73, 0.2658,
    475.48, -62.02,
    0.0, 0.2658,
    97.56, 0, 0,
    413.46, 2, 100,
    97.56, 303.58, 0.0, 303.58, 80.68,
    222.9, 0.7342, 2, 96,
    1500.0, 500.0, 2193.56,
    -1970.66, -6.4914, 'review', 'manager',
    2.1277, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 34.45, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 34.45, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 34.45, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 34.45, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 34.45, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 34.45, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 34.45, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 34.45, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 34.45, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 34.45, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 34.45, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 34.45, 0, 'spreadsheet_seed');

  -- [172/179] Express Plumbing
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Express Plumbing', '', '',
    true, 7468.610000000001, 19, 393.08, 0.2813,
    8588.9, -1120.29,
    0.0, 0.2813,
    4477.43, 0, 0,
    7468.610000000001, 2, 100,
    4477.43, 5368.03, 0.0, 5368.03, 1509.78,
    3858.25, 0.7187, 19, 912,
    1500.0, 500.0, 7389.43,
    -3531.18, -0.6578, 'review', 'manager',
    0.9952, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 622.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 622.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 622.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 622.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 622.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 622.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 622.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 622.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 622.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 622.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 622.38, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 622.38, 0, 'spreadsheet_seed');

  -- [173/179] Nu Bathroom and kitchen centre
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Nu Bathroom and kitchen centre', '', '',
    true, 662.2, 4, 165.55, 0.2622,
    761.53, -99.33,
    0.095, 0.2622,
    484.37, 0, 0,
    662.2, 2, 100,
    484.37, 488.59, 46.42, 442.17, 115.92,
    326.25, 0.7378, 4, 192,
    1500.0, 500.0, 2676.37,
    -2350.12, -5.315, 'review', 'manager',
    0.611, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 55.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 55.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 55.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 55.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 55.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 55.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 55.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 55.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 55.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 55.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 55.18, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 55.18, 0, 'spreadsheet_seed');

  -- [174/179] Vanity Co (Divine Kitchens)
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Vanity Co (Divine Kitchens)', '', '',
    true, 569.64, 2, 284.82, 0.2657,
    655.09, -85.45,
    0.0, 0.2657,
    637.8, 0, 0,
    569.64, 2, 100,
    637.8, 418.28, 0.0, 418.28, 111.14,
    307.14, 0.7343, 2, 96,
    1500.0, 500.0, 2733.8,
    -2426.66, -5.8015, 'review', 'manager',
    0.5053, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 47.47, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 47.47, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 47.47, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 47.47, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 47.47, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 47.47, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 47.47, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 47.47, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 47.47, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 47.47, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 47.47, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 47.47, 0, 'spreadsheet_seed');

  -- [175/179] Ayvan Pty Ltd
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Ayvan Pty Ltd', '', '',
    true, 399.5, 1, 399.5, 0.3116,
    459.42, -59.92,
    0.0, 0.3116,
    1086.49, 0, 0,
    399.5, 2, 100,
    1086.49, 275.02, 0.0, 275.02, 85.69,
    189.33, 0.6884, 1, 48,
    1500.0, 500.0, 3134.49,
    -2945.16, -9.9999, 'review', 'manager',
    0.2089, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 33.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 33.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 33.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 33.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 33.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 33.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 33.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 33.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 33.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 33.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 33.29, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 33.29, 0, 'spreadsheet_seed');

  -- [176/179] San Marco Ceramics
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'San Marco Ceramics', '', '',
    true, 4385.26, 20, 219.26, 0.3434,
    5043.05, -657.79,
    0.0, 0.3434,
    2795.35, 0, 0,
    4385.26, 2, 100,
    2795.35, 2879.49, 0.0, 2879.49, 988.73,
    1890.76, 0.6566, 20, 960,
    1500.0, 500.0, 5755.35,
    -3864.59, -1.3421, 'review', 'manager',
    0.6867, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 365.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 365.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 365.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 365.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 365.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 365.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 365.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 365.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 365.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 365.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 365.44, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 365.44, 0, 'spreadsheet_seed');

  -- [177/179] Kewco
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Kewco', '', '',
    true, 1913.17, 13, 147.17, 0.7481,
    2200.15, -286.98,
    0.095, 0.7481,
    749.72, 0, 0,
    1913.17, 2, 100,
    749.72, 481.91, 45.78, 436.13, 326.27,
    109.86, 0.2519, 13, 624,
    1500.0, 500.0, 3373.72,
    -3263.86, -7.4837, 'review', 'manager',
    -0.1919, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 159.43, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 159.43, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 159.43, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 159.43, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 159.43, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 159.43, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 159.43, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 159.43, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 159.43, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 159.43, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 159.43, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 159.43, 0, 'spreadsheet_seed');

  -- [178/179] Cowra Creative Tiles
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Cowra Creative Tiles', '', '',
    true, 26.73, 1, 26.73, 0.3172,
    30.74, -4.01,
    0.0, 0.3172,
    2614.32, 0, 0,
    26.73, 2, 100,
    2614.32, 18.25, 0.0, 18.25, 5.79,
    12.46, 0.6827, 1, 48,
    1500.0, 500.0, 4662.32,
    -4649.86, -9.9999, 'review', 'manager',
    -0.0114, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2.23, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2.23, 0, 'spreadsheet_seed');

  -- [179/179] Meir
  INSERT INTO display_requests (
    submitted_by, submitted_at, status, approved_at,
    store_name, store_code, rep_name,
    is_existing_client, existing_annual_revenue, existing_orders, existing_aov, existing_cogs_pct,
    baseline_revenue, incremental_revenue,
    rebate_pct, cogs_pct,
    board_labour_cost, product_cogs, free_samples_cost,
    forecast_revenue, rep_hours_monthly, catalogues_qty,
    total_investment, revenue_after_discount, rebate_cost, net_revenue, cogs_on_sales,
    gross_profit, gross_margin, est_orders, order_processing,
    rep_visit_cost, catalogue_cost, total_costs,
    net_contribution, net_margin, profitability_flag, approval_tier,
    roi_multiplier, verdict
  ) VALUES (
    admin_id, '2025-04-01T00:00:00Z', 'approved', '2025-04-01T00:00:00Z',
    'Meir', '', '',
    true, 12878.019999999997, 30, 429.27, 0.3871,
    14809.72, -1931.7,
    0.0, 0.3871,
    25450.69, 0, 0,
    12878.019999999997, 2, 100,
    25450.69, 7893.42, 0.0, 7893.42, 3055.25,
    4838.17, 0.6129, 30, 1440,
    1500.0, 500.0, 28890.69,
    -24052.52, -3.0472, 'review', 'cfo',
    0.2536, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1073.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1073.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1073.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1073.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1073.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1073.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1073.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1073.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1073.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1073.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1073.17, 0, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1073.17, 0, 'spreadsheet_seed');

END $$;