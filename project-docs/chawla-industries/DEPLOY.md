# Deploy the Chawla prototype with Wrangler

Folder layout — keep it exactly like this:

```
chawla-demo/
├── wrangler.toml
└── public/
    └── index.html
```

---

## One time

**1. Check Node is installed.** Open PowerShell and run:

```powershell
node -v
```

If it says something like `v22.x`, you are fine. If it says the command is not
recognised, install the **LTS** version from https://nodejs.org and reopen
PowerShell.

**2. Go into the folder.**

```powershell
cd C:\Users\YourName\Documents\chawla-demo
```

**3. Log in to Cloudflare.**

```powershell
npx wrangler@latest login
```

A browser tab opens — pick the Sangam InfoAnalytics account and click Allow.
If no tab opens, copy the URL it prints and paste it into your browser.

Check it picked the right account:

```powershell
npx wrangler@latest whoami
```

---

## Deploy

```powershell
npx wrangler@latest deploy
```

That is the whole thing. After about 20 seconds it prints a URL like:

```
https://chawla-demo.sangam-infoanalytics.workers.dev
```

Open it on your phone. That is the link you show the client.

---

## Updating it later

Save the new file over `public/index.html`, then run the same command again:

```powershell
npx wrangler@latest deploy
```

The URL never changes, so anything you already shared keeps working.

---

## If something goes wrong

**"Unknown field: assets"** — your Wrangler is too old. Always use
`npx wrangler@latest` rather than a globally installed `wrangler`.

**"More than one account available"** — add your account ID to
`wrangler.toml`. Find it on the Cloudflare dashboard home page, right sidebar:

```toml
account_id = "your-account-id-here"
```

**Page loads but is blank** — the file is probably not at `public/index.html`.
Check the name is exactly `index.html`, all lowercase. Windows hides
extensions by default, so turn on **File name extensions** in Explorer's View
menu and make sure it is not `index.html.html`.

**Name already taken** — change `name = "chawla-demo"` in `wrangler.toml` to
something else and deploy again.

---

## Alternative: Pages instead of Workers

If you would rather it sit under Pages alongside your other projects, skip
`wrangler.toml` entirely and run this from the `chawla-demo` folder:

```powershell
npx wrangler@latest pages deploy ./public --project-name=chawla-demo
```

You get a `chawla-demo.pages.dev` address instead. Both work the same for a
static file — pick one and stay with it.
