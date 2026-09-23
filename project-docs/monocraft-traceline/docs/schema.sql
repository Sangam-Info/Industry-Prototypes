-- =====================================================================
-- Monocraft · TraceLine — Production database schema (v1)
-- Target: PostgreSQL / Supabase.  (D1/SQLite notes at the bottom.)
-- Everything here is REAL structure — no demo data. Config seed rows only.
-- =====================================================================

-- ---------- ENUMS ----------
create type role_type        as enum ('super_admin','admin','production_manager','qc_manager','operator','dispatch_staff','viewer');
create type order_priority   as enum ('low','normal','high','rush');
create type order_status     as enum ('open','in_production','on_hold','awaiting_dispatch','dispatched','delayed','cancelled');
create type stage_status     as enum ('pending','active','on_hold','completed','skipped');
create type inspection_type  as enum ('material','in_process','final');
create type inspection_result as enum ('accepted','rejected','partial','rework');

-- ---------- USERS / RBAC ----------
-- Auth itself (email, password hash, sessions) is handled by Supabase Auth (auth.users).
-- profiles extends each auth user with role + shop-floor info.
create table profiles (
  id           uuid primary key references auth.users(id) on delete cascade,
  full_name    text not null,
  employee_id  text unique,
  role         role_type not null default 'viewer',
  department   text,
  phone        text,
  status       text not null default 'active',           -- active | inactive
  created_at   timestamptz not null default now()
);

-- ---------- MASTERS ----------
create table customers (
  id             uuid primary key default gen_random_uuid(),
  code           text unique not null,                    -- e.g. CUST-001
  company_name   text not null,
  contact_person text, phone text, email text, address text,
  gstin          text,
  status         text not null default 'active',
  created_at     timestamptz not null default now()
);

create table suppliers (
  id      uuid primary key default gen_random_uuid(),
  code    text unique not null,
  name    text not null,
  contact text, phone text, email text,
  status  text not null default 'active'
);

create table parts (
  id                uuid primary key default gen_random_uuid(),
  code              text unique not null,                 -- part code
  name              text not null,
  customer_id       uuid references customers(id),
  drawing_no        text,
  material          text, grade text, weight_kg numeric,
  standard_qty      integer,
  standard_tat_hours numeric,                             -- expected turnaround
  qc_requirements   jsonb default '{}'::jsonb,            -- configurable QC params per part
  status            text not null default 'active',
  created_at        timestamptz not null default now()
);

-- 9 production stages as CONFIG (so they can be renamed / reordered, not hard-coded)
create table stages (
  id    uuid primary key default gen_random_uuid(),
  seq   integer not null,
  code  text unique not null,                             -- ORDER, MATERIAL_QC, CUTTING, ...
  name  text not null,
  kind  text not null default 'process',                 -- gate | qc | process | heat
  is_qc boolean not null default false
);

-- CONFIGURABLE production routes (different parts can have different routes)
create table production_routes (
  id         uuid primary key default gen_random_uuid(),
  part_id    uuid references parts(id),                   -- null = default route
  name       text not null,
  is_default boolean not null default false,
  status     text not null default 'active'
);
create table production_route_stages (
  id                 uuid primary key default gen_random_uuid(),
  route_id           uuid not null references production_routes(id) on delete cascade,
  stage_id           uuid not null references stages(id),
  seq                integer not null,
  standard_tat_hours numeric,
  unique (route_id, seq)
);

-- ---------- MATERIAL TRACEABILITY ----------
create table materials (
  id                uuid primary key default gen_random_uuid(),
  batch_no          text not null,
  heat_no           text,                                 -- heat number
  supplier_id       uuid references suppliers(id),
  part_id           uuid references parts(id),
  grade             text,
  qty_received      numeric, qty_accepted numeric, qty_rejected numeric,
  received_date     date,
  inspection_result inspection_result,
  remarks           text,
  created_at        timestamptz not null default now(),
  unique (batch_no, heat_no)
);

-- ---------- PRODUCTION ORDERS ----------
create table production_orders (
  id               uuid primary key default gen_random_uuid(),
  job_id           text unique not null,                  -- MC-1001 (auto-generated, sequential)
  customer_id      uuid not null references customers(id),
  part_id          uuid not null references parts(id),
  route_id         uuid references production_routes(id),
  quantity         integer not null,
  priority         order_priority not null default 'normal',
  order_date       date not null default current_date,
  delivery_date    date,
  material_spec    text, drawing_ref text, remarks text,
  current_stage_id uuid references stages(id),
  status           order_status not null default 'open',
  created_by       uuid references profiles(id),
  created_at       timestamptz not null default now()
);
create index on production_orders (status);
create index on production_orders (current_stage_id);
create index on production_orders (delivery_date);

-- Immutable per-stage record: the permanent production history.
-- Never UPDATE historical rows in place except to move pending->active->completed.
create table production_stage_records (
  id            uuid primary key default gen_random_uuid(),
  order_id      uuid not null references production_orders(id) on delete cascade,
  stage_id      uuid not null references stages(id),
  seq           integer not null,
  status        stage_status not null default 'pending',
  operator_id   uuid references profiles(id),
  material_id   uuid references materials(id),            -- links finished component -> material batch
  qty_in        integer, qty_out integer, qty_rejected integer default 0,
  started_at    timestamptz, completed_at timestamptz,
  remarks       text,
  created_at    timestamptz not null default now(),
  unique (order_id, seq)
);
create index on production_stage_records (order_id);

