# Launch checklist — jason-howell.com (target: tonight)

## 1. Images (2 min) — do this FIRST
Open Terminal in this folder:
    ./get-images.sh
(If "permission denied": chmod +x get-images.sh first.)
All 26 photos land in assets/img/ — the site is now Wix-free.

## 2. GitHub (10 min)
- github.com → New repository → name: jason-howell-site → **Public** → Create
- "uploading an existing file" → drag EVERYTHING in this folder in
  (index.html, impressum.html, datenschutz.html, assets/, CNAME,
  .nojekyll, README.md) → Commit
- Settings → Pages → Source: "Deploy from a branch" → main / (root) → Save
- Same page → Custom domain: jason-howell.com → Save

## 3. Wix DNS (5 min)
Wix → Domains → ⋯ next to jason-howell.com → Manage DNS records
- A records (host = blank/@): DELETE Wix's, ADD these four:
    185.199.108.153
    185.199.109.153
    185.199.110.153
    185.199.111.153
- CNAME, host "www": change value to  <username>.github.io
- Save. Touch nothing else (MX etc. stay).

## 4. Wait, then lock (15 min – 2 h typically)
- Check: https://jason-howell.com shows the new site
- GitHub → Settings → Pages → tick "Enforce HTTPS" once available

## DO NOT (yet)
- Do NOT cancel the Wix plan tonight
- Do NOT start a domain transfer (freezes DNS changes)
Both are next week's tasks, after the site is verified live.
