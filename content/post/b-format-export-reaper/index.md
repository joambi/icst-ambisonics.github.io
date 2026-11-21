---
title: Exporting the B-Format Master – AmbiX, Channel Order and Normalisation
description: "How to export a correct Ambisonics master in REAPER: AmbiX format, ACN channel order, SN3D normalisation, render dialog settings and the most common mistakes in multichannel export."
date: 2026-03-21T16:30:00+01:00
year: 2026
month: 2026-03
weight: 36
tags: ["export", "render", "ambix", "acn", "sn3d", "reaper", "b-format", "workflow", "delivery"]
key_points:
  - "AmbiX = ACN channel order + SN3D normalisation – today's standard"
  - "REAPER: 'Multichannel tracks to multichannel files' must be active in the render dialog"
  - "The channel count of the B-format bus and the order in the decoder must be identical"
difficulty: "intermediate"
post_kind: "tutorial"
tool: ["REAPER"]
---

Level: Intermediate | **Audience:** Composers, technicians, sound engineers.

---

Exporting a finished Ambisonics production sounds trivial – but it is not. A wrongly configured render produces silent channels, swapped channel order or incorrectly normalised signals that sound wrong at the next production stage without any obvious error being visible. This article shows how to produce a correct AmbiX master from REAPER.

---

<figure data-gen="g24" style="margin:1.8rem 0">
<video controls muted loop playsinline preload="metadata" poster="/videos/bformat-export-en-poster.jpg" src="/videos/bformat-export-en.mp4" style="width:100%;max-width:720px;height:auto;display:block;border-radius:8px"></video>
<figcaption style="font-size:.9em;opacity:.8;margin-top:.4rem">Video: render from the B-format master, not from the decoder output (about 14 seconds).</figcaption>
</figure>

## The format: AmbiX

Today's industry standard for exchanging Ambisonics is **AmbiX**. AmbiX defines two things:

**ACN – Ambisonic Channel Number**: the order in which the spherical harmonics are stored in the file. ACN numbers the channels with the formula `n(n+1) + m`, where `n` is the order and `m` the degree.

**SN3D – Semi-Normalized 3D**: the normalisation scheme that determines how strongly the individual harmonics are weighted. SN3D ensures that the peak level of a point source does not exceed the W channel – no overload from higher orders.

The combination ACN/SN3D is what all current plugins – IEM Suite, SPARTA, ICST AmbiPlugins – use as the standard. Whenever you hand over or receive a file, make sure both sides speak the same format.

### Channel counts per order

| Order | Total channels | New channels of this order |
|---|---|---|
| 1st order (FOA) | 4 | 4 |
| 2nd order | 9 | 5 |
| 3rd order | 16 | 7 |
| 4th order | 25 | 9 |
| 5th order | 36 | 11 |
| 7th order | 64 | 15 |

The formula: `(n+1)²` channels for order `n`.

### FuMa – the old format

FuMa (Furse-Malham) is the legacy format from the time before AmbiX. The differences:

- **Channel order**: WXYZ instead of ACN (at 1st order: W is channel 1, then X, Y, Z)
- **W level**: 3 dB lower than in AmbiX/SN3D
- **Higher orders**: different designations and normalisation

FuMa is still found in older plugins and some archive files (extension `.amb`). In the ICST workflow, keep everything in AmbiX/SN3D; use FuMa only if a recipient explicitly demands it. For conversions between formats: **ambix_converter** (free, command line) or **dearVR AMBI MICRO** with a built-in converter.

---

