# ICST Ambisonics — ambisonics.ch

**Official documentation site:** [ambisonics.ch](https://ambisonics.ch)
📖 **Documentation:** [ambisonics.ch](https://ambisonics.ch)
Free spatial audio plugins, a composing guide, and artist residencies at ICST / Zurich University of the Arts (ZHdK).

- 🎛️ [ICST Ambisonics Plugins for REAPER](https://ambisonics.ch/icst-ambisonics-plugins/) — free & open source
- 🎼 [Composing in Ambisonics](https://ambisonics.ch/composing-in-ambisonics/) — spatial composition guide
- 🏛️ [Studio Residencies](https://ambisonics.ch/residenzen/) — artist-in-residence programme at ICST
- 🧊 [Max/MSP Tools](https://ambisonics.ch/icst-ambisonics-tools/) — live spatialisation and algorithmic sound

---

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
