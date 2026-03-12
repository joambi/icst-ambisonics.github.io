This is the new Blog for the ICST Ambisonics Stuff.

## Build policy

Production and preview builds use `public/` as the canonical output directory.

- `public/` is the deployment output used by the current site setup.
- `docs/` is treated as a legacy or optional export target and should only be regenerated when there is an explicit reason to ship a checked-in static snapshot.
- Day-to-day content and layout work should be verified against `public/`, not `docs/`.

## Build commands

Production builds use `hugo` with future-dated content disabled.

```bash
hugo
```

For local preview including future-dated content, use:

```bash
hugo server --config hugo.toml,hugo.preview.toml
```

Only regenerate `docs/` when you explicitly need a committed export:

```bash
hugo --destination docs
```