## REAPER: render setup step by step

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 130" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Five render steps for a B-format export: bus channel count, encoder sends, render dialog, file format and naming." xmlns="http://www.w3.org/2000/svg"><defs><marker id="mr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10.0" y="28" width="124" height="66" rx="8" stroke="#d9534f" fill="#d9534f" fill-opacity=".16" stroke-width="1.5"/><text x="72.0" y="58.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">1 Bus channels</text><text x="72.0" y="75.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">4 / 16 / 64 ch</text><line x1="136.0" y1="61" x2="154.0" y2="61" stroke="currentColor" stroke-width="1.6" marker-end="url(#mr)"/><rect x="156.5" y="28" width="124" height="66" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="218.5" y="58.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">2 Encoder sends</text><text x="218.5" y="75.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">offset 0, all ch</text><line x1="282.5" y1="61" x2="300.5" y2="61" stroke="currentColor" stroke-width="1.6" marker-end="url(#mr)"/><rect x="303.0" y="28" width="124" height="66" rx="8" stroke="#d9534f" fill="#d9534f" fill-opacity=".16" stroke-width="1.5"/><text x="365.0" y="58.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">3 Render dialog</text><text x="365.0" y="75.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">multichannel on</text><line x1="429.0" y1="61" x2="447.0" y2="61" stroke="currentColor" stroke-width="1.6" marker-end="url(#mr)"/><rect x="449.5" y="28" width="124" height="66" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="511.5" y="58.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">4 File format</text><text x="511.5" y="75.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">32-bit float, 48k</text><line x1="575.5" y1="61" x2="593.5" y2="61" stroke="currentColor" stroke-width="1.6" marker-end="url(#mr)"/><rect x="596.0" y="28" width="124" height="66" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="658.0" y="58.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">5 Naming</text><text x="658.0" y="75.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">order, ACN, SN3D</text><text x="72" y="118" text-anchor="middle" font-size="11" font-weight="400" fill="#d9534f" fill-opacity="0.9">too few = silent channels</text><text x="365.0" y="118" text-anchor="middle" font-size="11" font-weight="400" fill="#d9534f" fill-opacity="0.9">else only 2 channels</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Render checklist: the two most common errors sit at steps 1 and 3.</figcaption>
</figure>


### 1. Configure the B-format bus correctly

Before you render, the B-format master bus must have the right channel count. Right-click the track → *Track Channels* → set the channel count to the sum of all active harmonics:

- HOA1: 4 channels
- HOA3: 16 channels
- HOA7: 64 channels

A bus with too few channels silently cuts off the higher harmonics – the render then contains silent channels without any error message.

### 2. Check all encoder sends to the bus

Every AmbiEncoder must send its output completely to the B-format bus. In REAPER: check the send routing, channel offset = 0, source channels = all active channels. A single wrongly configured send can overlay or omit channels.

### 3. Configure the render dialog

Open **File → Render**. The decisive setting:

> **☑ Multichannel tracks to multichannel files**

Without this tick REAPER renders only the first two channels (stereo fallback). The option must be active so that the full channel count of the bus is written to the output file.

Further settings:

- **Source**: master mix or selected track (depending on the session layout)
- **Format**: WAV, 32-bit float or 24-bit PCM – always 32-bit float for archives; 24-bit PCM for delivery
- **Sample rate**: 48 kHz standard; 96 kHz if the production is based on it
- **Dither**: only needed for 16-bit or 24-bit float → int conversion

### 4. File naming convention

An AmbiX file without documentation is useless to the recipient. Channel order and normalisation are not stored in the WAV standard. Recommended convention in the file name:

```
Title_HOA3_ACN_SN3D_48k_24bit.wav
```

Or as an accompanying document: a `.txt` file with format details, order, channel count, normalisation and the encoder suite used.

---

## Validation before delivery

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 248" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="A rendered B-format file is checked for channel count, silent channels, W level and by listening in a fresh session." xmlns="http://www.w3.org/2000/svg"><defs><marker id="mv" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="92" width="150" height="66" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="85.0" y="130.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Rendered file</text><line x1="162" y1="125" x2="208" y2="34" stroke="currentColor" stroke-width="1.6" marker-end="url(#mv)"/><rect x="210" y="8" width="500" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="224" y="31.0" text-anchor="start" font-size="13" font-weight="600" fill="currentColor">Channel count</text><text x="224" y="48.0" text-anchor="start" font-size="11" fill="currentColor" fill-opacity=".75">HOA3 = 16, HOA7 = 64 channels</text><line x1="162" y1="125" x2="208" y2="94" stroke="currentColor" stroke-width="1.6" marker-end="url(#mv)"/><rect x="210" y="68" width="500" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="224" y="91.0" text-anchor="start" font-size="13" font-weight="600" fill="currentColor">No silent channels</text><text x="224" y="108.0" text-anchor="start" font-size="11" fill="currentColor" fill-opacity=".75">flat line = bus or send problem</text><line x1="162" y1="125" x2="208" y2="154" stroke="currentColor" stroke-width="1.6" marker-end="url(#mv)"/><rect x="210" y="128" width="500" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="224" y="151.0" text-anchor="start" font-size="13" font-weight="600" fill="currentColor">W level</text><text x="224" y="168.0" text-anchor="start" font-size="11" fill="currentColor" fill-opacity=".75">channel 1 is the loudest; otherwise check order and normalisation</text><line x1="162" y1="125" x2="208" y2="214" stroke="currentColor" stroke-width="1.6" marker-end="url(#mv)"/><rect x="210" y="188" width="500" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="224" y="211.0" text-anchor="start" font-size="13" font-weight="600" fill="currentColor">A/B listening</text><text x="224" y="228.0" text-anchor="start" font-size="11" fill="currentColor" fill-opacity=".75">fresh session + decoder: sources must not be mirrored or rotated</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Four checks before delivery.</figcaption>
</figure>


