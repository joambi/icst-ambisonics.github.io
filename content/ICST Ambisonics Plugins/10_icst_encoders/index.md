---
title: ICST Encoders
date: 2025-01-01T00:00:00
weight: 100
draft: false
---

Institute for Computer Music and Sound Technology (ICST) Zurich University of the Arts

---

# ICST AmbiEncoders

The **ICST AmbiEncoders** position and move sound sources within the Ambisonics B-format field. Two encoder variants are available:

- **Mono-Encoder (A)** – Positions or moves a single mono source in 3D space.
- **Multi-Encoder (B)** – Positions or moves up to 64 sources per audio track, organized into up to 8 groups. Each group can be manipulated relative to its group center, enabling complex spatial choreographies.

A key distinction of the ICST encoders is their built-in **distance simulation**: a distance scaler applies lowpass filtering and a basic Doppler effect to model depth and proximity perception.

Incoming and outgoing parameters can be sent and received via [OSC](https://en.wikipedia.org/wiki/Open_Sound_Control).

> [!info]
> Wiki: [ICST AmbiEncoder · GitHub](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)

> [!example]
> Video: ICST Ambisonics Plugins – 02 – Encoder and Routing
> https://youtu.be/-U0t8sjeTsw?si=zJh9QpgOKeFe2BL0

---

## Overview

![[Overview AmbiEncoder.png]]

| Label | Description                                                |
| ----- | ---------------------------------------------------------- |
| **A** | Mono-Encoder – positions/moves a single mono source        |
| **B** | Multi-Encoder – positions/moves up to 64 sources per track |

---
## User Interface

### Main Controls

1. **Settings** – Opens the Encoder Settings window
2. **Help** – Opens the Help window

![[CleanShot 2026-03-04 at 15.04.30@2x.png]]

### Source Window (3)

![[CleanShot 2026-03-04 at 15.02.00@2x.png]]

Displays and controls individual sources. Each source can be positioned by azimuth, elevation, and distance.

### Encoding Settings (4)

![[CleanShot 2026-03-04 at 15.02.47@2x.png]]

Configures the Ambisonics encoding parameters such as order and channel format.

![[CleanShot 2026-03-04 at 18.09.16.png]]

### Radar (5)

Visual top-down display of the sound field showing the current positions of all sources.

#### Example

![[CleanShot 2026-03-04 at 18.03.59.png]]

---

## OSC Integration (6 & 7)

6. **OSC Inputs & JavaScript** – Receives OSC messages and allows custom JavaScript for parameter control
7. **OSC Output** – Sends encoder state as OSC messages to external applications

> [!example]
> Video: ICST Ambisonics Plugins – 03 – OSC Part 1
> https://youtu.be/7_s-jaUQa14?si=NM8TPRrigY_egDfC

---

## Additional Controls

8. **Distance Scaler** – Simulates distance perception via lowpass filtering and Doppler effect
9. **Infiniti** – Enables infinite distance mode, placing sources at the far field boundary
10. **Gain / Volume** – Adjusts the input or output gain of the encoder
11. **Import & Export** – Imports or exports source configurations as files
12. **Groups Editor** – Manages source groups; each group can be repositioned relative to its group center

#### Example: Create Groups

![[create groups.png]]

#### Example: Group Manipulation & Animation

![[2c34531a-ff69-490d-c9d0-e3ea82eb29b0.gif]]

13. **Save & Load Presets** – Stores and recalls complete encoder configurations

---

## Summary

The ICST AmbiEncoders offer:

- Mono and multi-source encoding (up to 64 sources per track)
- Group-based spatial choreography with up to 8 groups
- Distance simulation with lowpass filtering and Doppler effect
- Full OSC integration (input, output, and JavaScript scripting)
- Preset management for reproducible sessions

---
<span style="font-size:9px;color:#9f9f9f;">©2026 ICST</span>