# Meir Display App — Process Map

> **This is the single source of truth for what the app does.**
> Updated: 9 April 2026
>
> RULES FOR CLAUDE:
> 1. Read this file at the start of every session.
> 2. Before changing any behaviour in the app, update this file FIRST.
> 3. If something in the code contradicts this file, flag it — do not silently override.
> 4. Every step listed here maps to real code. If it is not here, it is not built.

---

## PHASE 1: Rep Creates a Display Request

### 1.1 Rep logs in
- Magic link auth via Supabase (email based, no password).
- On page load, system detects logged in user's email.
- If email matches a user with role='rep', their name is shown in a green banner: "Logged in as {name}".
- Sales Rep dropdown is pre selected to their email.
- Rep can override the dropdown if the detection is wrong.
- **File:** `src/app/requests/new/page.tsx` init useEffect.

### 1.2 Rep fills Store Details
- **Sales Rep** (dropdown, auto detected from login). Options: all users where role='rep' and is_active=true.
- **Is Existing Client** (toggle).
  - YES: search dropdown queries `client_baseline` table by `customer_group` (case insensitive partial match, top 50 by net_sales desc). Selecting a client auto fills store_name, store_code, rebate_pct, cogs_pct from baseline data.
  - NO: free text `store_name`. Store code is not shown (CS creates it later).
- **Display Type** (dropdown): Freestanding, Shelf, Counter, Wall, End Cap, Other.
- **Is New / Replacement / Update** (radio).
- **Brand Tier** (visual selector with images, only shown if not "update"): High end, Premium, Mid range, Basic.
- **File:** `src/app/requests/new/page.tsx` Store Details section.

### 1.3 Rep fills Opportunity Details
- **Opportunity Description** (textarea, required).
- **Competitor Brands** (textarea, required — 3 closest competitors).
- **Brand Acknowledged** (checkbox, required).
- **Planned Install Date** (date picker, required).
- **Differentiation Plan** (textarea).
- **Store Agreed Location** (checkbox).
- **File:** `src/app/requests/new/page.tsx` Opportunity section.

### 1.4 Rep selects Display Products (SKUs)
- Minimum 1 SKU row. Can add more.
- Each row: SKU dropdown (from products table, paginated in 1000 row batches), Qty (default 1), Colour (read only, decoded from SKU suffix), Unit Cost (read only, from products table).
- **Colour decoding:** last segment after hyphen mapped via COLOUR_MAP constant. Examples: CH=Champagne, BK=Matte Black, PVDGM=Gun Metal. Colour is for rep awareness only, not stored separately.
- **Auto fittings:** system compares selected SKU codes against `display_fittings.trigger_prefixes`. For each match: total_qty = qty_per_sku x count of triggering SKUs. total_cost = total_qty x unit_cost.
- **Product COGS calculated client side:** sum(sku.unitCost x sku.qty) + sum(matched fittings total_cost).
- **File:** `src/app/requests/new/page.tsx` SKU section + fittings matching logic. Products API: `src/app/api/products/route.ts` (paginated). Fittings API: `src/app/api/fittings/route.ts`.

### 1.5 Rep uploads photos
- Three categories: Location (required, at least 1), Design rendering (optional), Current display (optional, if replacing).
- Upload via POST `/api/photos/upload`. Validated: JPEG/PNG/WebP/HEIC/HEIF only, max 10MB.
- Stored in Supabase Storage bucket "display photos". Metadata saved to `request_photos` table.
- Tips shown to rep for good photo quality (stand back, show context, show surrounding brands).
- **File:** `src/app/requests/new/page.tsx` PhotoUploader component. API: `src/app/api/photos/upload/route.ts`.

