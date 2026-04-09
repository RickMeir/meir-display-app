import { Resend } from 'resend'
import { DisplayRequest, User } from './types'
import { formatCurrency, formatPercent, TIER_LABELS, OVERRIDE_ALERT_RECIPIENTS } from './calculations'

// Lazy initialisation — avoids crash when RESEND_API_KEY is not set at build time
let _resend: InstanceType<typeof Resend> | null = null
function getResend() {
  if (!_resend) {
    const key = process.env.RESEND_API_KEY
    if (!key || key.startsWith('re_placeholder')) {
      console.warn('RESEND_API_KEY not configured — emails will not send')
      return null
    }
    _resend = new Resend(key)
  }
  return _resend
}
const FROM_EMAIL = 'Meir Displays <displays@meir.com.au>'
const APP_URL = process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000'

// Test mode: when EMAIL_TEST_RECIPIENT is set, ALL emails go to that address
// instead of the real recipients. Set in Vercel env vars for safe testing.
const TEST_RECIPIENT = process.env.EMAIL_TEST_RECIPIENT || ''

// ============================================================
// Email functions matching the existing workflow
// ============================================================

/** Sent to Brooke when a rep submits a new request */
export async function sendValidationEmail(request: DisplayRequest) {
  const link = `${APP_URL}/requests/${request.id}/validate`

  await sendEmail(
    'brooke@meir.com.au',
    `[Meir Display] ${request.store_name} — VALIDATE INPUTS`,
    `
      <h2>New Display Request — ${request.store_name}</h2>
      <p><strong>Store Code:</strong> ${request.store_code}</p>
      <p><strong>Rep:</strong> ${request.rep_name}</p>
      <p><strong>Brand Tier:</strong> ${request.brand_tier || 'Not specified'}</p>
      <p><strong>Total Investment:</strong> ${formatCurrency(request.total_investment)}</p>
      <p><strong>Forecast Revenue (12mo):</strong> ${formatCurrency(request.forecast_revenue)}</p>
      <hr/>
      <p><a href="${link}" style="display:inline-block;padding:12px 24px;background:#0074c5;color:#fff;text-decoration:none;border-radius:6px;">Review & Validate</a></p>
      <p style="color:#666;font-size:13px;">Check that the inputs are accurate, then mark as Validated or Queried.</p>
    `,
    request.id
  )
}

/** Sent to Rick (plaintext) when Brooke validates — informational only */
export async function sendDesignReviewEmail(request: DisplayRequest) {
  await sendEmail(
    'rick@meir.com.au',
    `Display Request: ${request.store_name} — For Design Review`,
    `
      <p>Display request validated for ${request.store_name} (${request.store_code}).</p>
      <p>Rep: ${request.rep_name}</p>
      <p>Brand Tier: ${request.brand_tier || 'Not specified'}</p>
      <p>Display Type: ${request.display_type || 'Not specified'}</p>
      <p>Investment: ${formatCurrency(request.total_investment)}</p>
      <p style="color:#666;">This is for your awareness — no register action needed.</p>
      <p><a href="${APP_URL}/requests/${request.id}">View request</a></p>
    `,
    request.id
  )
}

