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
