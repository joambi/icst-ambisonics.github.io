---
title: ICST Kristall Motion Map — User Guide
date: 2026-07-01T00:00:00
weight: 90
draft: false
toc: true
translationKey: kristall-motion-map
description: "Step-by-step guide to ICST Kristall Motion Map — a modular 3D crystal-lattice motion system for up to 64 AmbiEncoder sources in REAPER. Covers instances, transforms, quantization, smoothing, interaction, and presets."
---

Level: Intermediate | Audience: Composer, sound designer, spatial-audio technician. | **Version: 0.1.0**

ICST Kristall Motion Map generates **three-dimensional lattice-based spatial movement** for up to 64 AmbiEncoder sources. Each audio source is mapped to a point in a crystal lattice; a step sequencer walks the source through the lattice while transforms (rotation, scale, bounds, quantization) and a distance-based interaction engine shape the movement. Results can be written as REAPER automation or streamed live via OSC.

> **Script file:** `JS_ICST_Kristall_Motion_Map.lua` — see [Downloads](/icst-ambisonics-plugins/08_downloads/)

---

## 1. What is a crystal lattice?

A crystal lattice is a **repeating 3D grid** of positions defined by a unit cell — the smallest repeating unit. The seven classical crystal systems differ in axis lengths and angles:

| System | Axes | Angles | Example shape |
|--------|------|--------|---------------|
| Cubic | a = b = c | α = β = γ = 90° | Cube |
| Tetragonal | a = b ≠ c | α = β = γ = 90° | Elongated cube |
| Orthorhombic | a ≠ b ≠ c | α = β = γ = 90° | Brick |
| Hexagonal | a = b ≠ c | α = β = 90°, γ = 120° | Honeycomb column |
| Rhombohedral | a = b = c | α = β = γ ≠ 90° | Skewed cube |
| Monoclinic | a ≠ b ≠ c | α = γ = 90°, β ≠ 90° | Tilted brick |
| Triclinic | a ≠ b ≠ c | α ≠ β ≠ γ ≠ 90° | Fully skewed |

In ICST Kristall Motion each **instance** represents one lattice point. Its position is computed as:

```
position = start + currentStep × offset
```

Transforms (rotation, scale, bounds) are then applied before output.

---

## 2. Requirements

- **REAPER** v6 or later
- **ICST AmbiEncoder_64** on the target track (see [Installation](/icst-ambisonics-plugins/02_installation/))
- `JS_ICST_Kristall_Motion_Map.lua` loaded via *Actions → Load ReaScript*
- **Python 3** — required only for live OSC preview

{{< notice warning >}}
The Lua module exposes a **host adapter** (Section 3 of the script). Before use, replace the six stub functions (`declareParam`, `getParam`, `setParam`, `drawPoint`, `drawLine`, `getTransportState`) with REAPER-specific calls. Without adaptation the script runs as a pure logic module with no UI or output.
{{< /notice >}}

---

## 3. Installation

### Step 1 — Download and place the script

1. Download `JS_ICST_Kristall_Motion_Map.lua` from the [Downloads page](/icst-ambisonics-plugins/08_downloads/).
2. Place the file in your REAPER Scripts folder:
   - **macOS:** `~/Library/Application Support/REAPER/Scripts/`
   - **Windows:** `%APPDATA%\REAPER\Scripts\`

### Step 2 — Adapt the host functions

Open the script in a text editor and locate **SECTION 3 — HOST ADAPTER STUBS** (lines ~80–130). Replace each stub with the appropriate REAPER Lua call:

```lua
-- Example REAPER adapter for declareParam using JS_ReaScriptAPI
local function declareParam(id, label, group, min, max, default)
  -- Map to your slider/knob system here
end

local function getTransportState()
  local playing = reaper.GetPlayState() == 1
  local _, bpm  = reaper.GetProjectTimeSignature2(0)
  local time    = reaper.GetPlayPosition()
  return { playing = playing, bpm = bpm, time = time }
