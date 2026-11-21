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

<figure data-gen="g24" style="margin:1.8rem 0">
<video controls muted loop playsinline preload="metadata" poster="/videos/xyz-vs-aed-en-poster.jpg" src="/videos/xyz-vs-aed-en.mp4" style="width:100%;max-width:720px;height:auto;display:block;border-radius:8px"></video>
<figcaption style="font-size:.9em;opacity:.8;margin-top:.4rem">Video: the same position as azimuth, elevation, distance and as X, Y, Z (about 14 seconds).</figcaption>
</figure>

## The problem: how do you describe where a loudspeaker stands?

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 350" role="img" aria-label="Same point in XYZ and in AED" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="170" y="24" text-anchor="middle" font-weight="600">XYZ</text><text x="170" y="42" text-anchor="middle" font-size="11">Cartesian</text><line x1="40" y1="200" x2="305" y2="200" stroke="currentColor" stroke-width="1.3" opacity="0.7" marker-end="url(#ar1)"/><line x1="170" y1="310" x2="170" y2="75" stroke="currentColor" stroke-width="1.3" opacity="0.7" marker-end="url(#ar1)"/><text x="304" y="216" text-anchor="end" font-size="12">+X</text><text x="178" y="78" text-anchor="start" font-size="12">+Y</text><line x1="224.0" y1="106.5" x2="224.0" y2="200" stroke="#4a8fe0" stroke-width="1.2" opacity="1" stroke-dasharray="4 3"/><line x1="224.0" y1="106.5" x2="170" y2="106.5" stroke="#4a8fe0" stroke-width="1.2" opacity="1" stroke-dasharray="4 3"/><circle cx="224.0" cy="106.5" r="7" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="236.0" y="96.5" text-anchor="start" font-weight="600" fill="#d9534f">P</text><text x="224.0" y="218" text-anchor="middle" fill="#4a8fe0" font-size="12">x = 1.5</text><text x="162" y="110.5" text-anchor="end" fill="#4a8fe0" font-size="12">y = 2.6</text><text x="42" y="192" text-anchor="start" font-size="11">left</text><text x="298" y="192" text-anchor="end" font-size="11">right</text><text x="540" y="24" text-anchor="middle" font-weight="600">AED</text><text x="540" y="42" text-anchor="middle" font-size="11">Polar</text><circle cx="540" cy="200" r="108" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><line x1="418" y1="200" x2="662" y2="200" stroke="currentColor" stroke-width="1" opacity="0.35"/><line x1="540" y1="78" x2="540" y2="322" stroke="currentColor" stroke-width="1" opacity="0.35"/><circle cx="540" cy="200" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="540" y="72" text-anchor="middle" font-size="11">front</text><line x1="540" y1="200" x2="594.0" y2="106.5" stroke="#d9534f" stroke-width="1.6" opacity="1"/><circle cx="594.0" cy="106.5" r="7" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="606.0" y="96.5" text-anchor="start" font-weight="600" fill="#d9534f">P</text><path d="M540.0,150.0 A50,50 0 0 1 565.0,156.7" fill="none" stroke="#4a8fe0" stroke-width="2"/><text x="532" y="138" text-anchor="end" fill="#4a8fe0" font-size="12">A = 30°</text><text x="577.0" y="171.25" text-anchor="start" fill="#4a8fe0" font-size="12">D = 3 m</text><text x="418" y="192" text-anchor="end" font-size="11">left</text><text x="662" y="192" text-anchor="start" font-size="11">right</text><text x="360" y="342" text-anchor="middle" font-weight="600" font-size="12">Same point, two descriptions – the decoder always shows both</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">One loudspeaker position, two descriptions: as distances along the axes (left) or as angle plus distance from the centre (right).</figcaption>
</figure>














A loudspeaker in a room has a position, but that position can be described in different ways. The ICST AmbiDecoder offers two systems at the same time:

- **XYZ** – Cartesian coordinates (Euclidean space)
- **AED** – polar coordinates: azimuth, elevation, distance

Both systems describe the same point in space. The decoder calculates internally with XYZ but always shows both values. You can edit in either system at any time – a double-click on a parameter field is enough.

---

## XYZ – Cartesian coordinates

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 320" role="img" aria-label="XYZ axes and a point" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><line x1="90" y1="270" x2="362.0" y2="270.0" stroke="currentColor" stroke-width="1.3" opacity="0.7" marker-end="url(#ar2)"/><line x1="134.0" y1="295.5" x2="280.4" y2="191.8" stroke="currentColor" stroke-width="1.3" opacity="0.7" marker-end="url(#ar2)"/><line x1="170.0" y1="282.0" x2="170.0" y2="98.0" stroke="currentColor" stroke-width="1.3" opacity="0.7" marker-end="url(#ar2)"/><text x="370.0" y="274.0" text-anchor="start" font-weight="600" fill="#4a8fe0">+X</text><text x="288.4" y="193.8" text-anchor="start" font-weight="600" fill="#3fa968">+Y</text><text x="178.0" y="102.0" text-anchor="start" font-weight="600" fill="#d9534f">+Z</text><line x1="362" y1="219" x2="362" y2="139" stroke="#d9a441" stroke-width="1.4" opacity="1" stroke-dasharray="4 3"/><line x1="362" y1="219" x2="290" y2="270" stroke="#4a8fe0" stroke-width="1.2" opacity="1" stroke-dasharray="4 3"/><line x1="362" y1="219" x2="242" y2="219" stroke="#3fa968" stroke-width="1.2" opacity="1" stroke-dasharray="4 3"/><circle cx="362" cy="219" r="3" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="362" cy="139" r="7" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="374" y="131" text-anchor="start" font-weight="600" fill="#d9534f">P (x, y, z)</text><circle cx="170" cy="270" r="4" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="162" y="286" text-anchor="end" font-size="11">centre</text><rect x="490" y="130" width="210" height="130" rx="8" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><circle cx="508" cy="162" r="6" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><text x="522" y="167" text-anchor="start" font-size="12">X: left (−) / right (+)</text><circle cx="508" cy="196" r="6" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><text x="522" y="201" text-anchor="start" font-size="12">Y: back (−) / front (+)</text><circle cx="508" cy="230" r="6" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="522" y="235" text-anchor="start" font-size="12">Z: down (−) / up (+)</text><text x="360" y="24" text-anchor="middle" font-weight="600">Cartesian XYZ: three distances from the centre</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">XYZ: the position is the sum of three steps along X, Y and Z – exactly what a laser measurement or CAD export delivers.</figcaption>
</figure>














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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Azimuth and elevation" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="180" y="24" text-anchor="middle" font-weight="600">Top view: azimuth A</text><circle cx="180" cy="160" r="100" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><line x1="66" y1="160" x2="294" y2="160" stroke="currentColor" stroke-width="1" opacity="0.35"/><line x1="180" y1="46" x2="180" y2="274" stroke="currentColor" stroke-width="1" opacity="0.35"/><circle cx="180" cy="160" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="180.0" y="42.0" text-anchor="middle" font-weight="600" font-size="12">0°</text><text x="302.0" y="164.0" text-anchor="middle" font-weight="600" font-size="12">90°</text><text x="180.0" y="286.0" text-anchor="middle" font-weight="600" font-size="12">180°</text><text x="58.0" y="164.0" text-anchor="middle" font-weight="600" font-size="12">270°</text><line x1="180" y1="160" x2="256.6" y2="95.7" stroke="#d9534f" stroke-width="1.6" opacity="1"/><circle cx="256.6" cy="95.7" r="7" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><path d="M180.0,115.0 A45,45 0 0 1 214.5,131.1" fill="none" stroke="#4a8fe0" stroke-width="2"/><text x="192" y="108" text-anchor="start" font-weight="600" fill="#4a8fe0">A</text><text x="180" y="298" text-anchor="middle" font-size="11">0° front, 90° right, 180° back, 270° left</text><text x="540" y="24" text-anchor="middle" font-weight="600">Side view: elevation E</text><line x1="430" y1="160" x2="650" y2="160" stroke="currentColor" stroke-width="1.2" opacity="0.5"/><line x1="540" y1="265" x2="540" y2="55" stroke="currentColor" stroke-width="1.2" opacity="0.35"/><circle cx="540" cy="160" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="654" y="164" text-anchor="start" font-size="11">E = 0°</text><text x="540" y="48" text-anchor="middle" font-size="11">+90°</text><text x="540" y="284" text-anchor="middle" font-size="11">−90°</text><line x1="540" y1="160" x2="621.9152044288992" y2="102.64235636489539" stroke="#d9534f" stroke-width="1.6" opacity="1"/><circle cx="621.9152044288992" cy="102.64235636489539" r="7" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><path d="M590,160 A50,50 0 0 0 581.0,131.3" fill="none" stroke="#4a8fe0" stroke-width="2"/><text x="598" y="148" text-anchor="start" font-weight="600" fill="#4a8fe0">E</text><text x="574.9576022144496" y="123.32117818244768" text-anchor="end" font-weight="600" fill="#4a8fe0">D</text><text x="540" y="298" text-anchor="middle" font-size="11">0° horizon, +90° straight up</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">AED: azimuth is measured in the horizontal plane, elevation upwards from the horizon, distance along the line to the loudspeaker.</figcaption>
</figure>














AED describes the same position in a perception-oriented way, starting from the centre of the listening area:

- **A (azimuth)** – horizontal angle in degrees (0° = front, 90° = right, 180° / -180° = back, 270° / -90° = left; clockwise, like a compass)
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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Octagon array in AED" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar4" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><circle cx="200" cy="155" r="100" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><circle cx="200" cy="155" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="200" y="22" text-anchor="middle" font-size="11">front</text><rect x="182.0" y="43.0" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="200.0" y="59.0" text-anchor="middle" font-size="11">LS 1</text><rect x="252.7" y="72.3" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="270.7" y="88.3" text-anchor="middle" font-size="11">LS 2</text><rect x="282.0" y="143.0" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="300.0" y="159.0" text-anchor="middle" font-size="11">LS 3</text><rect x="252.7" y="213.7" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="270.7" y="229.7" text-anchor="middle" font-size="11">LS 4</text><rect x="182.0" y="243.0" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="200.0" y="259.0" text-anchor="middle" font-size="11">LS 5</text><rect x="111.30000000000001" y="213.7" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="129.3" y="229.7" text-anchor="middle" font-size="11">LS 6</text><rect x="82.0" y="143.0" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="100.0" y="159.0" text-anchor="middle" font-size="11">LS 7</text><rect x="111.30000000000001" y="72.3" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="129.3" y="88.3" text-anchor="middle" font-size="11">LS 8</text><path d="M200.0,115.0 A40,40 0 0 1 238.6,144.6" fill="none" stroke="#d9a441" stroke-width="2" marker-end="url(#ar4)"/><text x="200" y="187" text-anchor="middle" font-size="10"></text><text x="200" y="290" text-anchor="middle" font-size="11">numbering clockwise, as azimuth increases</text><text x="470" y="70" text-anchor="start" font-weight="600">All eight loudspeakers:</text><text x="470" y="104" text-anchor="start" font-size="13">E = 0°  (ear height)</text><text x="470" y="134" text-anchor="start" font-size="13">D = 3.0 m</text><text x="470" y="164" text-anchor="start" font-size="13">A = 0°, 45°, 90° … 315°</text><text x="470" y="206" text-anchor="start" fill="#d9534f" font-size="11">LS 1 (red) stands exactly in front.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Octagon: only the azimuth changes from loudspeaker to loudspeaker – in XYZ every position would need sine and cosine.</figcaption>
</figure>














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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 334" role="img" aria-label="Azimuth convention compared" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar5" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="180" y="24" text-anchor="middle" font-weight="600">ICST AmbiDecoder</text><circle cx="180" cy="170" r="95" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><line x1="71" y1="170" x2="289" y2="170" stroke="currentColor" stroke-width="1" opacity="0.35"/><line x1="180" y1="61" x2="180" y2="279" stroke="currentColor" stroke-width="1" opacity="0.35"/><circle cx="180" cy="170" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="180.0" y="56.0" text-anchor="middle" font-size="12">0°</text><text x="298.0" y="174.0" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="13">90°</text><text x="180.0" y="292.0" text-anchor="middle" font-size="12">180°</text><text x="62.0" y="174.0" text-anchor="middle" font-size="12">270°</text><path d="M180.0,110.0 A60,60 0 0 1 236.4,149.5" fill="none" stroke="#3fa968" stroke-width="2" marker-end="url(#ar5)"/><text x="180" y="326" text-anchor="middle" font-size="11">clockwise, 90° = right (like a compass)</text><text x="540" y="24" text-anchor="middle" font-weight="600">Mathematical convention</text><circle cx="540" cy="170" r="95" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><line x1="431" y1="170" x2="649" y2="170" stroke="currentColor" stroke-width="1" opacity="0.35"/><line x1="540" y1="61" x2="540" y2="279" stroke="currentColor" stroke-width="1" opacity="0.35"/><circle cx="540" cy="170" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="540.0" y="56.0" text-anchor="middle" font-size="12">0°</text><text x="658.0" y="174.0" text-anchor="middle" font-size="12">270°</text><text x="540.0" y="292.0" text-anchor="middle" font-size="12">180°</text><text x="422.0" y="174.0" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="13">90°</text><path d="M540.0,110.0 A60,60 0 0 0 483.6,149.5" fill="none" stroke="#d9534f" stroke-width="2" marker-end="url(#ar5)"/><text x="540" y="326" text-anchor="middle" font-size="11">counter-clockwise, 90° = left (e.g. IEM plugins)</text><text x="360" y="175" text-anchor="middle" font-weight="600" font-size="34">≠</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">The same angle, 90°, points to opposite sides. Check the convention before importing coordinates from other tools.</figcaption>
</figure>














Not all systems use the same azimuth direction. In the ICST AmbiDecoder:

- **0°** = front (direction Y+)
- **90°** = right (direction X+)
- **180° / -180°** = back
- **270° / -90°** = left (direction X-)

The azimuth therefore increases **clockwise**, like a compass. Many mathematical and Ambisonics tools count counter-clockwise instead (90° = left). If you import coordinates from other tools, check the convention.

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
