# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Static website for [ambisonics.ch](https://ambisonics.ch/) — documentation, tutorials, and downloads for the ICST Ambisonics plugin suite (VST3/AU/LV2) and related REAPER tools. Built with **Hugo** using the **Anatole** theme (git submodule at `themes/anatole`). Deployed to GitHub Pages via `main` branch.

## Commands

```bash
# Local dev server (live reload)
hugo server

# Production build
hugo --minify

# Run all CI checks (required before pushing)
./scripts/check-frontmatter.sh
./scripts/check-i18n-consistency.sh
./scripts/check-links.sh

# Format code
npm run prettier

# Full build including theme resources (for theme dev)
npm run build
```

Hugo version used in CI: **0.159.1** (extended, with Dart Sass).  
Node.js: 22. Pagefind is added post-build by CI (`npx pagefind --site public`).

## Architecture

### Content structure

```
content/
  ICST Ambisonics Plugins/   # Plugin docs (type: docs)
    00_new/ … 15_icst_ambi_motion_map/
  ICST Ambisonics Tools/     # Tools docs (type: docs)
  post/                      # Blog/tutorial posts
  learn/                     # Ambisonics concepts
  Blog/                      # Studio/residency posts
```

The `docs` page type gets a special layout (`layouts/docs/single.html`) with:
- Left chapter nav sidebar (sorted by `weight`)
- Top tab navigation between all pages in the section
- Optional sticky right-column TOC when frontmatter has `toc: true` and content has sufficient headings

To add a new docs section page, set `type: docs` in the section `_index.md` and `cascade: type: docs`.

### Bilingual (EN / DE)

Every content page has an `index.md` (EN) and `index.de.md` (DE) pair. The CI script `check-i18n-consistency.sh` enforces structural parity: same `##` section structure, same callout types, same table column counts, same frontmatter keys, and same CTA blocks. If a page can legitimately differ between languages, add its path to `scripts/i18n-ignore.txt`.

Translation pairing is resolved via `translationKey` frontmatter (preferred) or filename convention.

### Frontmatter requirements

All `content/post/` and `content/Blog/` pages must have: `title`, `description`, `date`, `tags`. The date `0001-01-01` is treated as a placeholder and fails CI. The `check-frontmatter.sh` script enforces this.

### Downloads

Downloadable files live in two locations (both must stay in sync):
- `static/downloads/` — served directly
- `public/downloads/` — Hugo output (generated, but committed for the theme's exampleSite build)

When updating a Lua script (`JS_AmbiEncoder64_Motion_Map_GUI.lua`, etc.), copy to **both**:
```
static/downloads/lua-scripts/
public/downloads/lua-scripts/
```
The source of truth is `Reaper_Scripts_JS/Scripts/` — changes flow from there into this repo.

### Custom layouts and shortcodes

| File | Purpose |
|------|---------|
| `layouts/docs/single.html` | Two/three-column docs layout with sidebar nav + optional TOC |
| `layouts/shortcodes/notice.html` | `{{< notice warning >}}…{{< /notice >}}` callout boxes (types: `warning`, `update`) |
| `layouts/shortcodes/loading.html` | Lazy-load placeholder |
| `layouts/partials/toc.html` | Standalone TOC partial (used by docs layout) |

### Theme

`themes/anatole` is a **git submodule**. Don't modify files inside it directly — override via `layouts/` or `assets/` in the repo root (Hugo's lookup order gives root files priority).

### Static assets

`static/` is served as-is. Images referenced in docs typically live under `static/<page-slug>/` (e.g. `static/motion-markers/gui-overview.gif`).

## CI checks summary

The GitHub Actions workflow (`.github/workflows/hugo.yml`) runs on every push to `main`:

1. `check-frontmatter.sh` — title, description, date, tags on all post pages
2. `check-i18n-consistency.sh` — structural parity between EN/DE pairs
3. `check-links.sh` — no `localhost:1313` refs; no broken relative links in `content/post/` and `content/Blog/`
4. Hugo build with `--minify`
5. Pagefind search index
6. Deploy to GitHub Pages

## Domain-specific notes

### OSC address for AmbiEncoder

```
/icst/ambi/sourceindex/aed <int idx> <float az> <float el> <float dist>
```

### ICST AmbiEncoder coordinate system

The AmbiEncoder stores source positions as three Cartesian XYZ parameters (not AED). The writer scripts use a linear mapping:

```
X_cart = az / 180      (linear, NOT sin)
Y_cart = el / 90
Z_cart = 2 * d - 1
```

When sending positions via OSC, the encoder converts incoming AED to Cartesian using sin/cos (spherical). Use `toOscAED()` (in the GUI script) to invert this and send correct OSC values that match the written automation.

### Lua scripts and the writer relationship

`JS_AmbiEncoder64_Motion_Map_GUI.lua` is the user-facing GUI. It calls `JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua` (the writer engine) via `dofile()`. Both must be kept in sync — the GUI passes a parameter table to the writer via `_G.__ambi_motion_params`. The ICST plugin parameter layout: first XYZ param index = 11, stride per source = 5.
