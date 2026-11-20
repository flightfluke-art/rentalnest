RentalNest — First deployable booking-calendar milestone

1. In Supabase Dashboard > SQL Editor > New query, paste setup.sql and click Run.
2. In Supabase Authentication > Providers, ensure Email sign-in is enabled. For a private owner-only app, disable public signups after creating your account.
3. Upload index.html to a static web host (e.g. Netlify Drop), or open it locally in a browser to test. A real hosted URL is needed for reliable login redirects and production use.
4. Sign up or sign in, add a test booking, refresh the page, and confirm it persists.

Security: The app uses a public publishable key, but data access is protected by Supabase Auth and row-level security. Do not use service_role or secret keys in the browser. This starter uses a separate table so it does not disturb the tables you already created.

Scope: V1 booking calendar, 2 cottages, create/list/delete, overlap prevention, fees, MAT preview, authentication. NOT YET: existing-table migration, payment collection, guest ID uploads, email reminders, multi-owner administration, production compliance review. MAT preview is 4% of cottage price, not a tax filing calculation.