Before you hand over the file: a short check.

**Check the channel count**: open the rendered file in a multichannel viewer or directly in REAPER. The channel count must match the expected order. An HOA3 file has exactly 16 channels.

**No silent channels**: check in the waveform editor that all channels carry signal. Silent channels (flat line) point to a wrong bus configuration or interrupted sends.

**Level check on the W channel**: channel 1 (W, omnidirectional) should have the highest level of all channels. If channel 2 or 3 is stronger, the normalisation or the channel order is wrong.

**A/B listening**: open the file in a fresh REAPER session with the IEM AllRAD decoder or the ICST AmbiDecoder. Localisation must match the production session. If sources sound mirrored or rotated: check the channel order.

---

## Common mistakes

**Forgetting "Multichannel to multichannel files"**: the most common mistake. The render produces a 2-channel file without an error message. Always check.

**Wrong bus channel count**: encoder set to HOA3, bus at 4 channels. The higher 12 channels are zero in the render. It sounds like FOA.

**N3D instead of SN3D in plugins**: if one plugin runs on N3D while all the others use SN3D, incoherent levels arise between orders. Localisation sounds shifted, the level of the higher harmonics is too loud or too quiet.

**Mixing FuMa and AmbiX**: loading an FOA source file in FuMa into an HOA3 AmbiX session without converting creates channel confusion. Bring all imported B-format files to AmbiX/SN3D first.

**Too little headroom**: N3D-normalised signals can have 6–12 dB more level than SN3D at higher orders. If you work in N3D (e.g. because of a plugin), plan for correspondingly more headroom.

---

## AmbiX conversion tools

<figure data-gen="g21" style="margin:1.8rem 0">
<svg viewBox="0 0 720 240" role="img" aria-label="Decision: deliver AmbiX as is or convert to FuMa if the recipient asks for it" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="are1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="20" y="85" width="180" height="60" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="110" y="110" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="13">Your master</text><text x="110" y="128" text-anchor="middle" font-size="11">ACN · SN3D</text><rect x="235" y="85" width="200" height="60" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="335" y="120" text-anchor="middle" font-weight="600" font-size="12">What does the recipient need?</text><line x1="202" y1="115" x2="233" y2="115" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#are1)"/><rect x="500" y="25" width="200" height="60" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="600" y="50" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="13">AmbiX (ACN/SN3D)</text><text x="600" y="68" text-anchor="middle" font-size="11">deliver as is</text><rect x="500" y="145" width="200" height="78" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="600" y="168" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="13">FuMa (.amb)</text><text x="600" y="184" text-anchor="middle" font-size="11">convert first:</text><text x="600" y="199" text-anchor="middle" font-size="10">ambix_converter or</text><text x="600" y="212" text-anchor="middle" font-size="10">dearVR AMBI MICRO</text><line x1="437" y1="100" x2="498" y2="60" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#are1)"/><line x1="437" y1="130" x2="498" y2="170" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#are1)"/><text x="360" y="236" text-anchor="middle" font-size="11">Default in the ICST workflow: stay in AmbiX, convert only on explicit request.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Convert only when the recipient explicitly requires FuMa.</figcaption>
</figure>



If you have received a FuMa file or need a different order:

- **ambix_converter**: command-line tool that converts between FuMa, AmbiX and various normalisations. Free.
- **IEM AmbiX Converter** (part of the IEM Suite): GUI tool for format conversions directly in REAPER
- **VVMicArray**: for microphone-specific conversions
- **dearVR AMBI MICRO**: contains a FuMa-to-AmbiX converter as a plugin

---

## Further reading

- [ICST AmbiDecoder – setup and operation](/icst-ambisonics-plugins/08_icst_decoder/)
- [Coordinate systems: XYZ and AED compared](/post/xyz-vs-aed-koordinatensysteme/)
- [From the Ambisonics scene to an Atmos bed](/post/ambisonics-to-atmos-bed/)
- [Binaural monitoring in the ICST workflow](/post/binaural-monitoring-icst-workflow/)

<p class="ai-credit" style="font-size:.85em;opacity:.7"><em>Diagrams and explainer videos created with the help of Claude (Anthropic). <a href="/about/#about-this-site">→</a></em></p>
