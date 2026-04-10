-- Re-seed: all 230 display customers from Sales & Margin Analysis spreadsheet
-- Replaces the 179-row seed from migration 013
-- Source: Sales & Margin Analysis 31.03.2026 v6.xlsx

DO $$
DECLARE
  admin_id UUID;
  req_id UUID;
BEGIN
  SELECT id INTO admin_id FROM users WHERE email = 'rick@meir.com.au' LIMIT 1;
  IF admin_id IS NULL THEN
    RAISE EXCEPTION 'Admin user rick@meir.com.au not found';
  END IF;

  -- Delete previous seed data
  DELETE FROM monthly_actuals WHERE request_id IN (
    SELECT id FROM display_requests WHERE submitted_by = admin_id AND submitted_at = '2025-04-01T00:00:00Z'
  );
  DELETE FROM display_requests WHERE submitted_by = admin_id AND submitted_at = '2025-04-01T00:00:00Z';

  -- [1/230] Harvey Norman
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
    true, 3900418.33, 4713, 827.59, 0.4254,
    4485481.08, -585062.75,
    0.15, 0.4254,
    166497.89, 0, 0,
    3900418.33, 2, 100,
    166497.89, 2241043.06, 585062.75, 1655980.31, 1659375.27,
    1655980.31, 0.4246, 4713, 226224,
    1500.0, 500.0, 394721.89,
    1263258.42, 0.3239, 'green', 'admin',
    8.5872, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 325034.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 325034.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 325034.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 325034.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 325034.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 325034.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 325034.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 325034.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 325034.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 325034.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 325034.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 325034.86, 8, 'spreadsheet_seed');

  -- [2/230] Beaumont Tiles
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
    true, 1939440.06, 3360, 577.21, 0.3719,
    2230356.07, -290916.01,
    0.08, 0.3719,
    122668.2, 0, 0,
    1939440.06, 2, 100,
    122668.2, 1218132.08, 1551.55, 1216580.53, 721307.98,
    1216580.53, 0.5481, 3360, 161280,
    1500.0, 500.0, 285948.2,
    932632.33, 0.4809, 'green', 'admin',
    8.6029, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 161620.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 161620.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 161620.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 161620.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 161620.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 161620.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 161620.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 161620.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 161620.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 161620.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 161620.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 161620.0, 8, 'spreadsheet_seed');

  -- [3/230] SIBO Trading
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
    0, 0.6742,
    10583.36, 0, 0,
    1897269.02, 2, 100,
    10583.36, 618066.03, 0, 618066.03, 1279202.99,
    618066.03, 0.3258, 230, 11040,
    1500.0, 500.0, 23623.36,
    596442.67, 0.3144, 'green', 'cfo',
    57.3566, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 158105.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 158105.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 158105.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 158105.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 158105.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 158105.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 158105.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 158105.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 158105.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 158105.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 158105.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 158105.75, 8, 'spreadsheet_seed');

  -- [4/230] United Spaces Pty Ltd (The Blue Space)
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
    true, 870916.25, 812, 1072.56, 0.3225,
    1001553.69, -130637.44,
    0, 0.3225,
    6988.12, 0, 0,
    870916.25, 2, 100,
    6988.12, 590070.52, 0, 590070.52, 280845.73,
    590070.52, 0.6775, 812, 38976,
    1500.0, 500.0, 47964.12,
    544106.4, 0.6248, 'green', 'manager',
    78.8616, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 72576.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 72576.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 72576.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 72576.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 72576.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 72576.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 72576.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 72576.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 72576.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 72576.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 72576.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 72576.35, 8, 'spreadsheet_seed');

  -- [5/230] Reece
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
    true, 802549.98, 1026, 782.21, 0.2759,
    922932.48, -120382.5,
    0, 0.2759,
    9762.59, 0, 0,
    802549.98, 2, 100,
    9762.59, 581158.67, 0, 581158.67, 221391.31,
    581158.67, 0.7241, 1026, 49248,
    1500.0, 500.0, 61010.59,
    522148.08, 0.6506, 'green', 'manager',
    54.4846, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 66879.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 66879.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 66879.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 66879.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 66879.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 66879.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 66879.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 66879.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 66879.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 66879.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 66879.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 66879.17, 8, 'spreadsheet_seed');

  -- [6/230] Bathroom Sales Direct
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
    true, 723520.25, 1743, 415.1, 0.3607,
    832048.29, -108528.04,
    0, 0.3607,
    16340.13, 0, 0,
    723520.25, 2, 100,
    16340.13, 462567.6, 0, 462567.6, 260952.65,
    462567.6, 0.6393, 1743, 83664,
    1500.0, 500.0, 102004.13,
    362563.47, 0.5011, 'green', 'cfo',
    23.1885, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 60293.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 60293.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 60293.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 60293.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 60293.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 60293.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 60293.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 60293.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 60293.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 60293.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 60293.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 60293.35, 8, 'spreadsheet_seed');

  -- [7/230] My Homeware Bathroom and Kitchen Supplies
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
    true, 522211.46, 493, 1059.25, 0.321,
    600543.18, -78331.72,
    0, 0.321,
    8934.62, 0, 0,
    522211.46, 2, 100,
    8934.62, 354606.8, 0, 354606.8, 167604.66,
    354606.8, 0.679, 493, 23664,
    1500.0, 500.0, 34598.62,
    322008.18, 0.6166, 'green', 'manager',
    37.0405, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 43517.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 43517.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 43517.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 43517.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 43517.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 43517.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 43517.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 43517.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 43517.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 43517.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 43517.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 43517.62, 8, 'spreadsheet_seed');

  -- [8/230] Designer Bathware
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
    true, 579524.22, 1412, 410.43, 0.3677,
    666452.85, -86928.63,
    0, 0.3677,
    14593.76, 0, 0,
    579524.22, 2, 100,
    14593.76, 366410.91, 0, 366410.91, 213113.31,
    366410.91, 0.6323, 1412, 67776,
    1500.0, 500.0, 84369.76,
    284041.15, 0.4901, 'green', 'cfo',
    20.4632, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 48293.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 48293.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 48293.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 48293.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 48293.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 48293.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 48293.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 48293.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 48293.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 48293.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 48293.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 48293.68, 8, 'spreadsheet_seed');

  -- [9/230] Amber Tiles
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
    true, 362853.77, 652, 556.52, 0.3279,
    417281.84, -54428.07,
    0.06, 0.3279,
    27063.8, 0, 0,
    362853.77, 2, 100,
    27063.8, 243857.12, 217.71, 243639.41, 118996.65,
    243639.41, 0.6121, 652, 31296,
    1500.0, 500.0, 60359.8,
    185279.61, 0.5106, 'green', 'cfo',
    7.846, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 30237.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 30237.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 30237.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 30237.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 30237.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 30237.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 30237.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 30237.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 30237.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 30237.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 30237.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 30237.81, 8, 'spreadsheet_seed');

  -- [10/230] Samios
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
    true, 269452.44, 329, 819.0, 0.3082,
    309870.31, -40417.87,
    0.05, 0.3082,
    10924.5, 0, 0,
    269452.44, 2, 100,
    10924.5, 186401.71, 134.73, 186266.98, 83050.73,
    186266.98, 0.6418, 329, 15792,
    1500.0, 500.0, 28716.5,
    159550.48, 0.5921, 'green', 'cfo',
    15.6048, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 22454.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 22454.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 22454.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 22454.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 22454.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 22454.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 22454.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 22454.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 22454.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 22454.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 22454.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 22454.37, 8, 'spreadsheet_seed');

  -- [11/230] Buildmat
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
    true, 225070.25, 300, 750.23, 0.2905,
    258830.79, -33760.54,
    0, 0.2905,
    206.9, 0, 0,
    225070.25, 2, 100,
    206.9, 159678.46, 0, 159678.46, 65391.79,
    159678.46, 0.7095, 300, 14400,
    1500.0, 500.0, 16606.9,
    145071.56, 0.6446, 'green', 'manager',
    702.1675, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 18755.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 18755.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 18755.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 18755.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 18755.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 18755.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 18755.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 18755.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 18755.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 18755.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 18755.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 18755.85, 8, 'spreadsheet_seed');

  -- [12/230] Renovation Kingdom
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
    true, 206723.91, 219, 943.94, 0.3647,
    237732.5, -31008.59,
    0, 0.3647,
    3413.33, 0, 0,
    206723.91, 2, 100,
    3413.33, 131339.92, 0, 131339.92, 75383.99,
    131339.92, 0.6353, 219, 10512,
    1500.0, 500.0, 15925.33,
    117414.59, 0.568, 'green', 'manager',
    35.3988, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 17226.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 17226.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 17226.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 17226.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 17226.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 17226.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 17226.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 17226.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 17226.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 17226.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 17226.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 17226.99, 8, 'spreadsheet_seed');

  -- [13/230] Tradelink
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
    true, 187191.38, 340, 550.56, 0.2923,
    215270.09, -28078.71,
    0.07, 0.2923,
    9398.95, 0, 0,
    187191.38, 2, 100,
    9398.95, 132482.41, 131.03, 132351.38, 54708.97,
    132351.38, 0.6377, 340, 16320,
    1500.0, 500.0, 27718.95,
    106632.43, 0.5696, 'green', 'manager',
    12.3451, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 15599.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 15599.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 15599.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 15599.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 15599.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 15599.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 15599.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 15599.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 15599.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 15599.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 15599.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 15599.28, 8, 'spreadsheet_seed');

  -- [14/230] Sydney Taps
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
    true, 231384.1, 368, 628.76, 0.4086,
    266091.71, -34707.61,
    0.095, 0.4086,
    17169.35, 0, 0,
    231384.1, 2, 100,
    17169.35, 136832.17, 219.81, 136612.36, 94551.93,
    136612.36, 0.4964, 368, 17664,
    1500.0, 500.0, 36833.35,
    101779.01, 0.4399, 'green', 'cfo',
    6.9279, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 19282.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 19282.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 19282.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 19282.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 19282.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 19282.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 19282.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 19282.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 19282.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 19282.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 19282.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 19282.01, 8, 'spreadsheet_seed');

  -- [15/230] Elia Bathrooms
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
    true, 182346.01, 265, 688.1, 0.3624,
    209697.91, -27351.9,
    0, 0.3624,
    4663.44, 0, 0,
    182346.01, 2, 100,
    4663.44, 116257.42, 0, 116257.42, 66088.59,
    116257.42, 0.6376, 265, 12720,
    1500.0, 500.0, 19383.44,
    98873.98, 0.5422, 'green', 'manager',
    22.2019, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 15195.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 15195.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 15195.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 15195.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 15195.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 15195.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 15195.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 15195.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 15195.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 15195.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 15195.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 15195.5, 8, 'spreadsheet_seed');

  -- [16/230] Clifton Bathrooms and Kitchens
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
    true, 170374.12, 347, 490.99, 0.3222,
    195930.24, -25556.12,
    0, 0.3222,
    1553.14, 0, 0,
    170374.12, 2, 100,
    1553.14, 115482.3, 0, 115482.3, 54891.82,
    115482.3, 0.6778, 347, 16656,
    1500.0, 500.0, 20209.14,
    97273.16, 0.5709, 'green', 'manager',
    63.63, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 14197.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 14197.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 14197.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 14197.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 14197.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 14197.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 14197.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 14197.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 14197.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 14197.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 14197.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 14197.84, 8, 'spreadsheet_seed');

  -- [17/230] Icon Bathware
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
    11106.59, 115471.55, 168.87, 115302.68, 62284.24,
    115302.68, 0.5546, 251, 12048,
    1500.0, 500.0, 25154.59,
    92148.09, 0.5184, 'green', 'cfo',
    9.2967, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 14812.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 14812.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 14812.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 14812.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 14812.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 14812.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 14812.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 14812.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 14812.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 14812.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 14812.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 14812.98, 8, 'spreadsheet_seed');

  -- [18/230] Yeomans Bagno & Ceramiche
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
    7563.87, 113144.7, 171.34, 112973.36, 67212.84,
    112973.36, 0.5323, 287, 13776,
    1500.0, 500.0, 23339.87,
    91633.49, 0.5081, 'green', 'manager',
    13.1146, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 15029.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 15029.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 15029.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 15029.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 15029.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 15029.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 15029.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 15029.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 15029.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 15029.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 15029.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 15029.8, 8, 'spreadsheet_seed');

  -- [19/230] Blue Leaf Bathware & Tiles
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
    true, 164010.88, 198, 828.34, 0.3812,
    188612.51, -24601.63,
    0.095, 0.3812,
    990.57, 0, 0,
    164010.88, 2, 100,
    990.57, 101490.23, 155.81, 101334.42, 62520.65,
    101334.42, 0.5238, 198, 9504,
    1500.0, 500.0, 12494.57,
    90839.85, 0.5539, 'green', 'manager',
    92.7046, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 13667.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 13667.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 13667.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 13667.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 13667.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 13667.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 13667.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 13667.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 13667.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 13667.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 13667.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 13667.57, 8, 'spreadsheet_seed');

  -- [20/230] Empire Bathrooms
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
    2476.94, 96528.5, 128.64, 96399.86, 38887.01,
    96399.86, 0.6178, 151, 7248,
    1500.0, 500.0, 11724.94,
    86674.92, 0.6401, 'green', 'manager',
    35.9927, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 11284.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 11284.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 11284.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 11284.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 11284.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 11284.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 11284.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 11284.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 11284.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 11284.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 11284.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 11284.63, 8, 'spreadsheet_seed');

  -- [21/230] Bathroom Space
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
    true, 135060.05, 123, 1098.05, 0.3674,
    155319.06, -20259.01,
    0, 0.3674,
    3010.57, 0, 0,
    135060.05, 2, 100,
    3010.57, 85439.26, 0, 85439.26, 49620.79,
    85439.26, 0.6326, 123, 5904,
    1500.0, 500.0, 10914.57,
    76524.69, 0.5666, 'green', 'manager',
    26.4187, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 11255.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 11255.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 11255.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 11255.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 11255.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 11255.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 11255.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 11255.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 11255.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 11255.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 11255.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 11255.0, 8, 'spreadsheet_seed');

  -- [22/230] Ideal Bathrooms
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
    true, 120176.53, 152, 790.64, 0.3199,
    138203.01, -18026.48,
    0, 0.3199,
    1202.65, 0, 0,
    120176.53, 2, 100,
    1202.65, 81730.41, 0, 81730.41, 38446.12,
    81730.41, 0.6801, 152, 7296,
    1500.0, 500.0, 10498.65,
    73231.76, 0.6094, 'green', 'manager',
    61.892, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 10014.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 10014.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 10014.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 10014.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 10014.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 10014.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 10014.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 10014.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 10014.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 10014.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 10014.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 10014.71, 8, 'spreadsheet_seed');

  -- [23/230] Jacoba Tiles
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
    true, 130704.2, 184, 710.35, 0.3629,
    150309.83, -19605.63,
    0, 0.3629,
    3552.51, 0, 0,
    130704.2, 2, 100,
    3552.51, 83273.19, 0, 83273.19, 47431.01,
    83273.19, 0.6371, 184, 8832,
    1500.0, 500.0, 14384.51,
    70888.68, 0.5424, 'green', 'manager',
    20.9545, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 10892.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 10892.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 10892.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 10892.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 10892.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 10892.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 10892.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 10892.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 10892.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 10892.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 10892.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 10892.02, 8, 'spreadsheet_seed');

  -- [24/230] Benton''s Plumbing Supplies
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
    true, 129038.78, 292, 441.91, 0.3123,
    148394.6, -19355.82,
    0, 0.3123,
    5455.35, 0, 0,
    129038.78, 2, 100,
    5455.35, 88745.61, 0, 88745.61, 40293.17,
    88745.61, 0.6877, 292, 14016,
    1500.0, 500.0, 21471.35,
    69274.26, 0.5368, 'green', 'manager',
    13.6984, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 10753.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 10753.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 10753.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 10753.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 10753.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 10753.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 10753.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 10753.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 10753.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 10753.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 10753.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 10753.23, 8, 'spreadsheet_seed');

  -- [25/230] Design Bathware
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
    0, 0.3524,
    4453.41, 0, 0,
    123569.5, 2, 100,
    4453.41, 80028.12, 0, 80028.12, 43541.38,
    80028.12, 0.6476, 147, 7056,
    1500.0, 500.0, 13509.41,
    68518.71, 0.5545, 'green', 'manager',
    16.3857, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 10297.46, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 10297.46, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 10297.46, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 10297.46, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 10297.46, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 10297.46, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 10297.46, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 10297.46, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 10297.46, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 10297.46, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 10297.46, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 10297.46, 8, 'spreadsheet_seed');

  -- [26/230] JB Camerons (Plumbing, Steel, Welding & Industrial)
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
    0, 0.3128,
    11079.55, 0, 0,
    122872.85, 2, 100,
    11079.55, 84438.2, 0, 84438.2, 38434.65,
    84438.2, 0.6872, 120, 5760,
    1500.0, 500.0, 18839.55,
    67598.65, 0.5502, 'green', 'cfo',
    7.1012, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 10239.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 10239.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 10239.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 10239.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 10239.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 10239.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 10239.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 10239.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 10239.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 10239.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 10239.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 10239.4, 8, 'spreadsheet_seed');

  -- [27/230] BMC Sharm LTD
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
    true, 157062.74, 36, 4362.85, 0.5474,
    180622.15, -23559.41,
    0, 0.5474,
    2227.18, 0, 0,
    157062.74, 2, 100,
    2227.18, 71079.92, 0, 71079.92, 85982.82,
    71079.92, 0.4526, 36, 1728,
    1500.0, 500.0, 5955.18,
    67124.74, 0.4274, 'green', 'manager',
    31.1389, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 13088.56, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 13088.56, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 13088.56, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 13088.56, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 13088.56, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 13088.56, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 13088.56, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 13088.56, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 13088.56, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 13088.56, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 13088.56, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 13088.56, 8, 'spreadsheet_seed');

  -- [28/230] Elegance Tiles
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
    0, 0.3743,
    13536.39, 0, 0,
    141845.88, 2, 100,
    13536.39, 88753.4, 0, 88753.4, 53092.48,
    88753.4, 0.6257, 222, 10656,
    1500.0, 500.0, 26192.39,
    64561.01, 0.4551, 'green', 'cfo',
    5.7694, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 11820.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 11820.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 11820.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 11820.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 11820.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 11820.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 11820.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 11820.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 11820.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 11820.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 11820.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 11820.49, 8, 'spreadsheet_seed');

  -- [29/230] Metcash Hardings / D10
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
    0, 0.3527,
    22013.98, 0, 0,
    151039.29, 2, 100,
    22013.98, 97772.82, 0, 97772.82, 53266.47,
    97772.82, 0.6473, 235, 11280,
    1500.0, 500.0, 35293.98,
    64478.84, 0.4269, 'green', 'cfo',
    3.929, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 12586.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 12586.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 12586.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 12586.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 12586.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 12586.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 12586.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 12586.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 12586.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 12586.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 12586.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 12586.61, 8, 'spreadsheet_seed');

  -- [30/230] Tile Republic
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
    true, 119945.74, 112, 1070.94, 0.3701,
    137937.6, -17991.86,
    0, 0.3701,
    5868.06, 0, 0,
    119945.74, 2, 100,
    5868.06, 75557.09, 0, 75557.09, 44388.65,
    75557.09, 0.6299, 112, 5376,
    1500.0, 500.0, 13244.06,
    64313.03, 0.5362, 'green', 'manager',
    11.9598, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 9995.48, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 9995.48, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 9995.48, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 9995.48, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 9995.48, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 9995.48, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 9995.48, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 9995.48, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 9995.48, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 9995.48, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 9995.48, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 9995.48, 8, 'spreadsheet_seed');

  -- [31/230] Brands Direct Online
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
    true, 139531.45, 406, 343.67, 0.3492,
    160461.17, -20929.72,
    0.095, 0.3492,
    8240.71, 0, 0,
    139531.45, 2, 100,
    8240.71, 90810.54, 132.55, 90677.99, 48720.91,
    90677.99, 0.5558, 406, 19488,
    1500.0, 500.0, 29728.71,
    62949.28, 0.4511, 'green', 'manager',
    8.6388, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 11627.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 11627.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 11627.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 11627.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 11627.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 11627.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 11627.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 11627.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 11627.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 11627.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 11627.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 11627.62, 8, 'spreadsheet_seed');

  -- [32/230] FAS Group Pty Ltd (GT&B)
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
    true, 107326.36, 181, 592.96, 0.3613,
    123425.31, -16098.95,
    0.095, 0.3613,
    6256.94, 0, 0,
    107326.36, 2, 100,
    6256.94, 68549.3, 101.96, 68447.34, 38777.06,
    68447.34, 0.5437, 181, 8688,
    1500.0, 500.0, 16944.94,
    53502.4, 0.4985, 'green', 'manager',
    9.5509, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 8943.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 8943.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 8943.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 8943.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 8943.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 8943.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 8943.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 8943.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 8943.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 8943.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 8943.86, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 8943.86, 8, 'spreadsheet_seed');

  -- [33/230] Sannine Bathrooms
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
    true, 107865.31, 108, 998.75, 0.4167,
    124045.11, -16179.8,
    0, 0.4167,
    5086.66, 0, 0,
    107865.31, 2, 100,
    5086.66, 62914.34, 0, 62914.34, 44950.97,
    62914.34, 0.5833, 108, 5184,
    1500.0, 500.0, 12270.66,
    52643.68, 0.4881, 'green', 'manager',
    11.3494, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 8988.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 8988.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 8988.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 8988.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 8988.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 8988.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 8988.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 8988.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 8988.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 8988.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 8988.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 8988.78, 8, 'spreadsheet_seed');

  -- [34/230] Temple and Webster
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
    true, 166263.77, 1392, 119.44, 0.3009,
    191203.34, -24939.57,
    0, 0.3009,
    1233.36, 0, 0,
    166263.77, 2, 100,
    1233.36, 116232.49, 0, 116232.49, 50031.28,
    116232.49, 0.6991, 1392, 66816,
    1500.0, 500.0, 70049.36,
    48183.13, 0.2898, 'green', 'manager',
    40.0666, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 13855.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 13855.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 13855.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 13855.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 13855.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 13855.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 13855.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 13855.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 13855.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 13855.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 13855.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 13855.31, 8, 'spreadsheet_seed');

  -- [35/230] NCP
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
    true, 86436.21, 133, 649.9, 0.3643,
    99401.64, -12965.43,
    0, 0.3643,
    1296.52, 0, 0,
    86436.21, 2, 100,
    1296.52, 54948.07, 0, 54948.07, 31488.14,
    54948.07, 0.6357, 133, 6384,
    1500.0, 500.0, 9680.52,
    47267.55, 0.5468, 'green', 'manager',
    37.4572, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 7203.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 7203.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 7203.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 7203.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 7203.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 7203.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 7203.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 7203.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 7203.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 7203.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 7203.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 7203.02, 8, 'spreadsheet_seed');

  -- [36/230] Biga Limited
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
    true, 77682.22, 66, 1177.0, 0.3867,
    89334.55, -11652.33,
    0, 0.3867,
    2504.81, 0, 0,
    77682.22, 2, 100,
    2504.81, 47643.08, 0, 47643.08, 30039.14,
    47643.08, 0.6133, 66, 3168,
    1500.0, 500.0, 7672.81,
    41970.27, 0.5403, 'green', 'manager',
    17.7559, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 6473.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 6473.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 6473.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 6473.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 6473.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 6473.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 6473.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 6473.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 6473.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 6473.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 6473.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 6473.52, 8, 'spreadsheet_seed');

  -- [37/230] Bina Warehouse
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
    0, 0.5067,
    4250.52, 0, 0,
    103976.96, 2, 100,
    4250.52, 51290.94, 0, 51290.94, 52686.02,
    51290.94, 0.4933, 116, 5568,
    1500.0, 500.0, 11818.52,
    41472.42, 0.3989, 'green', 'manager',
    10.757, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 8664.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 8664.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 8664.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 8664.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 8664.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 8664.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 8664.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 8664.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 8664.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 8664.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 8664.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 8664.75, 8, 'spreadsheet_seed');

  -- [38/230] Eos Bathware
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
    true, 78161.31, 154, 507.54, 0.3597,
    89885.51, -11724.2,
    0, 0.3597,
    2962.67, 0, 0,
    78161.31, 2, 100,
    2962.67, 50045.99, 0, 50045.99, 28115.32,
    50045.99, 0.6403, 154, 7392,
    1500.0, 500.0, 12354.67,
    39691.32, 0.5078, 'green', 'manager',
    14.3971, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 6513.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 6513.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 6513.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 6513.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 6513.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 6513.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 6513.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 6513.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 6513.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 6513.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 6513.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 6513.44, 8, 'spreadsheet_seed');

  -- [39/230] Wentworth Tiles
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
    true, 62530.39, 97, 644.64, 0.291,
    71909.95, -9379.56,
    0.095, 0.291,
    972.17, 0, 0,
    62530.39, 2, 100,
    972.17, 44336.58, 59.4, 44277.18, 18193.81,
    44277.18, 0.614, 97, 4656,
    1500.0, 500.0, 7628.17,
    38649.01, 0.6181, 'green', 'manager',
    40.7554, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 5210.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 5210.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 5210.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 5210.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 5210.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 5210.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 5210.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 5210.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 5210.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 5210.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 5210.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 5210.87, 8, 'spreadsheet_seed');

  -- [40/230] Routleys Bathroom Kitchen Laundry
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
    0, 0.3319,
    1753.16, 0, 0,
    67895.73, 2, 100,
    1753.16, 45359.86, 0, 45359.86, 22535.87,
    45359.86, 0.6681, 114, 5472,
    1500.0, 500.0, 9225.16,
    38134.7, 0.5617, 'green', 'manager',
    22.752, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 5657.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 5657.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 5657.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 5657.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 5657.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 5657.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 5657.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 5657.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 5657.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 5657.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 5657.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 5657.98, 8, 'spreadsheet_seed');

  -- [41/230] Wellsons Plumbing and Bathroom Supplies
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
    true, 65022.57, 146, 445.36, 0.2961,
    74775.96, -9753.39,
    0, 0.2961,
    1822.68, 0, 0,
    65022.57, 2, 100,
    1822.68, 45767.16, 0, 45767.16, 19255.41,
    45767.16, 0.7039, 146, 7008,
    1500.0, 500.0, 10830.68,
    36936.48, 0.5681, 'green', 'manager',
    21.2649, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 5418.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 5418.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 5418.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 5418.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 5418.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 5418.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 5418.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 5418.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 5418.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 5418.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 5418.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 5418.55, 8, 'spreadsheet_seed');

  -- [42/230] Embracing Space
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
    0, 0.2187,
    383.08, 0, 0,
    47718.91, 2, 100,
    383.08, 37281.98, 0, 37281.98, 10436.93,
    37281.98, 0.7813, 16, 768,
    1500.0, 500.0, 3151.08,
    36130.9, 0.7572, 'green', 'manager',
    95.3169, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3976.58, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3976.58, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3976.58, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3976.58, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3976.58, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3976.58, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3976.58, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3976.58, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3976.58, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3976.58, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3976.58, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3976.58, 8, 'spreadsheet_seed');

  -- [43/230] Djati&Mastello B.V.
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
    true, 205516.29, 257, 799.67, 0.7597,
    236343.73, -30827.44,
    0, 0.7597,
    1007.08, 0, 0,
    205516.29, 2, 100,
    1007.08, 49395.08, 0, 49395.08, 156121.21,
    49395.08, 0.2403, 257, 12336,
    1500.0, 500.0, 15343.08,
    36052.0, 0.1754, 'green', 'manager',
    36.7985, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 17126.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 17126.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 17126.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 17126.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 17126.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 17126.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 17126.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 17126.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 17126.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 17126.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 17126.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 17126.36, 8, 'spreadsheet_seed');

  -- [44/230] Armanti Tiles and Bathroom
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
    0, 0.289,
    5062.58, 0, 0,
    59581.7, 2, 100,
    5062.58, 42362.7, 0, 42362.7, 17219.0,
    42362.7, 0.711, 80, 3840,
    1500.0, 500.0, 10902.58,
    33460.12, 0.5616, 'green', 'manager',
    7.6093, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4965.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4965.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4965.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4965.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4965.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4965.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4965.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4965.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4965.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4965.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4965.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4965.14, 8, 'spreadsheet_seed');

  -- [45/230] Portelli Home Centre
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
    true, 68182.22, 91, 749.26, 0.3787,
    78409.55, -10227.33,
    0, 0.3787,
    4818.02, 0, 0,
    68182.22, 2, 100,
    4818.02, 42361.07, 0, 42361.07, 25821.15,
    42361.07, 0.6213, 91, 4368,
    1500.0, 500.0, 11186.02,
    33175.05, 0.4866, 'green', 'manager',
    7.8856, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 5681.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 5681.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 5681.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 5681.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 5681.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 5681.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 5681.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 5681.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 5681.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 5681.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 5681.85, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 5681.85, 8, 'spreadsheet_seed');

  -- [46/230] W.Eagles Plumbing Supplies Pty Ltd
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
    true, 55064.01, 107, 514.62, 0.2876,
    63323.61, -8259.6,
    0, 0.2876,
    1277.27, 0, 0,
    55064.01, 2, 100,
    1277.27, 39229.47, 0, 39229.47, 15834.54,
    39229.47, 0.7124, 107, 5136,
    1500.0, 500.0, 8413.27,
    32816.2, 0.596, 'green', 'manager',
    26.6925, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4588.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4588.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4588.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4588.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4588.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4588.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4588.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4588.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4588.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4588.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4588.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4588.67, 8, 'spreadsheet_seed');

  -- [47/230] Gratico Tile and Bath
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
    true, 53790.87, 80, 672.39, 0.3254,
    61859.5, -8068.63,
    0, 0.3254,
    829.0, 0, 0,
    53790.87, 2, 100,
    829.0, 36286.19, 0, 36286.19, 17504.68,
    36286.19, 0.6746, 80, 3840,
    1500.0, 500.0, 6669.0,
    31617.19, 0.5878, 'green', 'manager',
    39.139, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4482.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4482.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4482.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4482.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4482.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4482.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4482.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4482.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4482.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4482.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4482.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4482.57, 8, 'spreadsheet_seed');

  -- [48/230] Burdens Plumbing
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
    true, 94339.32, 225, 419.29, 0.3695,
    108490.22, -14150.9,
    0, 0.3695,
    17463.6, 0, 0,
    94339.32, 2, 100,
    17463.6, 59480.09, 0, 59480.09, 34859.23,
    59480.09, 0.6305, 225, 10800,
    1500.0, 500.0, 30263.6,
    31216.49, 0.3309, 'green', 'cfo',
    2.7875, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 7861.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 7861.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 7861.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 7861.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 7861.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 7861.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 7861.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 7861.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 7861.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 7861.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 7861.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 7861.61, 8, 'spreadsheet_seed');

  -- [49/230] Hasl
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
    true, 49323.29, 52, 948.52, 0.2613,
    56721.78, -7398.49,
    0, 0.2613,
    3648.45, 0, 0,
    49323.29, 2, 100,
    3648.45, 36434.18, 0, 36434.18, 12889.11,
    36434.18, 0.7387, 52, 2496,
    1500.0, 500.0, 8144.45,
    30289.73, 0.6141, 'green', 'manager',
    9.3021, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4110.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4110.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4110.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4110.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4110.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4110.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4110.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4110.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4110.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4110.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4110.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4110.27, 8, 'spreadsheet_seed');

  -- [50/230] Regal Concept Design
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
    true, 47061.65, 49, 960.44, 0.2646,
    54120.9, -7059.25,
    0, 0.2646,
    1988.91, 0, 0,
    47061.65, 2, 100,
    1988.91, 34607.88, 0, 34607.88, 12453.77,
    34607.88, 0.7354, 49, 2352,
    1500.0, 500.0, 6340.91,
    30266.97, 0.6431, 'green', 'manager',
    16.2179, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3921.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3921.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3921.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3921.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3921.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3921.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3921.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3921.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3921.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3921.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3921.8, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3921.8, 8, 'spreadsheet_seed');

  -- [51/230] Cass Brothers
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
    0, 0.2915,
    167.11, 0, 0,
    46825.66, 2, 100,
    167.11, 33177.09, 0, 33177.09, 13648.57,
    33177.09, 0.7085, 65, 3120,
    1500.0, 500.0, 5287.11,
    29889.98, 0.6383, 'green', 'manager',
    179.8641, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3902.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3902.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3902.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3902.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3902.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3902.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3902.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3902.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3902.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3902.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3902.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3902.14, 8, 'spreadsheet_seed');

  -- [52/230] Ken''s Plumbing Plus
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
    0, 0.2855,
    38.4, 0, 0,
    44775.07, 2, 100,
    38.4, 31992.01, 0, 31992.01, 12783.06,
    31992.01, 0.7145, 44, 2112,
    1500.0, 500.0, 4150.4,
    29841.61, 0.6665, 'green', 'manager',
    778.1253, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3731.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3731.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3731.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3731.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3731.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3731.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3731.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3731.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3731.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3731.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3731.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3731.26, 8, 'spreadsheet_seed');

  -- [53/230] Art Bathrooms And Kitcheware Pty Ltd
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
    true, 53771.05, 72, 746.82, 0.3698,
    61836.71, -8065.66,
    0, 0.3698,
    1127.16, 0, 0,
    53771.05, 2, 100,
    1127.16, 33886.68, 0, 33886.68, 19884.37,
    33886.68, 0.6302, 72, 3456,
    1500.0, 500.0, 6583.16,
    29303.52, 0.545, 'green', 'manager',
    26.9977, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4480.92, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4480.92, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4480.92, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4480.92, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4480.92, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4480.92, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4480.92, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4480.92, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4480.92, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4480.92, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4480.92, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4480.92, 8, 'spreadsheet_seed');

  -- [54/230] Ceramico Tiles & Bathrooms
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
    0, 0.2733,
    793.35, 0, 0,
    42488.59, 2, 100,
    793.35, 30874.91, 0, 30874.91, 11613.68,
    30874.91, 0.7267, 25, 1200,
    1500.0, 500.0, 3993.35,
    28881.56, 0.6797, 'green', 'manager',
    37.4046, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3540.72, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3540.72, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3540.72, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3540.72, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3540.72, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3540.72, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3540.72, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3540.72, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3540.72, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3540.72, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3540.72, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3540.72, 8, 'spreadsheet_seed');

  -- [55/230] Fred Rose Bathrooms
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
    true, 42809.02, 42, 1019.26, 0.2873,
    49230.37, -6421.35,
    0, 0.2873,
    295.25, 0, 0,
    42809.02, 2, 100,
    295.25, 30508.31, 0, 30508.31, 12300.71,
    30508.31, 0.7127, 42, 2016,
    1500.0, 500.0, 4311.25,
    28197.06, 0.6587, 'green', 'manager',
    96.5023, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3567.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3567.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3567.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3567.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3567.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3567.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3567.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3567.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3567.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3567.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3567.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3567.42, 8, 'spreadsheet_seed');

  -- [56/230] Stocks Designer Appliances and Bathrooms
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
    true, 38481.88, 24, 1603.41, 0.2697,
    44254.16, -5772.28,
    0, 0.2697,
    342.33, 0, 0,
    38481.88, 2, 100,
    342.33, 28103.79, 0, 28103.79, 10378.09,
    28103.79, 0.7303, 24, 1152,
    1500.0, 500.0, 3494.33,
    26609.46, 0.6915, 'green', 'manager',
    78.7304, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3206.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3206.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3206.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3206.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3206.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3206.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3206.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3206.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3206.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3206.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3206.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3206.82, 8, 'spreadsheet_seed');

  -- [57/230] Mitre 10
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
    0, 0.3207,
    2844.88, 0, 0,
    48472.18, 2, 100,
    2844.88, 32927.55, 0, 32927.55, 15544.63,
    32927.55, 0.6793, 78, 3744,
    1500.0, 500.0, 8588.88,
    26338.67, 0.5434, 'green', 'manager',
    10.2583, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4039.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4039.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4039.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4039.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4039.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4039.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4039.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4039.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4039.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4039.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4039.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4039.35, 8, 'spreadsheet_seed');

  -- [58/230] Sunlight Bathrooms
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
    true, 51019.18, 141, 361.84, 0.3365,
    58672.06, -7652.88,
    0, 0.3365,
    1066.43, 0, 0,
    51019.18, 2, 100,
    1066.43, 33852.74, 0, 33852.74, 17166.44,
    33852.74, 0.6635, 141, 6768,
    1500.0, 500.0, 9834.43,
    26018.31, 0.51, 'green', 'manager',
    25.3976, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4251.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4251.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4251.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4251.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4251.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4251.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4251.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4251.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4251.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4251.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4251.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4251.6, 8, 'spreadsheet_seed');

  -- [59/230] The Renovation Hub
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
    true, 39654.09, 51, 777.53, 0.3007,
    45602.2, -5948.11,
    0, 0.3007,
    1416.91, 0, 0,
    39654.09, 2, 100,
    1416.91, 27728.68, 0, 27728.68, 11925.41,
    27728.68, 0.6993, 51, 2448,
    1500.0, 500.0, 5864.91,
    23863.77, 0.6018, 'green', 'manager',
    17.8421, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3304.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3304.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3304.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3304.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3304.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3304.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3304.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3304.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3304.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3304.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3304.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3304.51, 8, 'spreadsheet_seed');

  -- [60/230] Design Tiles
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
    true, 48786.83, 69, 707.06, 0.4019,
    56104.85, -7318.02,
    0, 0.4019,
    2225.14, 0, 0,
    48786.83, 2, 100,
    2225.14, 29179.17, 0, 29179.17, 19607.66,
    29179.17, 0.5981, 69, 3312,
    1500.0, 500.0, 7537.14,
    23642.03, 0.4846, 'green', 'manager',
    11.625, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4065.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4065.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4065.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4065.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4065.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4065.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4065.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4065.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4065.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4065.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4065.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4065.57, 8, 'spreadsheet_seed');

  -- [61/230] Ken Bathroom & Tiles
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
    true, 39913.45, 41, 973.5, 0.3485,
    45900.47, -5987.02,
    0, 0.3485,
    669.64, 0, 0,
    39913.45, 2, 100,
    669.64, 26002.13, 0, 26002.13, 13911.32,
    26002.13, 0.6515, 41, 1968,
    1500.0, 500.0, 4637.64,
    23364.49, 0.5854, 'green', 'manager',
    35.8911, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3326.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3326.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3326.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3326.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3326.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3326.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3326.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3326.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3326.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3326.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3326.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3326.12, 8, 'spreadsheet_seed');

  -- [62/230] Essential Building Supplies
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
    true, 41908.76, 25, 1676.35, 0.4075,
    48195.07, -6286.31,
    0, 0.4075,
    330.89, 0, 0,
    41908.76, 2, 100,
    330.89, 24832.57, 0, 24832.57, 17076.19,
    24832.57, 0.5925, 25, 1200,
    1500.0, 500.0, 3530.89,
    23301.68, 0.556, 'green', 'manager',
    71.4212, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3492.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3492.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3492.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3492.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3492.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3492.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3492.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3492.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3492.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3492.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3492.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3492.4, 8, 'spreadsheet_seed');

  -- [63/230] Spigot and More
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
    0, 0.3807,
    67.34, 0, 0,
    39914.25, 2, 100,
    67.34, 24719.95, 0, 24719.95, 15194.3,
    24719.95, 0.6193, 35, 1680,
    1500.0, 500.0, 3747.34,
    22972.61, 0.5755, 'green', 'manager',
    342.1436, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3326.19, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3326.19, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3326.19, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3326.19, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3326.19, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3326.19, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3326.19, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3326.19, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3326.19, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3326.19, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3326.19, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3326.19, 8, 'spreadsheet_seed');

  -- [64/230] Mandk Pte Ltd
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
    true, 99747.74, 157, 635.34, 0.5409,
    114709.9, -14962.16,
    0, 0.5409,
    15451.88, 0, 0,
    99747.74, 2, 100,
    15451.88, 45793.44, 0, 45793.44, 53954.3,
    45793.44, 0.4591, 157, 7536,
    1500.0, 500.0, 24987.88,
    22805.56, 0.2286, 'green', 'cfo',
    2.4759, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 8312.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 8312.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 8312.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 8312.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 8312.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 8312.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 8312.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 8312.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 8312.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 8312.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 8312.31, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 8312.31, 8, 'spreadsheet_seed');

  -- [65/230] MTS Bathroomware
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
    0, 0.2927,
    638.51, 0, 0,
    35965.47, 2, 100,
    638.51, 25438.53, 0, 25438.53, 10526.94,
    25438.53, 0.7073, 42, 2016,
    1500.0, 500.0, 4654.51,
    22784.02, 0.6335, 'green', 'manager',
    36.6831, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2997.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2997.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2997.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2997.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2997.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2997.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2997.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2997.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2997.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2997.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2997.12, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2997.12, 8, 'spreadsheet_seed');

  -- [66/230] Retail Customer
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
    true, 97549.86, 668, 146.03, 0.4191,
    112182.34, -14632.48,
    0, 0.4191,
    2100.62, 0, 0,
    97549.86, 2, 100,
    2100.62, 56670.41, 0, 56670.41, 40879.45,
    56670.41, 0.5809, 668, 32064,
    1500.0, 500.0, 36164.62,
    22505.79, 0.2307, 'green', 'manager',
    11.7139, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 8129.15, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 8129.15, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 8129.15, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 8129.15, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 8129.15, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 8129.15, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 8129.15, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 8129.15, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 8129.15, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 8129.15, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 8129.15, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 8129.15, 8, 'spreadsheet_seed');

  -- [67/230] Toowoomba Tiles
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
    0, 0.3165,
    1309.5, 0, 0,
    36412.9, 2, 100,
    1309.5, 24889.26, 0, 24889.26, 11523.64,
    24889.26, 0.6835, 31, 1488,
    1500.0, 500.0, 4797.5,
    22091.76, 0.6067, 'green', 'manager',
    17.8704, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3034.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3034.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3034.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3034.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3034.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3034.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3034.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3034.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3034.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3034.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3034.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3034.41, 8, 'spreadsheet_seed');

  -- [68/230] Topware
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
    true, 35965.06, 29, 1240.17, 0.3482,
    41359.82, -5394.76,
    0, 0.3482,
    332.78, 0, 0,
    35965.06, 2, 100,
    332.78, 23443.1, 0, 23443.1, 12521.96,
    23443.1, 0.6518, 29, 1392,
    1500.0, 500.0, 3724.78,
    21718.32, 0.6039, 'green', 'manager',
    66.2633, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2997.09, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2997.09, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2997.09, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2997.09, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2997.09, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2997.09, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2997.09, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2997.09, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2997.09, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2997.09, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2997.09, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2997.09, 8, 'spreadsheet_seed');

  -- [69/230] Tile House (previously AA Tiles)
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
    0, 0.3536,
    1687.34, 0, 0,
    38896.43, 2, 100,
    1687.34, 25141.21, 0, 25141.21, 13755.22,
    25141.21, 0.6464, 40, 1920,
    1500.0, 500.0, 5607.34,
    21533.87, 0.5536, 'green', 'manager',
    13.762, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3241.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3241.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3241.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3241.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3241.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3241.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3241.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3241.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3241.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3241.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3241.37, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3241.37, 8, 'spreadsheet_seed');

  -- [70/230] Cook''s Plumbing Supplies
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
    0, 0.25,
    375.77, 0, 0,
    30449.02, 2, 100,
    375.77, 22835.38, 0, 22835.38, 7613.64,
    22835.38, 0.75, 26, 1248,
    1500.0, 500.0, 3623.77,
    21211.61, 0.6966, 'green', 'manager',
    57.4484, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2537.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2537.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2537.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2537.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2537.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2537.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2537.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2537.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2537.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2537.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2537.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2537.42, 8, 'spreadsheet_seed');

  -- [71/230] Canberra Tile House
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
    true, 46523.28, 68, 684.17, 0.3642,
    53501.77, -6978.49,
    0, 0.3642,
    5711.91, 0, 0,
    46523.28, 2, 100,
    5711.91, 29579.32, 0, 29579.32, 16943.96,
    29579.32, 0.6358, 68, 3264,
    1500.0, 500.0, 10975.91,
    20603.41, 0.4429, 'green', 'manager',
    4.6071, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3876.94, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3876.94, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3876.94, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3876.94, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3876.94, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3876.94, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3876.94, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3876.94, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3876.94, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3876.94, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3876.94, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3876.94, 8, 'spreadsheet_seed');

  -- [72/230] Walkers
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
    0, 0.296,
    2275.6, 0, 0,
    33646.46, 2, 100,
    2275.6, 23687.94, 0, 23687.94, 9958.52,
    23687.94, 0.704, 40, 1920,
    1500.0, 500.0, 6195.6,
    19492.34, 0.5793, 'green', 'manager',
    9.5658, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2803.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2803.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2803.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2803.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2803.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2803.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2803.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2803.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2803.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2803.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2803.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2803.87, 8, 'spreadsheet_seed');

  -- [73/230] Melbourne Tile Gallery Tullamarine
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
    0, 0.3396,
    343.95, 0, 0,
    32603.93, 2, 100,
    343.95, 21531.13, 0, 21531.13, 11072.8,
    21531.13, 0.6604, 36, 1728,
    1500.0, 500.0, 4071.95,
    19459.18, 0.5968, 'green', 'manager',
    57.5756, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2716.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2716.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2716.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2716.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2716.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2716.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2716.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2716.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2716.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2716.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2716.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2716.99, 8, 'spreadsheet_seed');

  -- [74/230] K & R Plumbing Supplies
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
    true, 29548.01, 33, 895.39, 0.2787,
    33980.21, -4432.2,
    0, 0.2787,
    275.94, 0, 0,
    29548.01, 2, 100,
    275.94, 21314.27, 0, 21314.27, 8233.74,
    21314.27, 0.7213, 33, 1584,
    1500.0, 500.0, 3859.94,
    19454.33, 0.6584, 'green', 'manager',
    71.502, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2462.33, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2462.33, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2462.33, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2462.33, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2462.33, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2462.33, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2462.33, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2462.33, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2462.33, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2462.33, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2462.33, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2462.33, 8, 'spreadsheet_seed');

  -- [75/230] Luscombe Tiles
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
    true, 39682.12, 78, 508.75, 0.299,
    45634.44, -5952.32,
    0, 0.299,
    4802.01, 0, 0,
    39682.12, 2, 100,
    4802.01, 27816.16, 0, 27816.16, 11865.96,
    27816.16, 0.701, 78, 3744,
    1500.0, 500.0, 10546.01,
    19270.15, 0.4856, 'green', 'manager',
    5.0129, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3306.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3306.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3306.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3306.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3306.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3306.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3306.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3306.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3306.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3306.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3306.84, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3306.84, 8, 'spreadsheet_seed');

  -- [76/230] Phillips Tiles
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
    0, 0.4185,
    4451.25, 0, 0,
    44046.22, 2, 100,
    4451.25, 25613.96, 0, 25613.96, 18432.26,
    25613.96, 0.5815, 62, 2976,
    1500.0, 500.0, 9427.25,
    18186.71, 0.4129, 'green', 'manager',
    5.0858, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3670.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3670.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3670.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3670.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3670.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3670.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3670.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3670.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3670.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3670.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3670.52, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3670.52, 8, 'spreadsheet_seed');

  -- [77/230] Tile Gallery Aus Pty Ltd
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
    true, 30393.81, 24, 1266.41, 0.3259,
    34952.88, -4559.07,
    0, 0.3259,
    1537.03, 0, 0,
    30393.81, 2, 100,
    1537.03, 20488.04, 0, 20488.04, 9905.77,
    20488.04, 0.6741, 24, 1152,
    1500.0, 500.0, 4689.03,
    17799.01, 0.5856, 'green', 'manager',
    12.5801, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2532.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2532.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2532.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2532.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2532.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2532.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2532.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2532.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2532.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2532.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2532.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2532.82, 8, 'spreadsheet_seed');

  -- [78/230] Pambula Tiles
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
    true, 27681.79, 40, 692.04, 0.3039,
    31834.06, -4152.27,
    0, 0.3039,
    1075.13, 0, 0,
    27681.79, 2, 100,
    1075.13, 19269.58, 0, 19269.58, 8412.21,
    19269.58, 0.6961, 40, 1920,
    1500.0, 500.0, 4995.13,
    16274.45, 0.5879, 'green', 'manager',
    16.1372, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2306.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2306.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2306.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2306.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2306.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2306.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2306.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2306.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2306.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2306.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2306.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2306.82, 8, 'spreadsheet_seed');

  -- [79/230] Derwent Park Plumbing
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
    0, 0.3153,
    299.44, 0, 0,
    24970.52, 2, 100,
    299.44, 17097.32, 0, 17097.32, 7873.2,
    17097.32, 0.6847, 23, 1104,
    1500.0, 500.0, 3403.44,
    15693.88, 0.6285, 'green', 'manager',
    53.4108, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2080.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2080.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2080.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2080.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2080.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2080.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2080.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2080.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2080.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2080.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2080.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2080.88, 8, 'spreadsheet_seed');

  -- [80/230] YT Bathroom
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
    true, 22215.11, 13, 1708.85, 0.2489,
    25547.38, -3332.27,
    0.095, 0.2489,
    395.1, 0, 0,
    22215.11, 2, 100,
    395.1, 16686.03, 21.1, 16664.93, 5529.08,
    16664.93, 0.6561, 13, 624,
    1500.0, 500.0, 3019.1,
    15645.83, 0.7043, 'green', 'manager',
    40.5997, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1851.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1851.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1851.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1851.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1851.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1851.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1851.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1851.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1851.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1851.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1851.26, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1851.26, 8, 'spreadsheet_seed');

  -- [81/230] Kents H Hardware
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
    true, 24834.14, 29, 856.35, 0.2984,
    28559.26, -3725.12,
    0, 0.2984,
    488.3, 0, 0,
    24834.14, 2, 100,
    488.3, 17423.92, 0, 17423.92, 7410.22,
    17423.92, 0.7016, 29, 1392,
    1500.0, 500.0, 3880.3,
    15543.62, 0.6259, 'green', 'manager',
    32.8321, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2069.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2069.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2069.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2069.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2069.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2069.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2069.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2069.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2069.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2069.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2069.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2069.51, 8, 'spreadsheet_seed');

  -- [82/230] Trade Warehouse Direct
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
    true, 35599.23, 127, 280.31, 0.3862,
    40939.11, -5339.88,
    0, 0.3862,
    315.16, 0, 0,
    35599.23, 2, 100,
    315.16, 21851.1, 0, 21851.1, 13748.13,
    21851.1, 0.6138, 127, 6096,
    1500.0, 500.0, 8411.16,
    15439.94, 0.4337, 'green', 'manager',
    49.9908, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2966.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2966.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2966.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2966.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2966.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2966.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2966.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2966.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2966.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2966.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2966.6, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2966.6, 8, 'spreadsheet_seed');

  -- [83/230] Vision Bathroom Supplies
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
    391.29, 16140.4, 21.31, 16119.09, 6287.12,
    16119.09, 0.6247, 14, 672,
    1500.0, 500.0, 3063.29,
    15055.8, 0.6713, 'green', 'manager',
    39.4774, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1868.96, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1868.96, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1868.96, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1868.96, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1868.96, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1868.96, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1868.96, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1868.96, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1868.96, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1868.96, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1868.96, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1868.96, 8, 'spreadsheet_seed');

  -- [84/230] Naturally Tiles & Bathware
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
    539.04, 18595.19, 24.75, 18570.44, 7460.07,
    18570.44, 0.6187, 63, 3024,
    1500.0, 500.0, 5563.04,
    15007.4, 0.576, 'green', 'manager',
    28.841, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2171.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2171.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2171.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2171.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2171.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2171.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2171.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2171.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2171.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2171.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2171.27, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2171.27, 8, 'spreadsheet_seed');

  -- [85/230] Motif
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
    0, 0.2929,
    46.5, 0, 0,
    22456.09, 2, 100,
    46.5, 15879.62, 0, 15879.62, 6576.47,
    15879.62, 0.7071, 29, 1392,
    1500.0, 500.0, 3438.5,
    14441.12, 0.6431, 'green', 'manager',
    311.5617, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1871.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1871.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1871.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1871.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1871.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1871.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1871.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1871.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1871.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1871.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1871.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1871.34, 8, 'spreadsheet_seed');

  -- [86/230] Elenni Kitchen & Bathroom Collection
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
    true, 38692.19, 62, 624.07, 0.3688,
    44496.02, -5803.83,
    0, 0.3688,
    7182.89, 0, 0,
    38692.19, 2, 100,
    7182.89, 24422.75, 0, 24422.75, 14269.44,
    24422.75, 0.6312, 62, 2976,
    1500.0, 500.0, 12158.89,
    14263.86, 0.3686, 'green', 'manager',
    2.9858, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 3224.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 3224.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 3224.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 3224.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 3224.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 3224.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 3224.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 3224.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 3224.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 3224.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 3224.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 3224.35, 8, 'spreadsheet_seed');

  -- [87/230] Seven Days Plumbing
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
    true, 29044.75, 63, 461.03, 0.3635,
    33401.46, -4356.71,
    0, 0.3635,
    1310.74, 0, 0,
    29044.75, 2, 100,
    1310.74, 18487.51, 0, 18487.51, 10557.24,
    18487.51, 0.6365, 63, 3024,
    1500.0, 500.0, 6334.74,
    14152.77, 0.4873, 'green', 'manager',
    11.7975, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2420.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2420.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2420.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2420.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2420.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2420.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2420.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2420.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2420.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2420.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2420.4, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2420.4, 8, 'spreadsheet_seed');

  -- [88/230] All Bathroom Gear
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
    0, 0.3145,
    1068.7, 0, 0,
    22906.97, 2, 100,
    1068.7, 15703.46, 0, 15703.46, 7203.51,
    15703.46, 0.6855, 14, 672,
    1500.0, 500.0, 3740.7,
    13962.76, 0.6095, 'green', 'manager',
    14.0652, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1908.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1908.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1908.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1908.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1908.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1908.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1908.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1908.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1908.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1908.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1908.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1908.91, 8, 'spreadsheet_seed');

  -- [89/230] Schots Home Emporium - Clifton Hill
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
    true, 54184.99, 265, 204.47, 0.3728,
    62312.74, -8127.75,
    0, 0.3728,
    7514.52, 0, 0,
    54184.99, 2, 100,
    7514.52, 33983.21, 0, 33983.21, 20201.78,
    33983.21, 0.6272, 265, 12720,
    1500.0, 500.0, 22234.52,
    13748.69, 0.2537, 'green', 'manager',
    2.8296, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4515.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4515.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4515.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4515.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4515.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4515.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4515.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4515.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4515.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4515.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4515.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4515.42, 8, 'spreadsheet_seed');

  -- [90/230] QA Bathroom Warehouse
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
    true, 21676.17, 31, 699.23, 0.2825,
    24927.6, -3251.43,
    0, 0.2825,
    451.69, 0, 0,
    21676.17, 2, 100,
    451.69, 15552.44, 0, 15552.44, 6123.73,
    15552.44, 0.7175, 31, 1488,
    1500.0, 500.0, 3939.69,
    13612.75, 0.628, 'green', 'manager',
    31.1374, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1806.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1806.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1806.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1806.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1806.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1806.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1806.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1806.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1806.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1806.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1806.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1806.35, 8, 'spreadsheet_seed');

  -- [91/230] Watertek
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
    0, 0.2693,
    804.21, 0, 0,
    20762.98, 2, 100,
    804.21, 15172.08, 0, 15172.08, 5590.9,
    15172.08, 0.7307, 16, 768,
    1500.0, 500.0, 3572.21,
    13599.87, 0.655, 'green', 'manager',
    17.9108, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1730.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1730.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1730.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1730.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1730.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1730.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1730.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1730.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1730.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1730.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1730.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1730.25, 8, 'spreadsheet_seed');

  -- [92/230] The Bathroom Biz
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
    0, 0.256,
    393.59, 0, 0,
    19670.83, 2, 100,
    393.59, 14634.2, 0, 14634.2, 5036.63,
    14634.2, 0.744, 15, 720,
    1500.0, 500.0, 3113.59,
    13520.61, 0.6873, 'green', 'manager',
    35.352, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1639.24, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1639.24, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1639.24, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1639.24, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1639.24, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1639.24, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1639.24, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1639.24, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1639.24, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1639.24, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1639.24, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1639.24, 8, 'spreadsheet_seed');

  -- [93/230] Hot & Cold Outlet (Engadine Plumbing)
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
    true, 19674.07, 11, 1788.55, 0.2741,
    22625.18, -2951.11,
    0.095, 0.2741,
    224.3, 0, 0,
    19674.07, 2, 100,
    224.3, 14281.01, 18.69, 14262.32, 5393.06,
    14262.32, 0.6309, 11, 528,
    1500.0, 500.0, 2752.3,
    13510.02, 0.6867, 'green', 'manager',
    61.2319, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1639.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1639.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1639.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1639.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1639.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1639.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1639.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1639.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1639.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1639.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1639.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1639.51, 8, 'spreadsheet_seed');

  -- [94/230] Designer Bathrooms Plus
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
    true, 19776.69, 18, 1098.71, 0.2603,
    22743.19, -2966.5,
    0.095, 0.2603,
    434.59, 0, 0,
    19776.69, 2, 100,
    434.59, 14628.76, 18.79, 14609.97, 5147.93,
    14609.97, 0.6447, 18, 864,
    1500.0, 500.0, 3298.59,
    13311.38, 0.6731, 'green', 'manager',
    31.6297, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1648.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1648.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1648.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1648.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1648.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1648.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1648.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1648.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1648.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1648.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1648.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1648.06, 8, 'spreadsheet_seed');

  -- [95/230] In Haus Living
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
    true, 60213.31, 110, 547.39, 0.4195,
    69245.31, -9032.0,
    0, 0.4195,
    16380.14, 0, 0,
    60213.31, 2, 100,
    16380.14, 34956.37, 0, 34956.37, 25256.94,
    34956.37, 0.5805, 110, 5280,
    1500.0, 500.0, 23660.14,
    13296.23, 0.2208, 'green', 'cfo',
    1.8117, 'marginal'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 5017.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 5017.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 5017.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 5017.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 5017.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 5017.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 5017.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 5017.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 5017.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 5017.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 5017.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 5017.78, 8, 'spreadsheet_seed');

  -- [96/230] Trade Sync Group
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
    1082.89, 16251.45, 21.52, 16229.93, 6404.46,
    16229.93, 0.6223, 39, 1872,
    1500.0, 500.0, 4954.89,
    13275.04, 0.5859, 'green', 'manager',
    13.2589, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1887.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1887.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1887.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1887.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1887.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1887.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1887.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1887.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1887.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1887.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1887.99, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1887.99, 8, 'spreadsheet_seed');

  -- [97/230] Flat Hill Studio
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
    0, 0.2243,
    296.18, 0, 0,
    19102.53, 2, 100,
    296.18, 14818.42, 0, 14818.42, 4284.11,
    14818.42, 0.7757, 26, 1248,
    1500.0, 500.0, 3544.18,
    13274.24, 0.6949, 'green', 'manager',
    45.8182, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1591.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1591.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1591.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1591.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1591.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1591.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1591.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1591.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1591.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1591.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1591.88, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1591.88, 8, 'spreadsheet_seed');

  -- [98/230] Beri Distributors Pty Ltd
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
    0, 0.27,
    923.08, 0, 0,
    21067.31, 2, 100,
    923.08, 15378.29, 0, 15378.29, 5689.02,
    15378.29, 0.73, 32, 1536,
    1500.0, 500.0, 4459.08,
    12919.21, 0.6132, 'green', 'manager',
    14.9958, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1755.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1755.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1755.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1755.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1755.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1755.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1755.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1755.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1755.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1755.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1755.61, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1755.61, 8, 'spreadsheet_seed');

  -- [99/230] Oxford and Nelson
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
    true, 25703.79, 102, 252.0, 0.2748,
    29559.36, -3855.57,
    0, 0.2748,
    967.75, 0, 0,
    25703.79, 2, 100,
    967.75, 18640.94, 0, 18640.94, 7062.85,
    18640.94, 0.7252, 102, 4896,
    1500.0, 500.0, 7863.75,
    12777.19, 0.4971, 'green', 'manager',
    14.203, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2141.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2141.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2141.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2141.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2141.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2141.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2141.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2141.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2141.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2141.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2141.98, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2141.98, 8, 'spreadsheet_seed');

  -- [100/230] Bathroom Collective
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
    true, 22344.33, 29, 770.49, 0.3543,
    25695.98, -3351.65,
    0.095, 0.3543,
    370.2, 0, 0,
    22344.33, 2, 100,
    370.2, 14426.96, 21.23, 14405.73, 7917.37,
    14405.73, 0.5507, 29, 1392,
    1500.0, 500.0, 3762.2,
    12643.53, 0.5658, 'green', 'manager',
    35.1532, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1862.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1862.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1862.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1862.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1862.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1862.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1862.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1862.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1862.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1862.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1862.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1862.03, 8, 'spreadsheet_seed');

  -- [101/230] Tap and Sink Contemporary Living
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
    true, 55913.08, 182, 307.21, 0.4545,
    64300.04, -8386.96,
    0, 0.4545,
    9280.68, 0, 0,
    55913.08, 2, 100,
    9280.68, 30497.89, 0, 30497.89, 25415.19,
    30497.89, 0.5455, 182, 8736,
    1500.0, 500.0, 20016.68,
    12481.21, 0.2232, 'green', 'manager',
    2.3449, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4659.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4659.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4659.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4659.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4659.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4659.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4659.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4659.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4659.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4659.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4659.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4659.42, 8, 'spreadsheet_seed');

  -- [102/230] Plumbcorp
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
    true, 20001.39, 29, 689.7, 0.3127,
    23001.6, -3000.21,
    0, 0.3127,
    375.88, 0, 0,
    20001.39, 2, 100,
    375.88, 13746.5, 0, 13746.5, 6254.89,
    13746.5, 0.6873, 29, 1392,
    1500.0, 500.0, 3767.88,
    11978.62, 0.5989, 'green', 'manager',
    32.8682, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1666.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1666.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1666.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1666.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1666.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1666.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1666.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1666.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1666.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1666.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1666.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1666.78, 8, 'spreadsheet_seed');

  -- [103/230] JusTiles Sydney - Padstow
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
    0, 0.3394,
    350.4, 0, 0,
    20876.98, 2, 100,
    350.4, 13790.64, 0, 13790.64, 7086.34,
    13790.64, 0.6606, 32, 1536,
    1500.0, 500.0, 3886.4,
    11904.24, 0.5702, 'green', 'manager',
    34.9733, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1739.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1739.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1739.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1739.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1739.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1739.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1739.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1739.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1739.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1739.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1739.75, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1739.75, 8, 'spreadsheet_seed');

  -- [104/230] Royal Vanities
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
    true, 24701.93, 65, 380.03, 0.3311,
    28407.22, -3705.29,
    0, 0.3311,
    1520.98, 0, 0,
    24701.93, 2, 100,
    1520.98, 16524.01, 0, 16524.01, 8177.92,
    16524.01, 0.6689, 65, 3120,
    1500.0, 500.0, 6640.98,
    11883.03, 0.4811, 'green', 'manager',
    8.8127, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2058.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2058.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2058.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2058.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2058.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2058.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2058.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2058.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2058.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2058.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2058.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2058.49, 8, 'spreadsheet_seed');

  -- [105/230] 7to7 Bathrooms Pty Ltd
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
    true, 20296.33, 21, 966.49, 0.3077,
    23340.78, -3044.45,
    0, 0.3077,
    1480.45, 0, 0,
    20296.33, 2, 100,
    1480.45, 14050.22, 0, 14050.22, 6246.11,
    14050.22, 0.6923, 21, 1008,
    1500.0, 500.0, 4488.45,
    11561.77, 0.5696, 'green', 'manager',
    8.8096, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1691.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1691.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1691.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1691.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1691.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1691.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1691.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1691.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1691.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1691.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1691.36, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1691.36, 8, 'spreadsheet_seed');

  -- [106/230] Cook & Bathe
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
    0, 0.2881,
    194.83, 0, 0,
    19502.63, 2, 100,
    194.83, 13884.12, 0, 13884.12, 5618.51,
    13884.12, 0.7119, 45, 2160,
    1500.0, 500.0, 4354.83,
    11529.29, 0.5912, 'green', 'manager',
    60.1762, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1625.22, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1625.22, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1625.22, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1625.22, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1625.22, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1625.22, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1625.22, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1625.22, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1625.22, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1625.22, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1625.22, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1625.22, 8, 'spreadsheet_seed');

  -- [107/230] Home Emporium Singleton (Buildtell Services)
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
    true, 21113.98, 22, 959.73, 0.4148,
    24281.08, -3167.1,
    0, 0.4148,
    98.48, 0, 0,
    21113.98, 2, 100,
    98.48, 12356.76, 0, 12356.76, 8757.22,
    12356.76, 0.5852, 22, 1056,
    1500.0, 500.0, 3154.48,
    11202.28, 0.5306, 'green', 'manager',
    114.7518, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1759.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1759.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1759.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1759.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1759.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1759.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1759.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1759.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1759.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1759.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1759.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1759.5, 8, 'spreadsheet_seed');

  -- [108/230] Tuck Plumbing Fixtures - Plumbtec
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
    0, 0.3161,
    22.08, 0, 0,
    18344.18, 2, 100,
    22.08, 12545.44, 0, 12545.44, 5798.74,
    12545.44, 0.6839, 33, 1584,
    1500.0, 500.0, 3606.08,
    10939.36, 0.5963, 'green', 'manager',
    496.442, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1528.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1528.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1528.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1528.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1528.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1528.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1528.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1528.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1528.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1528.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1528.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1528.68, 8, 'spreadsheet_seed');

  -- [109/230] Swan Street Sales
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
    true, 26361.44, 115, 229.23, 0.3914,
    30315.66, -3954.22,
    0, 0.3914,
    0.83, 0, 0,
    26361.44, 2, 100,
    0.83, 16042.37, 0, 16042.37, 10319.07,
    16042.37, 0.6086, 115, 5520,
    1500.0, 500.0, 7520.83,
    10521.54, 0.3991, 'green', 'manager',
    9999.9999, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2196.79, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2196.79, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2196.79, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2196.79, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2196.79, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2196.79, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2196.79, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2196.79, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2196.79, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2196.79, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2196.79, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2196.79, 8, 'spreadsheet_seed');

  -- [110/230] Retravision Commercial
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
    true, 19706.58, 13, 1515.89, 0.4373,
    22662.57, -2955.99,
    0, 0.4373,
    49.46, 0, 0,
    19706.58, 2, 100,
    49.46, 11088.43, 0, 11088.43, 8618.15,
    11088.43, 0.5627, 13, 624,
    1500.0, 500.0, 2673.46,
    10414.97, 0.5285, 'green', 'manager',
    211.5736, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1642.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1642.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1642.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1642.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1642.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1642.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1642.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1642.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1642.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1642.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1642.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1642.21, 8, 'spreadsheet_seed');

  -- [111/230] Camberwell Bathrooms
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
    true, 18266.43, 29, 629.88, 0.3597,
    21006.39, -2739.96,
    0.095, 0.3597,
    263.53, 0, 0,
    18266.43, 2, 100,
    263.53, 11695.24, 17.35, 11677.89, 6571.19,
    11677.89, 0.5453, 29, 1392,
    1500.0, 500.0, 3655.53,
    10022.36, 0.5487, 'green', 'manager',
    39.0312, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1522.2, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1522.2, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1522.2, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1522.2, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1522.2, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1522.2, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1522.2, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1522.2, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1522.2, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1522.2, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1522.2, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1522.2, 8, 'spreadsheet_seed');

  -- [112/230] ONE ONE CAPITAL GENERAL TRADING LLC
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
    true, 58889.01, 41, 1436.32, 0.4556,
    67722.36, -8833.35,
    0, 0.4556,
    20602.59, 0, 0,
    58889.01, 2, 100,
    20602.59, 32060.19, 0, 32060.19, 26828.82,
    32060.19, 0.5444, 41, 1968,
    1500.0, 500.0, 24570.59,
    9489.6, 0.1611, 'green', 'cfo',
    1.4606, 'marginal'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 4907.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 4907.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 4907.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 4907.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 4907.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 4907.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 4907.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 4907.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 4907.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 4907.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 4907.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 4907.42, 8, 'spreadsheet_seed');

  -- [113/230] Swiftwood Tiles & Bathrooms
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
    true, 14901.19, 27, 551.9, 0.267,
    17136.37, -2235.18,
    0, 0.267,
    210.34, 0, 0,
    14901.19, 2, 100,
    210.34, 10922.72, 0, 10922.72, 3978.47,
    10922.72, 0.733, 27, 1296,
    1500.0, 500.0, 3506.34,
    9416.38, 0.6319, 'green', 'manager',
    45.7674, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1241.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1241.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1241.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1241.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1241.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1241.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1241.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1241.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1241.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1241.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1241.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1241.77, 8, 'spreadsheet_seed');

  -- [114/230] Coastal Tiles
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
    true, 14594.04, 28, 521.22, 0.2887,
    16783.15, -2189.11,
    0, 0.2887,
    120.35, 0, 0,
    14594.04, 2, 100,
    120.35, 10380.74, 0, 10380.74, 4213.3,
    10380.74, 0.7113, 28, 1344,
    1500.0, 500.0, 3464.35,
    8916.39, 0.611, 'green', 'manager',
    75.0872, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1216.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1216.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1216.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1216.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1216.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1216.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1216.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1216.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1216.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1216.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1216.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1216.17, 8, 'spreadsheet_seed');

  -- [115/230] Cargo Bathroom and Kitchens
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
    2339.1, 12663.06, 17.51, 12645.55, 5770.65,
    12645.55, 0.592, 30, 1440,
    1500.0, 500.0, 5779.1,
    8866.45, 0.481, 'green', 'manager',
    4.7905, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1536.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1536.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1536.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1536.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1536.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1536.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1536.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1536.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1536.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1536.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1536.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1536.14, 8, 'spreadsheet_seed');

  -- [116/230] INTERO T/A THE KITCHEN HUB (AUD) (Formerly Change Agent Limited)
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
    true, 25988.2, 79, 328.96, 0.5066,
    29886.43, -3898.23,
    0, 0.5066,
    229.55, 0, 0,
    25988.2, 2, 100,
    229.55, 12821.43, 0, 12821.43, 13166.77,
    12821.43, 0.4934, 79, 3792,
    1500.0, 500.0, 6021.55,
    8799.88, 0.3386, 'green', 'manager',
    39.3354, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2165.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2165.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2165.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2165.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2165.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2165.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2165.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2165.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2165.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2165.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2165.68, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2165.68, 8, 'spreadsheet_seed');

  -- [117/230] Romano Indoor & Outdoor Solutions
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
    true, 13768.24, 20, 688.41, 0.2966,
    15833.48, -2065.24,
    0.095, 0.2966,
    93.6, 0, 0,
    13768.24, 2, 100,
    93.6, 9684.01, 13.08, 9670.93, 4084.23,
    9670.93, 0.6084, 20, 960,
    1500.0, 500.0, 3053.6,
    8617.33, 0.6259, 'green', 'manager',
    93.0655, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1147.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1147.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1147.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1147.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1147.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1147.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1147.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1147.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1147.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1147.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1147.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1147.35, 8, 'spreadsheet_seed');

  -- [118/230] Riverina Home Centre
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
    0, 0.2897,
    209.18, 0, 0,
    12805.24, 2, 100,
    209.18, 9095.21, 0, 9095.21, 3710.03,
    9095.21, 0.7103, 9, 432,
    1500.0, 500.0, 2641.18,
    8454.03, 0.6602, 'green', 'manager',
    41.4151, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1067.1, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1067.1, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1067.1, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1067.1, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1067.1, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1067.1, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1067.1, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1067.1, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1067.1, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1067.1, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1067.1, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1067.1, 8, 'spreadsheet_seed');

  -- [119/230] TI Home Improvement Centre (Formerly Tile Importer)
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
    true, 14548.57, 43, 338.34, 0.3144,
    16730.86, -2182.29,
    0, 0.3144,
    82.81, 0, 0,
    14548.57, 2, 100,
    82.81, 9974.54, 0, 9974.54, 4574.03,
    9974.54, 0.6856, 43, 2064,
    1500.0, 500.0, 4146.81,
    7827.73, 0.538, 'green', 'manager',
    95.5264, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1212.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1212.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1212.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1212.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1212.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1212.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1212.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1212.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1212.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1212.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1212.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1212.38, 8, 'spreadsheet_seed');

  -- [120/230] Revive Bathroom Supplies
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
    305.21, 9021.62, 12.21, 9009.41, 3831.66,
    9009.41, 0.6069, 24, 1152,
    1500.0, 500.0, 3457.21,
    7552.2, 0.5876, 'green', 'manager',
    25.7443, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1071.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1071.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1071.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1071.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1071.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1071.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1071.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1071.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1071.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1071.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1071.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1071.11, 8, 'spreadsheet_seed');

  -- [121/230] Cerastone Surfaces
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
    true, 19718.11, 56, 352.11, 0.3757,
    22675.83, -2957.72,
    0, 0.3757,
    2081.23, 0, 0,
    19718.11, 2, 100,
    2081.23, 12310.8, 0, 12310.8, 7407.31,
    12310.8, 0.6243, 56, 2688,
    1500.0, 500.0, 6769.23,
    7541.57, 0.3825, 'green', 'manager',
    4.6236, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1643.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1643.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1643.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1643.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1643.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1643.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1643.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1643.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1643.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1643.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1643.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1643.18, 8, 'spreadsheet_seed');

  -- [122/230] Thrifty Bathrooms and Plumbing
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
    true, 13458.05, 21, 640.86, 0.3717,
    15476.76, -2018.71,
    0, 0.3717,
    56.57, 0, 0,
    13458.05, 2, 100,
    56.57, 8455.31, 0, 8455.31, 5002.74,
    8455.31, 0.6283, 21, 1008,
    1500.0, 500.0, 3064.57,
    7390.74, 0.5492, 'green', 'manager',
    131.6477, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1121.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1121.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1121.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1121.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1121.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1121.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1121.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1121.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1121.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1121.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1121.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1121.5, 8, 'spreadsheet_seed');

  -- [123/230] Lexatonia Tiles Melbourne (Formally Bathroom Nation)
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
    true, 12448.17, 16, 778.01, 0.2616,
    14315.4, -1867.23,
    0, 0.2616,
    1212.58, 0, 0,
    12448.17, 2, 100,
    1212.58, 9192.13, 0, 9192.13, 3256.04,
    9192.13, 0.7384, 16, 768,
    1500.0, 500.0, 3980.58,
    7211.55, 0.5793, 'green', 'manager',
    6.9473, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1037.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1037.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1037.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1037.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1037.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1037.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1037.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1037.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1037.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1037.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1037.35, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1037.35, 8, 'spreadsheet_seed');

  -- [124/230] IBuild Group NSW (Home Renovation Studio)
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
    0, 0.3608,
    438.03, 0, 0,
    13609.35, 2, 100,
    438.03, 8699.07, 0, 8699.07, 4910.28,
    8699.07, 0.6392, 23, 1104,
    1500.0, 500.0, 3542.03,
    7157.04, 0.5259, 'green', 'manager',
    17.3392, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1134.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1134.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1134.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1134.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1134.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1134.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1134.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1134.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1134.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1134.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1134.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1134.11, 8, 'spreadsheet_seed');

  -- [125/230] Terry Brothers Bathrooms
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
    true, 9591.3, 5, 1918.26, 0.2474,
    11030.0, -1438.69,
    0.095, 0.2474,
    426.53, 0, 0,
    9591.3, 2, 100,
    426.53, 7218.01, 9.11, 7208.9, 2373.29,
    7208.9, 0.6576, 5, 240,
    1500.0, 500.0, 2666.53,
    6542.37, 0.6821, 'green', 'manager',
    16.3386, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 799.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 799.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 799.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 799.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 799.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 799.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 799.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 799.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 799.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 799.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 799.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 799.28, 8, 'spreadsheet_seed');

  -- [126/230] Veejay''s Renovations
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
    true, 9432.7, 8, 1179.09, 0.2732,
    10847.6, -1414.9,
    0, 0.2732,
    43.7, 0, 0,
    9432.7, 2, 100,
    43.7, 6855.66, 0, 6855.66, 2577.04,
    6855.66, 0.7268, 8, 384,
    1500.0, 500.0, 2427.7,
    6427.96, 0.6815, 'green', 'manager',
    148.0929, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 786.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 786.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 786.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 786.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 786.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 786.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 786.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 786.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 786.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 786.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 786.06, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 786.06, 8, 'spreadsheet_seed');

  -- [127/230] Big River Trade Centre
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
    true, 10050.13, 14, 717.87, 0.2661,
    11557.65, -1507.52,
    0.095, 0.2661,
    293.95, 0, 0,
    10050.13, 2, 100,
    293.95, 7376.0, 9.55, 7366.45, 2674.13,
    7366.45, 0.6389, 14, 672,
    1500.0, 500.0, 2965.95,
    6400.5, 0.6369, 'green', 'manager',
    22.7741, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 837.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 837.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 837.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 837.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 837.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 837.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 837.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 837.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 837.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 837.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 837.51, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 837.51, 8, 'spreadsheet_seed');

  -- [128/230] Bathroom International
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
    true, 10132.94, 15, 675.53, 0.2801,
    11652.88, -1519.94,
    0, 0.2801,
    350.42, 0, 0,
    10132.94, 2, 100,
    350.42, 7295.2, 0, 7295.2, 2837.74,
    7295.2, 0.7199, 15, 720,
    1500.0, 500.0, 3070.42,
    6224.78, 0.6143, 'green', 'manager',
    18.7638, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 844.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 844.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 844.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 844.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 844.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 844.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 844.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 844.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 844.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 844.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 844.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 844.41, 8, 'spreadsheet_seed');

  -- [129/230] Bathroom Kitchen Home
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
    0, 0.2922,
    160.71, 0, 0,
    9542.5, 2, 100,
    160.71, 6753.75, 0, 6753.75, 2788.75,
    6753.75, 0.7078, 9, 432,
    1500.0, 500.0, 2592.71,
    6161.04, 0.6456, 'green', 'manager',
    39.3364, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 795.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 795.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 795.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 795.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 795.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 795.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 795.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 795.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 795.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 795.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 795.21, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 795.21, 8, 'spreadsheet_seed');

  -- [130/230] My Tile Co - Woy Woy
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
    true, 10937.82, 14, 781.27, 0.2782,
    12578.49, -1640.67,
    0, 0.2782,
    1065.8, 0, 0,
    10937.82, 2, 100,
    1065.8, 7894.68, 0, 7894.68, 3043.14,
    7894.68, 0.7218, 14, 672,
    1500.0, 500.0, 3737.8,
    6156.88, 0.5629, 'green', 'manager',
    6.7768, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 911.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 911.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 911.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 911.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 911.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 911.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 911.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 911.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 911.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 911.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 911.49, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 911.49, 8, 'spreadsheet_seed');

  -- [131/230] Harpers
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
    true, 11992.11, 32, 374.75, 0.2902,
    13790.93, -1798.82,
    0, 0.2902,
    831.38, 0, 0,
    11992.11, 2, 100,
    831.38, 8511.77, 0, 8511.77, 3480.34,
    8511.77, 0.7098, 32, 1536,
    1500.0, 500.0, 4367.38,
    6144.39, 0.5124, 'green', 'manager',
    8.3906, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 999.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 999.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 999.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 999.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 999.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 999.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 999.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 999.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 999.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 999.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 999.34, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 999.34, 8, 'spreadsheet_seed');

  -- [132/230] Blaxland Tiles and Bathrooms
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
    788.76, 8161.7, 10.82, 8150.88, 3223.43,
    8150.88, 0.6219, 28, 1344,
    1500.0, 500.0, 4132.76,
    6018.12, 0.5286, 'green', 'manager',
    8.6299, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 948.76, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 948.76, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 948.76, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 948.76, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 948.76, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 948.76, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 948.76, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 948.76, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 948.76, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 948.76, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 948.76, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 948.76, 8, 'spreadsheet_seed');

  -- [133/230] Oscar & Co
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
    true, 13751.15, 21, 654.82, 0.3051,
    15813.82, -2062.67,
    0, 0.3051,
    3178.19, 0, 0,
    13751.15, 2, 100,
    3178.19, 9555.77, 0, 9555.77, 4195.38,
    9555.77, 0.6949, 21, 1008,
    1500.0, 500.0, 6186.19,
    5369.58, 0.3905, 'green', 'manager',
    2.6895, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1145.93, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1145.93, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1145.93, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1145.93, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1145.93, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1145.93, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1145.93, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1145.93, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1145.93, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1145.93, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1145.93, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1145.93, 8, 'spreadsheet_seed');

  -- [134/230] Tuggerah Tiles
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
    true, 8526.04, 9, 947.34, 0.2777,
    9804.95, -1278.91,
    0, 0.2777,
    518.51, 0, 0,
    8526.04, 2, 100,
    518.51, 6158.71, 0, 6158.71, 2367.33,
    6158.71, 0.7223, 9, 432,
    1500.0, 500.0, 2950.51,
    5208.2, 0.6109, 'green', 'manager',
    11.0446, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 710.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 710.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 710.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 710.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 710.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 710.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 710.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 710.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 710.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 710.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 710.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 710.5, 8, 'spreadsheet_seed');

  -- [135/230] SAINT GEORGE MODERN CONSTRUCTIONS PTY LTD
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
    0, 0.3641,
    100.6, 0, 0,
    8750.01, 2, 100,
    100.6, 5564.19, 0, 5564.19, 3185.82,
    5564.19, 0.6359, 9, 432,
    1500.0, 500.0, 2532.6,
    5031.59, 0.575, 'green', 'manager',
    51.0158, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 729.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 729.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 729.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 729.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 729.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 729.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 729.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 729.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 729.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 729.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 729.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 729.17, 8, 'spreadsheet_seed');

  -- [136/230] Seaside Bathware
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
    0, 0.2826,
    152.16, 0, 0,
    8038.0, 2, 100,
    152.16, 5766.83, 0, 5766.83, 2271.17,
    5766.83, 0.7174, 14, 672,
    1500.0, 500.0, 2824.16,
    4942.67, 0.6149, 'green', 'manager',
    33.4834, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 669.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 669.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 669.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 669.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 669.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 669.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 669.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 669.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 669.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 669.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 669.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 669.83, 8, 'spreadsheet_seed');

  -- [137/230] Area Bathrooms
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
    0, 0.3349,
    1016.34, 0, 0,
    10495.51, 2, 100,
    1016.34, 6980.08, 0, 6980.08, 3515.43,
    6980.08, 0.6651, 26, 1248,
    1500.0, 500.0, 4264.34,
    4715.74, 0.4493, 'green', 'manager',
    5.6399, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 874.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 874.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 874.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 874.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 874.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 874.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 874.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 874.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 874.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 874.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 874.63, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 874.63, 8, 'spreadsheet_seed');

  -- [138/230] Vogue Spas and Bathrooms
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
    0, 0.2543,
    170.92, 0, 0,
    6954.64, 2, 100,
    170.92, 5185.94, 0, 5185.94, 1768.7,
    5185.94, 0.7457, 7, 336,
    1500.0, 500.0, 2506.92,
    4679.02, 0.6728, 'green', 'manager',
    28.3755, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 579.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 579.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 579.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 579.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 579.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 579.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 579.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 579.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 579.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 579.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 579.55, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 579.55, 8, 'spreadsheet_seed');

  -- [139/230] one stop bath and tiles
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
    0, 0.2827,
    24.24, 0, 0,
    6818.74, 2, 100,
    24.24, 4891.39, 0, 4891.39, 1927.35,
    4891.39, 0.7173, 8, 384,
    1500.0, 500.0, 2408.24,
    4483.15, 0.6575, 'green', 'manager',
    185.9484, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 568.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 568.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 568.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 568.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 568.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 568.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 568.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 568.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 568.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 568.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 568.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 568.23, 8, 'spreadsheet_seed');

  -- [140/230] Adelaide Bathroom and Kitchen Supplies
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
    0, 0.3754,
    982.17, 0, 0,
    10618.96, 2, 100,
    982.17, 6632.49, 0, 6632.49, 3986.47,
    6632.49, 0.6246, 25, 1200,
    1500.0, 500.0, 4182.17,
    4450.32, 0.4191, 'green', 'manager',
    5.5311, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 884.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 884.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 884.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 884.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 884.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 884.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 884.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 884.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 884.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 884.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 884.91, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 884.91, 8, 'spreadsheet_seed');

  -- [141/230] Bretts Plumbing Plus
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
    0, 0.2899,
    20.56, 0, 0,
    7860.4, 2, 100,
    20.56, 5581.61, 0, 5581.61, 2278.79,
    5581.61, 0.7101, 25, 1200,
    1500.0, 500.0, 3220.56,
    4361.05, 0.5548, 'green', 'manager',
    213.1133, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 655.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 655.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 655.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 655.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 655.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 655.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 655.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 655.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 655.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 655.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 655.03, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 655.03, 8, 'spreadsheet_seed');

  -- [142/230] FBI interiors
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
    true, 13341.89, 36, 370.61, 0.4479,
    15343.17, -2001.28,
    0, 0.4479,
    1302.11, 0, 0,
    13341.89, 2, 100,
    1302.11, 7366.4, 0, 7366.4, 5975.49,
    7366.4, 0.5521, 36, 1728,
    1500.0, 500.0, 5030.11,
    4336.29, 0.325, 'green', 'manager',
    4.3302, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1111.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1111.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1111.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1111.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1111.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1111.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1111.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1111.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1111.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1111.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1111.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1111.82, 8, 'spreadsheet_seed');

  -- [143/230] Corowa Plumbing Supplies Pty Ltd T/A Jones Plumbing Plus - Albury
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
    0, 0.2933,
    71.08, 0, 0,
    6315.03, 2, 100,
    71.08, 4462.64, 0, 4462.64, 1852.39,
    4462.64, 0.7067, 2, 96,
    1500.0, 500.0, 2167.08,
    4295.56, 0.6802, 'green', 'manager',
    61.4328, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 526.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 526.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 526.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 526.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 526.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 526.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 526.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 526.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 526.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 526.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 526.25, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 526.25, 8, 'spreadsheet_seed');

  -- [144/230] James St Bathrooms Pty Ltd
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
    0, 0.2369,
    225.63, 0, 0,
    5718.84, 2, 100,
    225.63, 4363.93, 0, 4363.93, 1354.91,
    4363.93, 0.7631, 2, 96,
    1500.0, 500.0, 2321.63,
    4042.3, 0.7068, 'green', 'manager',
    18.9156, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 476.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 476.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 476.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 476.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 476.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 476.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 476.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 476.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 476.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 476.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 476.57, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 476.57, 8, 'spreadsheet_seed');

  -- [145/230] Bendigo Floor & Home Centre (Elegance Tiles)
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
    0, 0.3591,
    1811.81, 0, 0,
    10743.52, 2, 100,
    1811.81, 6885.44, 0, 6885.44, 3858.08,
    6885.44, 0.6409, 23, 1104,
    1500.0, 500.0, 4915.81,
    3969.63, 0.3695, 'green', 'manager',
    3.191, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 895.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 895.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 895.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 895.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 895.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 895.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 895.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 895.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 895.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 895.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 895.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 895.29, 8, 'spreadsheet_seed');

  -- [146/230] The Boardroom Pty Ltd T/A The Gallery Interiors
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
    true, 6537.93, 7, 933.99, 0.2637,
    7518.62, -980.69,
    0, 0.2637,
    787.01, 0, 0,
    6537.93, 2, 100,
    787.01, 4813.92, 0, 4813.92, 1724.01,
    4813.92, 0.7363, 7, 336,
    1500.0, 500.0, 3123.01,
    3690.91, 0.5645, 'green', 'manager',
    5.6898, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 544.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 544.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 544.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 544.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 544.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 544.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 544.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 544.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 544.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 544.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 544.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 544.83, 8, 'spreadsheet_seed');

  -- [147/230] Concept Tiles & Surfaces
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
    0, 0.2541,
    285.39, 0, 0,
    5719.69, 2, 100,
    285.39, 4266.11, 0, 4266.11, 1453.58,
    4266.11, 0.7459, 7, 336,
    1500.0, 500.0, 2621.39,
    3644.72, 0.6372, 'green', 'manager',
    13.771, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 476.64, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 476.64, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 476.64, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 476.64, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 476.64, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 476.64, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 476.64, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 476.64, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 476.64, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 476.64, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 476.64, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 476.64, 8, 'spreadsheet_seed');

  -- [148/230] Builders World
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
    true, 5293.64, 8, 661.7, 0.2474,
    6087.69, -794.05,
    0, 0.2474,
    118.43, 0, 0,
    5293.64, 2, 100,
    118.43, 3983.94, 0, 3983.94, 1309.7,
    3983.94, 0.7526, 8, 384,
    1500.0, 500.0, 2502.43,
    3481.51, 0.6577, 'green', 'manager',
    30.3972, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 441.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 441.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 441.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 441.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 441.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 441.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 441.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 441.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 441.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 441.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 441.14, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 441.14, 8, 'spreadsheet_seed');

  -- [149/230] Choice Bathroom & Kitchen Supplies
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
    850.19, 4538.51, 6.26, 4532.25, 2046.87,
    4532.25, 0.5942, 6, 288,
    1500.0, 500.0, 3138.19,
    3394.06, 0.5154, 'green', 'manager',
    4.9921, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 548.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 548.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 548.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 548.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 548.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 548.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 548.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 548.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 548.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 548.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 548.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 548.78, 8, 'spreadsheet_seed');

  -- [150/230] My Tile Market - Brookvale
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
    0, 0.3024,
    12.34, 0, 0,
    5528.51, 2, 100,
    12.34, 3856.78, 0, 3856.78, 1671.73,
    3856.78, 0.6976, 10, 480,
    1500.0, 500.0, 2492.34,
    3364.44, 0.6086, 'green', 'manager',
    273.6451, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 460.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 460.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 460.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 460.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 460.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 460.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 460.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 460.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 460.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 460.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 460.71, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 460.71, 8, 'spreadsheet_seed');

  -- [151/230] Terrace Tiles
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
    139.3, 3711.5, 4.9, 3706.6, 1444.0,
    3706.6, 0.6249, 7, 336,
    1500.0, 500.0, 2475.3,
    3231.3, 0.6268, 'green', 'manager',
    24.1967, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 429.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 429.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 429.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 429.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 429.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 429.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 429.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 429.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 429.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 429.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 429.62, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 429.62, 8, 'spreadsheet_seed');

  -- [152/230] Mr Sink
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
    true, 5170.39, 7, 738.63, 0.3064,
    5945.95, -775.56,
    0, 0.3064,
    244.38, 0, 0,
    5170.39, 2, 100,
    244.38, 3586.15, 0, 3586.15, 1584.24,
    3586.15, 0.6936, 7, 336,
    1500.0, 500.0, 2580.38,
    3005.77, 0.5813, 'green', 'manager',
    13.2996, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 430.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 430.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 430.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 430.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 430.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 430.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 430.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 430.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 430.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 430.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 430.87, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 430.87, 8, 'spreadsheet_seed');

  -- [153/230] Adorn Tiles
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
    0, 0.2714,
    894.36, 0, 0,
    5361.3, 2, 100,
    894.36, 3906.04, 0, 3906.04, 1455.26,
    3906.04, 0.7286, 5, 240,
    1500.0, 500.0, 3134.36,
    2771.68, 0.517, 'green', 'manager',
    4.0991, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 446.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 446.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 446.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 446.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 446.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 446.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 446.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 446.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 446.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 446.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 446.78, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 446.78, 8, 'spreadsheet_seed');

  -- [154/230] Surf Coast Bath + Co
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
    1250.12, 4345.56, 6.28, 4339.28, 2263.7,
    4339.28, 0.5625, 10, 480,
    1500.0, 500.0, 3730.12,
    2609.16, 0.3948, 'green', 'manager',
    3.0871, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 550.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 550.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 550.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 550.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 550.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 550.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 550.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 550.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 550.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 550.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 550.77, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 550.77, 8, 'spreadsheet_seed');

  -- [155/230] Hera Bathware
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
    true, 5217.9, 27, 193.26, 0.2789,
    6000.59, -782.68,
    0, 0.2789,
    395.24, 0, 0,
    5217.9, 2, 100,
    395.24, 3762.77, 0, 3762.77, 1455.13,
    3762.77, 0.7211, 27, 1296,
    1500.0, 500.0, 3691.24,
    2071.53, 0.397, 'green', 'manager',
    6.2412, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 434.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 434.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 434.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 434.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 434.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 434.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 434.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 434.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 434.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 434.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 434.83, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 434.83, 8, 'spreadsheet_seed');

  -- [156/230] Builders Discount Warehouse Pty Ltd
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
    true, 4636.61, 14, 331.19, 0.3075,
    5332.1, -695.49,
    0.095, 0.3075,
    484.32, 0, 0,
    4636.61, 2, 100,
    484.32, 3210.85, 4.4, 3206.45, 1425.76,
    3206.45, 0.5975, 14, 672,
    1500.0, 500.0, 3156.32,
    2050.13, 0.4422, 'green', 'manager',
    5.233, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 386.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 386.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 386.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 386.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 386.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 386.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 386.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 386.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 386.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 386.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 386.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 386.38, 8, 'spreadsheet_seed');

  -- [157/230] Metcash M10
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
    true, 5715.37, 9, 635.04, 0.2995,
    6572.68, -857.31,
    0, 0.2995,
    1668.54, 0, 0,
    5715.37, 2, 100,
    1668.54, 4003.9, 0, 4003.9, 1711.47,
    4003.9, 0.7005, 9, 432,
    1500.0, 500.0, 4100.54,
    1903.36, 0.333, 'review', 'manager',
    2.1407, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 476.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 476.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 476.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 476.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 476.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 476.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 476.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 476.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 476.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 476.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 476.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 476.28, 8, 'spreadsheet_seed');

  -- [158/230] Dahlsens
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
    true, 3131.97, 5, 626.39, 0.3655,
    3601.77, -469.8,
    0, 0.3655,
    24.43, 0, 0,
    3131.97, 2, 100,
    24.43, 1987.27, 0, 1987.27, 1144.7,
    1987.27, 0.6345, 5, 240,
    1500.0, 500.0, 2264.43,
    1722.84, 0.5501, 'review', 'manager',
    71.5215, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 261.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 261.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 261.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 261.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 261.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 261.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 261.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 261.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 261.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 261.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 261.0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 261.0, 8, 'spreadsheet_seed');

  -- [159/230] Kelly''s Plumbing Supplies
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
    0, 0.2591,
    380.61, 0, 0,
    2948.06, 2, 100,
    380.61, 2184.12, 0, 2184.12, 763.94,
    2184.12, 0.7409, 4, 192,
    1500.0, 500.0, 2572.61,
    1611.51, 0.5466, 'review', 'manager',
    5.234, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 245.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 245.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 245.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 245.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 245.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 245.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 245.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 245.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 245.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 245.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 245.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 245.67, 8, 'spreadsheet_seed');

  -- [160/230] Scott''s Plumbing Supplies
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
    0, 0.2998,
    284.5, 0, 0,
    3017.03, 2, 100,
    284.5, 2112.5, 0, 2112.5, 904.53,
    2112.5, 0.7002, 5, 240,
    1500.0, 500.0, 2524.5,
    1588.0, 0.5263, 'review', 'manager',
    6.5817, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 251.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 251.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 251.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 251.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 251.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 251.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 251.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 251.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 251.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 251.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 251.42, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 251.42, 8, 'spreadsheet_seed');

  -- [161/230] Bayview Renovations Braeside
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
    0, 0.291,
    179.79, 0, 0,
    2841.8, 2, 100,
    179.79, 2014.93, 0, 2014.93, 826.87,
    2014.93, 0.709, 6, 288,
    1500.0, 500.0, 2467.79,
    1547.14, 0.5444, 'review', 'manager',
    9.6053, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 236.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 236.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 236.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 236.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 236.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 236.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 236.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 236.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 236.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 236.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 236.82, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 236.82, 8, 'spreadsheet_seed');

  -- [162/230] Bondi Spaces Pty Ltd
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
    true, 3973.29, 5, 794.66, 0.2478,
    4569.28, -595.99,
    0, 0.2478,
    1308.52, 0, 0,
    3973.29, 2, 100,
    1308.52, 2988.9, 0, 2988.9, 984.39,
    2988.9, 0.7522, 5, 240,
    1500.0, 500.0, 3548.52,
    1440.38, 0.3625, 'review', 'manager',
    2.1008, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 331.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 331.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 331.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 331.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 331.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 331.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 331.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 331.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 331.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 331.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 331.11, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 331.11, 8, 'spreadsheet_seed');

  -- [163/230] DEMOR EST 1980 PTY LTD (Previously known as Demor)
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
    82.98, 1639.3, 2.35, 1636.95, 830.37,
    1636.95, 0.5688, 8, 384,
    1500.0, 500.0, 2466.98,
    1169.97, 0.4737, 'review', 'manager',
    15.0995, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 205.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 205.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 205.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 205.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 205.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 205.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 205.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 205.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 205.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 205.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 205.81, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 205.81, 8, 'spreadsheet_seed');

  -- [164/230] All Trade Plumbing Centre Pty Ltd
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
    0, 0.3227,
    179.55, 0, 0,
    2370.0, 2, 100,
    179.55, 1605.2, 0, 1605.2, 764.8,
    1605.2, 0.6773, 6, 288,
    1500.0, 500.0, 2467.55,
    1137.65, 0.48, 'review', 'manager',
    7.3361, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 197.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 197.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 197.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 197.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 197.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 197.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 197.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 197.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 197.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 197.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 197.5, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 197.5, 8, 'spreadsheet_seed');

  -- [165/230] Astley’s Plumbing & Hardware
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
    true, 7748.0, 14, 553.43, 0.3296,
    8910.2, -1162.2,
    0, 0.3296,
    3644.99, 0, 0,
    7748.0, 2, 100,
    3644.99, 5194.53, 0, 5194.53, 2553.47,
    5194.53, 0.6704, 14, 672,
    1500.0, 500.0, 6316.99,
    877.54, 0.1133, 'review', 'manager',
    1.2408, 'marginal'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 645.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 645.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 645.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 645.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 645.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 645.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 645.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 645.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 645.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 645.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 645.67, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 645.67, 8, 'spreadsheet_seed');

  -- [166/230] Abode Carpentry & Renovations Pty Ltd
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
    0, 0.2889,
    1896.28, 0, 0,
    4074.5, 2, 100,
    1896.28, 2897.2, 0, 2897.2, 1177.3,
    2897.2, 0.7111, 3, 144,
    1500.0, 500.0, 4040.28,
    856.92, 0.2103, 'review', 'manager',
    1.4519, 'marginal'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 339.54, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 339.54, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 339.54, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 339.54, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 339.54, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 339.54, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 339.54, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 339.54, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 339.54, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 339.54, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 339.54, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 339.54, 8, 'spreadsheet_seed');

  -- [167/230] Stone Arc T/A Arc Trading Pty Ltd
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
    true, 1984.94, 2, 992.47, 0.2762,
    2282.68, -297.74,
    0, 0.2762,
    534.37, 0, 0,
    1984.94, 2, 100,
    534.37, 1436.63, 0, 1436.63, 548.31,
    1436.63, 0.7238, 2, 96,
    1500.0, 500.0, 2630.37,
    806.26, 0.4062, 'review', 'manager',
    2.5088, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 165.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 165.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 165.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 165.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 165.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 165.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 165.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 165.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 165.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 165.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 165.41, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 165.41, 8, 'spreadsheet_seed');

  -- [168/230] Tweed Heads Plumbing Supplies
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
    true, 2640.21, 8, 330.03, 0.2967,
    3036.24, -396.03,
    0, 0.2967,
    686.2, 0, 0,
    2640.21, 2, 100,
    686.2, 1856.95, 0, 1856.95, 783.26,
    1856.95, 0.7033, 8, 384,
    1500.0, 500.0, 3070.2,
    786.75, 0.298, 'review', 'manager',
    2.1465, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 220.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 220.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 220.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 220.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 220.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 220.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 220.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 220.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 220.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 220.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 220.02, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 220.02, 8, 'spreadsheet_seed');

  -- [169/230] COD Customers
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
    true, 4467.41, 14, 319.1, 0.4213,
    5137.52, -670.11,
    0, 0.4213,
    1703.66, 0, 0,
    4467.41, 2, 100,
    1703.66, 2585.37, 0, 2585.37, 1882.04,
    2585.37, 0.5787, 14, 672,
    1500.0, 500.0, 4375.66,
    209.71, 0.0469, 'review', 'manager',
    1.1231, 'marginal'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 372.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 372.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 372.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 372.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 372.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 372.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 372.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 372.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 372.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 372.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 372.28, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 372.28, 8, 'spreadsheet_seed');

  -- [170/230] Bathroom Supplies
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
    0, 0.2165,
    90.66, 0, 0,
    500.23, 2, 100,
    90.66, 391.95, 0, 391.95, 108.28,
    391.95, 0.7835, 2, 96,
    1500.0, 500.0, 2186.66,
    205.29, 0.4104, 'review', 'manager',
    3.2644, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 41.69, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 41.69, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 41.69, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 41.69, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 41.69, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 41.69, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 41.69, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 41.69, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 41.69, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 41.69, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 41.69, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 41.69, 8, 'spreadsheet_seed');

  -- [171/230] Inhouse Trade Centre
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
    0, 0.2658,
    97.56, 0, 0,
    413.46, 2, 100,
    97.56, 303.58, 0, 303.58, 109.88,
    303.58, 0.7342, 2, 96,
    1500.0, 500.0, 2193.56,
    110.02, 0.2661, 'review', 'manager',
    2.1277, 'worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 34.45, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 34.45, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 34.45, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 34.45, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 34.45, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 34.45, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 34.45, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 34.45, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 34.45, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 34.45, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 34.45, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 34.45, 8, 'spreadsheet_seed');

  -- [172/230] Bass Strait Interiors
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
    'Bass Strait Interiors', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    8.32, 0, 0,
    0.0, 2, 100,
    8.32, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2008.32,
    -8.32, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [173/230] Express Plumbing
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
    true, 7468.61, 19, 393.08, 0.2813,
    8588.9, -1120.29,
    0, 0.2813,
    4477.43, 0, 0,
    7468.61, 2, 100,
    4477.43, 5368.03, 0, 5368.03, 2100.58,
    5368.03, 0.7187, 19, 912,
    1500.0, 500.0, 7389.43,
    -21.4, -0.0029, 'review', 'manager',
    0.9952, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 622.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 622.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 622.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 622.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 622.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 622.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 622.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 622.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 622.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 622.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 622.38, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 622.38, 8, 'spreadsheet_seed');

  -- [174/230] Bathware Direct
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
    'Bathware Direct', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    30.9, 0, 0,
    0.0, 2, 100,
    30.9, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2030.9,
    -30.9, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [175/230] Akira Interiors (BIGA+)
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
    'Akira Interiors (BIGA+)', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    47.47, 0, 0,
    0.0, 2, 100,
    47.47, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2047.47,
    -47.47, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [176/230] Absolute Building Solutions
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
    'Absolute Building Solutions', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    48.26, 0, 0,
    0.0, 2, 100,
    48.26, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2048.26,
    -48.26, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [177/230] Novale
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
    'Novale', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    56.36, 0, 0,
    0.0, 2, 100,
    56.36, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2056.36,
    -56.36, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [178/230] S.S. Lootah Trading Building Material Division LLC
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
    'S.S. Lootah Trading Building Material Division LLC', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    92.32, 0, 0,
    0.0, 2, 100,
    92.32, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2092.32,
    -92.32, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [179/230] Hunter Bathrooms
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
    'Hunter Bathrooms', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    140.02, 0, 0,
    0.0, 2, 100,
    140.02, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2140.02,
    -140.02, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [180/230] PT Austindo Perdana
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
    'PT Austindo Perdana', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    144.24, 0, 0,
    0.0, 2, 100,
    144.24, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2144.24,
    -144.24, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [181/230] Fisher''s Plumber Plus
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
    'Fisher''s Plumber Plus', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    157.85, 0, 0,
    0.0, 2, 100,
    157.85, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2157.85,
    -157.85, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [182/230] Timberline
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
    'Timberline', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    160.41, 0, 0,
    0.0, 2, 100,
    160.41, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2160.41,
    -160.41, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [183/230] Nu Bathroom and kitchen centre
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
    484.37, 488.59, 0.63, 487.96, 173.61,
    487.96, 0.6428, 4, 192,
    1500.0, 500.0, 2676.37,
    -188.41, -0.2845, 'review', 'manager',
    0.611, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 55.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 55.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 55.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 55.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 55.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 55.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 55.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 55.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 55.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 55.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 55.18, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 55.18, 8, 'spreadsheet_seed');

  -- [184/230] Elite Design Studio
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
    'Elite Design Studio', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    190.64, 0, 0,
    0.0, 2, 100,
    190.64, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2190.64,
    -190.64, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [185/230] Q Bathrooms
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
    'Q Bathrooms', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    191.02, 0, 0,
    0.0, 2, 100,
    191.02, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2191.02,
    -191.02, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [186/230] Burnett''s Plumbing Supplies
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
    'Burnett''s Plumbing Supplies', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    237.82, 0, 0,
    0.0, 2, 100,
    237.82, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2237.82,
    -237.82, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [187/230] Synergy Building Design
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
    'Synergy Building Design', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    268.34, 0, 0,
    0.0, 2, 100,
    268.34, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2268.34,
    -268.34, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [188/230] Meir - Charity / Donation
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
    'Meir - Charity / Donation', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    275.29, 0, 0,
    0.0, 2, 100,
    275.29, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2275.29,
    -275.29, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [189/230] Tiento Pty Ltd
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
    'Tiento Pty Ltd', '', '',
    false, 0.0, 2, 0.0, 0,
    0, 0.0,
    0, 0,
    180.7, 0, 0,
    0.0, 2, 100,
    180.7, 0.0, 0, 0, 0.0,
    0, 0, 2, 96,
    1500.0, 500.0, 2276.7,
    -276.7, 0, 'review', 'manager',
    -0.5313, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [190/230] Killen Tiling Pty Ltd
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
    'Killen Tiling Pty Ltd', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    308.02, 0, 0,
    0.0, 2, 100,
    308.02, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2308.02,
    -308.02, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [191/230] Vanity Co (Divine Kitchens)
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
    0, 0.2657,
    637.8, 0, 0,
    569.64, 2, 100,
    637.8, 418.28, 0, 418.28, 151.36,
    418.28, 0.7343, 2, 96,
    1500.0, 500.0, 2733.8,
    -315.52, -0.5539, 'review', 'manager',
    0.5053, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 47.47, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 47.47, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 47.47, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 47.47, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 47.47, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 47.47, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 47.47, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 47.47, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 47.47, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 47.47, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 47.47, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 47.47, 8, 'spreadsheet_seed');

  -- [192/230] Renova House
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
    'Renova House', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    320.02, 0, 0,
    0.0, 2, 100,
    320.02, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2320.02,
    -320.02, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [193/230] Atelier Bathrooms
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
    'Atelier Bathrooms', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    368.46, 0, 0,
    0.0, 2, 100,
    368.46, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2368.46,
    -368.46, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [194/230] Just Bathrooms
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
    'Just Bathrooms', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    404.39, 0, 0,
    0.0, 2, 100,
    404.39, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2404.39,
    -404.39, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [195/230] Desino
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
    'Desino', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    480.22, 0, 0,
    0.0, 2, 100,
    480.22, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2480.22,
    -480.22, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [196/230] Haus of Hardy
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
    'Haus of Hardy', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    483.11, 0, 0,
    0.0, 2, 100,
    483.11, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2483.11,
    -483.11, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [197/230] J & J SCERRI HOLDINGS PTY LTD T/A North Richmond Tile Centre
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
    'J & J SCERRI HOLDINGS PTY LTD T/A North Richmond Tile Centre', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    533.97, 0, 0,
    0.0, 2, 100,
    533.97, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2533.97,
    -533.97, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [198/230] Jeffs Joinery & Building Centre Pty Ltd
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
    'Jeffs Joinery & Building Centre Pty Ltd', '', '',
    false, -14.33, 3, -4.78, 0.8604,
    0, -14.33,
    0, 0.8604,
    533.75, 0, 0,
    -14.33, 2, 100,
    533.75, -2.0, 0, -2.0, -12.33,
    -2.0, 0.1396, 3, 144,
    1500.0, 500.0, 2677.75,
    -679.75, 9.9999, 'review', 'manager',
    -0.2735, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [199/230] Marbello
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
    'Marbello', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    708.09, 0, 0,
    0.0, 2, 100,
    708.09, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2708.09,
    -708.09, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [200/230] Ayvan Pty Ltd
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
    0, 0.3116,
    1086.49, 0, 0,
    399.5, 2, 100,
    1086.49, 275.02, 0, 275.02, 124.48,
    275.02, 0.6884, 1, 48,
    1500.0, 500.0, 3134.49,
    -859.47, -2.1514, 'review', 'manager',
    0.2089, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 33.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 33.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 33.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 33.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 33.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 33.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 33.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 33.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 33.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 33.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 33.29, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 33.29, 8, 'spreadsheet_seed');

  -- [201/230] San Marco Ceramics
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
    0, 0.3434,
    2795.35, 0, 0,
    4385.26, 2, 100,
    2795.35, 2879.49, 0, 2879.49, 1505.77,
    2879.49, 0.6566, 20, 960,
    1500.0, 500.0, 5755.35,
    -875.86, -0.1997, 'review', 'manager',
    0.6867, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 365.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 365.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 365.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 365.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 365.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 365.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 365.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 365.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 365.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 365.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 365.44, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 365.44, 8, 'spreadsheet_seed');

  -- [202/230] Kewco
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
    749.72, 481.91, 1.82, 480.09, 1431.26,
    480.09, 0.1569, 13, 624,
    1500.0, 500.0, 3373.72,
    -893.63, -0.4671, 'review', 'manager',
    -0.1919, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 159.43, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 159.43, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 159.43, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 159.43, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 159.43, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 159.43, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 159.43, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 159.43, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 159.43, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 159.43, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 159.43, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 159.43, 8, 'spreadsheet_seed');

  -- [203/230] Ultimate Bathroom
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
    'Ultimate Bathroom', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    935.44, 0, 0,
    0.0, 2, 100,
    935.44, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 2935.44,
    -935.44, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [204/230] Meir - Marketing Materials
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
    'Meir - Marketing Materials', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    1110.88, 0, 0,
    0.0, 2, 100,
    1110.88, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 3110.88,
    -1110.88, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [205/230] Nood Co Concrete
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
    'Nood Co Concrete', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    1392.34, 0, 0,
    0.0, 2, 100,
    1392.34, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 3392.34,
    -1392.34, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [206/230] Meir - Stock Awaiting Parts
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
    'Meir - Stock Awaiting Parts', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    1440.67, 0, 0,
    0.0, 2, 100,
    1440.67, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 3440.67,
    -1440.67, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [207/230] Meir - Influencer / Content
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
    'Meir - Influencer / Content', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    1479.27, 0, 0,
    0.0, 2, 100,
    1479.27, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 3479.27,
    -1479.27, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [208/230] Swan Plumbing
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
    'Swan Plumbing', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    1682.07, 0, 0,
    0.0, 2, 100,
    1682.07, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 3682.07,
    -1682.07, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [209/230] Modena Kitchens & Bathrooms
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
    'Modena Kitchens & Bathrooms', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    2002.34, 0, 0,
    0.0, 2, 100,
    2002.34, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 4002.34,
    -2002.34, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [210/230] Cowra Creative Tiles
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
    0, 0.3172,
    2614.32, 0, 0,
    26.73, 2, 100,
    2614.32, 18.25, 0, 18.25, 8.48,
    18.25, 0.6828, 1, 48,
    1500.0, 500.0, 4662.32,
    -2644.07, -9.9999, 'review', 'manager',
    -0.0114, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 2.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 2.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 2.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 2.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 2.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 2.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 2.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 2.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 2.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 2.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 2.23, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 2.23, 8, 'spreadsheet_seed');

  -- [211/230] Tiento Tiles
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
    'Tiento Tiles', '', '',
    true, 0.1, 3, 0.03, 9.9999,
    0.11, -0.01,
    0, 9.9999,
    1602.66, 0, 0,
    0.1, 2, 100,
    1602.66, -1018.08, 0, -1018.08, 1018.18,
    -1018.08, -9.9999, 3, 144,
    1500.0, 500.0, 3746.66,
    -2764.74, -9.9999, 'review', 'manager',
    -0.7251, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0.01, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0.01, 8, 'spreadsheet_seed');

  -- [212/230] Meir - Marketing / Photoshoot
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
    'Meir - Marketing / Photoshoot', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    3607.92, 0, 0,
    0.0, 2, 100,
    3607.92, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 5607.92,
    -3607.92, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [213/230] Navi by Centre (Centre Plumbing Plus)
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
    'Navi by Centre (Centre Plumbing Plus)', '', '',
    false, -510.07, 18, -28.34, 0.0669,
    0, -510.07,
    0, 0.0669,
    3595.02, 0, 0,
    -510.07, 2, 100,
    3595.02, -475.97, 0, -475.97, -34.1,
    -475.97, 0.9331, 18, 864,
    1500.0, 500.0, 6459.02,
    -4934.99, 9.6751, 'review', 'manager',
    -0.3727, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [214/230] RetraVision
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
    'RetraVision', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    7583.42, 0, 0,
    0.0, 2, 100,
    7583.42, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 9583.42,
    -7583.42, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [215/230] Retail International
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
    'Retail International', '', '',
    true, 951.6, 5, 190.32, 5.5633,
    1094.34, -142.74,
    0, 5.5633,
    4258.0, 0, 0,
    951.6, 2, 100,
    4258.0, -4342.44, 0, -4342.44, 5294.04,
    -4342.44, -4.5633, 5, 240,
    1500.0, 500.0, 6498.0,
    -8840.44, -9.2901, 'review', 'manager',
    -1.0762, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 79.3, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 79.3, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 79.3, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 79.3, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 79.3, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 79.3, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 79.3, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 79.3, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 79.3, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 79.3, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 79.3, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 79.3, 8, 'spreadsheet_seed');

  -- [216/230] Meir - Staff Home / Personal
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
    'Meir - Staff Home / Personal', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    9116.89, 0, 0,
    0.0, 2, 100,
    9116.89, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 11116.89,
    -9116.89, 0, 'review', 'manager',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [217/230] Meir - Choc Boxes
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
    'Meir - Choc Boxes', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    11971.95, 0, 0,
    0.0, 2, 100,
    11971.95, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 13971.95,
    -11971.95, 0, 'review', 'cfo',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [218/230] Meir - Curvae Display Allocation
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
    'Meir - Curvae Display Allocation', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    12055.01, 0, 0,
    0.0, 2, 100,
    12055.01, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 14055.01,
    -12055.01, 0, 'review', 'cfo',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [219/230] Meir - Backplates / Cover Plates
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
    'Meir - Backplates / Cover Plates', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    12547.72, 0, 0,
    0.0, 2, 100,
    12547.72, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 14547.72,
    -12547.72, 0, 'review', 'cfo',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [220/230] Meir - Expo / Trade Show
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
    'Meir - Expo / Trade Show', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    13265.38, 0, 0,
    0.0, 2, 100,
    13265.38, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 15265.38,
    -13265.38, 0, 'review', 'cfo',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [221/230] Meir - Product Launch
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
    'Meir - Product Launch', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    14130.98, 0, 0,
    0.0, 2, 100,
    14130.98, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 16130.98,
    -14130.98, 0, 'review', 'cfo',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [222/230] Meir - Generic Display Stock
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
    'Meir - Generic Display Stock', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    14706.13, 0, 0,
    0.0, 2, 100,
    14706.13, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 16706.13,
    -14706.13, 0, 'review', 'cfo',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [223/230] Meir - Samples / Discs
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
    'Meir - Samples / Discs', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    16606.0, 0, 0,
    0.0, 2, 100,
    16606.0, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 18606.0,
    -16606.0, 0, 'review', 'cfo',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [224/230] Meir
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
    true, 12878.02, 30, 429.27, 0.3871,
    14809.72, -1931.7,
    0, 0.3871,
    25450.69, 0, 0,
    12878.02, 2, 100,
    25450.69, 7893.42, 0, 7893.42, 4984.6,
    7893.42, 0.6129, 30, 1440,
    1500.0, 500.0, 28890.69,
    -18997.27, -1.4752, 'review', 'cfo',
    0.2536, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 1073.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 1073.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 1073.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 1073.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 1073.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 1073.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 1073.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 1073.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 1073.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 1073.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 1073.17, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 1073.17, 8, 'spreadsheet_seed');

  -- [225/230] #N/A
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
    '#N/A', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    19517.19, 0, 0,
    0.0, 2, 100,
    19517.19, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 21517.19,
    -19517.19, 0, 'review', 'cfo',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [226/230] Meir - Boot Stock / Car Stock
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
    'Meir - Boot Stock / Car Stock', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    22438.14, 0, 0,
    0.0, 2, 100,
    22438.14, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 24438.14,
    -22438.14, 0, 'review', 'cfo',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [227/230] Meir - Unclassified
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
    'Meir - Unclassified', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    53635.54, 0, 0,
    0.0, 2, 100,
    53635.54, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 55635.54,
    -53635.54, 0, 'review', 'coo',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [228/230] Meir - Harrington Allocation
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
    'Meir - Harrington Allocation', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    54746.42, 0, 0,
    0.0, 2, 100,
    54746.42, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 56746.42,
    -54746.42, 0, 'review', 'coo',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [229/230] Consumer < $100
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
    'Consumer < $100', '', '',
    false, 0.0, 2, 0.0, 0,
    0, 0.0,
    0, 0,
    70058.78, 0, 0,
    0.0, 2, 100,
    70058.78, -10.86, 0, -10.86, 10.86,
    -10.86, 0, 2, 96,
    1500.0, 500.0, 72154.78,
    -70165.64, 0, 'review', 'coo',
    -0.0015, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

  -- [230/230] Unknown
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
    'Unknown', '', '',
    false, 0.0, 0, 650, 0,
    0, 0.0,
    0, 0,
    133205.56, 0, 0,
    0.0, 2, 100,
    133205.56, 0.0, 0, 0, 0.0,
    0, 0, 0, 0,
    1500.0, 500.0, 135205.56,
    -133205.56, 0, 'review', 'admin',
    0, 'not_worth_it'
  ) RETURNING id INTO req_id;

  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-04', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-05', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-06', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-07', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-08', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-09', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-10', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-11', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2025-12', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-01', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-02', 0, 8, 'spreadsheet_seed');
  INSERT INTO monthly_actuals (request_id, month_year, revenue, catalogues_used, source)
  VALUES (req_id, '2026-03', 0, 8, 'spreadsheet_seed');

END $$;