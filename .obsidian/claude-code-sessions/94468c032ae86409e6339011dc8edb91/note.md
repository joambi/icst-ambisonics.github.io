---
tags: [ambisonics, audio, plugin, 3D-audio, REAPER, ZHdK, ICST]
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

More information:
[https://ambisonics.ch/icst-ambisonics-plugins/](https://ambisonics.ch/icst-ambisonics-plugins/)
Wiki:
[https://github.com/schweizerweb/icst-ambisonics-plugins/wiki](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)

All examples in this article are performed in REAPER. REAPER supports up to 128 audio channels per track and is therefore particularly well-suited for Higher-Order Ambisonics productions.

---

## Overview ICST Ambisonics Decoder

![[CleanShot 2026-02-11 at 10.31.18@2x.png]]

### Main Areas of the User Interface
1. **Radar – horizontal view** of the loudspeaker arrangement
2. **Vertical radar view (Z-axis)**
3. **Speaker parameters**
    - CH = Index
    - Name = loudspeaker label
    - Coordinates: Cartesian (XYZ) & Polar (Azimuth, Elevation, Distance)

> [!tip]
> Double-click the parameter fields to enter values directly

## Core Functions

### Speaker Settings ![[CleanShot 2026-02-11 at 11.45.08@2x.png |25]]
- Gear icon → Opens the _Speaker Settings_ window
- Question mark → Help window
- Individual loudspeaker configurations can be saved as presets

### Speaker Settings – Detail
Under "Speakers" you can edit the speaker parameters directly and then save them as a preset.
![[CleanShot 2026-02-11 at 11.13.46@2x.png]]
- Add and edit loudspeakers
- Select the **Ambisonics order** (up to 7th order)
- Adjust **Channel Weights**
- Scale room dimensions and loudspeaker coordinates
- Automatic calculation of delay times

### Speaker Filter (optional)

> [!todo]
> Add a screenshot and a detailed description of the filter section

- Separate filtering per loudspeaker
- Individual adjustment for height, mid, or floor segments
- Particularly relevant for large or vertically staggered arrays

---

## Audio Test Function

The decoder features an integrated test section:

- Pink noise generator
- Individual test per loudspeaker
- Sequential test of all loudspeakers (clockwise)
- Mute / Solo shortcuts:
    - `Ctrl + Shift + M`
    - `Ctrl + Shift + S`

This enables a quick technical check of the entire system before rehearsal or performance.

---

## Workflow: Ambisonics Decoding in REAPER

### Recommended Structure

1. **B-Format Source Track**
    (1st–7th Order Ambisonics File)
2. **Ambisonics Bus**
    - Collection of multiple B-formats
    - Hosting mastering FX
3. **Decoder Track**
    - Hosting the ICST Ambisonics Decoder
    - Output to physical loudspeakers
This clear separation ensures transparency, modularity, and reproducible setups.

---

## Overview ICST MultiDecoder

The **ICST MultiDecoder** extends classical Ambisonics rendering with a multi-layer decoding architecture.

### How It Works

1. Activation of _Multi-Decoder Mode_
    (can be toggled directly for comparison purposes)
2. Up to **four parallel decoder units**
    e.g. for:
    - Height layer
    - Mid layer
    - Floor layer
    - Substructure
3. Each decoder unit has:
    - Its own loudspeaker selection
    - Individual Ambisonics sequence and weighting
    - Separate filter section
    - Individual gain
    - Mute / Unmute
### Conceptual Background

The MultiDecoder is based on the observation that classical Ambisonics decoding, while producing a natural result, can sometimes yield a somewhat diffuse depth image.

Through frequency- or layer-specific decoding units, psychoacoustic aspects can be modeled in a targeted way, without leaving the field-based Ambisonics paradigm.

The result is a more precise depth layering and a more differentiated spatial structure – particularly with complex, vertically extended loudspeaker arrays.

---

## Summary

The ICST Ambisonics Decoder offers:

- Precise Higher-Order Ambisonics decoding
- Flexible loudspeaker geometries (symmetric & asymmetric)
- Integrated test and measurement functions
- Multi-layer MultiDecoder architecture
- Seamless integration into professional DAW workflows

It thus forms a robust foundation for artistic, scientific, and production-oriented applications in 3D audio.

---
