# Quotation Manager — Mobile Quotation Prototype

## Overview

Quotation Manager demonstrates a mobile-first quotation workflow for a small business:
maintain an item and client list, prepare a GST-aware quotation, review its
status, and share a prepared message with a customer.

## Main screens and workflow

- **Home:** monthly quotation totals, awaiting and accepted quotes, expiring
  quotes, recent activity, and GST totals by slab.
- **Quotes:** review quotations and filter by status.
- **New quotation:** select a client, add catalogue items and quantities, review
  tax calculations and terms, then prepare the quote for sharing.
- **Items and clients:** view and add sample catalogue items and customers.
- **More / settings:** inspect the business identity, contact, bank and quote
  numbering fields.

The intended walkthrough is: open a recent quote, start a new quote, select a
client and items, review the GST calculation, then use the share action.

## Prototype status and data

- Published prototype: [`public/deservoir/index.html`](../../public/deservoir/index.html).
- Quotes, clients, items and settings are sample data. Nothing is saved, so
  changes are not retained after leaving or refreshing the page.
- Sharing opens a prepared customer message; it does not constitute delivery
  through a production messaging service.
- The example company identity is a placeholder. Replace it with approved
  business, tax, address, bank and contact details before using any generated
  quotation outside a demo.
- No authentication, server-side quotation storage or production PDF service
  is provided by this prototype.

## Related documentation

The public-facing detailed guide is
[`public/deservoir/documentation.html`](../../public/deservoir/documentation.html).
It describes the purpose, quotation workflow, modules, prototype limitations
and discovery questions. This README is the project-docs index and implementation
reference for the published demo.