### 1.6 Rep enters Financial Data (ALL MANDATORY)
- **Rebate %** — enter 0 if none.
- **Client Discount % (COGS %)** — enter 0 if none.
- **Board Cost $** — enter 0 if none.
- **Labour Cost $** — enter 0 if none.
- **12 Month Sales Forecast $** — IMMUTABLE after submission.
- **Rep Hours Per Month** — enter 0 if none.
- **Free Samples $** — enter 0 if none.
- **Gifts $** — enter 0 if none.
- **Catalogues Per Year** — enter 0 if none.
- **Initial Order** (checkbox): has the store committed to an initial order?
  - YES: Initial Order Value $ and optional notes.
  - NO: value set to 0.
- Every field has a red asterisk and "Enter 0 if none" helper text. If any are blank, form will not submit and shows error: "the ROI calculation depends on it".
- **File:** `src/app/requests/new/page.tsx` Financial Details section + validateForm().

### 1.7 Validation before submit
All of the following must pass or submission is blocked with a specific error message:
- Sales Rep not empty.
- Store Name not empty.
- Brand Tier selected (unless "update").
- Display Type selected.
- Opportunity Description not empty.
- Competitor Brands not empty.
- Brand Acknowledged checked.
- Planned Install Date set.
- Is New/Replacement selected.
- ALL 9 financial fields not blank (see 1.6).
- At least 1 location photo uploaded.
- At least 1 SKU with both code and name.
- **File:** `src/app/requests/new/page.tsx` validateForm().

### 1.8 Rep saves draft (optional)
- No validation required for drafts.
- POST `/api/requests` with save_as='draft'. Status set to 'draft', submitted_at=null.
- Draft ID stored in URL so rep can resume later.
- "Draft saved" confirmation shown for 3 seconds.
- **File:** `src/app/requests/new/page.tsx` handleSaveDraft(). API: `src/app/api/requests/route.ts`.

### 1.9 Rep submits request
- Calls validateForm() — blocks if any check fails.
- POST `/api/requests` with save_as='submit' (or PUT if updating existing draft).
- **File:** `src/app/requests/new/page.tsx` handleSubmit(). API: `src/app/api/requests/route.ts`.

---

## PHASE 2: Server Side Processing on Submit

### 2.1 Auth check
- User must be authenticated. 401 if not.

### 2.2 Client baseline lookup
- If is_existing_client=true AND store_name exists: query `client_baseline` where customer_group = store_name.
- Extracts: annual_revenue (net_sales), order_count, avg_order_value, cogs_pct.
- If not found or new client: existingClientData = null.
- **File:** `src/app/api/requests/route.ts` lines 38-56.

### 2.3 Financial calculations (calculation engine)
- Called: `calculateFinancials(input, existingClientData)`.
- **File:** `src/lib/calculations.ts`.

#### Constants:
| Constant | Value | Purpose |
|---|---|---|
| ORDER_PROCESSING_COST | $48 | Per order dispatch cost |
| DEFAULT_AOV | $650 | Average order value for new clients |
| REP_ANNUAL_SALARY | $120,000 | Used to derive hourly rate |
| REP_WORKING_HOURS | 1,920 | 48 weeks x 40 hours |
| REP_HOURLY_RATE | $62.50/hr | Salary / working hours |
| CATALOGUE_COST_EACH | $5.00 | Per catalogue |
| BASELINE_GROWTH_RATE | 15% | Expected organic growth for existing clients |
| MIN_NET_CONTRIBUTION | $2,000 | Green profitability threshold |
| MIN_NET_MARGIN | 15% | Green profitability threshold |

