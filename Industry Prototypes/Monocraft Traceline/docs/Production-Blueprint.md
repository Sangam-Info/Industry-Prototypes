# Monocraft · TraceLine — Production Build Blueprint

**From:** Sangam InfoAnalytics · **For:** Monocraft Pvt. Ltd.
**Purpose:** turn the TraceLine prototype into a real, database-driven **Manufacturing Production Tracking & Material Traceability System (MES)**.

> This document is the engineering plan. It keeps the prototype's UI/UX as the visual spec and rebuilds everything under it for real. Items that must be confirmed with Monocraft before building are flagged **[CONFIRM]**.

---

## 1. What the prototype actually is (analysis)

I analysed the uploaded `monocraft-traceline (1).html` (913 lines, single file):

| Layer | Prototype today | Verdict |
|---|---|---|
| UI / UX | Dark industrial theme, Space Grotesk + Inter + JetBrains Mono, sticky nav, 3D line, KPI cards, kanban board, order drawer, confirm+reject dialog, reports + pie charts, PDF, toasts, responsive | **Keep — this is the visual foundation** |
| 9-stage workflow | Order → Material QC → Cutting → Forging → Heat treat → Shot blasting → Machining → Final QC → Dispatch | **Keep exactly** |
| Data | `seed()` + `Math.random()` generate all jobs, rejections, timestamps **in browser memory** | **Remove — replace with real DB** |
| Persistence | None. No database, no `localStorage`, no API | **Build the whole backend** |
| Auth / roles | None | **Build** |
| Demo limit | `DEMO_MAX_STAGE = 4` locks stage movement after Heat treatment; "PROTOTYPE" banner | **Remove in production** |

**Conclusion:** the prototype is a high-quality clickable demo. The UI is production-worthy; the engine (data, auth, history, reports) is entirely fake and must be rebuilt against a real database. This matches your spec's rule: *treat the UI as the foundation, engineer a secure DB-driven system underneath.*

---

## 2. Prototype → production: what changes

- In-memory `Store` → real REST/Realtime API backed by a relational DB.
- `seed()` / random values → real orders, real stage records, real rejections entered by real users.
- Client-side `Store.advance()` → server-enforced stage lifecycle with immutable history + audit.
- No auth → login + 7 role-based-access levels.
- `DEMO_MAX_STAGE` lock removed → full 9-stage flow.
- 3D line + KPIs + reports → driven by live DB queries, not generated numbers.
- PDF → server-generated from real query results.

---

## 3. Recommended architecture & stack

**Primary recommendation — Supabase + refactored TraceLine frontend:**

| Concern | Choice | Why |
|---|---|---|
| Database | **Supabase Postgres** | Relational — fits traceability, routes, reports; Row-Level Security gives real RBAC at the DB |
| Auth | **Supabase Auth** | Email/password + hashing + sessions out of the box (7 roles via `profiles.role` + RLS) |
| Real-time | **Supabase Realtime** | Board/KPIs/activity update instantly when a stage changes — no extra infra |
| File storage | **Supabase Storage** | Drawings, material certs, QC docs, dispatch docs |
| API | Supabase auto REST/RPC + a thin edge-function layer for business rules (job-ID generation, stage transitions, PDF) | Less glue code |
| Frontend | The existing TraceLine UI, refactored into a **Vite SPA / PWA** that calls the API | Keeps the look, adds real data + offline-friendly shop-floor use |
| Hosting | Frontend on **Cloudflare Pages/Workers** (your existing setup); DB/auth on Supabase | Matches your infra |

**Alternative — stay fully on Cloudflare:** Workers (API) + **D1** (SQLite) + KV (sessions) + R2 (files) + Durable Objects/SSE (real-time). Fully in your existing stack, but you build auth/RBAC/real-time yourself, so more effort. `schema.sql` includes D1 adaptation notes.

