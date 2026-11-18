# JSCC Official App — Starter Project

This is the initial Flutter source scaffold for the JSCC Android/iOS application. It includes the provided JSCC logo, Bengali UI shell, dashboard, separate fund tiles, accounts, member, 15-seat committee, admin UI, and notifications placeholder.

## Current status
- UI/source scaffold: created
- Supabase database schema draft: `supabase_schema.sql`
- Real authentication, database connection, push notifications, PDF export, payments, and store publishing: not yet configured
- The login and action buttons are placeholders and must not be treated as secure/working features yet.

## Run locally
1. Install Flutter SDK and Android Studio / Xcode.
2. From this folder run `flutter pub get`.
3. Run `flutter run` on an emulator or connected device.

## Before production
1. Create a Supabase project and apply the SQL schema.
2. Add row-level security policies and server-side approval workflows.
3. Configure push notifications (FCM/APNs).
4. Implement member registration, admin role management, immutable ledger/audit history, PDF reports, and payment gateway integration.
5. Test backups, permissions, and financial reconciliation before publishing.

Never put Supabase service-role keys or payment secrets in the app.