#### Calculation sequence:
```
1. rebateDecimal = rebate_pct / 100
   cogsDecimal = cogs_pct / 100

2. aov = existingClient.avg_order_value (if > 0) else $650

3. total_investment = board_labour_cost + product_cogs + free_samples_cost

4. revenue_after_discount = forecast_revenue x (1 - cogsDecimal)
   rebate_cost = revenue_after_discount x rebateDecimal
   net_revenue = revenue_after_discount - rebate_cost

5. cogs_on_sales = net_revenue x cogsDecimal

6. est_orders = ROUND(forecast_revenue / aov)
   order_processing = est_orders x $48

7. rep_visit_cost = rep_hours_monthly x $62.50 x 12
   catalogue_cost = catalogues_qty x $5.00

8. total_costs = order_processing + rep_visit_cost + catalogue_cost + total_investment

9. gross_profit = net_revenue - cogs_on_sales
   gross_margin = gross_profit / net_revenue (if net_revenue > 0)

10. net_contribution = gross_profit - order_processing - rep_visit_cost - catalogue_cost - total_investment
    net_margin = net_contribution / net_revenue (if net_revenue > 0)

11. profitability_flag:
    GREEN if net_contribution >= $2,000 AND net_margin >= 15%
    REVIEW otherwise

12. approval_tier:
    manager if total_investment <= $5,000
    cfo if total_investment <= $10,000
    coo if total_investment > $10,000
```

#### ROI calculation:
```
IF existing client with annual_revenue > 0:
  baseline_with_growth = annual_revenue x 1.15
  incremental_revenue = forecast_revenue - baseline_with_growth
  [calculates current margin from baseline data]
  incremental_margin = net_contribution - current_net_margin_val
  roi_multiplier = incremental_margin / total_investment

ELSE (new client):
  roi_multiplier = net_contribution / total_investment

VERDICT:
  Worth It if roi_multiplier >= 2.0
  Marginal if roi_multiplier >= 1.0
  Not Worth It if roi_multiplier < 1.0
```

### 2.4 Database writes
1. INSERT into `display_requests` — full record with all inputs, calculated outputs, status='pending_validation' (or 'draft').
2. INSERT into `display_skus` — one row per SKU with request_id, sku_code, sku_name, quantity, unit_cost, line_cost.
3. INSERT into `audit_log` — action='submitted', performed_by=user.id, details includes SKU count.
- **File:** `src/app/api/requests/route.ts`.

### 2.5 Validation email sent
- Only if not a draft.
- `sendValidationEmail()` to brooke@meir.com.au.
- Subject: "[Meir Display] {store_name} — VALIDATE INPUTS".
- Contains: store details, financial summary, link to validation page.
- **File:** `src/lib/email.ts` sendValidationEmail().

---

## PHASE 3: Brooke Validates

### 3.1 Brooke opens validation page
- Link from email: `/requests/{id}/validate`.
- Sees full request details, financial summary, ROI, profitability flag.
- Two actions: Validate or Query.
- **File:** `src/app/requests/[id]/validate/page.tsx`.

### 3.2a Brooke validates (inputs are correct)
- Brooke clicks "Validate and Proceed".
- **Confirmation dialog appears:** "You are about to validate this request for {store}. This will send it to {approver name} for financial approval. An email will be sent immediately and cannot be recalled."
- Brooke must click "Yes, validate and send" to proceed. Cancel returns to the review.
- POST `/api/requests/{id}/validate` with action='validate'.
- Server side:
  1. Auth + role check (must be validator or admin).
  2. Determine approval tier and look up approver from users table.
  3. UPDATE display_requests: status='pending_approval', validated_by=brooke.id, validated_at=now, routed_to=approver.id.
  4. INSERT audit_log: action='validated'.
  5. Send `sendDesignReviewEmail()` to rick@meir.com.au (FYI, plaintext, no action needed).
  6. Send `sendApprovalRequestEmail()` to the financial approver (michael/elan/paul based on tier).
- **File:** `src/app/requests/[id]/validate/page.tsx` (confirmation dialog) + `src/app/api/requests/[id]/validate/route.ts` (server).

### 3.2b Brooke queries (inputs need fixing)
- POST `/api/requests/{id}/validate` with action='query', note='{explanation}'.
- Server side:
  1. UPDATE display_requests: status='queried', validation_note=note.
  2. INSERT audit_log: action='queried'.
  3. Send query notification email.
- Query email goes to the rep (primary) AND Brooke (for visibility).
- **File:** `src/app/api/requests/[id]/validate/route.ts`.

---

## PHASE 4: Financial Approval