-- ---------- QUALITY CONTROL ----------
create table quality_inspections (
  id              uuid primary key default gen_random_uuid(),
  order_id        uuid not null references production_orders(id) on delete cascade,
  stage_record_id uuid references production_stage_records(id),
  type            inspection_type not null,
  params          jsonb default '{}'::jsonb,              -- dimensional, hardness, surface, thread/bore... (configurable)
  qty_inspected   integer, qty_accepted integer, qty_rejected integer,
  result          inspection_result,
  inspector_id    uuid references profiles(id),
  inspected_at    timestamptz not null default now(),
  remarks         text
);

-- ---------- REJECTIONS ----------
create table rejection_reasons (                          -- configurable list
  id       uuid primary key default gen_random_uuid(),
  code     text unique not null,
  label    text not null,
  stage_id uuid references stages(id),                    -- null = applies to any stage
  active   boolean not null default true
);
create table rejections (
  id              uuid primary key default gen_random_uuid(),
  order_id        uuid not null references production_orders(id),
  stage_record_id uuid references production_stage_records(id),
  stage_id        uuid references stages(id),
  part_id         uuid references parts(id),
  reason_id       uuid references rejection_reasons(id),
  qty             integer not null,
  operator_id     uuid references profiles(id),
  inspector_id    uuid references profiles(id),
  remarks         text,
  created_at      timestamptz not null default now()
);
create index on rejections (stage_id);
create index on rejections (reason_id);

-- ---------- DISPATCH ----------
create table dispatches (
  id               uuid primary key default gen_random_uuid(),
  order_id         uuid not null references production_orders(id),
  customer_id      uuid references customers(id),
  part_id          uuid references parts(id),
  qty_accepted     integer, qty_dispatched integer,
  dispatch_date    date not null default current_date,
  vehicle_no       text, transport text,
  delivery_doc_no  text, invoice_ref text, remarks text,
  created_by       uuid references profiles(id),
  created_at       timestamptz not null default now()
);

-- ---------- ACTIVITY FEED + IMMUTABLE AUDIT ----------
create table activities (
  id          uuid primary key default gen_random_uuid(),
  actor_id    uuid references profiles(id),
  action      text not null,                              -- order_created, stage_completed, qty_rejected, dispatched...
  entity_type text, entity_id uuid,
  meta        jsonb default '{}'::jsonb,
  created_at  timestamptz not null default now()
);
create index on activities (created_at desc);

create table audit_log (                                  -- who changed what, before/after; never deleted
  id          uuid primary key default gen_random_uuid(),
  actor_id    uuid references profiles(id),
  action      text not null,
  entity_type text, entity_id uuid,
  old_value   jsonb, new_value jsonb,
  ip          text, device text,
  created_at  timestamptz not null default now()
);

-- ---------- FILES / NOTIFICATIONS / SETTINGS ----------
create table attachments (
  id          uuid primary key default gen_random_uuid(),
  entity_type text not null, entity_id uuid not null,     -- customer|part|material|order|inspection|dispatch
  file_url    text not null, file_name text, mime text,
  uploaded_by uuid references profiles(id),
  created_at  timestamptz not null default now()
);
create table notifications (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid references profiles(id),
  type        text, title text, body text,
  entity_type text, entity_id uuid,
  read_at     timestamptz,
  created_at  timestamptz not null default now()
);
create table settings (
  key        text primary key,
  value      jsonb not null,
  updated_by uuid references profiles(id),
  updated_at timestamptz not null default now()
);

-- =====================================================================
-- CONFIG SEED (structure/config only — NOT demo production data)
-- =====================================================================
insert into stages (seq, code, name, kind, is_qc) values
 (0,'ORDER','Order received','gate',false),
 (1,'MATERIAL_QC','Material inspection','qc',true),
 (2,'CUTTING','Cutting','process',false),
 (3,'FORGING','Forging','heat',false),
 (4,'HEAT_TREAT','Heat treatment','heat',false),
 (5,'BLASTING','Shot blasting','process',false),
 (6,'MACHINING','Machining (CNC + VMC)','process',false),
 (7,'FINAL_QC','Final inspection','qc',true),
 (8,'DISPATCH','Dispatch','gate',false);

insert into rejection_reasons (code, label) values
 ('DIM_TOL','Dimensional — out of tolerance'),
 ('FORGE_CRACK','Forging defect — crack / lap'),
 ('FORGE_UNDERFILL','Forging defect — underfill'),
 ('COLD_SHUT','Cold shut'),
 ('DIE_SHIFT','Die mismatch / shift'),
 ('SURFACE','Surface defect — seam / scale pit'),
 ('HARDNESS','Heat-treat — hardness out of range'),
 ('DISTORTION','Heat-treat — distortion / warpage'),
 ('DECARB','Decarburization'),
 ('MACH_TOOL','Machining — burr / tool mark'),
 ('MACH_BORE','Machining — bore / OD out of tolerance'),
 ('THREAD','Thread defect'),
 ('MATERIAL','Material — inclusion / porosity'),
 ('DENT','Dent / handling damage'),
 ('RUST','Rust / corrosion'),
 ('OTHER','Other');

-- =====================================================================
-- D1 / SQLite adaptation notes:
--   • drop the "create type ... enum" lines; use text columns + CHECK(... in (...)) instead
--   • uuid  -> text  ;  gen_random_uuid() -> generate in app or lower(hex(randomblob(16)))
--   • jsonb -> text (store JSON as string)  ;  timestamptz -> text (ISO-8601)
--   • date  -> text  ;  numeric -> real
--   • RBAC: enforce in the Worker layer (D1 has no row-level security)
-- Supabase: enable Row-Level Security on every table and add policies per role
--           (see blueprint §6 & §11).
-- =====================================================================
