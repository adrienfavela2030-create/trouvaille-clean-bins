# Supabase SQL migration — initial schema

-- 001_init.sql

-- Tables: profiles (user metadata separate from auth.users), bookings, subscriptions, schedules, announcements, job_timers

BEGIN;

-- profiles table (link to auth.users)
CREATE TABLE IF NOT EXISTS profiles (
  id uuid PRIMARY KEY REFERENCES auth.users ON DELETE CASCADE,
  full_name text,
  username text UNIQUE,
  phone text,
  role text DEFAULT 'customer', -- 'customer' or 'admin'
  created_at timestamptz DEFAULT now()
);

-- bookings
CREATE TABLE IF NOT EXISTS bookings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles(id) ON DELETE SET NULL,
  service_type text NOT NULL,
  bins int DEFAULT 1,
  price numeric(8,2) NOT NULL,
  address text,
  preferred_at timestamptz,
  status text DEFAULT 'requested', -- requested, scheduled, in_progress, completed, cancelled
  created_at timestamptz DEFAULT now()
);

-- subscriptions
CREATE TABLE IF NOT EXISTS subscriptions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE,
  plan text,
  price numeric(8,2),
  status text DEFAULT 'active',
  next_billing_date timestamptz,
  created_at timestamptz DEFAULT now()
);

-- schedules (assigned cleaning dates)
CREATE TABLE IF NOT EXISTS schedules (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  booking_id uuid REFERENCES bookings(id) ON DELETE CASCADE,
  scheduled_at timestamptz,
  assigned_by uuid REFERENCES profiles(id),
  created_at timestamptz DEFAULT now()
);

-- announcements
CREATE TABLE IF NOT EXISTS announcements (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text,
  message text,
  active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

-- job_timers
CREATE TABLE IF NOT EXISTS job_timers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  booking_id uuid REFERENCES bookings(id) ON DELETE CASCADE,
  started_at timestamptz,
  paused_at timestamptz,
  elapsed_seconds int DEFAULT 0,
  status text DEFAULT 'idle', -- idle, running, paused, finished
  created_at timestamptz DEFAULT now()
);

COMMIT;

-- Row-Level Security (RLS) and policies (examples). Enable RLS on tables and create policies appropriate for your app.

-- NOTE: You must enable RLS after creating the tables and then add policies. Example below is a starter idea.

-- Example: Enable RLS for bookings
-- ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
-- CREATE POLICY "Customers can manage their bookings" ON bookings FOR ALL USING (auth.uid() = user_id);
-- CREATE POLICY "Admins full access" ON bookings FOR ALL USING (exists(select 1 from profiles p where p.id = auth.uid() and p.role = 'admin')) WITH CHECK (exists(select 1 from profiles p where p.id = auth.uid() and p.role = 'admin'));

-- Repeat policies for other tables. Be careful: policies must be tailored to your security model.
