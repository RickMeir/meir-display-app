// ============================================================
// Core types for Meir Display Request system
// ============================================================

export type UserRole = 'rep' | 'validator' | 'manager' | 'cfo' | 'coo' | 'admin'

export type RequestStatus =
  | 'draft'
  | 'submitted'
  | 'validated'
  | 'queried'
  | 'pending_approval'
  | 'approved'
  | 'rejected'
  | 'cancelled'

export type ProfitabilityFlag = 'green' | 'review'
export type TrackingStatus = 'on_track' | 'at_risk' | 'off_track' | 'not_started'

export interface User {
  id: string
  email: string
  name: string
  role: UserRole
  is_active: boolean
}

export interface DisplayRequest {
  id: string
  submitted_by: string
  submitted_at: string
  status: RequestStatus

  // Store
  store_name: string
  store_code: string
  rep_name: string
  brand_tier: string | null
  display_type: string | null
  display_reason: string | null  // legacy — replaced by structured fields below
  opportunity_description: string | null
  competitor_brands: string | null
  brand_perception_impact: 'increase' | 'no_change' | 'reduce' | null
  planned_install_date: string | null
  is_new_or_replacement: 'new' | 'replacement' | 'update' | null
  differentiation_plan: string | null
  store_agreed_location: boolean

  // Financial inputs
  rebate_pct: number
  cogs_pct: number
  board_labour_cost: number
  forecast_revenue: number   // IMMUTABLE
  rep_hours_monthly: number
  free_samples_cost: number
  catalogues_qty: number
  product_cogs: number
  photos_link: string | null
  comments: string | null

  // Calculated
  total_investment: number
  revenue_after_discount: number
  net_revenue: number
  rebate_cost: number
  cogs_on_sales: number
  est_orders: number
  order_processing: number
  rep_visit_cost: number
  catalogue_cost: number
  total_costs: number
  gross_profit: number
  gross_margin: number
  net_contribution: number
  net_margin: number
  profitability_flag: ProfitabilityFlag
  roi_multiplier: number | null
  verdict: string | null

  // Existing client baseline
  is_existing_client: boolean
  existing_annual_revenue: number
  existing_orders: number
  existing_aov: number
  existing_cogs_pct: number
  baseline_revenue: number
  incremental_revenue: number

  // Initial order commitment
  has_initial_order: boolean
  initial_order_value: number
  initial_order_notes: string | null

  // Routing
  routed_to: string | null
  approval_tier: string | null

  // Validation
  validated_by: string | null
  validated_at: string | null
  validation_note: string | null

  // Approval
  approved_by: string | null
  approved_at: string | null
  approval_note: string | null
  was_override: boolean

  // CS
  cs_reference: string | null
  cs_processed_at: string | null

  // Tracking
  tracking_status: TrackingStatus

  created_at: string
  updated_at: string

  // Joined data (optional)
  submitter?: User
  skus?: DisplaySku[]
}

export interface DisplaySku {
  id: string
  request_id: string
  sku_code: string
  sku_name: string | null
  quantity: number
  unit_cost: number
  line_cost: number
  sort_order: number
}

export interface MonthlyActual {
  id: string
  request_id: string
  month_year: string
  revenue: number
  cogs: number
  gross_profit: number
  gross_margin_pct: number
  order_count: number
  catalogues_used: number
  source: 'manual' | 'acumatica'
  acumatica_ref: string | null
  entered_by: string | null
  entered_at: string
}

export interface AuditEntry {
  id: string
  request_id: string | null
  action: string
  performed_by: string | null
  details: Record<string, unknown> | null
  created_at: string
}

// ============================================================
// Lifecycle tracking types
// ============================================================

export type LifecycleInterval = '3_month' | '6_month' | '9_month' | '12_month'
export type ExpenseStatus = 'proposed' | 'approved' | 'rejected' | 'cancelled'
export type ExpenseCategory =
  | 'rep_hours'
  | 'gifts'
  | 'rebates'
  | 'discounts'
  | 'marketing'
  | 'catalogues'
  | 'other'

export const INTERVAL_LABELS: Record<LifecycleInterval, string> = {
  '3_month': '3 Month Review',
  '6_month': '6 Month Review',
  '9_month': '9 Month Review',
  '12_month': '12 Month Review',
}

export const EXPENSE_CATEGORY_LABELS: Record<ExpenseCategory, string> = {
  rep_hours: 'Additional Rep Hours',
  gifts: 'Gifts',
  rebates: 'Additional Rebates',
  discounts: 'Additional Discounts',
  marketing: 'Marketing / Advertising',
  catalogues: 'Catalogues / Promotional Material',
  other: 'Other',
}

export const EXPENSE_STATUS_LABELS: Record<ExpenseStatus, string> = {
  proposed: 'Proposed',
  approved: 'Approved',
  rejected: 'Rejected',
  cancelled: 'Cancelled',
}