**Not recommended for the core:** Firestore/NoSQL — the traceability chain and cross-entity reports (rejection-by-operator, material-batch → job) are painful without relational joins.

> **[CONFIRM] Hosting & data-residency preference** (Supabase vs Cloudflare-only), and whether data must stay in India.

---

## 4. Database

Full schema is in the companion file **`schema.sql`** (PostgreSQL/Supabase, with D1/SQLite notes). Core entities and relationships:

- `customers` → `parts` → `production_routes` → `production_route_stages` → `stages`
- `production_orders` (auto `job_id` MC-1001…) → `production_stage_records` (immutable per-stage history) → `quality_inspections`, `rejections`
- `materials` (batch/heat) ←linked→ `production_stage_records` (finished component traceable back to its batch)
- `dispatches`, `activities`, `audit_log`, `attachments`, `notifications`, `settings`
- `stages`, `rejection_reasons` are **config tables** (renamable/reorderable) — nothing hard-coded.

Key rules baked in: stage records are permanent (no silent overwrite), every change writes to `audit_log`, routes are configurable per part, QC params and rejection reasons are config-driven.

---

## 5. API / service map

Grouped REST resources (all behind auth + RBAC):

- `auth` — login, logout, session, me
- `users` / `profiles` — CRUD (admin), operator assignment
- `customers`, `suppliers`, `parts`, `materials` — masters CRUD
- `routes` — configure production routes per part
- `orders` — create (auto job-ID), read, list/filter, update, cancel
- `orders/{id}/stages/{seq}` — **start / hold / complete / reject** (the shop-floor actions)
- `qc` — material & final inspections
- `rejections` — record + analytics queries
- `dispatch` — create + history
- `reports` — 12 report queries + PDF export
- `activities`, `notifications`, `audit`, `settings`

Rule: **no faked responses** — every endpoint hits the DB.

---

## 6. Roles & permissions (RBAC)

| Capability | Super Admin | Admin | Prod. Mgr | QC Mgr | Operator | Dispatch | Viewer |
|---|---|---|---|---|---|---|---|
| Manage users/roles | ✓ | ✓ | | | | | |
| Manage masters (customers/parts/routes) | ✓ | ✓ | ✓ | | | | |
| Create/edit orders | ✓ | ✓ | ✓ | | | | |
| Start/hold/complete stage | ✓ | ✓ | ✓ | | ✓ (assigned) | | |
| Enter qty / record rejection | ✓ | ✓ | ✓ | ✓ | ✓ | | |
| QC inspect / approve-reject | ✓ | ✓ | | ✓ | | | |
| Dispatch | ✓ | ✓ | ✓ | | | ✓ | |
| View reports/analytics | ✓ | ✓ | ✓ | ✓ | limited | limited | ✓ |
| Settings / audit log | ✓ | ✓ | | | | | |

Enforced at the DB via RLS (Supabase) or in the Worker layer (D1). **[CONFIRM] exact role list & who gets which.**

---

## 7. Core workflow (server-enforced)

`Order created → Order Received` then per stage on the route:
`Start (operator, timestamp, qty_in) → [Hold?] → Complete (qty_out, qty_rejected, reason, remarks, timestamp) → next stage becomes active`.
When Final inspection is approved → `Dispatch`. History is append-only; edits go through audit.

---

## 8. QC · rejections · traceability

- **Material QC:** grade, heat number, supplier, qty received/accepted/rejected, result. Links the batch to the jobs that consume it.
- **Final QC:** dimensional, visual, hardness, surface, thread/bore — **configurable params per part**.
- **Rejections:** every reject stored (job, stage, part, qty, reason, operator, inspector, time) → analytics: total, %, by stage/operator/product/reason/trend.
- **Traceability:** finished component → `production_stage_records.material_id` → `materials` batch/heat → supplier. Full backward trace.

---

## 9. Reports & PDF

