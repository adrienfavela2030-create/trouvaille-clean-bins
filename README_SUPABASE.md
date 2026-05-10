# Trouvaille Bins — Supabase Scaffold

This branch contains a scaffold to integrate the Trouvaille Bins frontend with Supabase. It is a "scaffold-only" delivery: it includes SQL migration files, client wiring, Edge Function templates, and frontend placeholders. You must run the migrations and add your Supabase keys to complete the wiring.

Files added in this commit:
- supabase/migrations/001_init.sql — schema and starter RLS policies
- supabase/functions/send_booking_email/index.js — example Edge Function for sending booking notification (template)
- supabase/functions/timer_control/index.js — example Edge Function template to start/stop timers
- src/lib/supabaseClient.js — client initializer (uses env vars)
- src/app.js — frontend wiring placeholder that replaces localStorage demo with Supabase calls (scaffold)
- src/styles.css — refined styles used by src/index.html
- .env.example — environment variables required
- README_SUPABASE.md — detailed setup steps for running migrations and deploying functions

Important: do NOT paste service_role keys in this repository. Add keys as GitHub secrets or set them in your local environment when running migrations or deploying functions.
