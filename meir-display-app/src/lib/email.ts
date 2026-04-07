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
      <p><strong>Total Investment:</strong> ${formatCurrency(request.total_investment)}</p>
      <p><strong>Approval Tier:</strong> ${TIER_LABELS[request.approval_tier || 'manager']}</p>
      <p><strong>Net Contribution:</strong> ${formatCurrency(request.net_contribution)}</p>
      <p><strong>Net Margin:</strong> ${formatPercent(request.net_margin)}</p>
      <p><strong>Deal Status:</strong> ${request.profitability_flag === 'green' ? 'GREEN — Viable' : 'REVIEW — Below thresholds'}</p>
      <hr/>
      <p><a href="${link}" style="display:inline-block;padding:12px 24px;background:#0074c5;color:#fff;text-decoration:none;border-radius:6px;">Review & Approve</a></p>
    `,
    request.id
  )
}

/** Sent to CS team when approved */
export async function sendCSProcessingEmail(request: DisplayRequest) {
  await sendEmail(
    'sales@meir.com.au',
    `APPROVED — Display Order: ${request.store_name} — Please Process`,
    `
      <h2>Display Order Approved — Please Process</h2>
      <p><strong>Store:</strong> ${request.store_name} (${request.store_code})</p>
      <p><strong>Rep:</strong> ${request.rep_name}</p>
      <p><strong>Total Investment:</strong> ${formatCurrency(request.total_investment)}</p>
      <p><strong>Brand Tier:</strong> ${request.brand_tier || 'Not specified'}</p>
      <hr/>
      <p>Please create a Display Order (DO) in Acumatica for this request.</p>
      <p>Once created, enter the reference number in the system:</p>
      <p><a href="${APP_URL}/requests/${request.id}">Update CS Reference</a></p>
      <p style="color:#c00;font-weight:bold;">Only process orders that appear in this system with status "Approved".</p>
    `,
    request.id
  )
}

/** Sent to Brooke when financially approved */
export async function sendApprovalConfirmationEmail(request: DisplayRequest) {
  await sendEmail(
    'brooke@meir.com.au',
    `Display Approved: ${request.store_name}`,
    `
      <p>The display request for <strong>${request.store_name}</strong> has been financially approved.</p>
      <p>Approved by: ${request.approval_tier?.toUpperCase()}</p>
      <p><a href="${APP_URL}/requests/${request.id}">View request</a></p>
    `,
    request.id
  )
}

/** Sent to Brooke + Michael when rejected */
export async function sendRejectionEmail(request: DisplayRequest, note: string) {
  const recipients = ['brooke@meir.com.au', 'michael@meir.com.au']
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

/** Sent when Brooke queries a request */
export async function sendQueryEmail(request: DisplayRequest, note: string) {
  // Notify the submitting rep
  await sendEmail(
    'brooke@meir.com.au', // For now goes to Brooke; in future, to the rep directly
    `Display Request QUERIED: ${request.store_name} — Inputs Need Correction`,
    `
      <p>The display request for <strong>${request.store_name}</strong> has been queried.</p>
      <p><strong>Issue:</strong> ${note}</p>
      <p><a href="${APP_URL}/requests/${request.id}">View request</a></p>
    `,
    request.id
  )
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
