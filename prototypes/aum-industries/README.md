# AUM Industries — Material Tracking Prototype (Sangam InfoAnalytics)

All files sit at the top level (no folders). `npm run build` creates the `dist` folder that gets deployed.

## Cloudflare (Workers & Pages → aum-industries → Settings → Build)
- Build command: `npm run build`
- Deploy command: `npx wrangler deploy`
- Root directory: `/`

## Firebase
1. Rename `firebaserc.txt` to `.firebaserc` and put your Firebase project ID inside.
2. Run `npx firebase-tools login`, then `npm run deploy:firebase`.

## GitHub Pages
Go to Settings → Pages → Source: "Deploy from a branch". This needs a `gh-pages` branch; ask Sangam for the workflow file if needed.
Cloudflare or Firebase is simpler for private client links.

## Local test
`npm start`, then open http://localhost:5173
