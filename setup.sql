-- RentalNest V1 secure booking table. Run in Supabase SQL Editor.
-- Creates a NEW table, leaving existing properties/bookings tables untouched.
create extension if not exists btree_gist;
create table if not exists public.rentalnest_bookings (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  property_name text not null check (property_name in ('QMD 246','QMD 247')),
  guest_name text not null,
  check_in date not null,
  check_out date not null,
  status text not null default 'confirmed' check (status in ('confirmed','pending','blocked')),
  cottage_price numeric(12,2) not null default 0 check (cottage_price>=0),
  cleaning_fee numeric(12,2) not null default 0 check (cleaning_fee>=0),
  golf_cart_fee numeric(12,2) not null default 0 check (golf_cart_fee>=0),
  sherkston_fee numeric(12,2) not null default 0 check (sherkston_fee>=0),
  created_at timestamptz not null default now(),
  constraint valid_stay check (check_out>check_in),
  constraint prevent_overlap exclude using gist (
    owner_id with =, property_name with =,
    daterange(check_in,check_out,'[)') with &&
  )
);
alter table public.rentalnest_bookings enable row level security;
revoke all on public.rentalnest_bookings from anon;
grant select,insert,update,delete on public.rentalnest_bookings to authenticated;
drop policy if exists owner_select on public.rentalnest_bookings;
drop policy if exists owner_insert on public.rentalnest_bookings;
drop policy if exists owner_update on public.rentalnest_bookings;
drop policy if exists owner_delete on public.rentalnest_bookings;
create policy owner_select on public.rentalnest_bookings for select to authenticated using (owner_id=(select auth.uid()));
create policy owner_insert on public.rentalnest_bookings for insert to authenticated with check (owner_id=(select auth.uid()));
create policy owner_update on public.rentalnest_bookings for update to authenticated using (owner_id=(select auth.uid())) with check (owner_id=(select auth.uid()));
create policy owner_delete on public.rentalnest_bookings for delete to authenticated using (owner_id=(select auth.uid()));
