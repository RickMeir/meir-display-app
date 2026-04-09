# Meir Display App — Institutional Context

> This file captures decisions, people, and nuances that Rick has shared across sessions.
> Read this before asking Rick questions he has already answered.

## People and Roles (Web App)

### Sales Reps (role = 'rep')
These are the field reps who submit display requests:

| Name | Email |
|------|-------|
| Betty Zwanink | betty@meir.com.au |
| Carla Vella | carla@meir.com.au |
| Deanne Jolly | deanne@meir.com.au |
| Di Poppleton | di@meir.com.au |
| Jodie Wallace | jodie@meir.com.au |
| Lee Lawson | lee@meir.com.au |
| Maree Cope | maree@meir.com.au |
| Simon Kayrooz | simon@meir.com.au |
| Sue Rooker | sue@meir.com.au |

### Brooke (brooke@meir.com.au) — role = 'validator'
Brooke is the sole input validator AND Michael's 2IC (second in command). She is NOT a
field sales rep and must never appear in the sales rep dropdown. Her role in the web app
is `validator`, not `rep`. Rick has stated this clearly and does not want to repeat it.

### Michael (michael@meir.com.au) — role = 'manager'
Financial approver for requests up to $10,000.

### Elan (elan@meir.com.au) — role = 'cfo'
Financial approver for $10,001 to $50,000.

### Paul (paul@meir.com.au) — role = 'coo'
Financial approver for over $50,000.

### CS Team (sales@meir.com.au) — role = 'rep' (legacy)
Customer service. Processes approved display orders in Acumatica. Creates store codes.
Currently has role='rep' in the database but this is legacy — they are not a field rep.

### Rick (rick@meir.com.au) — role = 'admin'
Owner of the process. Design and brand review is informational only — not a gate.

### Sophia (sophia@meir.com.au) — role = 'admin'
Receives monthly summary reports. No active role in approval workflow.

## Financial Approval Tiers

| Investment Amount | Approver |
|---|---|
| Up to $10,000 | Michael (manager) |
| $10,001 to $50,000 | Elan (CFO) |
| $50,001 to $100,000 | Paul (COO) |
| Over $100,000 | Rick (admin) |

## Key Decisions

1. Store Code is not shown to reps — CS creates it later when processing
2. All financial fields are mandatory (discount %, rebate %, board cost, labour cost,
   forecast, rep hours, samples, gifts, catalogues) — enter 0 if none
3. SKU colour is decoded from suffix and shown to reps only (not stored separately)
4. Profitability thresholds: GREEN if Net Contribution >= $2,000 AND Net Margin >= 15%
5. ROI verdict: Worth It >= 2.0x, Marginal >= 1.0x, Not Worth It < 1.0x
6. Form auto detects logged in rep and pre selects them in the dropdown
7. Brooke validates inputs (column AD). Financial approvers approve spending (column AF).
   These are deliberately separate steps handled by different people.

## Acumatica Integration (PINNED)
Rick pinned this for later. The idea is to automate monthly actuals data entry by pulling
revenue data from Acumatica. Blocked on Paul. Not yet scoped.
