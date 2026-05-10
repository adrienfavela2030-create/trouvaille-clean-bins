# Trouvaille Bins — Supabase integration (scaffold)

You confirmed "Start with first" (scaffold-only). I added the scaffold for Supabase integration to the trouvaille-bins-start branch. Next steps are to run migrations and wire environment secrets.

Recommended next steps (safe, no secrets in repo):

1) Create a Supabase project
   - https://app.supabase.com/
   - Note the Project URL and public anon key

2) Run the migration in `supabase/migrations/001_init.sql`
   - Use the Supabase CLI or psql with your service_role key to apply the migration.
   - Example with supabase CLI:
     - Install: https://supabase.com/docs/guides/cli
     - Login: `supabase login`
     - Link project: `supabase link --project-ref your-project-ref`
     - Push migrations: `supabase db push --project-ref your-project-ref`

3) Add RLS policies and create an admin user
   - Enable RLS and add secure policies for each table (examples in the SQL file comments)
   - Create an admin profile by signing up a Supabase Auth user and updating `profiles.role` to `admin` using the service_role key or via the Supabase dashboard.

4) Deploy Edge Functions (optional)
   - Use Supabase Functions to deploy `supabase/functions/*` (or implement equivalent serverless functions).

5) Configure environment
   - Add the keys to your Vite/Netlify/Vercel environment or as GitHub repo secrets
   - Update `.env` locally with values from `.env.example`

6) Replace demo localStorage flows in `src/app.js` with the Supabase functions (the scaffold already includes examples).

7) Email integration
   - Provide SendGrid or SMTP credentials to the Edge Function or serverless function that sends booking emails to the owner.

If you want, I can now:
- Push additional client code converting the current index.html demo to use `src/lib/supabaseClient.js` (requires the anon key from you to test locally).
- Create a GitHub Action that runs migrations using the service_role key stored in repository secrets (I will provide the workflow and you will add the secret).

Which of these would you like me to do next?
