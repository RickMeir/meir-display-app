import { ProfitabilityFlag, RequestFormInput } from './types'

// ============================================================
// Constants (matched to spreadsheet Assumptions tab)
// ============================================================

const ORDER_PROCESSING_COST = 48       // $ per order (dispatch)
const DEFAULT_AOV = 650                // $ default for new clients (spreadsheet Assumptions)
const REP_ANNUAL_SALARY = 120000       // $ average annual salary
const REP_WORKING_HOURS = 1920         // 48 weeks × 40 hours
const REP_HOURLY_RATE = REP_ANNUAL_SALARY / REP_WORKING_HOURS  // = $62.50/hr
const CATALOGUE_COST_EACH = 5.00       // $ per catalogue (spreadsheet Assumptions)
const BASELINE_GROWTH_RATE = 0.15      // 15% assumed YoY growth for existing clients

// Profitability thresholds
const MIN_NET_CONTRIBUTION = 2000      // $2,000 (spreadsheet Assumptions)
const MIN_NET_MARGIN = 0.15            // 15% (spreadsheet Assumptions)

// ROI verdict thresholds (Investment Forecast tab)
const ROI_WORTH_IT = 2.0
const ROI_MARGINAL = 1.0

// Financial approval tiers
const TIER_MANAGER_MAX = 10000         // Up to $10,000 → Michael
const TIER_CFO_MAX = 50000             // $10,001 to $50,000 → Elan
const TIER_COO_MAX = 100000            // $50,001 to $100,000 → Paul
                                        // Over $100,000 → Rick (admin)

// ============================================================
// Exported constants (for use in UI and other modules)
// ============================================================

export const CALC_CONSTANTS = {
  ORDER_PROCESSING_COST,
  DEFAULT_AOV,
  REP_HOURLY_RATE,
  CATALOGUE_COST_EACH,
  BASELINE_GROWTH_RATE,
  MIN_NET_CONTRIBUTION,
  MIN_NET_MARGIN,
  ROI_WORTH_IT,
  ROI_MARGINAL,
} as const

// ============================================================
// Calculation engine
// ============================================================

export type Verdict = 'worth_it' | 'marginal' | 'not_worth_it'

export interface CalculatedFields {
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
  approval_tier: 'manager' | 'cfo' | 'coo' | 'admin'
  roi_multiplier: number | null
  verdict: Verdict | null
}

export interface ExistingClientData {
  annual_revenue: number
  order_count: number
  avg_order_value: number
  cogs_pct: number
}

