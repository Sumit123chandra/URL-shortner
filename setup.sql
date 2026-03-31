-- ─────────────────────────────────────────────────────────
--  TRIM — Supabase Database Setup
--  Run this entire file in: Supabase → SQL Editor → New Query
-- ─────────────────────────────────────────────────────────

-- 1. Create the links table
create table if not exists links (
  id          bigserial primary key,
  code        text unique not null,
  original_url text not null,
  clicks      integer not null default 0,
  created_at  timestamptz not null default now()
);

-- 2. Index for fast lookups by code
create index if not exists links_code_idx on links (code);

-- 3. Index for sorting by date
create index if not exists links_created_idx on links (created_at desc);

-- 4. Allow public read + insert (no login needed)
alter table links enable row level security;

create policy "Anyone can read links"
  on links for select
  using (true);

create policy "Anyone can create links"
  on links for insert
  with check (true);

-- 5. Function for atomic click counting
create or replace function increment_clicks(link_id bigint)
returns void language sql security definer as $$
  update links set clicks = clicks + 1 where id = link_id;
$$;

-- ✓ Done! Go back to config.js and paste your Project URL + anon key.
