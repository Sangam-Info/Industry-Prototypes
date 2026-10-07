# Coating Job Tracker — Powder Coating Production Prototype

## Overview

The Coating Job Tracker demonstrates job intake and shop-floor tracking for a powder-coating
operation. A lot moves through preparation and coating stages before it is
ready for dispatch. The interface is designed for office staff, production
staff and drivers.

## Main workflow

1. Create or find an inward lot and record its customer and items.
2. Track required quantities and shortages at the current production stage.
3. Confirm work at the stage and advance the lot when its work is complete.
4. Review the lot timeline and stage status.
5. Record dispatch and delivery details when the lot is ready.

The configured stages are **Washing & Cleaning**, **Powder Coating**, optional
**Wooden Coating**, and **Ready to dispatch**. Stage progression depends on
whether wooden coating is required for the lot.

## Prototype capabilities

- Staff and driver sign-in flows.
- Inward lots, item quantities, shade and stage tracking.
- Stage tally, shortages, locks and rejection/exception details.
- Dispatch and delivery information.
- Dashboard, search, reports and settings views.
- Firebase Authentication and Cloud Firestore integration are used by the
  current app for sign-in and shared records; the application names a specific
  Firestore database.

## Important setup and limitations

- Published prototype: [`public/classic-powder-coating/index.html`](../../public/classic-powder-coating/index.html).
- The page is a single HTML app and imports Firebase modules and fonts from
  external CDNs; an internet connection is needed for those services.
- Firebase configuration and the Firestore database must match the project
  environment. Confirm Firebase Authentication users, Firestore rules, database
  ID and any seeded records before testing. Never place privileged credentials
  or service-account keys in the HTML.
- The interface is still a prototype. Validate every role, permission, stage
  transition, record-retention rule and production backup before operational
  use.
- The portfolio back button returns to `public/index.html`.

## Local preview and deployment

Run the repository static site with the Cloudflare Wrangler assets directory
(`public/`), or open the file in a browser for a visual inspection. The root
[`wrangler.jsonc`](../../wrangler.jsonc) is the deployment configuration for
the published showcase.
