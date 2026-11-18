-- JSCC starter database schema for Supabase (PostgreSQL)
create extension if not exists pgcrypto;

create type public.app_role as enum ('super_admin','president','general_secretary','treasurer','committee','member');
create type public.member_status as enum ('pending','approved','rejected','inactive');
create type public.fund_type as enum ('social_welfare','sports','cultural');
create type public.entry_type as enum ('income','expense');

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  member_no text unique,
  full_name text not null,
  phone text,
  address text,
  photo_url text,
  role public.app_role not null default 'member',
  status public.member_status not null default 'pending',
  created_at timestamptz not null default now()
);

create table public.committee_members (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid references public.profiles(id) on delete set null,
  zone_no int not null check (zone_no between 1 and 15),
  position text not null,
  term_start date,
  term_end date,
  approved boolean not null default false,
  created_at timestamptz not null default now(),
  unique(zone_no)
);

create table public.fund_accounts (
  id uuid primary key default gen_random_uuid(),
  fund public.fund_type not null unique,
  display_name text not null,
  opening_balance numeric(14,2) not null default 0 check (opening_balance >= 0)
);
insert into public.fund_accounts(fund,display_name) values
 ('social_welfare','সামাজিক কল্যাণ ফান্ড'),('sports','ক্রীড়া ফান্ড'),('cultural','সাংস্কৃতিক ফান্ড')
on conflict (fund) do nothing;

create table public.ledger_entries (
  id uuid primary key default gen_random_uuid(),
  fund_id uuid not null references public.fund_accounts(id),
  entry_kind public.entry_type not null,
  amount numeric(14,2) not null check (amount > 0),
  source text not null,
  description text not null,
  transaction_date date not null default current_date,
  receipt_no text unique,
  created_by uuid references public.profiles(id),
  approved_by uuid references public.profiles(id),
  approved_at timestamptz,
  created_at timestamptz not null default now()
);

create table public.notifications (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  body text not null,
  event_type text not null,
  related_record_id uuid,
  approved boolean not null default false,
  published_at timestamptz,
  created_by uuid references public.profiles(id),
  created_at timestamptz not null default now()
);

create table public.audit_log (
  id uuid primary key default gen_random_uuid(),
  actor_id uuid references public.profiles(id),
  action text not null,
  table_name text not null,
  record_id uuid,
  old_data jsonb,
  new_data jsonb,
  created_at timestamptz not null default now()
);

create table public.dues (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id),
  billing_month date not null,
  amount_due numeric(14,2) not null check (amount_due >= 0),
  amount_paid numeric(14,2) not null default 0 check (amount_paid >= 0),
  paid_at timestamptz,
  receipt_no text unique,
  unique(profile_id,billing_month)
);

-- IMPORTANT: Before production, enable RLS on every table and add role-aware policies.
-- Do not expose service-role keys in the mobile app. Ledger writes must be approved server-side.