end
```

All other sections are pure Lua and need no modification.

### Step 3 — Load the script into REAPER

1. Open REAPER.
2. Go to **Actions → Load ReaScript…**
3. Navigate to your Scripts folder and select `JS_ICST_Kristall_Motion_Map.lua`.
4. Click **Open** — REAPER confirms: *"Script loaded successfully."*

### Step 4 — Initialise the module

Call `init()` once at startup (your wrapper script should do this):

```lua
local KM = dofile(reaper.GetResourcePath() .. "/Scripts/JS_ICST_Kristall_Motion_Map.lua")
KM.init()   -- declares all UI parameters and boots a default 2×2×2 cubic lattice
```

From then on, call `KM.onUpdate(dt)` on every frame, where `dt` is the elapsed time in seconds.

---

## 4. Core concepts

### Instances

An **instance** is one crystal-lattice point — one moving audio source. Each instance has its own position, offset vector, rate, transform stack, and interaction settings. Up to **64 instances** can run simultaneously.

### Step sequencer

Each instance has an internal step counter. On every beat subdivision (controlled by **Rate**), the step counter advances by 1. The position is computed as:

```
rawPos = start + currentStep × effectiveOffset
```

Three **repetition modes** control what happens at the end:

- **Infinite** — the step counter runs forever (position drifts away from the origin).
- **Finite** — stops at `stepCount − 1` and holds the final position.
- **Pingpong** — reverses direction at both ends, creating a back-and-forth motion.

### The transform pipeline

Every frame, each instance's position passes through this chain in order:

```
Step position → Rotation → Scale → Bounds → Spatial quantization → Smoothing → Output
```

---

## 5. Instance parameters

### Position

| Parameter | Description |
|-----------|-------------|
| **Start X / Y / Z** | World-space origin of this instance |
| **Offset X / Y / Z** | Lattice vector — how far the position moves per step |

### Timing

| Parameter | Range | Description |
|-----------|-------|-------------|
| **Rate** | 0.001 – 16 | Steps per beat |
| **Repetition Mode** | Infinite / Finite / Pingpong | What happens when `stepCount` is reached |
| **Step Count** | 1 – 1024 | Total number of steps (Finite and Pingpong modes) |

### Rotation

Rotation pivots around the instance's **Start** position. Angles are in degrees.

| Parameter | Description |
|-----------|-------------|
| **Rotation X / Y / Z** | Euler angles in degrees |
| **Rotation Order** | Application order: XYZ, XZY, YXZ, YZX, ZXY, ZYX |

### Scale

Scale stretches the lattice vector relative to the Start position.

| Parameter | Range | Description |
|-----------|-------|-------------|
| **Scale X / Y / Z** | 0.001 – 10 | Per-axis scale factor |

### Bounds

Bounds clamp or fold the position into a defined region.

| Parameter | Description |
|-----------|-------------|
| **Bounds Enabled** | Toggle bounds processing |
| **Bound Min/Max X/Y/Z** | The bounding box corners |
| **Bound Mode** | none / clamp / wrap / mirror |

**Bound modes explained:**

- `clamp` — position stops at the boundary.
- `wrap` — position jumps to the opposite boundary (torus topology).
- `mirror` — position reflects at the boundary (ping-pong in each axis independently).

---

## 6. Step-by-step: First crystal motion

This walkthrough creates a simple cubic lattice with three sources moving along the X-axis.

### Step 1 — Apply the Cubic preset

In the Utilities group, trigger **Preset: Cubic** (set the parameter to 1, then back to 0). This creates a 3×3×3 grid of 27 instances with default settings.

### Step 2 — Select an instance

Set **Selected Index** (Utilities group) to `1`. The *Selected Instance* parameters now show instance 1.

### Step 3 — Adjust the offset

Set **Offset X** to `0.5`, **Offset Y** to `0`, **Offset Z** to `0`. Instance 1 will now move 0.5 units along X per step.

### Step 4 — Set repetition

Set **Repetition Mode** to `Pingpong` and **Step Count** to `16`. The source will travel 8 steps out and bounce back.

### Step 5 — Enable smoothing

Make sure **Smoothing** is on and **Glide Time** is around `0.08`. Positions will glide smoothly between steps.

### Step 6 — Connect to AmbiEncoder_64

Call `KM.getOutputPositions()` in your update loop and map each `{x, y, z}` to the corresponding AmbiEncoder source via OSC or automation parameters.

### Step 7 — Press Play

Start REAPER transport. The status dot in your GUI turns green; sources begin moving.

---

## 7. Rotation

Rotation applies a 3×3 Euler rotation matrix to the position **relative to the Start point**. The six rotation orders follow standard aerospace convention:

| Order | Sequence |
|-------|----------|
| XYZ | Roll → Pitch → Yaw |
| XZY | Roll → Yaw → Pitch |
| YXZ | Pitch → Roll → Yaw |
| YZX | Pitch → Yaw → Roll |
| ZXY | Yaw → Roll → Pitch |
| ZYX | Yaw → Pitch → Roll (most common in robotics) |

{{< notice warning >}}
Rotation order matters. XYZ and ZYX produce the same result only when two of the three angles are zero.
{{< /notice >}}

**Tip:** To rotate an entire lattice plane without moving the origin, keep Start X/Y/Z at `0` and set the rotation before adding a non-zero Offset.

---

## 8. Bounds

Bounds are applied **after** rotation and scale. The four modes are:

**Clamp** — the position is stopped at the boundary and stays there until the step reverses:

```
position = max(boundMin, min(boundMax, position))
```

**Wrap** — the position teleports to the opposite side. Creates a torus topology — useful for continuous circular motion without pingpong:

```
position = boundMin + (position - boundMin) mod (boundMax - boundMin)
```

**Mirror** — the position reflects at each boundary. Each axis behaves like pingpong independently of the step counter's repetition mode.

**None** — bounds are disabled; positions can go anywhere.

---

## 9. Quantization

### Space quantization

Snaps the computed position to the nearest grid point **before** smoothing. The grid is defined per-axis:

| Parameter | Description |
|-----------|-------------|
| **Space Quantize** | Enable/disable |
| **Grid X / Y / Z** | Grid cell size per axis |
| **Round Mode** | nearest / floor / ceil |

Use `nearest` for symmetric snapping, `floor` to always snap downward (useful for indexing speaker arrays), `ceil` to always snap upward.

### Time quantization

When enabled, step advances are **snapped to beat subdivisions** rather than accumulating continuously. Rate then controls how many beat subdivisions fit in one step cycle:

```
stepDuration = (60 / bpm) / rate    (seconds per step)
```

Enable time quantization for **rhythmically locked** crystal motion that stays in sync with the DAW grid.

---

## 10. Smoothing

The smoothing engine applies an **exponential-decay lerp** (one-pole low-pass filter) between the raw stepped position (`targetPos`) and the output (`currentPos`):

```
alpha       = 1 − exp(−dt / glideTime)
currentPos  = currentPos + alpha × (targetPos − currentPos)
```

| Parameter | Range | Description |
|-----------|-------|-------------|
| **Smoothing** | on / off | Toggle the filter |
| **Glide Time** | 0 – 2 s | Time constant (time to reach 63 % of target) |

A glide time of `0.08 s` produces snappy but smooth jumps. Values above `0.5 s` create slow glides that blur step boundaries. Set to `0` for hard discrete steps.

---

## 11. Interaction engine

Interaction allows instances to **influence each other's movement** based on their 3D distance. Each instance can act as a sender, a receiver, or both.

### How it works

Every frame, before positions are computed, each sender instance casts an influence sphere of radius **Interaction Radius**. Any receiver within that radius accumulates a weighted contribution to its **Effective Offset** and/or **Effective Rate**.

### Falloff modes

| Mode | Formula | Character |
|------|---------|-----------|
| **Linear** | `w = 1 − dist / radius` | Even, predictable fade |
| **Inverse Square** | `w = (1 − dist/radius)²` | Strong centre, fast edge drop |
| **Gaussian** | `w = exp(−dist² / 2σ²)` | Smooth bell curve, σ = radius / 3 |

### Interaction parameters

| Parameter | Description |
|-----------|-------------|
| **Interaction** | Enable/disable for this instance |
| **Send Amount** | How strongly this instance influences others (0 = silent sender) |
| **Receive Amount** | How strongly this instance accepts incoming influence (0 = deaf) |
| **Radius** | Sphere of influence in world units |
| **Affect Offset** | Whether incoming influence modifies the Effective Offset vector |
| **Affect Rate** | Whether incoming influence modifies the Effective Rate |

{{< notice warning >}}
Interaction is computed between **all** active instances every frame. With 64 instances and large radii, every instance may influence every other. Start with `Send Amount = 0.2` and increase gradually.
{{< /notice >}}

---

## 12. Presets

Four built-in presets generate complete instance configurations. Each preset clears all existing instances.

### Cubic lattice

Creates an n×n×n grid of instances with equal spacing on all axes (a = b = c). Default: 3×3×3 = 27 instances.

```lua
KM.presetCubic(3, 1.0)    -- 3×3×3 grid, 1.0 unit spacing
```

### Tetragonal lattice

Creates an nx×ny×nz grid where the X-Y spacing differs from the Z spacing (a = b ≠ c). Default: 3×3×2 = 18 instances.

```lua
KM.presetTetragonal(3, 3, 2, 1.0, 1.6)    -- sa=1.0, sc=1.6
```

Use `sc > sa` for elongated columns (like a crystal of quartz). Use `sc < sa` for flat platelet structures.

### Hexagonal lattice

Generates a 2D hexagonal grid (γ = 120°) tiled along the Z-axis. Uses axial coordinates for perfect hex packing.

```lua
KM.presetHexagonal(2, 2, 1.0)    -- 2 rings, 2 layers, 1.0 spacing
```

The resulting speaker distribution mirrors common higher-order Ambisonics dome layouts.

### Random crystal swarm

Scatters instances randomly within a sphere. Rate, offset direction, rotation, glide time, and interaction settings are all randomised.

```lua
KM.presetRandomSwarm(16, 3.0)    -- 16 instances, 3-unit spread radius
```

Re-triggering the preset re-seeds the random values for a new configuration.

---

## 13. Output and AmbiEncoder integration

### getOutputPositions()

Returns a flat table of `{x, y, z}` for every enabled instance. Use this to feed positions to an OSC sender:

```lua
local positions = KM.getOutputPositions()
for i, pos in ipairs(positions) do
  -- Send OSC to AmbiEncoder source i
  sendOSC("/icst/ambi/sourceindex/aed", i-1, pos.x, pos.y, pos.z)