export function calculateFinancials(
  input: RequestFormInput,
  existingClient?: ExistingClientData | null
): CalculatedFields {
  // Convert percentages to decimals
  const rebateDecimal = input.rebate_pct / 100
  const cogsDecimal = input.cogs_pct / 100

  // Use real AOV for existing clients, default for new
  const aov = existingClient && existingClient.avg_order_value > 0
    ? existingClient.avg_order_value
    : DEFAULT_AOV

  // Total Display Investment = Board & Labour + Display Product COGS + Free Samples
  // NOTE: Catalogue cost is an operating cost, NOT part of display investment
  const total_investment = input.board_labour_cost + input.product_cogs + input.free_samples_cost

  // Revenue calculations
  // Revenue After Discount = Forecast × (1 - COGS%)
  const revenue_after_discount = input.forecast_revenue * (1 - cogsDecimal)

  // Rebate is on Revenue After Discount (not gross forecast)
  const rebate_cost = revenue_after_discount * rebateDecimal

  // Net Revenue = Revenue After Discount - Rebate Cost
  const net_revenue = revenue_after_discount - rebate_cost

  // COGS on sales = Net Revenue × COGS%
  const cogs_on_sales = net_revenue * cogsDecimal

  // Order estimates
  const est_orders = aov > 0 ? Math.round(input.forecast_revenue / aov) : 0
  const order_processing = est_orders * ORDER_PROCESSING_COST

  // Operating costs
  const rep_visit_cost = input.rep_hours_monthly * REP_HOURLY_RATE * 12
  const catalogue_cost = input.catalogues_qty * CATALOGUE_COST_EACH

  // Total costs = Order Processing + Rep Visit + Catalogue + Display Investment
  // (COGS and Rebate are already accounted for in gross profit)
  const total_costs = order_processing + rep_visit_cost + catalogue_cost + total_investment

  // Gross Profit = Net Revenue - COGS on Sales
  const gross_profit = net_revenue - cogs_on_sales
  const gross_margin = net_revenue > 0 ? gross_profit / net_revenue : 0

  // Net contribution = Gross Profit - Operating Costs - Display Investment
  const net_contribution = gross_profit - order_processing - rep_visit_cost - catalogue_cost - total_investment

  // Net margin denominator = Net Revenue (after discount and rebate)
  const net_margin = net_revenue > 0 ? net_contribution / net_revenue : 0

  // Profitability assessment
  const profitability_flag: ProfitabilityFlag =
    net_contribution >= MIN_NET_CONTRIBUTION && net_margin >= MIN_NET_MARGIN
      ? 'green'
      : 'review'

  // Approval tier routing based on total investment
  let approval_tier: 'manager' | 'cfo' | 'coo' | 'admin'
  if (total_investment <= TIER_MANAGER_MAX) {
    approval_tier = 'manager'
  } else if (total_investment <= TIER_CFO_MAX) {
    approval_tier = 'cfo'
  } else if (total_investment <= TIER_COO_MAX) {
    approval_tier = 'coo'
  } else {
    approval_tier = 'admin'
  }

  // ROI and Verdict
  let roi_multiplier: number | null = null
  let verdict: Verdict | null = null

  if (existingClient && existingClient.annual_revenue > 0) {
    // Existing client: ROI on New Spend = Incremental Margin / New Investment
    const baseline_with_growth = existingClient.annual_revenue * (1 + BASELINE_GROWTH_RATE)
    const incremental_revenue = input.forecast_revenue - baseline_with_growth
    // Calculate current net margin for baseline
    const current_cogs_decimal = existingClient.cogs_pct
    const current_rev_after_disc = existingClient.annual_revenue * (1 - current_cogs_decimal)
    const current_net_rev = current_rev_after_disc  // simplified: use approved rebate from form
    const current_gp = current_net_rev - (current_net_rev * current_cogs_decimal)
    const current_fulfilment = existingClient.order_count * ORDER_PROCESSING_COST
    const current_net_margin_val = current_gp - current_fulfilment

    const new_investment = total_investment  // the new display spend
    const incremental_margin = net_contribution - current_net_margin_val

    if (new_investment > 0) {
      roi_multiplier = incremental_margin / new_investment
    }
  } else {
    // New client: ROI = Net Contribution / Total Investment
    if (total_investment > 0) {
      roi_multiplier = net_contribution / total_investment
    }
  }

  if (roi_multiplier !== null) {
    if (roi_multiplier >= ROI_WORTH_IT) {
      verdict = 'worth_it'
    } else if (roi_multiplier >= ROI_MARGINAL) {
      verdict = 'marginal'
    } else {
      verdict = 'not_worth_it'
    }
  }

  return {
    total_investment: round2(total_investment),
    revenue_after_discount: round2(revenue_after_discount),
    net_revenue: round2(net_revenue),
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
    roi_multiplier: roi_multiplier !== null ? round4(roi_multiplier) : null,
    verdict,
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
  admin: 'rick@meir.com.au',
}

export const TIER_LABELS: Record<string, string> = {
  manager: 'Manager (up to $10,000)',
  cfo: 'CFO ($10,001 to $50,000)',
  coo: 'COO ($50,001 to $100,000)',
  admin: 'Rick (over $100,000)',
}

export const VERDICT_LABELS: Record<Verdict, string> = {
  worth_it: 'Worth It',
  marginal: 'Marginal',
  not_worth_it: 'Not Worth It',
}

export const VERDICT_COLOURS: Record<Verdict, string> = {
  worth_it: 'text-green-700 bg-green-50',
  marginal: 'text-amber-700 bg-amber-50',
  not_worth_it: 'text-red-700 bg-red-50',
}

export const VERDICT_ICONS: Record<Verdict, string> = {
  worth_it: '✅',
  marginal: '⚠️',
  not_worth_it: '❌',
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
