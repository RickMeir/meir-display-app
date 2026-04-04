// ============================================================
// Core types for Meir Display Request system
// ============================================================

export type UserRole = 'rep' | 'validator' | 'manager' | 'cfo' | 'coo' | 'admin'

export type RequestStatus =
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
  display_reason: string | null

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
  sort_order: number
}

export interface MonthlyActual {
  id: string
  request_id: string
  month_year: string
  revenue: number
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
// Form input type (what the rep submits — no calculated fields)
// ============================================================

export interface RequestFormInput {
  store_name: string
  store_code: string
  rep_name: string
  brand_tier: string
  display_type: string
  display_reason: string
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
  skus: { code: string; name: string }[]
}

// ============================================================
// Status display helpers
// ============================================================

export const STATUS_LABELS: Record<RequestStatus, string> = {
  submitted: 'Awaiting Validation',
  validated: 'Validated',
  queried: 'Queried',
  pending_approval: 'Awaiting Approval',
  approved: 'Approved',
  rejected: 'Rejected',
  cancelled: 'Cancelled',
}

export const STATUS_COLOURS: Record<RequestStatus, string> = {
  submitted: 'bg-yellow-100 text-yellow-800',
  validated: 'bg-blue-100 text-blue-800',
  queried: 'bg-orange-100 text-orange-800',
  pending_approval: 'bg-purple-100 text-purple-800',
  approved: 'bg-green-100 text-green-800',
  rejected: 'bg-red-100 text-red-800',
  cancelled: 'bg-gray-100 text-gray-800',
}
