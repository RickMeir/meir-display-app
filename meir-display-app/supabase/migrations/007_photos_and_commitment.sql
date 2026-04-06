-- Migration 007: Photo uploads and initial order commitment tracking
-- Photos stored in Supabase Storage (bucket: display-photos), metadata here.
-- Commitment tracking captures whether reps secure an initial order.

-- Photo metadata table — one row per uploaded photo
CREATE TABLE IF NOT EXISTS request_photos (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  request_id uuid NOT NULL REFERENCES display_requests(id) ON DELETE CASCADE,
  photo_url text NOT NULL,
  storage_path text NOT NULL,          -- path within the Supabase Storage bucket
  photo_type text NOT NULL,            -- 'location', 'design_rendering', 'current_display'
  filename text NOT NULL,
  file_size integer,
  uploaded_by uuid REFERENCES users(id),
  uploaded_at timestamptz DEFAULT now()
);

CREATE INDEX idx_request_photos_request ON request_photos(request_id);

-- Initial order commitment fields on display_requests
ALTER TABLE display_requests ADD COLUMN IF NOT EXISTS has_initial_order boolean DEFAULT false;
ALTER TABLE display_requests ADD COLUMN IF NOT EXISTS initial_order_value numeric DEFAULT 0;
ALTER TABLE display_requests ADD COLUMN IF NOT EXISTS initial_order_notes text;
