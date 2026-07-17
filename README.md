# jason-howell.com — new website

A complete rebuild of Jason's site as a single fast, self-hosted page.
No Wix, no page builder, no monthly site subscription needed.

**What's in the box**

- `index.html` — the entire website (design, content, photo gallery, lightbox)
- `get-images.sh` — one-time script that pulls all photos off Wix's servers
- `assets/img/` — created by the script; holds all images locally

---

## Migration in 4 steps (order matters!)

### 1. Preview it

Double-click `index.html` — it opens in the browser and already shows all
images (they load from Wix's CDN for now, which works as long as the Wix
account is still active).

### 2. Localise the images — BEFORE cancelling Wix

```bash
./get-images.sh
```

This downloads all 26 photos into `assets/img/` and rewrites `index.html`
to use the local copies. After this, the site has zero dependency on Wix.

> If the terminal says "permission denied", run `chmod +x get-images.sh` first.

### 3. Deploy (free)

Easiest option — **Netlify Drop**:

1. Go to https://app.netlify.com/drop
2. Drag the whole `jason-howell-site` folder onto the page
3. The site is live in seconds on a temporary URL — check everything works

Equally good alternatives: **Cloudflare Pages** or **GitHub Pages**.
All three host static sites for free with SSL included.

### 4. Point the domain, then cancel Wix

- In Netlify: *Domain settings → Add custom domain → jason-howell.com*,
  then follow the DNS instructions shown (either switch nameservers to
  Netlify, or set an A record + `www` CNAME at the current registrar).
- **Important:** check where the domain itself is registered. If it was
  bought *through Wix*, cancel only the **website/premium plan** and keep
  the **domain registration** — or transfer the domain to another
  registrar (e.g. Cloudflare) first. Cancelling everything at once can
  put the domain at risk.
- Once the domain resolves to the new site and images are local:
  cancel the Wix site plan. Done.

---

## Editing the site later

Everything lives in `index.html` — open it in any text editor:

- **Text** (bio, release stories, contact): plain HTML near the top of
  the `<body>`, clearly commented by section.
- **Streaming links**: search for `platforms` — each button is one line.
- **Photos**: the gallery is a simple list of filenames in the
  `GALLERY = [...]` array at the bottom of the file. Add a photo to
  `assets/img/` and add its filename to the list.
- **A new release**: copy one of the `<article class="release">` blocks,
  swap the artwork, title, story and links.

## Nice-to-haves for later (optional)

- **Contact form** instead of the mailto link: on Netlify, add
  `<form name="contact" netlify>` and it works with no backend.
- **Analytics**: Plausible or Fathom are privacy-friendly one-liners.
- Verify the release years shown (single: 2021, album: 2020) — adjust in
  the two `release-meta` lines if needed.
