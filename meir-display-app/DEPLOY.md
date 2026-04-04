# Meir Display Management — Deployment Guide

## What you need

- A GitHub account (free)
- A Supabase account (free tier is fine — supabase.com)
- A Vercel account (free tier is fine — vercel.com)
- A Resend account for email (free tier: 100 emails/day — resend.com)

## Step 1: Create a GitHub repository

1. Go to github.com and create a new repository called `meir-display-app`
2. Upload all the files from the `meir-display-app` folder to this repository
3. You can use the GitHub web upload or git from the command line

## Step 2: Set up Supabase

1. Go to supabase.com and create a new project
2. Choose a region close to Australia (Singapore or Sydney)
3. Set a database password (save this somewhere secure)
4. Once the project is ready, go to **SQL Editor**
5. Copy the contents of `supabase/migrations/001_initial_schema.sql` and run it
6. This creates all the tables, security policies, and seeds the team users

### Configure authentication

1. In Supabase, go to **Authentication > Providers**
2. Make sure **Email** is enabled
3. Go to **Authentication > URL Configuration**
4. Set **Site URL** to your Vercel URL (you will get this in Step 3)
5. Add `https://your-app.vercel.app/api/auth/callback` to **Redirect URLs**

### Get your keys

1. Go to **Settings > API**
2. Copy the **Project URL** (this is NEXT_PUBLIC_SUPABASE_URL)
3. Copy the **anon public** key (this is NEXT_PUBLIC_SUPABASE_ANON_KEY)
4. Copy the **service_role** key (this is SUPABASE_SERVICE_ROLE_KEY — keep this secret)

## Step 3: Set up Resend (email)

1. Go to resend.com and create an account
2. Add your domain (meir.com.au) and verify it with DNS records
3. Copy your API key (this is RESEND_API_KEY)

**Note:** Until the domain is verified, emails will only work to the account owner's address. For testing, you can use Resend's test mode.

## Step 4: Deploy to Vercel

1. Go to vercel.com and sign in with your GitHub account
2. Click **Add New > Project**
3. Import the `meir-display-app` repository from GitHub
4. In the **Environment Variables** section, add:

   | Variable | Value |
   |---|---|
   | NEXT_PUBLIC_SUPABASE_URL | Your Supabase project URL |
   | NEXT_PUBLIC_SUPABASE_ANON_KEY | Your Supabase anon key |
   | SUPABASE_SERVICE_ROLE_KEY | Your Supabase service role key |
   | RESEND_API_KEY | Your Resend API key |
   | NEXT_PUBLIC_APP_URL | https://your-app.vercel.app |

5. Click **Deploy**
6. Once deployed, copy the URL and go back to Supabase to update the Site URL and Redirect URLs

## Step 5: Test it

1. Go to your deployed URL
2. Log in with rick@meir.com.au — you will receive a magic link email
3. You should see the dashboard
4. Create a test request, validate it, approve it — walk through the full workflow

## How the team logs in

Everyone uses magic links (no passwords). They enter their email address and receive a login link. The system recognises them by their email and assigns the correct role automatically.

The team is already seeded in the database:

| Person | Email | Role |
|---|---|---|
| Rick | rick@meir.com.au | Admin (full visibility) |
| Brooke | brooke@meir.com.au | Validator |
| Michael | michael@meir.com.au | Manager (approves up to $5,000) |
| Elan | elan@meir.com.au | CFO (approves $5,001 to $10,000) |
| Paul | paul@meir.com.au | COO (approves over $10,000) |
| Sophia | sophia@meir.com.au | Admin |
| CS Team | sales@meir.com.au | Rep |

To add sales reps, insert a row into the `users` table in Supabase:

```sql
INSERT INTO users (email, name, role)
VALUES ('newrep@meir.com.au', 'New Rep Name', 'rep');
```

## Architecture overview

- **Frontend:** Next.js 14 on Vercel (auto scales, zero maintenance)
- **Database:** Supabase (managed Postgres with row level security)
- **Auth:** Supabase magic links (no passwords to manage)
- **Email:** Resend (transactional email API)
- **Cost:** All free tier for your team size. Vercel and Supabase charge once you exceed generous free limits, which a team of fewer than 10 will not hit.

## What is included

- Rep request form (no ROI visible to reps)
- Brooke's validation view (full financial assessment visible)
- Financial approval routing by tier (Michael, Elan, Paul)
- Override detection (discrete alerts to Rick and Paul)
- Immutable forecast revenue (database enforced)
- Email notifications at every stage
- Audit logging
- Role based access control
- Dashboard with summary metrics

## What is NOT included yet (Phase 2)

- Acumatica integration for pulling actuals
- Forecast vs actual tracking views
- Monthly summary report generation
- CS reference number entry view
- Data migration from existing Google Sheet
