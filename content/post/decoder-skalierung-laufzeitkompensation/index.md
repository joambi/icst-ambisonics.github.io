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
post_kind: "reference"
tool: ["AmbiDecoder"]
---

Level: Intermediate | **Audience:** Technicians, installation artists, studio operators.

This page explains how the scaling and delay compensation function of the ICST AmbiDecoder works and when you need it.

> **Core sentence of this decoder series:** The decoder does not create the space anew; it projects a B-format field onto a real system.
>
> This article covers the second step of that projection: **delay**. Delay compensation determines **when** signals arrive at the listening centre once the geometry has been fixed.

---

## The problem: loudspeakers are not all equally far away

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 232" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Loudspeakers at 2.7, 3.4 and 4.2 metres: without compensation their signals reach the listening centre at different times, with compensation they arrive together." xmlns="http://www.w3.org/2000/svg"><defs><marker id="md" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="140" y="20" text-anchor="middle" font-size="12" font-weight="600" fill="currentColor" fill-opacity="1">Setup (top view)</text><circle cx="140" cy="125" r="64.8" fill="none" stroke="currentColor" stroke-opacity=".2" stroke-width="1" stroke-dasharray="3 4"/><circle cx="140" cy="125" r="81.6" fill="none" stroke="currentColor" stroke-opacity=".2" stroke-width="1" stroke-dasharray="3 4"/><circle cx="140" cy="125" r="100.8" fill="none" stroke="currentColor" stroke-opacity=".2" stroke-width="1" stroke-dasharray="3 4"/><circle cx="140.0" cy="125.0" r="5" fill="currentColor" fill-opacity="1"/><line x1="140" y1="125" x2="98.3" y2="75.4" stroke="currentColor" stroke-opacity=".3" stroke-width="1"/><circle cx="98.3" cy="75.4" r="9" fill="#4a8fe0" fill-opacity="0.85"/><text x="98.34736289231225" y="79.36032008589021" text-anchor="middle" font-size="11" font-weight="600" fill="#fff" fill-opacity="1">A</text><text x="84.34736289231225" y="79.36032008589021" text-anchor="end" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">2.7 m</text><line x1="140" y1="125" x2="202.5" y2="72.5" stroke="currentColor" stroke-opacity=".3" stroke-width="1"/><circle cx="202.5" cy="72.5" r="9" fill="#4a8fe0" fill-opacity="0.85"/><text x="202.5092265585086" y="76.5485310495784" text-anchor="middle" font-size="11" font-weight="600" fill="#fff" fill-opacity="1">B</text><text x="216.5092265585086" y="76.5485310495784" text-anchor="start" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">3.4 m</text><line x1="140" y1="125" x2="122.5" y2="224.3" stroke="currentColor" stroke-opacity=".3" stroke-width="1"/><circle cx="122.5" cy="224.3" r="9" fill="#4a8fe0" fill-opacity="0.85"/><text x="122.49626369117343" y="228.26862150363058" text-anchor="middle" font-size="11" font-weight="600" fill="#fff" fill-opacity="1">C</text><text x="136.49626369117343" y="228.26862150363058" text-anchor="start" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">4.2 m</text><text x="395" y="22" text-anchor="start" font-size="12" font-weight="600" fill="#d9534f" fill-opacity="1">Without compensation: staggered</text><text x="387" y="45" text-anchor="end" font-size="11" font-weight="600" fill="currentColor" fill-opacity="0.9">A</text><rect x="395" y="36" width="151.2" height="12" rx="3" fill="#4a8fe0" fill-opacity=".55"/><line x1="546.2" y1="33" x2="546.2" y2="51" stroke="#d9534f" stroke-width="2.5"/><text x="387" y="65" text-anchor="end" font-size="11" font-weight="600" fill="currentColor" fill-opacity="0.9">B</text><rect x="395" y="56" width="190.4" height="12" rx="3" fill="#4a8fe0" fill-opacity=".55"/><line x1="585.4" y1="53" x2="585.4" y2="71" stroke="#d9534f" stroke-width="2.5"/><text x="387" y="85" text-anchor="end" font-size="11" font-weight="600" fill="currentColor" fill-opacity="0.9">C</text><rect x="395" y="76" width="235.2" height="12" rx="3" fill="#4a8fe0" fill-opacity=".55"/><line x1="630.2" y1="73" x2="630.2" y2="91" stroke="#d9534f" stroke-width="2.5"/><text x="395" y="128" text-anchor="start" font-size="12" font-weight="600" fill="#3fa968" fill-opacity="1">With compensation: simultaneous</text><text x="387" y="151" text-anchor="end" font-size="11" font-weight="600" fill="currentColor" fill-opacity="0.9">A</text><line x1="395" y1="148" x2="479.0" y2="148" stroke="currentColor" stroke-opacity=".5" stroke-width="2" stroke-dasharray="4 3"/><rect x="479.0" y="142" width="151.2" height="12" rx="3" fill="#4a8fe0" fill-opacity=".55"/><text x="387" y="171" text-anchor="end" font-size="11" font-weight="600" fill="currentColor" fill-opacity="0.9">B</text><line x1="395" y1="168" x2="439.8" y2="168" stroke="currentColor" stroke-opacity=".5" stroke-width="2" stroke-dasharray="4 3"/><rect x="439.8" y="162" width="190.4" height="12" rx="3" fill="#4a8fe0" fill-opacity=".55"/><text x="387" y="191" text-anchor="end" font-size="11" font-weight="600" fill="currentColor" fill-opacity="0.9">C</text><rect x="395.0" y="182" width="235.2" height="12" rx="3" fill="#4a8fe0" fill-opacity=".55"/><line x1="630.2" y1="136" x2="630.2" y2="198" stroke="#3fa968" stroke-width="2.5"/><line x1="395" y1="212" x2="660.2" y2="212" stroke="currentColor" stroke-opacity=".5" stroke-width="1.2" marker-end="url(#md)"/><text x="664.2" y="216" text-anchor="start" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">time →</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Delay compensation holds back the nearer loudspeakers until the farthest one catches up.</figcaption>
</figure>



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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 244" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="A normalised loudspeaker preset on a unit circle is scaled to the real room dimensions; coordinates, distances and delay values are recalculated." xmlns="http://www.w3.org/2000/svg"><defs><marker id="ms" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="130" y="22" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Preset (normalised)</text><text x="130" y="38" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">all speakers at D = 1 m</text><circle cx="130" cy="130" r="70" fill="none" stroke="currentColor" stroke-opacity=".3" stroke-width="1.2" stroke-dasharray="3 4"/><circle cx="194.7" cy="156.8" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="156.8" cy="194.7" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="103.2" cy="194.7" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="65.3" cy="156.8" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="65.3" cy="103.2" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="103.2" cy="65.3" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="156.8" cy="65.3" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="194.7" cy="103.2" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="130.0" cy="130.0" r="4" fill="currentColor" fill-opacity="1"/><line x1="235" y1="130" x2="400" y2="130" stroke="currentColor" stroke-width="1.6" marker-end="url(#ms)"/><text x="318" y="120" text-anchor="middle" font-size="12" font-weight="600" fill="currentColor" fill-opacity="1">Scaling</text><text x="560" y="22" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Your room</text><text x="560" y="38" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">X × Y × Z in metres</text><rect x="430" y="70" width="260" height="130" rx="6" fill="currentColor" fill-opacity=".05" stroke="currentColor" stroke-opacity=".5" stroke-width="1.5"/><circle cx="661.8" cy="154.3" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="602.2" cy="181.5" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="517.8" cy="181.5" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="458.2" cy="154.3" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="458.2" cy="115.7" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="517.8" cy="88.5" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="602.2" cy="88.5" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="661.8" cy="115.7" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="560.0" cy="135.0" r="4" fill="currentColor" fill-opacity="1"/><text x="560" y="218" text-anchor="middle" font-size="12" font-weight="600" fill="currentColor" fill-opacity="0.8">X</text><text x="420" y="139" text-anchor="end" font-size="12" font-weight="600" fill="currentColor" fill-opacity="0.8">Y</text><text x="560" y="232" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Coordinates, distances and delays are recalculated.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Scaling stretches a normalised preset to your room.</figcaption>
</figure>



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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 120" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="The decoder in three steps: geometry decides where, delay decides when, tuning decides how clear or coloured." xmlns="http://www.w3.org/2000/svg"><defs><marker id="mr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="24" width="210" height="62" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="115.0" y="52.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Geometry</text><text x="115.0" y="69.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">where speakers stand</text><line x1="222" y1="55" x2="251" y2="55" stroke="currentColor" stroke-width="1.6" marker-end="url(#mr)"/><rect x="253" y="24" width="210" height="62" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="358.0" y="52.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Delay</text><text x="358.0" y="69.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">when signals arrive</text><line x1="465" y1="55" x2="494" y2="55" stroke="currentColor" stroke-width="1.6" marker-end="url(#mr)"/><rect x="496" y="24" width="210" height="62" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="601.0" y="52.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Tuning</text><text x="601.0" y="69.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">how clear or coloured</text><text x="358" y="106" text-anchor="middle" font-size="11" font-weight="600" fill="#4a8fe0" fill-opacity="0.8">▲ this page</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Decoder series: this page covers the second step.</figcaption>
</figure>



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
- [History and applications of the Ambisonics decoder](/blog/decoder-geschichte-und-anwendungen/)