/** Sent to the appropriate financial approver based on tier */
export async function sendApprovalRequestEmail(request: DisplayRequest, approverEmail: string) {
  const link = `${APP_URL}/requests/${request.id}/approve`

  await sendEmail(
    approverEmail,
    `Display Request VALIDATED: ${request.store_name} — Financial Approval Required`,
    `
      <h2>Display Request — Financial Approval Required</h2>
      <p><strong>Store:</strong> ${request.store_name} (${request.store_code})</p>
      <p><strong>Rep:</strong> ${request.rep_name}</p>
      <p><strong>Brand Tier:</strong> ${request.brand_tier || 'Not specified'}</p>
      <table style="border-collapse:collapse;margin:12px 0;width:100%;">
        <tr>
          <td style="padding:6px 12px;font-weight:bold;">Total Investment</td>
          <td style="padding:6px 12px;">${formatCurrency(request.total_investment)}</td>
          <td style="padding:6px 12px;font-weight:bold;">Forecast Revenue</td>
          <td style="padding:6px 12px;">${formatCurrency(request.forecast_revenue)}</td>
        </tr>
        <tr>
          <td style="padding:6px 12px;font-weight:bold;">Net Contribution</td>
          <td style="padding:6px 12px;">${formatCurrency(request.net_contribution)}</td>
          <td style="padding:6px 12px;font-weight:bold;">Net Margin</td>
          <td style="padding:6px 12px;">${formatPercent(request.net_margin)}</td>
        </tr>
        ${request.roi_multiplier != null ? `
        <tr>
          <td style="padding:6px 12px;font-weight:bold;">ROI Multiplier</td>
          <td style="padding:6px 12px;">${request.roi_multiplier.toFixed(2)}x</td>
          <td style="padding:6px 12px;font-weight:bold;">Verdict</td>
          <td style="padding:6px 12px;font-weight:bold;color:${request.verdict === 'worth_it' ? '#16a34a' : request.verdict === 'marginal' ? '#d97706' : '#dc2626'};">${request.verdict === 'worth_it' ? 'Worth It' : request.verdict === 'marginal' ? 'Marginal' : 'Not Worth It'}</td>
        </tr>
        ` : ''}
      </table>
      ${request.has_initial_order && request.initial_order_value > 0 ? `
      <p style="background:#eff6ff;padding:8px 12px;border-radius:4px;font-size:13px;">
        <strong>Initial Order:</strong> ${formatCurrency(request.initial_order_value)} committed
        ${request.forecast_revenue > 0 ? ` (${Math.round((request.initial_order_value / request.forecast_revenue) * 100)}% of forecast)` : ''}
      </p>` : ''}
      ${request.is_existing_client && request.existing_annual_revenue > 0 ? `
      <p style="background:#eff6ff;padding:8px 12px;border-radius:4px;font-size:13px;">
        <strong>Existing Client:</strong> Current revenue ${formatCurrency(request.existing_annual_revenue)}.
        Incremental revenue from display: ${formatCurrency(request.incremental_revenue)}.
      </p>` : ''}
      <p><strong>Approval Tier:</strong> ${TIER_LABELS[request.approval_tier || 'manager']}</p>
      <p><strong>Deal Status:</strong> <span style="color:${request.profitability_flag === 'green' ? '#16a34a' : '#dc2626'};font-weight:bold;">${request.profitability_flag === 'green' ? 'GREEN — Viable' : 'REVIEW — Below thresholds'}</span></p>
      <hr/>
      <p><a href="${link}" style="display:inline-block;padding:12px 24px;background:#0074c5;color:#fff;text-decoration:none;border-radius:6px;">Review & Approve</a></p>
    `,
    request.id
  )
}

/** Sent to CS team when approved */
export async function sendCSProcessingEmail(request: DisplayRequest, approverName?: string) {
  const approvedDate = request.approved_at
    ? new Date(request.approved_at).toLocaleString('en-AU', { dateStyle: 'medium', timeStyle: 'short' })
    : new Date().toLocaleString('en-AU', { dateStyle: 'medium', timeStyle: 'short' })

  await sendEmail(
    'sales@meir.com.au',
    `APPROVED — Display Order: ${request.store_name} — Please Process`,
    `
      <h2>Display Order Approved — Please Process</h2>
      <p><strong>Store:</strong> ${request.store_name} (${request.store_code})</p>
      <p><strong>Rep:</strong> ${request.rep_name}</p>
      <p><strong>Brand Tier:</strong> ${request.brand_tier || 'Not specified'}</p>
      <p><strong>Display Type:</strong> ${request.display_type || 'Not specified'}</p>
      <p><strong>Total Investment:</strong> ${formatCurrency(request.total_investment)}</p>
      <table style="border-collapse:collapse;margin:12px 0;background:#f0fdf4;border:1px solid #bbf7d0;border-radius:4px;">
        <tr>
          <td style="padding:8px 12px;font-weight:bold;color:#166534;">Approved By:</td>
          <td style="padding:8px 12px;color:#166534;">${approverName || request.approval_tier?.toUpperCase() || 'Manager'}</td>
        </tr>
        <tr>
          <td style="padding:8px 12px;font-weight:bold;color:#166534;">Approved At:</td>
          <td style="padding:8px 12px;color:#166534;">${approvedDate}</td>
        </tr>
        ${request.approval_note ? `
        <tr>
          <td style="padding:8px 12px;font-weight:bold;color:#166534;">Approval Note:</td>
          <td style="padding:8px 12px;color:#166534;">${request.approval_note}</td>
        </tr>` : ''}
      </table>
      <hr/>
      <p>Please create a Display Order (DO) in Acumatica for this request.</p>
      <p>Once created, enter the reference number in the system:</p>
      <p><a href="${APP_URL}/requests/${request.id}" style="display:inline-block;padding:12px 24px;background:#0074c5;color:#fff;text-decoration:none;border-radius:6px;">Update CS Reference</a></p>
      <p style="color:#c00;font-weight:bold;">Only process orders that appear in this system with status "Approved".</p>
    `,
    request.id
  )
}

