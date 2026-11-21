---
weight: 150
title: Render B-Format in REAPER
date: 2026-03-18T12:15:00+01:00
description: "Compact REAPER guide for rendering the Bformat Master correctly, choosing the right channel count, and documenting export metadata."
docs_nav_group: "Plugins"
---

Level: Beginner | Audience: Composer, technician, student, studio user.

Use this page when you want the shortest reliable path to a clean Ambisonics export from REAPER. The goal is simple: render the **Bformat Master**, not the decoder output.

If you need to clarify ambiX, ACN/SN3D, FOA/HOA, or why the channel count matters, keep [Ambisonics Formats Explained](/learn/ambisonics-formats/) open next to this guide.

## What you will achieve

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="One B-format file, many playback systems" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="100" width="150" height="56" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="90.0" y="132.0" text-anchor="middle" font-weight="600">Bformat Master</text><rect x="215" y="100" width="150" height="56" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="290.0" y="126.0" text-anchor="middle" font-weight="600">WAV file</text><text x="290.0" y="143.0" text-anchor="middle" font-size="10.5">64 ch · ambiX</text><line x1="165" y1="128" x2="213" y2="128" stroke="currentColor" stroke-width="1.8" opacity="1" marker-end="url(#ar1)"/><rect x="470" y="30" width="230" height="52" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="585.0" y="54.0" text-anchor="middle" font-weight="600">Loudspeaker decoder</text><text x="585.0" y="71.0" text-anchor="middle" font-size="10.5">any array</text><line x1="365" y1="128" x2="468" y2="56" stroke="#4a8fe0" stroke-width="1.4" opacity="0.8" marker-end="url(#ar1)"/><rect x="470" y="96" width="230" height="52" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="585.0" y="120.0" text-anchor="middle" font-weight="600">Binaural decoder</text><text x="585.0" y="137.0" text-anchor="middle" font-size="10.5">headphones</text><line x1="365" y1="128" x2="468" y2="122" stroke="#4a8fe0" stroke-width="1.4" opacity="0.8" marker-end="url(#ar1)"/><rect x="470" y="162" width="230" height="52" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="585.0" y="186.0" text-anchor="middle" font-weight="600">Other studio / system</text><text x="585.0" y="203.0" text-anchor="middle" font-size="10.5">archive, colleagues</text><line x1="365" y1="128" x2="468" y2="188" stroke="#4a8fe0" stroke-width="1.4" opacity="0.8" marker-end="url(#ar1)"/><text x="90" y="84" text-anchor="middle" font-size="11">rendered here</text><text x="290" y="84" text-anchor="middle" fill="#d9a441" font-size="11">once</text><text x="360" y="236" text-anchor="middle" font-weight="600" font-size="12">The B-format master stays neutral until the decoder is chosen.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">A render from the Bformat Master is decoded later for whatever system is available. A render of the decoder output would fix one speaker layout forever.</figcaption>
</figure>




By the end, you will have:

- a correct B-format export from the **Bformat Master**
- the correct channel count for your HOA order
- a reusable metadata note for project handover and later verification

