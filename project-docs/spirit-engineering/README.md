# Workshop Management — Operations and Sales Suite

## Overview

Workshop Management presents two connected workspaces for a small engineering or
manufacturing business:

- **Operations:** workforce, attendance, payroll, cashbook, billing and reports.
- **Catalog & Sales:** product catalogue, enquiries and customer sales workflows.

The outer application switches between the workspaces. Each workspace is
embedded in its own frame and is mounted when selected.

## Suggested walkthrough

1. Review the Operations dashboard and its attendance, cash and payroll
   summaries.
2. Open the team or muster workflow and inspect attendance handling.
3. Visit payroll, cashbook, bills and reports to show the internal operations
   side.
4. Switch to Catalog & Sales and walk through the customer-facing catalogue and
   sales workflow.

## Prototype status and limitations

- Published app: [`public/spirit-engineering/index.html`](../../public/spirit-engineering/index.html).
- The two embedded workspaces are packaged inside the HTML page. Treat the
  records and calculations as demonstration data, not authoritative business
  records.
- The interface advertises sample-data behavior and that refreshing resets
  changes.
- No production authentication, role enforcement, database backup or
  externally validated statutory calculations are guaranteed by this demo.
- The top-level portfolio button returns to `public/index.html`.

## Related documentation

The detailed solution overview, including operations and sales modules, user
groups, workflow, prototype-versus-production notes and discovery questions, is
[`public/spirit-engineering/documentation.html`](../../public/spirit-engineering/documentation.html).
This README summarizes the currently published prototype for project
maintenance.
