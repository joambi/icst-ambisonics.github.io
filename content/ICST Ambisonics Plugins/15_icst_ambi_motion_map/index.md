---
title: ICST Ambi Motion Map
date: 2026-06-27T00:00:00
weight: 87
draft: false
toc: true
description: "Algorithmic spatial movement generator for ICST AmbiEncoder_64 in REAPER — assign motion shapes per source and write XYZ automation over any time selection."
---

Level: Intermediate | Audience: Composer, sound designer, spatial-audio technician.

Use this page when you want to generate spatial movement automatically — circles, spirals, Lissajous figures, arcs — for multiple AmbiEncoder sources at once, written directly as REAPER automation.

> **Download:** [ICST Ambi Motion Map Bundle](/downloads/ICST_Ambi_Motion_Map_Bundle.zip) (GUI script + automation writer)

## What it does

`AmbiEncoder64 Motion Map GUI` lets you assign one motion shape per source index and then write XYZ automation over the current REAPER time selection in a single click. Instead of defining positions one by one, you choose a movement pattern — line, arc, circle, spiral, Lissajous — and the script generates the full automation curve.

It works with `AmbiEncoder_64` (up to 64 sources) and writes directly into FX parameter envelopes, creating a render region at the same time.

Use it when you need:

- generative or textural spatial movement (all sources orbiting at different phases)
- rapid prototyping of complex multi-source scenes
- automated variation rather than manually cued positions

![AmbiEncoder64 Motion Map GUI](/motion-markers/motion-map-gui-overview.png)

> **See also:** For musically timed, cue-based movement between defined positions, use [ICST Ambi Motion Markers](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) instead.

## Requirements

- **REAPER** (v6 or later)
- **ICST AmbiEncoder_64** on the target track — see [Installation](/icst-ambisonics-plugins/02_installation/)
- A time selection (loop range) must be set before writing automation

## Installation

### Add the scripts to REAPER

In REAPER: *Actions menu → Load ReaScript…* — then load both files from the bundle:

- `scripts/JS_AmbiEncoder64_Motion_Map_GUI.lua` — the GUI
- `scripts/JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua` — the automation writer (must be in the same folder)

The GUI script calls the writer automatically — both files must stay in the same directory.

## Workflow

1. Select exactly one track containing `AmbiEncoder_64`
2. Set a time selection (loop range) covering the region you want to fill
3. Open the GUI: run `JS_AmbiEncoder64_Motion_Map_GUI` from the Actions menu
4. Enable sources with the **✓** checkbox and assign a motion shape per source
5. Adjust the Settings panel (center, spread, steps/sec)
6. Click **Write Automation + Region**

The script writes envelope points, sets the track to Latch mode, and creates a named render region over the time selection.

## Motion shapes

Each source can be assigned one of ten movement patterns:

| Shape | Label | Character |
|-------|-------|-----------|
| `line` | Line | Diagonal from one corner to another across the time range |
| `arc_up` | Arc+ | Arc curving upward — smoothstep easing on azimuth |
| `arc_down` | Arc− | Arc curving downward |
| `s_curve` | S | S-shaped sweep — one full sinusoidal oscillation in elevation |
| `step` | Step | Quantised steps in azimuth with elevation triangle waves |
| `zigzag` | Zig | Fast azimuth/elevation zigzag pattern |
| `circle` | Circ | Full circle in the horizontal plane |
| `spiral` | Spir | Expanding spiral outward from centre |
| `fourier_xyz` | Four | Complex 3D trajectory from summed Fourier components |
| `lissajous` | Lis | Lissajous figure — azimuth and elevation at different frequencies |

Sources that share the same shape are offset in phase automatically, so they spread across the field rather than moving in lockstep.

## Settings

### Spatial parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| Steps/sec | 12 | Automation point density per second |
| X center | 0 | Azimuth center in degrees |
| X spread | 320 | Azimuth spread in degrees (total range) |
| Y center | 0 | Elevation center in degrees |
| Y spread | 50 | Elevation spread in degrees |
| Z center | 0.75 | Distance center (0–1) |
| Z spread | 0.35 | Distance spread |
| Motion amount | 2.0 | Scale factor applied to all motion amplitudes |

### Options

**Clear existing** — deletes existing envelope points in the time selection before writing. Disable to layer additional movement on top.

**Track Latch** — sets the AmbiEncoder track to Latch automation mode after writing, so live parameter movements are recorded on the next pass.

**Overwrite region** — if a region with the same name already exists, it is moved to the current time selection instead of creating a duplicate.

**Use Z motion** — includes distance (Z) movement. Disable to keep all sources at a fixed distance while azimuth and elevation still move.

### Region name

Sets the name of the render region created over the time selection. Default: `BFormat_TS`. Useful for naming scenes or sections directly in the project.

## Presets

The Presets row offers quick starting points:

| Preset | Effect |
|--------|--------|
| Auto | Assigns motion shapes in round-robin order across all 64 sources |
| Random | Assigns random shapes to all sources |
| All Line | Sets all enabled sources to Line |
| All Circle | Sets all enabled sources to Circle |
| All Step | Sets all enabled sources to Step |
| S0-7 Arc | Assigns Arc+ to sources 0–7 |
| S8-15 Circle | Assigns Circle to sources 8–15 |

The source-selection row controls which sources are enabled without changing their assigned shapes: **All Src**, **None Src**, **S0-7 Src**, **S8-15 Src**, **Clear Sel**.

## Good practices

- Start with **Auto** preset and 2–4 active sources to understand the default spread before adding more
- Use **Steps/sec 6–8** for broad sweeping movement, **20–30** for detailed articulation
- Keep **Motion amount** at 1.0 initially — values above 2 can push sources to the sphere boundary
- Use **Clear existing** off to layer a circle on top of an existing line automation
- Name regions meaningfully — they appear in the REAPER project and in render exports

## Troubleshooting

### "Bitte genau einen Track mit ICST AmbiEncoder_64 selektieren"

Exactly one track must be selected and it must contain an `AmbiEncoder_64` FX. Select the track first, then open the GUI.

### "Bitte zuerst eine Loop/Time Selection setzen"

No time selection is active. Set a loop range in REAPER before clicking Write Automation + Region.

### No envelope points written / no movement visible

- Confirm the track has `AmbiEncoder_64` and not a different encoder variant
- Check that at least one source is enabled (✓ checkbox active)
- Lower Steps/sec if the time selection is very short — a 0.1s selection at 12 steps/sec produces only 1 point

### Writer script not found

Both Lua files must be in the same directory. If you moved `JS_AmbiEncoder64_Motion_Map_GUI.lua` after loading it into REAPER, reload it from the new location. The writer path is resolved relative to the GUI script at runtime.