/** Sent to Brooke AND the submitting rep when financially approved */
export async function sendApprovalConfirmationEmail(request: DisplayRequest) {
  const recipients = ['brooke@meir.com.au']
  if (request.rep_name && request.rep_name.includes('@')) {
    recipients.push(request.rep_name)
  }

  for (const email of recipients) {
    await sendEmail(
      email,
      `Display Approved: ${request.store_name}`,
      `
        <p>The display request for <strong>${request.store_name}</strong> has been financially approved.</p>
        <p>Approved by: ${request.approval_tier?.toUpperCase()}</p>
        <p><a href="${APP_URL}/requests/${request.id}">View request</a></p>
      `,
      request.id
    )
  }
}

/** Sent to Brooke, Michael, AND the submitting rep when rejected */
export async function sendRejectionEmail(request: DisplayRequest, note: string) {
  const recipients = ['brooke@meir.com.au', 'michael@meir.com.au']
  if (request.rep_name && request.rep_name.includes('@')) {
    recipients.push(request.rep_name)
  }

  for (const email of recipients) {
    await sendEmail(
      email,
      `Display REJECTED: ${request.store_name}`,
      `
        <p>The display request for <strong>${request.store_name}</strong> has been rejected.</p>
        <p><strong>Reason:</strong> ${note || 'No reason provided'}</p>
        <p><a href="${APP_URL}/requests/${request.id}">View request</a></p>
      `,
      request.id
    )
  }
}

/** DISCRETE alert to Rick + Paul when a manager overrides a 'review' flag */
export async function sendOverrideAlertEmail(request: DisplayRequest, approverName: string) {
  for (const email of OVERRIDE_ALERT_RECIPIENTS) {
    await sendEmail(
      email,
      `Override Alert: ${request.store_name} approved despite review flag`,
      `
        <p style="color:#c00;"><strong>Override Notice</strong></p>
        <p>${approverName} approved a display request that was flagged for review.</p>
        <p><strong>Store:</strong> ${request.store_name} (${request.store_code})</p>
        <p><strong>Investment:</strong> ${formatCurrency(request.total_investment)}</p>
        <p><strong>Net Contribution:</strong> ${formatCurrency(request.net_contribution)}</p>
        <p><strong>Net Margin:</strong> ${formatPercent(request.net_margin)}</p>
        <p><a href="${APP_URL}/requests/${request.id}">View request</a></p>
        <p style="color:#666;font-size:12px;">This notification is not visible to the approver.</p>
      `,
      request.id
    )
  }
}

/** Sent to Rick, Paul, and the rep when a lifecycle review is completed as off_track */
export async function sendOffTrackAlertEmail(
  request: DisplayRequest,
  reviewInterval: string,
  variancePct: number,
  expectedRevenue: number,
  actualRevenue: number,
  reviewerName: string
) {
  const recipients = ['rick@meir.com.au', 'paul@meir.com.au']
  // Also notify the rep if we have their email
  if (request.rep_name && request.rep_name.includes('@')) {
    recipients.push(request.rep_name)
  }

  const varianceDisplay = Math.abs(variancePct).toFixed(1)

  for (const email of recipients) {
    await sendEmail(
      email,
      `OFF TRACK: ${request.store_name} — ${reviewInterval} Review`,
      `
        <p style="color:#c00;font-weight:bold;">Off Track Alert — Lifecycle Review</p>
        <p>The <strong>${reviewInterval}</strong> review for <strong>${request.store_name}</strong> (${request.store_code}) has been completed and the display is <strong>off track</strong>.</p>
        <table style="border-collapse:collapse;margin:12px 0;">
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Expected Revenue:</td><td>${formatCurrency(expectedRevenue)}</td></tr>
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Actual Revenue:</td><td>${formatCurrency(actualRevenue)}</td></tr>
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Variance:</td><td style="color:#c00;">-${varianceDisplay}%</td></tr>
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Reviewed By:</td><td>${reviewerName}</td></tr>
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Rep:</td><td>${request.rep_name}</td></tr>
        </table>
        <p><a href="${APP_URL}/requests/${request.id}/lifecycle" style="display:inline-block;padding:12px 24px;background:#c00;color:#fff;text-decoration:none;border-radius:6px;">View Lifecycle</a></p>
      `,
      request.id
    )
  }
}

