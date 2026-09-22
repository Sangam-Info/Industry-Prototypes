# Monocraft · TraceLine — Prototype Package

Material Flow + Production Tracking + Traceability + Quality Control + Dispatch + Analytics
for **Monocraft Pvt. Ltd.**, by **Sangam InfoAnalytics**.

```
monocraft-traceline-package/
├─ prototype/
│  └─ monocraft-traceline.html      ← the clickable demo (open in any browser)
├─ docs/
│  ├─ Production-Blueprint.md        ← plan to turn the demo into the real system
│  └─ schema.sql                     ← real production database schema
└─ README.md
```

## 1. What the prototype is
A single self-contained HTML file — open it in any browser (keep it online; it loads 3D + PDF + fonts from a CDN). It demonstrates the full look, feel and workflow of TraceLine.

**9 production stages:**
Order received → Material inspection → Cutting → Forging → Heat treatment → Shot blasting → Machining (CNC+VMC) → Final inspection → Dispatch.

**What it shows:** live production board (kanban by stage), per-stage part confirmation with rejection reason + "are you sure" check, full job traceability timeline, KPI dashboard, WIP/rejection pie charts, average time-per-stage, PDF report download, 3D production line, activity feed — all responsive for desktop/tablet/mobile.

## 2. Important — this is a DEMO, not the live system
- All data is sample data generated in the browser (no database, no login).
- Live stage movement is intentionally capped after the first few stages (demo limit).
- Nothing is saved between refreshes.

The demo is the **visual foundation**. The real, database-driven system is described in `docs/Production-Blueprint.md`, and its database is in `docs/schema.sql`.

## 3. How to demo it to the client
1. Open `prototype/monocraft-traceline.html`.
2. Drag the 3D line; point at the KPIs and the stage board.
3. Click any job → show its traceability timeline.
4. Hit "Confirm & move" on an early-stage job → change the good-qty → pick a rejection reason → confirm, and watch the board + reports update.
5. Open Reports → Download PDF.

## 4. Next step to go live
Read `docs/Production-Blueprint.md` (§12 — the questions to confirm with Monocraft), then Phase 1 (real auth + database + the 9-stage board wired to a real API) can begin.
