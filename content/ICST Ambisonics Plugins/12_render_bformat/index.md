---
weight: 110
title: Render B-Format in REAPER
date: 2026-03-18T12:15:00+01:00
description: "Compact REAPER guide for rendering the Bformat Master correctly, choosing the right channel count, and documenting export metadata."
---

Level: Beginner | Audience: Composer, technician, student, studio user.

Use this page when you want the shortest reliable path to a clean Ambisonics export from REAPER. The goal is simple: render the **Bformat Master**, not the decoder output.

## What you will achieve

By the end, you will have:

- a correct B-format export from the **Bformat Master**
- the correct channel count for your HOA order
- a reusable metadata note for project handover and later verification

## REAPER tutorial: render B-format correctly

Use this short REAPER sequence for a clean Ambisonics export:

1. Set the **Bformat Master** track to **Solo**.
2. Open **File -> Render**.
3. Choose **Source: Stems (selected tracks)** or the equivalent track-based render mode.
4. Select **Bformat Master** as the render target.
5. Set **Sample rate** to `48000`.
6. Choose **Multichannel WAV / RF64** as the output format.
7. Set the **channel count** to match your HOA order:
   - `4` channels for FOA / 1st order
   - `9` channels for 2nd order
   - `16` channels for 3rd order
   - up to `64` channels for 7th order
8. Render one short test file first, then re-import it into REAPER and verify playback through the decoder or binaural path.

## Channel-count quick reference

| HOA order | Channels |
|---|---:|
| 1st order / FOA | 4 |
| 2nd order | 9 |
| 3rd order | 16 |
| 4th order | 25 |
| 5th order | 36 |
| 6th order | 49 |
| 7th order | 64 |

## Meta text inside REAPER

Keep a short export note inside **Project Settings -> Notes** or in a session text file next to the render. This makes handover and later verification much easier.

Suggested meta text:

```text
Render: B-format master
Format: ambiX (ACN / SN3D)
Sample rate: 48000 Hz
Channels: 64
HOA order: 7th
Source track: BFORMAT_MASTER
Decoder preset used for monitoring: [speaker preset name]
Binaural check: yes / no
Filename: scene01_O7_take01.wav
Notes: rendered from B-format master, not decoder output
```

## Common mistakes

- Rendering the **decoder output** instead of the **Bformat Master**
- Using the wrong channel count for the selected HOA order
- Forgetting to document whether monitoring was checked on speakers, headphones, or both
- Delivering a file without clear order and take information in the filename

## Related pages

- [Step-by-Step Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)
- [Best Practices](/icst-ambisonics-plugins/15_best_practices/)
- [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/)
