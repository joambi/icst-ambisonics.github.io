---
title: XYZ and AED – Two Coordinate Systems, One Loudspeaker
description: "The ICST AmbiDecoder accepts loudspeaker positions in Cartesian (XYZ) as well as polar (AED) coordinates. This article explains the difference and when to use which system."
date: 2026-03-21T10:30:00+01:00
year: 2026
month: 2026-03
weight: 31
tags: ["decoder", "coordinates", "xyz", "aed", "loudspeaker", "setup", "configuration"]
key_points:
  - "XYZ describes positions in Euclidean space – ideal for surveyed installations"
  - "AED (azimuth, elevation, distance) follows how we hear and the points of the compass"
  - "Both systems are always visible and editable side by side in the decoder"
difficulty: "beginner"
post_kind: "reference"
tool: ["AmbiDecoder"]
---

Level: Beginner | **Audience:** Technicians, composers, students.

This page explains why the ICST AmbiDecoder offers two coordinate systems and how to decide which one to use.

> **Core sentence of this decoder series:** The decoder does not create the space anew; it projects a B-format field onto a real system.
>
> This article covers the first step of that projection: **geometry**. Coordinates determine **where** the decoder places the loudspeakers in space.

---

## The problem: how do you describe where a loudspeaker stands?

A loudspeaker in a room has a position, but that position can be described in different ways. The ICST AmbiDecoder offers two systems at the same time:

- **XYZ** – Cartesian coordinates (Euclidean space)
- **AED** – polar coordinates: azimuth, elevation, distance

Both systems describe the same point in space. The decoder calculates internally with XYZ but always shows both values. You can edit in either system at any time – a double-click on a parameter field is enough.

---

## XYZ – Cartesian coordinates

XYZ describes the position of a loudspeaker as a point in three-dimensional Euclidean space:

- **X** – left/right (negative = left, positive = right)
- **Y** – front/back (positive = front, negative = back)
- **Z** – up/down (positive = up, negative = down)

**When to use XYZ?** Whenever you have measurement data from a laser rangefinder, a CAD drawing or architectural documentation. Such data almost always comes as Cartesian coordinates. You can transfer it straight into the decoder without converting.

XYZ input is precise and reproducible. It is particularly suited to:

- concert installations with surveyed loudspeakers
- scientific research environments
- setups that need to be transferred between venues

---

## AED – azimuth, elevation, distance

AED describes the same position in a perception-oriented way, starting from the centre of the listening area:

- **A (azimuth)** – horizontal angle in degrees (0° = front, 90° = left, 180° / -180° = back, 270° / -90° = right)
- **E (elevation)** – vertical angle in degrees (0° = horizontal plane, +90° = directly above, -90° = directly below)
- **D (distance)** – distance of the loudspeaker from the centre in metres

**When to use AED?** When you think in direction and height rather than in coordinates. AED matches the way people describe direction: "The loudspeaker hangs to the left and up, 45° to the side and 30° raised."

AED is particularly useful for:

- quick manual configuration of symmetrical arrays
- conceptual planning of loudspeaker layouts
- adjustments during operation, when the geometry is already clear in your head

---

## Both systems at the same time

In the speaker parameter editor of the ICST AmbiDecoder you always see both representations for every loudspeaker:

```
Cartesian XYZ:   -1.186    3.110    0.000
Polar AED:        339.12   0.00     3.328
```

If you change a value in XYZ, AED updates automatically – and vice versa. You lose no precision, whichever system you use.

> **Tip:** A double-click on a parameter field opens direct numeric input. This lets you transfer measured values without conversion errors.

---

## A typical practical scenario

**Scenario:** You set up an octagon array (8 loudspeakers evenly spaced on a circle, all at ear height, all 3 metres from the centre).

With **AED** this is quick:

| Loudspeaker | Azimuth (A) | Elevation (E) | Distance (D) |
|---|---|---|---|
| LS 1 | 0° | 0° | 3.0 m |
| LS 2 | 45° | 0° | 3.0 m |
| LS 3 | 90° | 0° | 3.0 m |
| LS 4 | 135° | 0° | 3.0 m |
| LS 5 | 180° | 0° | 3.0 m |
| ... | ... | ... | ... |

With **XYZ** you would need trigonometry. Here AED is clearly faster.

**Counter-example:** You have surveyed a concert hall setup and received the positions as a CAD export. The coordinates come as `X=2.45, Y=-3.11, Z=1.20`. Here you take the XYZ values directly – no conversion, no error.

---

## A common source of error: the azimuth convention

Not all systems use the same azimuth direction. In the ICST AmbiDecoder:

- **0°** = front (direction Y+)
- **90°** = left (direction X-)
- **180° / -180°** = back

This is the mathematical convention, not the navigation convention (where 90° often means east = right). If you import coordinates from other sources, check the convention.

---

## Summary

### Decoder series: geometry

If you think of the decoder as a three-step process, this page covers **geometry**:

- **Geometry** determines **where** the loudspeakers stand in space
- **Delay** determines **when** the signals arrive there
- **Tuning** determines **how clearly** or **how coloured** the result is perceived

Wrong coordinates are therefore not a sonic character trait but a setup error. Only once the geometry is right can later decisions about delay, weighting or filtering be judged sensibly.

| | XYZ | AED |
|---|---|---|
| **Makes sense when…** | measurement data is available | planning angles intuitively |
| **Strength** | precise, straight from CAD/laser | perception-oriented, fast |
| **Typical context** | concert installation, research | studio, rehearsal, quick start |
| **Editable in the decoder** | yes | yes |

You do not have to choose. The decoder always shows both – use whichever the situation calls for.

---

## Further reading

- [ICST Decoder – Setup and operation](/icst-ambisonics-plugins/08_icst_decoder/)
- [Scaling and delay compensation](/post/decoder-skalierung-laufzeitkompensation/)
- [The Filter tab – practical examples and use cases](/post/decoder-filter-praxisbeispiele/)
- [Why the decoder sounds the way it does – methodological context](/post/decoder-methodological-context/)