end
```

{{< notice warning >}}
Kristall Motion outputs **Cartesian XYZ** coordinates, not AED (Azimuth/Elevation/Distance). Convert before sending OSC if your host expects AED. See the [ICST AmbiEncoder coordinate system](/icst-ambisonics-plugins/13_osc/) for the conversion formula.
{{< /notice >}}

### Automation writing

To write positions as REAPER automation, iterate over `getOutputPositions()` on each transport step and use REAPER's envelope API to insert points. See [Motion Map](/icst-ambisonics-plugins/15_icst_ambi_motion_map/) for the reference implementation using the writer script pattern.

---

## 14. Good practices

**Start sparse.** Begin with 4–8 instances rather than a full 64. Add instances incrementally once the basic motion is working.

**Match offset scale to room size.** If your speaker array spans roughly 2 units, keep offsets in the range ±1. Positions outside the array are still encoded but may lose spatial resolution.

**Use Bounds to contain a swarm.** Enable Bounds with `mirror` mode and a box matching your speaker layout to keep all sources audible at all times.

**Combine rotation orders.** Layer two instances at the same Start position with different rotation orders (e.g., XYZ and ZYX) to create intersecting arc trajectories.

**Rhythmic locking.** Enable **Time Quantize** for all instances in a swarm to lock all steps to the project BPM. Combine with Rate values of 1, 2, 4, or 8 (integer beat subdivisions) for rhythmic spatial patterns.

**Interaction as texture, not chaos.** Keep `Send Amount` ≤ 0.3 for subtle mutual perturbation. High send amounts with large radii can make the whole swarm collapse to a single point.

**Preset → tweak → duplicate.** Apply a built-in preset, select an interesting instance, adjust its parameters, then use **Duplicate** to create variations.

---

## 15. Troubleshooting

### Sources do not move after pressing Play

Check that `getTransportState()` returns `playing = true`. The update loop (`updateAllInstances`) exits immediately when the transport is stopped.

### All instances snap to the same position

The instances share the same `startX/Y/Z` and `offsetX/Y/Z`. Apply a preset (e.g., Cubic) to distribute them, or manually set unique Start positions.

### Positions drift far outside the speaker array

The repetition mode is set to **Infinite** with a non-zero offset. Either switch to **Finite** or **Pingpong**, or enable **Bounds** with a box matching your speaker layout.

### Smoothing produces no audible glide

Check that **Glide Time** is above zero and that the step actually advances (Rate must be > 0 and the transport must be running).

### Interaction makes all sources cluster together

Reduce **Send Amount** (try 0.1 – 0.2) and decrease **Interaction Radius** to limit the sphere of influence to immediate neighbours.

### Hexagonal preset produces too many instances

The number of cells in a hex grid grows quickly with `rings`: ring 0 = 1, ring 1 = 7, ring 2 = 19, ring 3 = 37. Keep `rings ≤ 3` or reduce layers to stay within MAX_INSTANCES (64).

### The host adapter functions do nothing

The default script ships with **stub functions**. You must replace the six functions in Section 3 with real host calls before the UI, transport state, and output will work.

---

## See also

- [ICST Ambi Motion Map](/icst-ambisonics-plugins/15_icst_ambi_motion_map/) — step-based 2D/3D motion shapes with a ready-made REAPER GUI
- [Motion Map Setup](/icst-ambisonics-plugins/16_motion_map_setup/) — installation guide for the Motion Map bundle
- [OSC Reference](/icst-ambisonics-plugins/13_osc/) — AmbiEncoder OSC address format and coordinate system
- [Downloads](/icst-ambisonics-plugins/08_downloads/) — all script downloads