### 4.1 Approver opens approval page
- Link from email: `/requests/{id}/approve`.
- Sees all financial details, ROI analysis, verdict, profitability flag.
- Two actions: Approve (note optional) or Reject (note required).
- **File:** `src/app/requests/[id]/approve/page.tsx`.

### 4.2 Approver tier routing
| Total Investment | Approver | Role |
|---|---|---|
| Up to $5,000 | Michael (michael@meir.com.au) | manager |
| $5,001 to $10,000 | Elan (elan@meir.com.au) | cfo |
| Over $10,000 | Paul (paul@meir.com.au) | coo |

### 4.3a Approver approves
- POST `/api/requests/{id}/approve` with action='approve', note (optional).
- Server side:
  1. Auth check — user role must match approval_tier (or admin).
  2. Check if profitability_flag='review'. If so, set was_override=true.
  3. UPDATE display_requests: status='approved', approved_by=user.id, approved_at=now, approval_note, was_override.
  4. INSERT audit_log: action='approved'.
  5. Send `sendCSProcessingEmail()` to sales@meir.com.au with approver name, timestamp, and note.
  6. Send `sendApprovalConfirmationEmail()` to brooke@meir.com.au.
  7. IF was_override: send `sendOverrideAlertEmail()` to rick@meir.com.au AND paul@meir.com.au. This email is NOT visible to the approver.
- **File:** `src/app/api/requests/[id]/approve/route.ts`.

### 4.3b Approver rejects
- POST `/api/requests/{id}/approve` with action='reject', note (required).
- Server side:
  1. UPDATE display_requests: status='rejected', approval_note=note.
  2. INSERT audit_log: action='rejected'.
  3. Send `sendRejectionEmail()` to brooke@meir.com.au AND michael@meir.com.au.
- Rep is also notified (in addition to Brooke and Michael).
- **File:** `src/app/api/requests/[id]/approve/route.ts`.

---

## PHASE 5: CS Processing

### 5.1 CS receives processing email
- Subject: "APPROVED — Display Order: {store_name} — Please Process".
- Contains: store details, total investment, approver name/timestamp/note, brand tier, display type.
- Instruction: create Display Order (DO) in Acumatica, enter reference number.
- CS Team email: sales@meir.com.au.
- **File:** `src/lib/email.ts` sendCSProcessingEmail().

### 5.2 CS creates store code and DO
- CS creates store code in Acumatica (not in the app — this is why store code was removed from the form).
- CS enters Acumatica DO reference number back into the system.
- **STATUS:** The UI for CS to enter the reference number exists but needs verification.

---

## PHASE 6: Post Approval Lifecycle

### 6.1 Additional expenses
- Categories: rep_hours, gifts, rebates, discounts, marketing, catalogues, other.
- Stored in `additional_expenses` table with status: proposed/approved/rejected.
- Triggers alert email to rick@meir.com.au and paul@meir.com.au if:
  - 2nd+ expense round (expense spiral detected), OR
  - Expense would push display below viability thresholds.
- **File:** `src/app/api/requests/[id]/expenses/route.ts`.

### 6.2 Forecast changes
- Rep or authorised user can update the 12 month forecast.
- Stored in `forecast_changes` table with old and new values.
- Triggers email to rick@meir.com.au and paul@meir.com.au with before/after financials and profitability flag change.
- **File:** `src/app/api/requests/[id]/forecast/route.ts`.

### 6.3 Monthly actuals
- Monthly revenue and catalogue usage entered (manual or Acumatica — Acumatica automation PINNED for later, blocked on Paul).
- Stored in `monthly_actuals` table (request_id, month_year, revenue, catalogues, source).
- **File:** `src/app/api/requests/[id]/actuals/route.ts`.

### 6.4 Lifecycle reviews
- Scheduled at 3, 6, 9, 12 months.
- Compares actual vs expected revenue at each milestone.
- Marked as on_track or off_track.
- If off_track: alert email to rick@meir.com.au, paul@meir.com.au, and the rep.
- Stored in `lifecycle_reviews` table.
- **File:** `src/app/api/requests/[id]/lifecycle/route.ts`.

