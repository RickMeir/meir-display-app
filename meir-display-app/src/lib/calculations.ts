import { ProfitabilityFlag, RequestFormInput } from './types'

// ============================================================
// Constants (matching the existing spreadsheet logic)
// ============================================================

const ORDER_PROCESSING_COST = 48       // $ per order
const AVG_ORDER_VALUE = 500            // $ for estimating order count
const REP_VISIT_COST_PER_HOUR = 50     // $ per hour
const CATALOGUE_COST_EACH = 2.50       // $ per catalogue

// Profitability thresholds (Rick's decision)
const MIN_NET_CONTRIBUTION = 5000      // $5,000
const MIN_NET_MARGIN = 0.15            // 15%

// Financial approval tiers
const TIER_MANAGER_MAX = 5000          // Up to $5,000 → Michael
const TIER_CFO_MAX = 10000             // $5,001 to $10,000 → Elan
                                        // Over $10,000 → Paul

// ============================================================
// Calculation engine
// ============================================================

export interface CalculatedFields {
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
  approval_tier: 'manager' | 'cfo' | 'coo'
}

export function calculateFinancials(input: RequestFormInput): CalculatedFields {
  // Convert percentages to decimals
  const rebateDecimal = input.rebate_pct / 100
  const cogsDecimal = input.cogs_pct / 100

  // Total Investment (what the company spends on the display)
  const catalogue_cost = input.catalogues_qty * CATALOGUE_COST_EACH
  const rep_visit_cost = input.rep_hours_monthly * REP_VISIT_COST_PER_HOUR * 12
  const total_investment = input.board_labour_cost + input.product_cogs + input.free_samples_cost + catalogue_cost

  // Revenue calculations
  const revenue_after_discount = input.forecast_revenue * (1 - cogsDecimal)
  const rebate_cost = input.forecast_revenue * rebateDecimal
  const cogs_on_sales = input.forecast_revenue * cogsDecimal

  // Order estimates
  const est_orders = AVG_ORDER_VALUE > 0 ? input.forecast_revenue / AVG_ORDER_VALUE : 0
  const order_processing = est_orders * ORDER_PROCESSING_COST

  // Costs
  const total_costs = cogs_on_sales + rebate_cost + order_processing + rep_visit_cost + catalogue_cost + total_investment

  // Profit
  const gross_profit = input.forecast_revenue - cogs_on_sales - rebate_cost
  const gross_margin = input.forecast_revenue > 0 ? gross_profit / input.forecast_revenue : 0

  // Net contribution (after all costs including display investment)
  const net_contribution = gross_profit - order_processing - rep_visit_cost - catalogue_cost - total_investment
  const net_margin = input.forecast_revenue > 0 ? net_contribution / input.forecast_revenue : 0

  // Profitability assessment
  const profitability_flag: ProfitabilityFlag =
    net_contribution >= MIN_NET_CONTRIBUTION && net_margin >= MIN_NET_MARGIN
      ? 'green'
      : 'review'

  // Approval tier routing based on total investment
  let approval_tier: 'manager' | 'cfo' | 'coo'
  if (total_investment <= TIER_MANAGER_MAX) {
    approval_tier = 'manager'
  } else if (total_investment <= TIER_CFO_MAX) {
    approval_tier = 'cfo'
  } else {
    approval_tier = 'coo'
  }

  return {
    total_investment: round2(total_investment),
    revenue_after_discount: round2(revenue_after_discount),
    rebate_cost: round2(rebate_cost),
    cogs_on_sales: round2(cogs_on_sales),
    est_orders: round2(est_orders),
    order_processing: round2(order_processing),
    rep_visit_cost: round2(rep_visit_cost),
    catalogue_cost: round2(catalogue_cost),
    total_costs: round2(total_costs),
    gross_profit: round2(gross_profit),
    gross_margin: round4(gross_margin),
    net_contribution: round2(net_contribution),
    net_margin: round4(net_margin),
    profitability_flag,
    approval_tier,
  }
}

// ============================================================
// Approval tier routing
// ============================================================

// Maps tier to the approver's email
export const TIER_APPROVER: Record<string, string> = {
  manager: 'michael@meir.com.au',
  cfo: 'elan@meir.com.au',
  coo: 'paul@meir.com.au',
}

export const TIER_LABELS: Record<string, string> = {
  manager: 'Manager (up to $5,000)',
  cfo: 'CFO ($5,001 to $10,000)',
  coo: 'COO (over $10,000)',
}

// ============================================================
// Override detection
// ============================================================

export function isOverrideApproval(profitabilityFlag: ProfitabilityFlag): boolean {
  return profitabilityFlag === 'review'
}

// People who get discrete override alerts
export const OVERRIDE_ALERT_RECIPIENTS = [
  'rick@meir.com.au',
  'paul@meir.com.au',
]

// ============================================================
// Formatting helpers
// ============================================================

export function formatCurrency(value: number): string {
  return new Intl.NumberFormat('en-AU', {
    style: 'currency',
    currency: 'AUD',
    minimumFractionDigits: 2,
  }).format(value)
}

export function formatPercent(value: number): string {
  return (value * 100).toFixed(1) + '%'
}

function round2(n: number): number {
  return Math.round(n * 100) / 100
}

function round4(n: number): number {
  return Math.round(n * 10000) / 10000
}