/** Sent to Rick and Paul when a forecast is changed */
export async function sendForecastChangeEmail(
  request: DisplayRequest,
  oldForecast: number,
  newForecast: number,
  changePct: number,
  reason: string,
  changedByName: string,
  newProfitabilityFlag: string
) {
  const recipients = ['rick@meir.com.au', 'paul@meir.com.au']
  const direction = changePct > 0 ? 'increased' : 'decreased'
  const flagColour = newProfitabilityFlag === 'green' ? '#16a34a' : '#c00'
  const flagLabel = newProfitabilityFlag === 'green' ? 'GREEN — Viable' : 'REVIEW — Below thresholds'

  for (const email of recipients) {
    await sendEmail(
      email,
      `Forecast Changed: ${request.store_name} — ${direction} ${Math.abs(changePct).toFixed(1)}%`,
      `
        <p><strong>Forecast Revenue Changed</strong></p>
        <p>The forecast for <strong>${request.store_name}</strong> (${request.store_code}) has been ${direction}.</p>
        <table style="border-collapse:collapse;margin:12px 0;">
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Previous Forecast:</td><td>${formatCurrency(oldForecast)}</td></tr>
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">New Forecast:</td><td>${formatCurrency(newForecast)}</td></tr>
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Change:</td><td>${changePct > 0 ? '+' : ''}${changePct.toFixed(1)}%</td></tr>
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Deal Status:</td><td style="color:${flagColour};">${flagLabel}</td></tr>
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Changed By:</td><td>${changedByName}</td></tr>
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Reason:</td><td>${reason || 'No reason provided'}</td></tr>
        </table>
        <p><a href="${APP_URL}/requests/${request.id}/lifecycle" style="display:inline-block;padding:12px 24px;background:#0074c5;color:#fff;text-decoration:none;border-radius:6px;">View Lifecycle</a></p>
      `,
      request.id
    )
  }
}

/** Sent to Rick + Paul when a new additional expense is proposed */
export async function sendExpenseProposedEmail(
  request: DisplayRequest,
  category: string,
  amount: number,
  rationale: string,
  expenseRound: number,
  makesUnviable: boolean,
  requestedByName: string
) {
  const recipients = ['rick@meir.com.au', 'paul@meir.com.au']
  const viabilityWarning = makesUnviable
    ? '<p style="color:#dc2626;font-weight:bold;">This expense would push the display below viability thresholds.</p>'
    : ''
  const spiralWarning = expenseRound >= 2
    ? `<p style="color:#d97706;font-weight:bold;">Expense spiral detected — this is round ${expenseRound} of additional spend.</p>`
    : ''

  for (const email of recipients) {
    await sendEmail(
      email,
      `Additional Expense Proposed: ${request.store_name} — ${formatCurrency(amount)}`,
      `
        <h2>Additional Expense Proposed</h2>
        <p>A new expense has been submitted for <strong>${request.store_name}</strong> (${request.store_code}).</p>
        ${spiralWarning}
        ${viabilityWarning}
        <table style="border-collapse:collapse;margin:12px 0;">
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Category:</td><td>${category}</td></tr>
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Amount:</td><td>${formatCurrency(amount)}</td></tr>
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Rationale:</td><td>${rationale || 'Not provided'}</td></tr>
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Requested By:</td><td>${requestedByName}</td></tr>
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Expense Round:</td><td>${expenseRound}</td></tr>
        </table>
        <p><a href="${APP_URL}/requests/${request.id}/lifecycle" style="display:inline-block;padding:12px 24px;background:#0074c5;color:#fff;text-decoration:none;border-radius:6px;">Review Expense</a></p>
      `,
      request.id
    )
  }
}

