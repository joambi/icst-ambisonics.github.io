---
title: The Filter Tab in the ICST AmbiDecoder – Practical Examples and Use Cases
description: "How to use channel-specific filters in the ICST AmbiDecoder: from room-acoustic correction and height rendering to experimental weighting of individual loudspeaker positions."
date: 2026-03-21T11:30:00+01:00
year: 2026
month: 2026-03
weight: 33
tags: ["decoder", "filter", "eq", "room-acoustics", "multidecoder", "tuning", "tutorial"]
key_points:
  - "Each loudspeaker can be processed individually with up to eight filter types"
  - "Filters compensate for room-acoustic problems or support a careful psychoacoustic tuning"
  - "In MultiDecoder mode every decoder unit can have its own filter section"
difficulty: "intermediate"
kind: "tutorial"
tool: ["AmbiDecoder"]
---

Level: Intermediate | **Audience:** Technicians, composers with a technical interest, studio operators.

This page explains how to use the Filter tab of the ICST AmbiDecoder in practice – and shows concrete scenarios for when which filter strategy makes sense.

> **Core sentence of this decoder series:** The decoder does not create the space anew; it projects a B-format field onto a real system.
>
> This article covers the third step of that projection: **tuning**. Filters, weighting and similar interventions determine **how clearly** or **how coloured** the result is perceived, once geometry and delay are already right.

---

## What the Filter tab can do

The **Filter** tab in the speaker settings window lets you process individual loudspeakers separately. Each loudspeaker has up to **eight independent filter slots**. The available filter types are:

- **Peak** – narrow-band boost or cut (parametric EQ)
- **High Shelf / Low Shelf** – boost or cut above/below a cut-off frequency
- **High Pass / Low Pass** – frequency cut with adjustable slope
- **Off** – slot disabled

Each slot has three parameters: **frequency**, **gain (dB)** and **Q value** (quality / bandwidth).

The **FFT toggle** shows the measured or simulated spectrum of the loudspeaker in the background of the display – helpful for visually checking the filter curve.

> **Important context:** The Filter tab is primarily intended for targeted corrections and careful tuning, not for a hard decomposition of the sound field into rigid perceptual bands.

---

## Opening the filter for a loudspeaker

1. Open **Speaker Settings** (gear icon in the decoder).
2. Select a loudspeaker in the table.
3. Click the **Filter** button on the right of the row – the filter panel opens.
4. Choose a filter type from the dropdown menu and set frequency, gain and Q.

> **Tip:** Activate **Bypass filter** in the panel to disable the filter temporarily and hear the effect directly as an A/B comparison.

---

## Practical example 1: the tweeter is too bright

**Problem:** Loudspeaker 7 has too prominent a high-frequency component – it sounds harsh and disturbs the uniformity of the array.

**Solution:**
- Filter type: **High Shelf**
- Frequency: approx. 8,000 Hz
- Gain: -3.0 to -5.0 dB
- Q: 0.7 (wide)

This gently attenuates the highs above 8 kHz without affecting the midrange. Compare with the neighbouring loudspeaker using solo/mute.

---

## Practical example 2: room modes with a subwoofer

**Problem:** The subwoofer (SUB) has a pronounced room mode at 63 Hz – a clear rise that bloats bass phantom sources.

**Solution:**
- Filter type: **Peak** (cutting)
- Frequency: 63 Hz
- Gain: -6.0 to -9.0 dB
- Q: 4.0 (narrow-band)

This addresses the mode specifically without weakening the whole bass range.

---

## Practical example 3: height rendering with a high-frequency boost

**Problem:** In a 3D array the height loudspeakers sound weaker in the highs than the ring loudspeakers – sound events that are meant to rise upwards disappear in the diffuse field.

**Solution (for all height loudspeakers):**
- Filter type: **High Shelf**
- Frequency: 3,000 Hz
- Gain: +3.0 to +5.0 dB
- Q: 1.0

This can support the perception of height and make upward movements clearer. Such interventions should always be dosed carefully and checked by ear on the real array.

---

## Practical example 4: suppressing low frequencies in the height layers

**Problem:** In a multi-level array (bottom, middle, top) the upper loudspeakers produce disturbing low-frequency components that destabilise phantom sources in the horizontal plane.

**Solution (for the upper loudspeaker group):**
- Filter type: **High Pass**
- Frequency: 250–400 Hz
- Q: 0.7

This cuts low frequencies below the cut-off frequency. Combined with MultiDecoder mode, this setting can be applied to a whole decoder unit (e.g. the "Top" group) without affecting the other layers.

---

## Filters in MultiDecoder mode

In **MultiDecoder mode** each of the up to four decoder units has its own filter section. This enables frequency-dependent spatial rendering across different loudspeaker groups:

| Decoder unit | Loudspeakers | Filter strategy |
|---|---|---|
| High (top) | 12 speakers | High Shelf +4 dB from 3 kHz |
| Middle | 16 speakers | flat (no filtering) |
| Deep (bottom/sub) | 12 speakers | Low Pass 300 Hz |

This approach can follow psychoacoustic models of perception: low frequencies often contribute more to envelopment, high frequencies more to vertical clarity. The separate filtering is not a fixed truth machine but a form of careful tuning that has to be verified on the specific array.

---

## Saving filter presets

Filter settings are saved with the loudspeaker preset. When you load a preset, all filter settings of all loudspeakers are restored as well.

To save a filter preset explicitly for a single loudspeaker:
- Click **Save** at the top right of the filter panel
- Give the preset a descriptive name (e.g. `LS7_HF_correction_ICST`)

Presets can be copied between loudspeakers – useful when several loudspeakers of the same type in the array need the same correction.

---

## What the filter does not replace

The Filter tab is not a substitute for:

- **Room-acoustic treatment** (absorbers, diffusers)
- **Proper loudspeaker routing** (wrongly routed channels will not sound right even with a filter)
- **Exact loudspeaker calibration** (a full measurement run with e.g. Room EQ Wizard is more accurate)

Use the filters in the decoder for targeted, specific corrections – not as a blanket colouring of the whole system.

---

## Decoder series: tuning

If you think of the decoder as a three-step process, this page covers **tuning**:

- **Geometry** determines **where** loudspeakers stand
- **Delay** determines **when** signals arrive
- **Tuning** determines **how clearly** or **how coloured** the result is perceived

Filtering is therefore the last step, not the first. If geometry or delay are still inconsistent, filters quickly look like problem solvers although they only mask symptoms.

---

## Further reading

- [ICST Decoder – setup and operation](/icst-ambisonics-plugins/08_icst_decoder/)
- [ICST MultiDecoder](/icst-ambisonics-plugins/09_icst_multidecoder/)
- [XYZ and AED – coordinate systems compared](/post/xyz-vs-aed-koordinatensysteme/)
- [Scaling and delay compensation](/post/decoder-skalierung-laufzeitkompensation/)
- [Why the decoder sounds the way it does – methodological context](/post/decoder-methodological-context/)
- [Best practices](/icst-ambisonics-plugins/17_best_practices/)
