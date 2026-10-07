# Industry-Prototypes

Sangam InfoAnalytics client prototype showcase, deployed on Cloudflare Workers (static assets).

## Structure

- `public/` — everything served on the website
  - `index.html` — portfolio landing page
  - `chawla-industries/`, `classic-powder-coating/`, `deservoir/`, `geeta-industries/`, `monocraft-traceline/`, `spirit-engineering/`, `aum-industries/`, `gir-eco-enterprise/`, `shivam-salt/` — one prototype each (`index.html`)
- `prototypes/` — source files for the three latest prototypes, kept separate from their published copies in `public/`
  - `aum-industries/` — AUM source app, dependencies and deployment files
  - `gir-eco-enterprise/`, `shivam-salt/` — original standalone prototype HTML files (`index.html`)
- `project-docs/` — internal project documentation (not published), grouped by prototype:
  - `chawla-industries/`, `classic-powder-coating/`, `deservoir/`,
    `geeta-industries/`, `spirit-engineering/`, `aum-industries/`,
    `gir-eco-enterprise/`, `shivam-salt/`, `monocraft-traceline/`
  - Monocraft includes the production blueprint and SQL schema; Chawla includes
    prototype details and deployment notes.
  - Deservoir and Workshop Management also have client-facing detailed documentation in
    their respective `public/` folders; project-docs READMEs link to those guides.
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

1. Create `public/<client-name>/index.html` (lowercase, hyphens, no spaces), and include any local assets it references.
2. Use `href="../index.html"` for the back link.
3. Add a card linking to `<client-name>/index.html` in `public/index.html`.
4. Commit and push.