/** Sent to Rick + Paul + requester when an expense is approved or rejected */
export async function sendExpenseDecisionEmail(
  request: DisplayRequest,
  category: string,
  amount: number,
  decision: 'approved' | 'rejected',
  decisionNote: string | null,
  expenseRound: number,
  makesUnviable: boolean
) {
  const recipients = ['rick@meir.com.au', 'paul@meir.com.au']
  const isApproved = decision === 'approved'
  const statusColour = isApproved ? '#16a34a' : '#dc2626'
  const statusLabel = isApproved ? 'APPROVED' : 'REJECTED'
  const viabilityWarning = isApproved && makesUnviable
    ? '<p style="color:#dc2626;font-weight:bold;">Warning: This approved expense pushes the display below viability thresholds.</p>'
    : ''

  for (const email of recipients) {
    await sendEmail(
      email,
      `Expense ${statusLabel}: ${request.store_name} — ${formatCurrency(amount)}`,
      `
        <h2>Additional Expense ${statusLabel}</h2>
        <p>An expense for <strong>${request.store_name}</strong> (${request.store_code}) has been <span style="color:${statusColour};font-weight:bold;">${statusLabel}</span>.</p>
        ${viabilityWarning}
        <table style="border-collapse:collapse;margin:12px 0;">
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Category:</td><td>${category}</td></tr>
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Amount:</td><td>${formatCurrency(amount)}</td></tr>
          ${decisionNote ? `<tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Note:</td><td>${decisionNote}</td></tr>` : ''}
          <tr><td style="padding:4px 12px 4px 0;font-weight:bold;">Expense Round:</td><td>${expenseRound}</td></tr>
        </table>
        <p><a href="${APP_URL}/requests/${request.id}/lifecycle" style="display:inline-block;padding:12px 24px;background:#0074c5;color:#fff;text-decoration:none;border-radius:6px;">View Lifecycle</a></p>
      `,
      request.id
    )
  }
}

/** Sent to the submitting rep (and Brooke for visibility) when a request is queried */
export async function sendQueryEmail(request: DisplayRequest, note: string) {
  const recipients: string[] = []
  // Primary recipient: the rep who submitted it
  if (request.rep_name && request.rep_name.includes('@')) {
    recipients.push(request.rep_name)
  }
  // Brooke always gets a copy for visibility
  recipients.push('brooke@meir.com.au')

  for (const email of recipients) {
    await sendEmail(
      email,
      `Display Request QUERIED: ${request.store_name} — Inputs Need Correction`,
      `
        <p>The display request for <strong>${request.store_name}</strong> has been queried and needs correction.</p>
        <p><strong>Issue:</strong> ${note}</p>
        <p><a href="${APP_URL}/requests/${request.id}">View request</a></p>
      `,
      request.id
    )
  }
}

// ============================================================
// Core send function
// ============================================================

async function sendEmail(to: string, subject: string, htmlBody: string, requestId?: string) {
  try {
    const resend = getResend()
    if (!resend) {
      console.warn(`Email skipped (no API key): ${subject} → ${to}`)
      return
    }

    // In test mode, redirect to the test recipient and show who it WOULD have gone to
    const actualTo = TEST_RECIPIENT || to
    const actualSubject = TEST_RECIPIENT
      ? `[TEST → ${to}] ${subject}`
      : subject

    await resend.emails.send({
      from: FROM_EMAIL,
      to: actualTo,
      subject: actualSubject,
      html: wrapHtml(TEST_RECIPIENT ? `<p style="background:#fff3cd;padding:8px;border:1px solid #ffc107;border-radius:4px;font-size:12px;"><strong>TEST MODE:</strong> This email would normally go to <strong>${to}</strong></p>${htmlBody}` : htmlBody),
    })

    // Log to notifications table if we have a service client
    if (requestId) {
      try {
        const { createServiceClient } = await import('./supabase/server')
        const supabase = createServiceClient()
        await supabase.from('notifications').insert({
          request_id: requestId,
          recipient_email: to,
          subject,
          body: htmlBody,
          sent_at: new Date().toISOString(),
        })
      } catch {
        // Non-critical: notification logging failed
      }
    }
  } catch (error) {
    console.error(`Failed to send email to ${to}:`, error)

    // Log the failure
    if (requestId) {
      try {
        const { createServiceClient } = await import('./supabase/server')
        const supabase = createServiceClient()
        await supabase.from('notifications').insert({
          request_id: requestId,
          recipient_email: to,
          subject,
          body: htmlBody,
          error: String(error),
        })
      } catch {
        // Non-critical
      }
    }
  }
}

function wrapHtml(body: string): string {
  return `
    <div style="font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;max-width:600px;margin:0 auto;padding:20px;color:#333;">
      ${body}
      <hr style="margin-top:30px;border:none;border-top:1px solid #ddd;"/>
      <p style="color:#999;font-size:12px;">Meir Display Management System</p>
    </div>
  `
}
