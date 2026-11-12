---
title: Which Ambisonics Order Do I Need? – Choosing HOA in Practice
description: "FOA, HOA3 or HOA7? This article explains when which order makes sense: channel count, spatial resolution, loudspeaker requirements, CPU load and binaural – as a clear decision aid for everyday production."
date: 2026-03-21T18:00:00+01:00
year: 2026
month: 2026-03
weight: 38
tags: ["hoa", "foa", "order", "channel-count", "workflow", "concept", "reaper"]
key_points:
  - "The formula (N+1)² sets the channel count: 1st = 4, 3rd = 16, 7th = 64 channels"
  - "The loudspeaker system is the limiting factor – not the DAW"
  - "HOA3 is the productive sweet spot: good resolution, manageable CPU load, broad plugin support"
difficulty: "beginner"
kind: "background"
---

Level: Beginner–Intermediate | **Audience:** Composers, producers, anyone setting up a new Ambisonics session.

---

Choosing the Ambisonics order is one of the first decisions in any production, and it determines channel count, CPU load, plugin requirements and the sound quality on a loudspeaker system. This article explains the relationships without maths and gives clear recommendations for typical situations.

---

## The basic formula

The number of channels in the B-format master follows from the chosen order:

**(N + 1)² = channel count**

| Order | Channels | New channels |
|---|---|---|
| 1st order (FOA) | **4** | 4 |
| 2nd order | **9** | 5 |
| 3rd order | **16** | 7 |
| 4th order | **25** | 9 |
| 5th order | **36** | 11 |
| 7th order | **64** | 15 |

A higher order means more channels, more spherical information, finer spatial resolution – and more computing effort.

---

## What changes with the order

### Spatial resolution

As the order rises, sound sources become sharper to localise. At 1st order a point source sounds slightly diffuse – a loudspeaker in a cluster is hard to tell from its neighbours. At 3rd order localisation is convincing for most listening situations. At 7th order the resolution approaches what the human ear can resolve under ideal conditions.

A simple picture: order behaves much like the resolution of a photo. FOA is 480p – recognisable but soft. HOA3 is 1080p – good for almost every purpose. HOA7 is 4K – you need a very good playback system to hear the difference.

### Sweet spot size

The sweet spot is the area in which the sound field is reproduced correctly. It grows with the order. With FOA it is hardly larger than a head at mid and high frequencies. With HOA3 it suffices for a small group of listeners. For large rooms and many people, HOA5 or HOA7 become relevant.

In practice: if you work for studio production and headphones, you hardly notice the sweet-spot difference. If you produce for a 31-speaker concert system, the difference between HOA3 and HOA7 becomes audible depending on repertoire and hall.

### Minimum number of loudspeakers

The loudspeaker system sets the practical ceiling of the usable order. The rule of thumb:

> **At least (N+1)² loudspeakers for order N**

| Order | Minimum loudspeakers |
|---|---|
| 1st | 4 |
| 2nd | 9 |
| 3rd | 16 |
| 5th | 36 |
| 7th | 64 |

On a system with 8 loudspeakers HOA3 makes little sense – the system cannot fully reproduce the 16-channel information. The decoder still calculates, but the spatial resolution is capped by the loudspeakers. The **ICST Composition Studio at ZHdK** has 31 loudspeakers – HOA3 is well used there, HOA5 is already demanding.

> **Important:** In REAPER and the ICST plugins you can use any order, however many loudspeakers you have. The system calculates correctly. But the sound quality is set by the weakest link – the monitoring system.

---

## A practical decision aid

### When is FOA (1st order) enough?

- Binaural-only production for headphones or streaming
- Compositional sketches or concept work without a final loudspeaker system
- Real-time performance on a small system (4–8 loudspeakers, e.g. an octagon)
- Ambisonics microphone recordings (Ambeo, NT-SF1 – these deliver FOA only)
- Resource-limited live situations (older laptop, unstable machine)

### When is HOA3 the right choice?

HOA3 is the **productive standard** for most Ambisonics productions today:

- Professional composition for a multi-loudspeaker system from about 16 loudspeakers
- High-quality binaural rendering (the IEM BinauralDecoder makes full use of HOA3)
- Mixing encoder sources and microphone recordings (the Zylia ZM-1 delivers HOA3)
- Export for platforms such as YouTube 360° or VR (most platforms accept HOA3 at most)
- Studio production on a modern computer without a specific need for HOA7

### When do you need HOA5 or HOA7?

- Large concert halls with 40+ loudspeakers (e.g. dome installations, IMAX-like systems)
- Archives and master files designed for future, higher-order systems
- Special height rendering in dense 3D arrays
- Academic or research contexts with precision requirements

### Binaural: how much order sounds better?

For binaural headphone monitoring, the perceptible jump in quality lies between FOA and HOA3 – clearly. Between HOA3 and HOA7 the difference in binaural rendering is measurable but perceptually less dramatic. From HOA3 up, binaural is high-resolution enough for most purposes.

---

## CPU load in REAPER

| Order | Channels | Relative CPU | In practice |
|---|---|---|---|
| FOA | 4 | very low | no problem even on older systems |
| HOA3 | 16 | moderate | standard on a modern computer, no problem |
| HOA5 | 36 | noticeable | large sessions require a freeze strategy |
| HOA7 | 64 | high | with many sources: freeze or render to file |

In REAPER: if HOA7 tracks need to be frozen, use the *Freeze* function (right-click the track → Freeze). The frozen track is stored internally as a fully calculated multichannel file and no longer causes encoder CPU load – only bus routing remains.

---

## Changing the order during production

You can change the order of a running session, but it requires adjustments:

1. **Adjust the channel count of the B-format bus** (right-click → Track Channels)
2. **Set all AmbiEncoders** to the new order (order parameter in the plugin)
3. **Set the ICST AmbiDecoder** to the new order
4. **The BinauralDecoder** adapts automatically (IEM detects the channel count)

The easiest way: fix the order before starting the production and build a REAPER template on that order. The ICST download pack contains prepared templates.

---

## Recommendation for the ICST workflow

If you produce at the **ICST Composition Studio** (31 loudspeakers): **HOA3** as the standard. The studio is optimised and calibrated for HOA3. HOA7 is technically possible but adds little on this system.

If you produce for **headphones and binaural**: **HOA3** as a sensible compromise between quality and performance.

If you build **your first own session**: start with **FOA or HOA3** – the concepts are the same, and getting started is easier.

---

## Further reading

- [Coordinate systems: XYZ and AED compared](/post/xyz-vs-aed-koordinatensysteme/)
- [ICST AmbiDecoder – scaling and delay compensation](/post/decoder-skalierung-laufzeitkompensation/)
- [Binaural monitoring in the ICST workflow](/post/binaural-monitoring-icst-workflow/)
- [Exporting the B-format master](/post/b-format-export-reaper/)
- [Recording with an Ambisonics microphone – A-format, B-format and ICST integration](/post/ambisonics-mikrofon-a-format-b-format/)