## REAPER tutorial: render B-format correctly

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Render sequence in REAPER" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="40" width="150" height="70" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="90.0" y="73.0" text-anchor="middle" font-weight="600">Solo</text><text x="90.0" y="90.0" text-anchor="middle" font-size="10.5">Bformat Master</text><rect x="205" y="20" width="300" height="230" rx="10" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="355" y="44" text-anchor="middle" font-weight="600">File → Render</text><text x="222" y="86" text-anchor="start" font-size="12">Source</text><rect x="360" y="68" width="135" height="28" rx="5" fill="none" fill-opacity="0" stroke="#4a8fe0" stroke-width="1.2" opacity="1"/><text x="427" y="87" text-anchor="middle" font-weight="600" font-size="12">Stems (selected)</text><text x="222" y="128" text-anchor="start" font-size="12">Sample rate</text><rect x="360" y="110" width="135" height="28" rx="5" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.2" opacity="1"/><text x="427" y="129" text-anchor="middle" font-size="12">48000 Hz</text><text x="222" y="170" text-anchor="start" font-size="12">Format</text><rect x="360" y="152" width="135" height="28" rx="5" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.2" opacity="1"/><text x="427" y="171" text-anchor="middle" font-size="12">Multi-WAV / RF64</text><text x="222" y="212" text-anchor="start" font-size="12">Channels</text><rect x="360" y="194" width="135" height="28" rx="5" fill="none" fill-opacity="0" stroke="#4a8fe0" stroke-width="1.2" opacity="1"/><text x="427" y="213" text-anchor="middle" font-weight="600" font-size="12">(N+1)²  e.g. 64</text><rect x="545" y="40" width="150" height="70" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="620.0" y="73.0" text-anchor="middle" font-weight="600">Test render</text><text x="620.0" y="90.0" text-anchor="middle" font-size="10.5">re-import + verify</text><line x1="165" y1="75" x2="203" y2="75" stroke="currentColor" stroke-width="1.8" opacity="1" marker-end="url(#ar2)"/><line x1="505" y1="75" x2="543" y2="75" stroke="currentColor" stroke-width="1.8" opacity="1" marker-end="url(#ar2)"/><text x="355" y="278" text-anchor="middle" font-size="12">Channels must match the HOA order: 4 · 9 · 16 · 25 · 36 · 49 · 64</text><text x="620" y="140" text-anchor="middle" font-size="24">↩</text><text x="620" y="162" text-anchor="middle" font-size="11">then full render</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Three steps: solo the master, set the render dialog, check a short test file before the full export.</figcaption>
</figure>




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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 190" role="img" aria-label="File name anatomy" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="70" y="50" width="192" height="56" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="166.0" y="87" text-anchor="middle" font-size="22" font-family="monospace" font-weight="600">scene01</text><line x1="166.0" y1="106" x2="166.0" y2="128" stroke="#4a8fe0" stroke-width="1.5" opacity="1" marker-end="url(#ar3)"/><text x="166.0" y="148" text-anchor="middle" fill="#4a8fe0" font-size="12">scene</text><rect x="278" y="50" width="92" height="56" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="324.0" y="87" text-anchor="middle" font-size="22" font-family="monospace" font-weight="600">O7</text><line x1="324.0" y1="106" x2="324.0" y2="128" stroke="#3fa968" stroke-width="1.5" opacity="1" marker-end="url(#ar3)"/><text x="324.0" y="148" text-anchor="middle" fill="#3fa968" font-size="12">order</text><rect x="386" y="50" width="162" height="56" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="467.0" y="87" text-anchor="middle" font-size="22" font-family="monospace" font-weight="600">take01</text><line x1="467.0" y1="106" x2="467.0" y2="128" stroke="#d9a441" stroke-width="1.5" opacity="1" marker-end="url(#ar3)"/><text x="467.0" y="148" text-anchor="middle" fill="#d9a441" font-size="12">take</text><rect x="564" y="50" width="92" height="56" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="610.0" y="87" text-anchor="middle" font-size="22" font-family="monospace" font-weight="600">.wav</text><line x1="610.0" y1="106" x2="610.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1" marker-end="url(#ar3)"/><text x="610.0" y="148" text-anchor="middle" font-size="12">format</text><text x="360" y="24" text-anchor="middle" font-weight="600">Filename documents order and take</text><text x="360" y="176" text-anchor="middle" font-size="11">Example: scene01_O7_take01.wav = scene 01, 7th order, take 01</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Order and take belong in the filename, so the channel layout is clear before the file is even opened.</figcaption>
</figure>




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
- [Ambisonics Formats Explained](/learn/ambisonics-formats/)
- [Best Practices](/icst-ambisonics-plugins/17_best_practices/)
- [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/)
