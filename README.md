# Industry-Prototypes

Sangam InfoAnalytics client prototype showcase, deployed on Cloudflare Workers (static assets).

## Structure

- `public/` — everything served on the website
  - `index.html` — portfolio landing page
  - `chawla-industries/`, `classic-powder-coating/`, `deservoir/`, `geeta-industries/`, `monocraft-traceline/`, `spirit-engineering/` — one prototype each (`index.html`)
- `project-docs/` — internal notes, READMEs, schema (not published)
- `wrangler.jsonc` — Cloudflare config

## Deploy

Cloudflare dashboard → Workers & Pages → industry-prototypes → Settings → Build:

| Field | Value |
|---|---|
| Build command | `npm run build` |
| Deploy command | `npx wrangler deploy` |
| Root directory | `/` |

Never put a path (like `/` or `./public`) in the Build command field — it is run as a shell command and fails with `Permission denied`. The folder to serve is set in `wrangler.jsonc` (`assets.directory`).

Every push to `main` redeploys automatically.

## Adding a new prototype

1. Create `public/<client-name>/index.html` (lowercase, hyphens, no spaces).
2. Use `href="../index.html"` for the back link.
3. Add a card linking to `<client-name>/index.html` in `public/index.html`.
4. Commit and push.
