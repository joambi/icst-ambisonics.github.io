---
title: ICST MultiDecoder
date: 2025-01-01T00:00:00
weight: 100
draft: false
---

> [!warning]
> 🚧 This section is currently under construction.

---

## Overview – ICST MultiDecoder

The **ICST MultiDecoder** extends the conventional Ambisonics decoder by running up to four parallel decoder units within a single plugin. All units receive the same B-format input signal and route their output independently to different loudspeaker subsets. This enables differentiated spatial strategies – such as height-based or frequency-dependent segmentation – without leaving the field-based B-format paradigm.

![MultiDecoder Overview](CleanShot%202026-02-11%20at%2013.46.56@2x.png)

The main controls at a glance:

| # | Control | Function |
|---|---------|----------|
| 1 | **Multi-Decoder toggle** | Activates / deactivates the multi-decoder mode |
| 2 | **Add Decoder** | Adds a new decoder unit (up to 4) |
| 3 | **Volume & Mute** | Per-unit level control and mute |
| 4 | **Filter Bands** | Opens the per-unit filter section |

## How It Works

### 1. Activate Multi-Decoder Mode

Pressing the toggle (① in the overview) switches the plugin from standard single-decoder operation into multi-decoder mode. The toggle can be switched at any time, which makes direct A/B comparison between both modes straightforward.

### 2. Add and Manage Decoder Units

New decoder units are added via the **+** button (②). Up to **four independent units** can run in parallel, each processing the same incoming B-format signal and sending its output to its own loudspeaker subset.

Typical use cases:

- Height layers (e.g. _Top / Mid / Bottom_)
- Frequency-based segmentation across layers
- Different loudspeaker subsets within the same array
- Side-by-side comparison of decoding strategies

### 3. Individual Parameters per Unit

Each active decoder unit can be configured independently:

#### a) Loudspeaker Selection

Each unit is assigned its own group of loudspeakers, selected from the overall speaker list. Subsets can be non-overlapping (e.g. floor / mid / ceiling) or freely defined.

![Loudspeaker selection](CleanShot%202026-02-11%20at%2013.55.43@2x.png)

#### b) Ambisonics Sequence and Weighting

Each unit can use a different **Ambisonics order** (how many spherical harmonics channels are decoded) and **channel weights** (e.g. Max-rE, Basic, In-Phase). Lower orders produce a wider, softer image; higher orders yield sharper localization. Weighting affects the trade-off between spatial focus and energy distribution.

![Ambisonics sequence](CleanShot%202026-02-11%20at%2013.59.16@2x.png)

#### c) Separate Filter Section

Each decoder unit has its own set of **filter bands** (④), allowing per-layer equalization. A common use case: applying a high-shelf cut to ceiling speakers to compensate for the different perception of elevated sound sources.

![Filter section](CleanShot%202026-02-11%20at%2014.05.58@2x.png)

#### d) Individual Audio Parameters

![Audio parameters](CleanShot%202026-02-11%20at%2014.09.04@2x.png)

Per unit (③):

1. **Filter Enable/Disable** – activate or deactivate the filter section for this unit
2. **Individual gain** – separate level control per decoder unit
3. **Mute / Unmute** – quickly isolate or silence individual decoders

---

## When to Use MultiDecoder

The standard single decoder is sufficient for symmetric, single-layer setups (e.g. Quadro, Octagon). MultiDecoder becomes useful when:

- the loudspeaker array has **distinct height layers** that benefit from different decoding parameters
- **frequency-specific treatment** per layer is needed (e.g. reduced high-frequency content for ceiling speakers)
- you want to **compare decoding strategies** within the same session without switching plugins

---

## Conceptual Background

Standard Ambisonics decoding applies the same algorithm uniformly across all loudspeakers. With vertically extended arrays, this can result in a **diffuse height image** – height layers blend into the mid layer and lose distinct spatial definition, making elevated sound sources harder to localize.

By assigning separate decoder units to each layer, psychoacoustic parameters (order, weighting, EQ) can be tuned per layer. The result is a more precise depth layering and a more differentiated spatial structure, while the field-based nature of Ambisonics is fully preserved.

The ICST MultiDecoder thus provides an extended tool for both artistic and research-based applications in Higher-Order Ambisonics.


