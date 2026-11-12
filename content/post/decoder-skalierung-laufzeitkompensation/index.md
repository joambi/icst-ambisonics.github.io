---
title: Scaling and Delay Compensation in the ICST AmbiDecoder
description: "How the scaling function of the ICST AmbiDecoder takes room size and loudspeaker distances into account, and why delay compensation is essential for geometrically coherent playback."
date: 2026-03-21T11:00:00+01:00
year: 2026
month: 2026-03
weight: 32
tags: ["decoder", "scaling", "delay", "delay-compensation", "setup", "installation", "configuration"]
key_points:
  - "The scaling function scales all loudspeaker coordinates to a real room size"
  - "Delay times are calculated automatically from the distance values"
  - "Without delay compensation at unequal distances the sound image becomes incoherent"
difficulty: "intermediate"
kind: "reference"
tool: ["AmbiDecoder"]
---

Level: Intermediate | **Audience:** Technicians, installation artists, studio operators.

This page explains how the scaling and delay compensation function of the ICST AmbiDecoder works and when you need it.

> **Core sentence of this decoder series:** The decoder does not create the space anew; it projects a B-format field onto a real system.
>
> This article covers the second step of that projection: **delay**. Delay compensation determines **when** signals arrive at the listening centre once the geometry has been fixed.

---

## The problem: loudspeakers are not all equally far away

In ideal setups – for example an even octagon or a spherical layout – all loudspeakers have the same distance from the listening centre. The signals therefore arrive at the same time.

In real rooms this is almost never the case:

- concert halls have asymmetric walls
- loudspeakers hang at different levels
- subwoofers are often placed differently from full-range speakers
- installations adapt to existing structures

If loudspeakers are at different distances, the signals reach the listening centre at different times. This clearly degrades the formation of phantom sources, the sharpness of localisation and the sense of coherence of the sound field.

---

## The solution: delay compensation

From the distance values of each loudspeaker, the ICST AmbiDecoder automatically calculates an individual delay value. Loudspeakers further away receive a larger leading delay – so that all signals arrive at the listening centre (acoustically speaking) at the same time.

The delay values are visible in the speaker table:

| CH | Name | D [m] | Delay [ms] | Delay comp. [ms] |
|----|------|--------|------------|------------------|
| 1  | L    | 3.376  | 9.84       | 3.57             |
| 2  | R    | 3.347  | 9.76       | 3.65             |
| 5  | SUB  | 2.709  | 7.88       | 5.45             |

- **D [m]** – measured distance of the loudspeaker from the centre
- **Delay [ms]** – calculated travel time of the sound (distance / speed of sound)
- **Delay comp. [ms]** – delay actually applied for compensation

> **Rule of thumb:** The loudspeaker that is furthest away needs no delay – it is the slowest anyway. All the others are delayed so that they wait for it.

---

## The scaling function

When you configure a loudspeaker preset for a room, the coordinates are sometimes given in normalised units (for example as vectors of length 1, i.e. all loudspeakers on a unit sphere). This is practical for presets that should work in different rooms – but it does not reflect the real geometry.

The **scaling function** lets you scale all loudspeaker coordinates to an actual room size:

1. Click **Scaling** in the speaker settings window.
2. Enter the room dimensions: **X** (width), **Y** (depth), **Z** (height) in metres.
3. The decoder scales all coordinates proportionally – and then recalculates the delay times.

The following are updated automatically:

- all Cartesian loudspeaker coordinates (XYZ)
- all polar distance values (D in AED)
- all delay values that result from them

---

## When do you need scaling?

**Scenario 1: preset from a different room size**
You use an existing octagon preset that was configured for a 6×6 m room. Your room is 8×9 m. With scaling you adapt the preset in a few seconds, without having to edit each loudspeaker by hand.

**Scenario 2: normalised preset, real room**
Many standard presets use unit vectors (distance = 1.0 m). You enter your real room dimensions – and all loudspeaker coordinates are scaled correctly.

**Scenario 3: touring or guest performances**
You perform the same piece in three different rooms. Instead of maintaining three separate presets, you have one normalised base preset and scale it for each room individually – with automatic delay recalculation.

---

## Manual delay override

In addition to the automatic calculation, you can also override the delay values for individual loudspeakers by hand. This makes sense when:

- a loudspeaker has a different acoustic characteristic because of its construction (e.g. mounted behind a membrane)
- you make room-acoustic corrections that go beyond pure travel time
- you want to make small fine corrections during operation

> **Caution:** Manual delay changes are overwritten by the next scaling operation. Save your preset beforehand.

---

## Quick check before the performance

Before you play a room, check the following points:

1. Are the **distance values (D)** entered for all loudspeakers and plausible?
2. Do the **delay comp.** values roughly match the expected travel-time differences?
3. Did you **save the preset again** after scaling?
4. Is the **Ambisonics order** in the decoder matched to the source material?

A short pink-noise test with a mute/solo check shows immediately whether the timing coherence is right.

---

## Decoder series: delay

If you think of the decoder as a three-step process, this page covers **delay**:

- **Geometry** determines **where** loudspeakers stand
- **Delay** determines **when** their signals arrive
- **Tuning** determines **how clearly** or **how coloured** the result appears

Scaling and delay compensation are therefore not creative sound shaping but a translation step between normalised preset and real room. Only once the timing relationships are right can weighting, filters or MultiDecoder layers be judged sensibly.

---

## Saving and exporting presets

After every scaling you should save the setup as a preset:

- **Save:** Speaker → Save preset → give it a name (e.g. `ICST-Studio_HOA7_2026-03`)
- **Export:** the configuration can be exported as a **TXT file** (Speaker → Export)

The exported TXT file contains all loudspeaker positions in AED format and can be loaded into external systems (e.g. Max/MSP via the `coll` object or `ambidecode~`). This enables cross-platform integration of the loudspeaker geometry into hybrid systems.

---

## Further reading

- [ICST Decoder – setup and operation](/icst-ambisonics-plugins/08_icst_decoder/)
- [XYZ and AED – coordinate systems compared](/post/xyz-vs-aed-koordinatensysteme/)
- [ICST MultiDecoder](/icst-ambisonics-plugins/09_icst_multidecoder/)
- [The Filter tab – practical examples and use cases](/post/decoder-filter-praxisbeispiele/)
- [Best practices](/icst-ambisonics-plugins/17_best_practices/)