---

## PHASE 7: Reporting and Export

### 7.1 CSV exports
- Available to admin, cfo, manager roles.
- Export types: requests, actuals, expenses, forecast_changes, lifecycle_reviews, audit_log, expected_performance, skus.
- **File:** `src/app/api/export/route.ts`.

### 7.2 Monthly summary reports
- **STATUS:** Exists in the Google Sheet script (1st of month, 8am, to Rick/Sophia/Elan/Paul/Brooke/Michael). NOT yet built in the web app.

---

## ALL EMAILS (complete list)

| Trigger | Function | To | Subject |
|---|---|---|---|
| Rep submits | sendValidationEmail | brooke@meir.com.au | [Meir Display] {store} — VALIDATE INPUTS |
| Brooke validates | sendDesignReviewEmail | rick@meir.com.au | Display Request: {store} — For Design Review |
| Brooke validates | sendApprovalRequestEmail | michael/elan/paul | Display Request VALIDATED: {store} — Financial Approval Required |
| Brooke queries | sendQueryEmail | rep + brooke | Display Request QUERIED: {store} — Inputs Need Correction |
| Approver approves | sendCSProcessingEmail | sales@meir.com.au | APPROVED — Display Order: {store} — Please Process |
| Approver approves | sendApprovalConfirmationEmail | brooke + rep | Display Approved: {store} |
| Approver approves (override) | sendOverrideAlertEmail | rick + paul | Override Alert: {store} approved despite review flag |
| Approver rejects | sendRejectionEmail | brooke + michael + rep | Display REJECTED: {store} |
| Forecast changed | sendForecastChangeEmail | rick + paul | Forecast Changed: {store} — {direction} {pct}% |
| Expense proposed | sendExpenseProposedEmail | rick + paul | Additional Expense Proposed: {store} — {amount} |
| Expense decided | sendExpenseDecisionEmail | rick + paul | Expense {approved/rejected}: {store} — {category} |
| Off track review | sendOffTrackAlertEmail | rick + paul + rep | OFF TRACK: {store} — {interval} Review |

---

## DATABASE TABLES

| Table | Purpose |
|---|---|
| users | Team members: name, email, role (rep/validator/manager/cfo/coo/admin), is_active |
| display_requests | Master record: all inputs, all calculated outputs, workflow status, approval chain |
| display_skus | SKUs per request: sku_code, sku_name, quantity, unit_cost, line_cost |
| display_fittings | Auto match rules: fitting_sku, description, qty_per_sku, unit_cost, trigger_prefixes |
| products | Active product catalogue: sku_code, sku_name, unit_cost, is_active |
| client_baseline | Historical client data for existing client lookup |
| request_photos | Photo metadata: photo_url, storage_path, photo_type, uploaded_by |
| audit_log | Every action: submitted, validated, approved, rejected, etc. |
| notifications | Email send log: recipient, subject, body, sent_at, error |
| lifecycle_reviews | 3/6/9/12 month reviews: expected vs actual, variance, on/off track |
| additional_expenses | Post approval expenses: category, amount, status |
| forecast_changes | Forecast revision history: old value, new value, reason |
| monthly_actuals | Monthly revenue and catalogue data |
| expected_performance | Expected revenue schedule by month |
| margin_alerts | COGS % variance alerts |

---

## KNOWN GAPS (not yet built or broken)

1. **Monthly summary report** — exists in Google Sheet script, not yet in web app.
2. **Dashboard KPIs** — no overview dashboard for managers/admins.
3. **Display register view** — no list/table view of all active displays with tracking status.
4. **Acumatica actuals automation** — PINNED, blocked on Paul. Currently manual entry.
5. **Margin alerts** — table exists, not wired into the UI or email flow.
6. **CS reference number entry** — UI exists but needs verification.
