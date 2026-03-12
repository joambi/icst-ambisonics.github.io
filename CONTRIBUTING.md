# Contributing

## EN/DE Consistency Rule

For every structural content change, update EN and DE together.

Required:

- Keep paired files in sync: `index.md` and `index.de.md`.
- Keep main section structure aligned: same number/order of `##` sections.
- Keep table structure aligned: same table count and column structure.
- Keep callout structure aligned: same alert sequence/types.
- Keep CTA block structure aligned.
- Keep front matter keys aligned (same key set, except `languageCode` / `translationKey`).

Before opening a PR:

1. Run `./scripts/check-i18n-consistency.sh`.
2. Run `./scripts/check-frontmatter.sh`.
3. Run `./scripts/check-links.sh`.

If a page is intentionally single-language, add its path to `scripts/i18n-ignore.txt` with a short reason in the PR description.
