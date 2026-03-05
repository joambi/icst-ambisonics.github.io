---
title: ICST Decoder
date: 2025-01-01T00:00:00
weight: 80
draft: false
---

Institute for Computer Music and Sound Technology (ICST) · Zurich University of the Arts

---

# ICST Ambisonics Decoder

Decoding is the central interface between the Ambisonics B-format and physical loudspeaker reproduction – its quality determines spatial precision, depth layering, and localization.

While binaural playback over headphones is today largely mature through established plug-ins (e.g., IEM, SPARTA), decoding for real loudspeaker arrays remains a technically and psychoacoustically demanding task. Geometry, delay times, weightings, filtering, and Ambisonics order must all be precisely coordinated.

The **ICST Ambisonics Decoder** is a powerful, practical tool developed specifically for flexible loudspeaker setups in studio and live contexts. In addition to standard configurations (e.g., Quadro, Octagon, 7.1.4), asymmetric or individually measured loudspeaker arrangements can also be accurately mapped.

The decoder was developed in the context of the ZHdK's 3D Composition Studio and has been continuously tested in studio and concert operation. The goal was to provide a **flexible, reproducible, and sonically transparent decoding system** for Higher-Order Ambisonics workflows.

---
## Plugin Formats

The **ICST Ambisonics Decoder Plugins** are available as:
- VST3
- AU (Component)
- LV2 _(experimental – not recommended for production use)_

Wiki: [ICST AmbiDecoder · schweizerweb/icst-ambisonics-plugins Wiki · GitHub](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)

All examples in this article are performed in REAPER. REAPER supports up to 128 audio channels per track and is therefore particularly well-suited for Higher-Order Ambisonics productions.

---

## Overview ICST Ambisonics Decoder

![ICST Ambisonics Decoder Overview](decoder-overview.png)

### Main Areas of the User Interface

1. **Radar – horizontal view** of the loudspeaker arrangement (ICST Composition Studio)
2. **Vertical radar view (Z-axis)**
3. **Speaker parameters**
    - CH = Index
    - Name = loudspeaker label
    - Coordinates: Cartesian (XYZ) & Polar (Azimuth, Elevation, Distance)

> [!tip]
> Double-click the parameter fields to enter values directly.

### Settings & Help <img src="speaker-settings-icon.png" width="28">

4. Gear icon → Opens the _Speaker Settings_ window
5. Question mark → Help window

**Speaker Parameter Editor:**

![Speaker Parameter Editor](CleanShot%202026-02-11%20at%2010.59.50@2x.png)

### Keyboard Shortcuts

| Action                        | Shortcut           |
| ----------------------------- | ------------------ |
| Mute selected source/speaker  | `Ctrl + Shift + M` |
| Solo selected source/speaker  | `Ctrl + Shift + S` |

> [!example]
> Video: ICST Ambisonics Plugins Overview
> https://www.youtube.com/watch?v=xkauhHMYt5k

> [!info]
> Wiki: ICST Ambisonics Plugins
> https://github.com/schweizerweb/icst-ambisonics-plugins/wiki

---

## Workflow: Ambisonics Decoding in REAPER

![Workflow schematic](CleanShot%202026-02-10%20at%2017.28.25@2x.png)

### Recommended Track Structure

Create three 64-channel audio tracks in REAPER:

![Track setup](CleanShot%202026-02-10%20at%2017.36.04@2x.png)

1. **B-Format Source Track** – 1st–7th Order Ambisonics file
2. **Ambisonics Bus** – collects multiple B-format signals, hosts mastering FX
3. **Decoder Track** – hosts the ICST Ambisonics Decoder, output to loudspeakers

This clear separation ensures transparency, modularity, and reproducible setups.

---

## ICST AmbiDecoder – Step-by-Step Setup

1. Add the **ICST AmbiDecoder** plugin to the Decoder Track.

    ![Add plugin](CleanShot%202026-02-10%20at%2017.54.52@2x.png)

    By default the decoder opens with the Stereo (90°) setting.

    ![Choose speaker preset](Choose_Quadro.gif)

2. Open the _Speaker Settings_ window (gear icon → "Speaker"). Select one of the many standard presets or enter your own loudspeaker configuration.

    ![Speaker editing](Speaker_Editing.gif)

3. Optionally activate the **Filter** section to equalize individual loudspeakers.

    ![Enable filter](CleanShot%202026-02-11%20at%2011.05.51@2x.png)

    Available filter types per speaker:

    ![Filter types](CleanShot%202026-02-11%20at%2011.11.32@2x.png)

    > [!todo]
    > Add screenshot: measured loudspeaker setup of the ICST Composition Studio

4. Under **"Speakers"** edit the speaker parameters directly and save them as a preset.

    ![Speaker settings detail](CleanShot%202026-02-10%20at%2018.57.37@2x.png)

5. Under **"Ambisonics"** select the desired order (up to 7th order) and Channel Weights.

    ![Ambisonics order](CleanShot%202026-02-11%20at%2009.30.18@2x.png)

6. Scale room dimensions as needed – loudspeaker coordinates and delay times are recalculated automatically.

    ![Room scaling](CleanShot%202026-02-11%20at%2010.19.42@2x.png)

---

## Audio Test Function

![Audio test](Decoder%20Audio%20test.gif)

The decoder features an integrated test section:

- Pink noise generator
- Individual test per loudspeaker
- Sequential test of all loudspeakers clockwise ("Test all speakers")
- Mute / Solo via `Ctrl + Shift + M` / `Ctrl + Shift + S`

This enables a quick technical check of the entire system before rehearsal or performance.

---

## Save & Load Presets

![Save presets](save%20decoder%20presets.gif)

Speaker configurations can be saved as presets and reloaded at any time. This ensures reproducibility across sessions and venues.

> [!tip]
> Export the speaker configuration as a TXT file and load it into the external `ambidecode~` object using a `coll`.

![TXT export](CleanShot%202026-02-11%20at%2014.23.51@2x.png)

---
## Summary

The ICST Ambisonics Decoder offers:

- Precise Higher-Order Ambisonics decoding
- Flexible loudspeaker geometries (symmetric & asymmetric)
- Per-speaker filtering and equalization
- Integrated test and measurement functions
- Multi-layer MultiDecoder architecture
- Preset management for reproducible setups
- Seamless integration into professional DAW workflows

It thus forms a robust foundation for artistic, scientific, and production-oriented applications in 3D audio.

---
