---
title: "Ambisonics Formats Explained: A-Format, B-Format, FuMa, ambiX, FOA and HOA"
description: "A practical reference for Ambisonics file and signal formats: A-Format, B-Format, FuMa, ambiX, ACN, SN3D, N3D, FOA, HOA, channel counts, and the ICST recommendation."
date: 2026-05-01T00:00:00
draft: false
slug: ambisonics-formats
tags:
  - ambisonics
  - b-format
  - ambix
  - hoa
---

Level: Beginner to Intermediate | Audience: Composers, students, producers, technicians, studio residents.

Use this page when you see terms such as **A-Format**, **B-Format**, **FuMa**, **ambiX**, **ACN/SN3D**, **FOA**, or **HOA** and need to know what they mean in practice.

<div class="hero__links">
  <a class="hero__link" href="#quick-checklist">Quick checklist</a>
  <a class="hero__link" href="#icst-recommendation">ICST recommendation</a>
  <a class="hero__link" href="/blog/b-format-archive/">B-Format Archive</a>
</div>

## 1. Why "format" is confusing in Ambisonics

Ambisonics uses the word **format** for several different things:

- the raw output of a microphone
- the internal spatial signal in a DAW
- the channel order inside a file
- the normalization convention used by the spherical harmonics
- the Ambisonics order, which determines the channel count

That is why "Is this B-Format?" is often not specific enough. A better practical question is:

> Is this an ambiX B-Format file, with ACN channel ordering and SN3D normalization, and which Ambisonics order does it use?

## 2. A-Format vs B-Format

**A-Format** is usually the raw signal from an Ambisonic microphone. In a first-order tetrahedral microphone, this means four capsule signals before spatial decoding or correction. A-Format is microphone-specific and normally should not be treated as a finished Ambisonics master.

**B-Format** is the Ambisonics signal representation used for production, exchange, decoding, and archiving. It describes a sound field around a listening point. First-order B-Format has four channels; higher-order B-Format has more.

Practical rule:

- A-Format comes from the microphone and must be converted.
- B-Format is the spatial scene you can edit, route, decode, archive, or render.

## 3. FuMa vs ambiX

**FuMa** is the older Ambisonics convention. It uses named first-order channels such as `W`, `X`, `Y`, `Z` and MaxN-style normalization. It is still encountered in older tools, historical material, and some first-order workflows.

**ambiX** is the modern exchange convention for Ambisonics. It uses:

- **ACN** channel ordering
- **SN3D** normalization
- ordinary multichannel audio files, usually WAV or RF64

In current ICST workflows, **ambiX is the default**. If a tool asks for channel ordering and normalization, choose `ACN/SN3D` unless you have a clear reason to do otherwise.

## 4. ACN, SN3D and N3D

**ACN** means Ambisonic Channel Number. It defines the channel order. Instead of using historical names such as `W`, `X`, `Y`, `Z`, each spherical harmonic component gets a numbered channel.

**SN3D** and **N3D** are normalization conventions. They define the scaling of Ambisonics components. The spatial scene may be conceptually the same, but a mismatch between SN3D and N3D changes levels between channels and can make decoding wrong.

For most plugin and DAW work today:

- `ACN/SN3D` = ambiX, recommended for exchange and production
- `ACN/N3D` = common in some research, analysis, and mathematical contexts
- `FuMa` = legacy convention, mainly first-order

## 5. FOA vs HOA

**FOA** means First-Order Ambisonics. It uses 4 channels and is useful for basic recording, simple spatial work, compatibility, and many entry-level microphone workflows.

**HOA** means Higher-Order Ambisonics. It starts at second order and increases the spatial resolution by adding more spherical harmonic components.

Higher order can give sharper localization, more stable rendering, and a larger useful listening area, but it also needs more channels and more careful routing.

## 6. Channel counts by order

For full 3D Ambisonics, the channel count is:

```text
channels = (order + 1)^2
```

| Order | Name | Channels |
|---:|---|---:|
| 1 | FOA | 4 |
| 2 | HOA-2 | 9 |
| 3 | HOA-3 | 16 |
| 4 | HOA-4 | 25 |
| 5 | HOA-5 | 36 |
| 6 | HOA-6 | 49 |
| 7 | HOA-7 | 64 |

In REAPER, this is why ICST sessions often use a **64-channel B-Format bus**: it can carry HOA-7 without silently cutting off higher-order channels.

## 7. Scene-based vs channel-based audio

Ambisonics is **scene-based**. The channels are not speaker feeds. They are components of a spatial sound-field representation.

This is different from **channel-based** audio, where channel 1 might mean left speaker, channel 2 right speaker, channel 3 center speaker, and so on.

In Ambisonics, the decoder decides how the B-Format scene becomes loudspeaker signals or binaural headphone output. That is the reason the same B-Format master can be rendered for a dome, an octagon, a studio array, headphones, or stereo.

<div id="icst-recommendation"></div>

## 8. Practical ICST recommendation

> **ICST Recommendation**
>
> For new Ambisonics work, use **ambiX**:
> **ACN channel ordering + SN3D normalization**.
>
> For higher-order work in REAPER, use a **64-channel B-Format bus** for HOA-7 when needed. Decode only at the monitoring or rendering stage.

This keeps the session open: the same B-Format master can feed loudspeaker decoding, binaural monitoring, archive export, and later reinterpretation on another playback system.

<div id="quick-checklist"></div>

## 9. Quick checklist: Which format should I use?

Use **ambiX B-Format, ACN/SN3D** when:

- you are starting a new Ambisonics production
- you are working with ICST, IEM, SPARTA, or other modern HOA tools
- you are exporting a B-Format archive master
- you need reliable exchange between DAWs, plugins, and rendering tools

Use **A-Format** only when:

- you are handling raw Ambisonic microphone recordings before conversion
- you still need the manufacturer-specific A-to-B conversion step

Use **FuMa** only when:

- an older tool or archive specifically requires it
- you are converting historical first-order material

Always document:

- Ambisonics order
- channel count
- channel ordering
- normalization
- sample rate and bit depth
- decoder or renderer used for monitoring

## Related pages

- [Ambisonics 101](/ambisonics-101/)
- [ICST B-Format Archive](/blog/b-format-archive/)
- [ICST Encoders](/icst-ambisonics-plugins/10_icst_encoders/)
- [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/)
- [Render B-Format in REAPER](/icst-ambisonics-plugins/12_render_bformat/)
