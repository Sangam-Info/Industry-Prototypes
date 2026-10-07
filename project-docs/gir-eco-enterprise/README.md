# LedgerFlow — Nonwoven Bag Accounts Prototype

## Overview

LedgerFlow demonstrates basic accounts and billing for a nonwoven-bag
business: customer and supplier balances, GST bills, received and paid amounts,
and ageing of outstanding dues.

## Main workflow

1. Open the prototype and review the dashboard totals for customers and
   suppliers.
2. Add or select a customer and prepare a GST bill with line items.
3. Review the bill and record a payment.
4. Open customer or supplier ledgers and the dues/ageing reports to inspect
   balances and overdue amounts.

The navigation also shows supplier, reporting and additional full-version
areas; locked sections are signposts for potential production scope and should
not be presented as implemented demo functionality.

## Demo limits and sample content

- Published app: [`public/gir-eco-enterprise/index.html`](../../public/gir-eco-enterprise/index.html).
- The page labels its data as sample data and resets state on refresh.
- Demo caps: up to 4 bills, 3 added customers, 4 payments and 3 purchase bills.
- The prototype includes an expiry date of **17 October 2026** in its current
  code; after that, the introductory screen may block entry.
- Invoice address and tax identity are sample placeholders. Replace and verify
  all legal, tax, bank and address details before any real-world document use.
- Payment reminder text is prepared from sample records; the prototype is not a
  connected accounting or payment service.

## Local preview and deployment

Open the published HTML file in a browser or serve the repository's `public/`
directory using its Wrangler configuration. The portfolio back button returns
to `public/index.html`.
