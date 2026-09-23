# Geeta Industries — QR Catalogue Prototype

Single-page static build. Everything (machines, prices, parts, both languages)
lives inside `public/index.html`. No backend, no Firebase, no secrets.

## Deploy
1. Upload the contents of this folder to its GitHub repo
2. Cloudflare Workers Builds deploys automatically
   - Build command: (leave empty)
   - Deploy command: `npx wrangler deploy`
   - Root directory: `/`

Live URL: https://prototype-geeta-industries.sangam-infoanalytics.workers.dev/
