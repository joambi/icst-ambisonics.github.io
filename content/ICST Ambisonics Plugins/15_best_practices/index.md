---
title: Best Practices
date: 2025-01-01T00:00:00
weight: 150
draft: false
---

Short, reliable rules for stable Ambisonics sessions in REAPER: clean routing, repeatable decoder setups, and less troubleshooting before recording, rehearsal, or export.

## 1. Set the session baseline first

Before adding sources, establish the session structure. Retrofitting routing later is a reliable source of errors.

- Set all Ambisonics-relevant tracks to `64` channels by default.
- Define the signal chain early and clearly: `Source → HOA Bus → Decoder`.
- Save working setups as project or track templates so you start from a known state every time.

## 2. Keep routing disciplined

Routing errors in Ambisonics sessions are often invisible until playback reveals wrong speaker assignments or phase collapse.

- Avoid accidental direct source-to-master paths — all sources should feed through the HOA bus.
- Name source tracks, the HOA bus, and the decoder clearly and consistently.
- Check routing immediately after adding each new source or bus track.

## 3. Standardize decoder practice

The decoder translates the B-format field into loudspeaker signals. A mismatch between preset and real hardware is the single most common cause of wrong localization.

- Always load the preset that matches the real loudspeaker setup before listening or recording.
- Verify speaker order with the decoder test function after loading a new preset.
- Keep loudspeaker monitoring and binaural monitoring separated: route the HOA bus to the decoder for speaker playback and to a separate binaural decoder (e.g. IEM BinauralDecoder, SPARTA) for headphone monitoring. Never let both run in parallel unintentionally.

For complex setups with height layers or separate subgroups, use the **[ICST MultiDecoder](/icst-ambisonics-plugins/09_icst_multidecoder/)**, which runs up to four independent decoder units on the same B-format input. Name each unit clearly by its zone (e.g. `Mid Ring`, `Top Layer`, `Sub`).

## 4. Do not skip monitoring and verification

A quick signal check at the start of each session prevents problems that are much harder to diagnose after recording.

- Start every session with a single mono test source on a known encoder position.
- Briefly verify movement, level, and speaker assignment before working.
- Run a short 30-second signal check before recording or export — especially after loading a preset, changing the speaker setup, or reopening a project.

## 5. Export and rendering

Export discipline prevents format confusion when delivering files to other systems, studios, or archiving.

- Export B-format from the **Bformat Master** track in solo, not from the decoder output.
- Use **48,000 Hz** sample rate and **64-channel multichannel WAV** (Wave/RF64 for large files).
- Set channel count to match your HOA order: 4 ch (FOA/1st order), 9 ch (2nd order), 16 ch (3rd order), up to 64 ch (7th order).
- Use the **ambiX convention** (ACN channel ordering, SN3D normalisation) unless your target pipeline requires FuMa.
- Use a consistent filename that documents order and take: `scene01_O5_take03.wav`.
- Document the export format and channel ordering in a session notes file alongside the rendered material.

## 6. Maintain project hygiene

A session that is easy to hand over is also a session that is easy to reopen six months later.

- Use consistent track names and clear bus labels throughout.
- Document decoder presets, OSC port assignments, and export formats in a text file or the REAPER project notes.
- Save important session states as numbered versions instead of only overwriting: `project_v01.rpp`, `project_v02.rpp`.

## 7. Common failure points

- One track in the HOA path is not set to `64` channels.
- The decoder preset does not match the real loudspeaker routing.
- The `Source → HOA Bus → Decoder` chain is broken somewhere.
- Loudspeaker and headphone monitoring run in parallel unintentionally.
- OSC ports do not match between REAPER, external controllers, or helper tools.
- Export was rendered from the decoder output instead of the B-format master.
- ambiX and FuMa channel ordering mixed up between production and delivery.

## 8. Recommended order for new setups

1. Install the plugins and verify REAPER channel counts.
2. Create the HOA bus and decoder structure.
3. Insert one source and test the routing end-to-end.
4. Load the decoder preset for the loudspeaker setup and verify speaker order.
5. Set up the binaural monitoring path separately.
6. Only then expand into automation, recording, or rendering.

## Related pages

- [Quick Start](/icst-ambisonics-plugins/04_quick_start/)
- [Step-by-Step Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)
- [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/)
- [ICST MultiDecoder](/icst-ambisonics-plugins/09_icst_multidecoder/)
- [ICST Encoders](/icst-ambisonics-plugins/10_icst_encoders/)
- [OSC](/icst-ambisonics-plugins/13_osc/)
- [Downloads](/blog/downloads/)
