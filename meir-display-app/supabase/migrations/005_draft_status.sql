-- Migration 005: Add 'draft' status to request_status enum
-- Allows reps to save incomplete display requests and return to them later

ALTER TYPE request_status ADD VALUE IF NOT EXISTS 'draft' BEFORE 'submitted';

-- Drafts are only visible to the rep who created them (existing RLS handles this —
-- reps can only see their own requests, and 'draft' is just another status value).
-- No additional RLS changes needed.
