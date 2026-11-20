---
aliases: ["/post/decoder-methodischer-kontext/"]
title: Why the Decoder Sounds the Way It Does – Methodological Context
description: "What is behind the Ambisonics decoder? This article explains field-based projection, the role of spherical harmonics, and why B-format remains rotation-invariant."
date: 2026-03-21T10:00:00+01:00
year: 2026
month: 2026-03
weight: 30
tags: ["decoder", "ambisonics", "theory", "b-format", "spherical-harmonics", "concept"]
key_points:
  - "B-format is a field-based, rotation-invariant representation of the sound field"
  - "Spherical harmonics are the mathematical basis of Ambisonics decoding"
  - "The decoder projects the field onto loudspeakers without redefining the field itself"
difficulty: "intermediate"
post_kind: "background"
tool: ["AmbiDecoder"]
---

Level: Intermediate | **Audience:** Composer, student, technically curious reader.

---

## The basic principle: field instead of objects

B-format describes a **sound field**, not individual objects or channels. This field consists of spherical harmonics that describe sound in all directions of space at the same time. The decoder **projects** this field onto a concrete loudspeaker arrangement without changing the field itself.

This distinguishes Ambisonics fundamentally from vector-based approaches such as VBAP or ALLRAD, where individual direction vectors are distributed to nearby loudspeakers. There the field is broken into objects; here it remains intact as a whole.

---

## What spherical harmonics have to do with it

Spherical harmonics divide the surface of a sphere into directional components, much like Fourier series divide a time curve into frequency components. Each order refines directional resolution:

- **0th order (W):** omnidirectional — uniform energy in all directions
- **1st order (X, Y, Z):** axis-oriented — front/back, left/right, up/down
- **Higher orders:** sharper localisation, more channels

A 3rd-order B-format signal (HOA3) contains 16 channels and localises sources much more precisely than 1st order (4 channels). The **Ambisonics Order** in the decoder therefore has to match the source material.

---

## Rotation invariance

B-format is **rotation-invariant**: the sound field can be rotated, mirrored, or transformed without having to be re-rendered, because spherical harmonics form a complete orthogonal basis that does not lose information under rotation. With object-based formats such as Dolby Atmos bed-plus-object workflows, this is not possible in the same direct way.

---

## Geometric accuracy and psychoacoustic coherence

**Geometry:** Loudspeaker coordinates enter directly into the decoder matrix. Wrong angles or distances cause deviations in the spatial image. Measured setups therefore sound better than guessed ones.

**Weighting, the actual decision:** Behind Basic, In-Phase, and Max-rE is a psychoacoustic model from the 1970s, formulated by Michael Gerzon. He defined two localisation vectors:

- **Velocity vector (rV):** describes the perceived direction at low frequencies, where hearing responds to interaural phase differences
- **Energy vector (rE):** describes the energy distribution at high frequencies, where interaural level differences dominate

A good decoder keeps both vectors pointing in the same direction and as close to length 1 as possible. The three schemes are different strategies for reaching this goal:

| Scheme | Behaviour | Use |
|---|---|---|
| **Basic** | unweighted, clean impulse response, but side lobes at off-centre positions | low frequencies, sweet-spot listening |
| **Max-rE** | maximises the energy vector, attenuates side lobes | mid and high frequencies, default for most setups |
| **In-Phase** | suppresses all side lobes, wider main lobe | difficult listening conditions, irregular arrays |

For demanding setups, researchers at IEM Graz recommend **dual-band decoding**: Basic (or unweighted) below roughly 400–700 Hz, Max-rE above, with an automatic crossover. In theory this gives the best combination of low-frequency stability and high-frequency localisation sharpness.

---

## What this means in practice

When setting up a new system, this order is a good rule:

1. **Order first** — match it to the source material and loudspeaker density
2. **Geometry second** — enter positions as accurately as possible
3. **Weighting last** — Max-rE as the default start, In-Phase for irregular arrays
4. **Scaling when needed** — for delay compensation with unequal distances

The decoder does not make artistic decisions. It calculates exactly what you tell it to calculate.

---

## Why this matters for composers

This theoretical distinction has direct practical consequences:

- You compose into a **field**, not into a fixed loudspeaker layout.
- The same B-format work can survive across different playback systems.
- Decoder decisions shape monitoring, but they do not redefine the work itself.
- Weightings change how clearly or how stably spatial gestures are perceived.

In practice, this means: keep the **B-format Master** stable, choose decoder settings consciously, and evaluate key passages on the real target setup whenever possible.

---

## Sources and further reading

- Michael Gerzon, *Periphony: With-Height Sound Reproduction*, JAES 1973
- Michael Gerzon, *Psychoacoustic Decoders for Multispeaker Stereo and Surround Sound*, AES 1992
- Jens Ahrens, [*Introduction to Ambisonics, Part 1*](https://arxiv.org/abs/2512.07570), arXiv 2024: the most accessible introduction without maths
- Matthias Frank (IEM Graz), [*How to Make Ambisonics Sound Good*](https://iaem.at/Members/frank/files/2014_frank_howtomakeambisonicssoundgood.pdf), 2014: practical weighting recommendations
- Franz Zotter & Matthias Frank, [*All-Round Ambisonic Panning and Decoding*](https://www.aes.org/tmpFiles/elib/20250925/16554.pdf), AES: the foundational AllRAD text
- [IEM Graz: Spherical Harmonics Documentation](https://ambisonics.iem.at/xchange/fileformat/docs/spherical-harmonics-symmetries)

---

## Further reading

- [ICST Decoder – Setup and operation](/icst-ambisonics-plugins/08_icst_decoder/)
- [ICST MultiDecoder](/icst-ambisonics-plugins/09_icst_multidecoder/)
- [XYZ and AED – Comparing coordinate systems](/post/xyz-vs-aed-koordinatensysteme/)
- [Scaling and delay compensation](/post/decoder-skalierung-laufzeitkompensation/)
