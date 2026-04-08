-- 012: Add actual sales reps to users table
-- These are the field reps who submit display requests.
-- Brooke stays as 'validator' (she is Michael's 2IC, not a field rep).

INSERT INTO users (name, email, role, is_active)
VALUES
  ('Betty Zwanink',  'betty@meir.com.au',   'rep', true),
  ('Carla Vella',    'carla@meir.com.au',   'rep', true),
  ('Deanne Jolly',   'deanne@meir.com.au',  'rep', true),
  ('Di Poppleton',   'di@meir.com.au',      'rep', true),
  ('Jodie Wallace',  'jodie@meir.com.au',   'rep', true),
  ('Lee Lawson',     'lee@meir.com.au',     'rep', true),
  ('Maree Cope',     'maree@meir.com.au',   'rep', true),
  ('Simon Kayrooz',  'simon@meir.com.au',   'rep', true),
  ('Sue Rooker',     'sue@meir.com.au',     'rep', true)
ON CONFLICT (email) DO UPDATE SET
  name = EXCLUDED.name,
  role = 'rep',
  is_active = true;

-- CS Team should not appear in the sales rep dropdown.
-- They are customer service, not a field rep.
UPDATE users SET role = 'admin' WHERE email = 'sales@meir.com.au';
