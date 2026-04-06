-- Migration 006: Restructure display request form fields
-- Replaces generic "display_reason" with specific structured questions
-- Adds brand perception, competitor, installation, and photo fields

-- New structured questions (replacing the single display_reason textarea)
ALTER TABLE display_requests ADD COLUMN IF NOT EXISTS opportunity_description text;
ALTER TABLE display_requests ADD COLUMN IF NOT EXISTS competitor_brands text;
ALTER TABLE display_requests ADD COLUMN IF NOT EXISTS brand_perception_impact text;  -- 'increase', 'no_change', 'reduce'
ALTER TABLE display_requests ADD COLUMN IF NOT EXISTS planned_install_date date;
ALTER TABLE display_requests ADD COLUMN IF NOT EXISTS is_new_or_replacement text;    -- 'new', 'replacement', 'update'
ALTER TABLE display_requests ADD COLUMN IF NOT EXISTS differentiation_plan text;
ALTER TABLE display_requests ADD COLUMN IF NOT EXISTS store_agreed_location boolean DEFAULT false;

-- Note: display_reason column is kept for backward compatibility with existing data
-- but the form will no longer write to it. New requests use the structured fields above.
-- photos_link column already exists and will be repurposed for installation area photo URLs.