12 reports (production, WIP, dispatch, rejection, stage-performance, TAT, delayed, customer-wise, part-wise, operator-wise, material-traceability, quality) with filters (date, customer, part, stage, operator, status, priority). PDF generated **server-side from real query results** with company header, filters, date range, generated timestamp, data, summary, totals.

---

## 10. Real-time, security, mobile

- **Real-time:** Supabase Realtime (or SSE/Durable Objects on CF) so board, KPIs, activity update the moment a stage completes.
- **Security:** provider-managed password hashing, RLS/authorization, input + API validation, secure file uploads, session management, immutable audit, scheduled backups. No secrets in frontend.
- **Mobile/tablet:** the stage screen gets large tap targets for shop-floor tablets (the prototype is already responsive).

---

## 11. Phased delivery roadmap (this is how it becomes deliverable)

| Phase | Scope | Outcome |
|---|---|---|
| **0 — Confirm & set up** | Answer the checklist in §12, provision DB/auth/hosting, load masters | Scope locked, environment ready |
| **1 — MVP (core tracking)** | Auth + RBAC, customers/parts/orders, the 9-stage board, start/hold/complete with qty in/out/reject + reason + operator + timestamp, order drawer with **real** timeline, activity feed, live KPIs. Demo locks & random data removed. | *"Where is every order right now?"* answered from a real DB |
| **2 — QC · rejections · dispatch · reports** | Material + final QC (configurable params), rejection analytics, dispatch module, the 12 reports + server PDF | Quality + dispatch + reporting live |
| **3 — Traceability · routes · realtime · files · audit** | Material batch/heat traceability, configurable routes per part, real-time updates, document uploads, full audit log, notifications (in-app) | Full MES |
| **4 — Optional (confirm)** | Inventory, barcode/QR, WhatsApp/email alerts, ERP/invoice integration, downtime/maintenance, shift/target mgmt, native app | Extensions on demand |

Each phase is independently quotable and shippable.

---

## 12. CLIENT CONFIRMATION REQUIRED (consolidated)

**Architecture-affecting (answer first):**
1. Exact legal company name & GSTIN for documents/reports.
2. Number of users and exact roles.
3. Hosting/data-residency preference (Supabase vs Cloudflare-only; India-only data?).
4. Are all 9 stages always used, or do different parts use different routes? How many part types?
5. Material batch / heat-number tracking required? (drives traceability tables)
6. Inventory (raw/WIP/finished/scrap) in scope now or later?
7. Real-time updates required, or is refresh acceptable?

**Scope-affecting:**
8. QC parameters per part (which checks, tolerances). 9. Rejection reason list (final). 10. Operator & machine management depth. 11. Dispatch fields + invoice/ERP integration. 12. Customer & supplier counts. 13. Document/attachment types to store. 14. Notification channels (in-app / email / WhatsApp) — WhatsApp needs template + your DLT header. 15. Barcode/QR on stage updates. 16. Existing software/ERP/DB + data migration needs. 17. Backup + expansion expectations.

*(Full 40-point list from the spec's §31 applies; the above groups them by impact. Anything unclear stays marked **[CONFIRM]** — not assumed.)*

---

## 13. Commercial reality (important)

The current signed direction was a **₹35,000 prototype-to-app** scope with sign-in, basic tracking and 1-month support. **This spec is a full multi-module MES** — auth+RBAC, QC, rejection analytics, material traceability, dispatch, 12 reports, real-time, audit, documents, and up to inventory/ERP/barcode. That is a materially larger build.

**Recommendation:** quote it **phase-wise** (Phase 1 MVP as the near-term deliverable, Phases 2–4 as follow-on) so Monocraft gets value fast and pricing matches real scope. Phase 1 alone (the live DB-driven 9-stage tracking with auth) is a clean, sellable first release. I can turn this blueprint into a phase-wise commercial quotation whenever you confirm the §12 answers.

---

*Prepared by Sangam InfoAnalytics · TraceLine production planning. Companion file: `schema.sql`.*
