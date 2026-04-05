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
