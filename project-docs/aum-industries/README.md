# StockPilot — Plywood Material Tracking Prototype

## Overview

StockPilot demonstrates inventory and order tracking for a plywood and door
factory, from purchasing and material inward through production and customer
dispatch.

## Main sections

- **Dashboard:** factory status, live 3D overview, material and order KPIs, and
  items needing attention.
- **Factory view:** interactive visual overview of factory stations.
- **Track anything:** search for an order, batch or purchase-order reference.
- **Purchase orders and material inward:** follow material orders and received
  quantities.
- **Stock:** inspect material availability and reorder status.
- **Production:** follow batches through production stages.
- **Customer orders and dispatch:** review customer orders and dispatch state.
- **Reports, users and settings:** displayed as full-version/limited areas in
  this prototype.

## Demo limits and data

- Published app: [`public/aum-industries/index.html`](../../public/aum-industries/index.html).
- The UI identifies itself as a prototype with sample data and explains that
  additions are cleared on reload.
- New-entry actions are capped in the demo; reports, user roles, settings and
  printing include locked/limited areas.
- Do not use displayed stock, purchase, production or dispatch values as live
  inventory records.
- The page loads Three.js and fonts from external sources. The interactive 3D
  view may require network access; the remaining interface is served as a
  static HTML asset.
- The portfolio back button returns to `public/index.html`.

## Local preview and deployment

Use the repository's static-site setup: `wrangler.jsonc` serves the `public/`
directory. The published prototype is the HTML page linked above, with its
supporting local assets in the same folder.