export const EXPENSE_STATUS_COLOURS: Record<ExpenseStatus, string> = {
  proposed: 'bg-yellow-100 text-yellow-800',
  approved: 'bg-green-100 text-green-800',
  rejected: 'bg-red-100 text-red-800',
  cancelled: 'bg-gray-200 text-gray-600',
}

export interface ExpectedPerformance {
  id: string
  request_id: string
  month_number: number
  calendar_month: string | null
  weight: number
  expected_revenue: number
  ramp_up_factor: number | null
  seasonality_factor: number | null
  created_at: string
  updated_at: string
}

export interface LifecycleReview {
  id: string
  request_id: string
  interval: LifecycleInterval
  due_date: string
  completed_at: string | null
  completed_by: string | null
  expected_revenue_cumulative: number | null
  actual_revenue_cumulative: number | null
  variance_pct: number | null
  tracking_assessment: TrackingStatus | null
  on_track_threshold: number
  at_risk_threshold: number
  notes: string | null
  action_taken: string | null
  notification_sent_at: string | null
  created_at: string
  updated_at: string
}

export interface AdditionalExpense {
  id: string
  request_id: string
  category: ExpenseCategory
  description: string
  amount: number
  rationale: string | null
  triggered_by_review: string | null
  status: ExpenseStatus
  requested_by: string
  requested_at: string
  approved_by: string | null
  approved_at: string | null
  approval_note: string | null
  original_total_investment: number | null
  new_total_investment: number | null
  original_required_revenue: number | null
  new_required_revenue: number | null
  original_net_margin: number | null
  new_net_margin: number | null
  makes_unviable: boolean
  expense_round: number
  cumulative_additional_spend: number | null
  created_at: string
  updated_at: string
}

export interface ForecastChange {
  id: string
  request_id: string
  changed_by: string
  changed_at: string
  old_forecast: number
  new_forecast: number
  change_pct: number | null
  reason: string | null
  notification_sent_at: string | null
  old_net_contribution: number | null
  new_net_contribution: number | null
  old_net_margin: number | null
  new_net_margin: number | null
  old_profitability_flag: ProfitabilityFlag | null
  new_profitability_flag: ProfitabilityFlag | null
  created_at: string
}

// ============================================================
// Form input type (what the rep submits — no calculated fields)
// ============================================================

export interface RequestFormInput {
  store_name: string
  store_code: string
  rep_name: string
  brand_tier: string
  display_type: string
  display_reason: string  // legacy
  opportunity_description: string
  competitor_brands: string
  brand_perception_impact: string
  planned_install_date: string
  is_new_or_replacement: string
  differentiation_plan: string
  store_agreed_location: boolean
  is_existing_client: boolean
  rebate_pct: number        // as percentage, e.g. 5 for 5%
  cogs_pct: number          // as percentage, e.g. 60 for 60%
  board_labour_cost: number
  forecast_revenue: number
  rep_hours_monthly: number
  free_samples_cost: number
  catalogues_qty: number
  product_cogs: number
  photos_link: string
  comments: string
  has_initial_order: boolean
  initial_order_value: number
  initial_order_notes: string
  skus: { code: string; name: string; qty: number; unit_cost: number }[]
}

export interface ClientBaseline {
  customer_group: string
  customer_code: string | null
  net_sales: number
  cogs: number
  cogs_pct: number
  order_count: number
  avg_order_value: number
  display_costs: number
  margin_before_ops: number
  margin_pct: number
  rebate_pct: number
}

export interface MarginAlert {
  id: string
  request_id: string
  month_year: string
  approved_cogs_pct: number
  actual_cogs_pct: number
  variance_pct: number
  approved_margin_pct: number
  actual_margin_pct: number
  revenue: number
  impact_amount: number
  acknowledged_by: string | null
  acknowledged_at: string | null
  created_at: string
}

// ============================================================
// Status display helpers
// ============================================================

export const STATUS_LABELS: Record<RequestStatus, string> = {
  draft: 'Draft',
  submitted: 'Awaiting Validation',
  validated: 'Validated',
  queried: 'Queried',
  pending_approval: 'Awaiting Approval',
  approved: 'Approved',
  rejected: 'Rejected',
  cancelled: 'Cancelled',
}

export const STATUS_COLOURS: Record<RequestStatus, string> = {
  draft: 'bg-gray-200 text-gray-600',
  submitted: 'bg-yellow-100 text-yellow-800',
  validated: 'bg-blue-100 text-blue-800',
  queried: 'bg-orange-100 text-orange-800',
  pending_approval: 'bg-purple-100 text-purple-800',
  approved: 'bg-green-100 text-green-800',
  rejected: 'bg-red-100 text-red-800',
  cancelled: 'bg-gray-200 text-gray-800',
}
