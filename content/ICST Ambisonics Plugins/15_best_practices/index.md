---
title: Best Practices
date: 2025-01-01T00:00:00
weight: 150
draft: false
---

Short, reliable rules for stable Ambisonics sessions in REAPER: clean routing, repeatable decoder setups, and less troubleshooting before recording, rehearsal, or export.

## 1. Set the session baseline first

- Set all Ambisonics-relevant tracks to `64` channels by default.
- Define the signal chain early and clearly: `Source -> HOA Bus -> Decoder`.
- Save working setups as project or track templates.

## 2. Keep routing disciplined

- Avoid accidental direct source-to-master paths.
- Name source tracks, the HOA bus, and the decoder clearly.
- Check routing immediately after adding each new source or bus track.

## 3. Standardize decoder practice

- Always load the preset that matches the real loudspeaker setup.
- Verify speaker order with the decoder test function.
- Keep loudspeaker and binaural monitoring separated and intentional.

## 4. Do not skip monitoring and verification

- Start every session with a single test source.
- Briefly check movement, level, and speaker assignment.
- Run a short 30-second signal check before recording or export.

## 5. Maintain project hygiene

- Use consistent track names and clear bus labels.
- Document decoder presets, OSC ports, and export formats.
- Save important session states as versions instead of only overwriting.

## 6. Common failure points

- One track in the HOA path is not set to `64` channels.
- The decoder preset does not match the real loudspeaker routing.
- The `Source -> HOA Bus -> Decoder` chain is broken.
- Loudspeaker and headphone monitoring run in parallel unintentionally.
- OSC ports do not match between REAPER, controllers, or helper tools.

## 7. Recommended order for new setups

1. Install the plugins and verify REAPER.
2. Create the HOA bus and decoder structure.
3. Insert one source and test the routing.
4. Load the decoder preset for the loudspeaker setup.
5. Only then expand into automation, recording, or rendering.

## Related pages

- [Quick Start](/icst-ambisonics-plugins/04_quick_start/)
- [Step-by-Step Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)
- [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/)
- [Downloads](/blog/downloads/)
