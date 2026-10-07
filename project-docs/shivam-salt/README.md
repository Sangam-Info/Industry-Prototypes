# WorkLedger — Salt Workforce and Accounts Prototype

## Overview

WorkLedger demonstrates attendance and basic accounts workflows for a
salt-production workforce: marking daily attendance by team, viewing monthly
work records and wages, and reviewing customer dues and supplier balances.

## Main sections and workflow

- **Dashboard:** today's workforce and summary of money due.
- **Mark attendance:** record present, absent, half-day or leave status by
  worker/team.
- **Monthly register:** review worker attendance and wage totals by month.
- **Workers:** inspect the sample team and worker records.
- **Debtors and creditors:** review customer receivables and supplier payables.
- **Quick actions:** mark attendance, record incoming/outgoing payment or add a
  credit sale.

## Demo limits and sample content

- Published app: [`public/shivam-salt/index.html`](../../public/shivam-salt/index.html).
- The page uses sample data; the demo explicitly says changes reset on refresh.
- Demo caps: up to 3 added workers, 3 added parties and 4 payments/entries.
- The prototype currently contains an expiry date of **20 October 2026**;
  after that date its entry screen may show an expired-demo message.
- Attendance, wages and balances are illustrative, not verified payroll or
  accounting records. Do not use the sample figures for statutory or financial
  decisions.
- The portfolio back button returns to `public/index.html`.

## Local preview and deployment

Open the published HTML file in a browser or serve the repository's `public/`
directory using Wrangler. The root `wrangler.jsonc` points Cloudflare assets to
that directory.
