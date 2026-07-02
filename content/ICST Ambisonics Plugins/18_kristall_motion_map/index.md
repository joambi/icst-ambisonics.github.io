---
title: ICST Kristall Motion Map — User Guide
date: 2026-07-01T00:00:00
weight: 90
draft: false
toc: true
translationKey: kristall-motion-map
description: "Installation and user guide for JS_ICST_Kristall_Motion_Map.lua — a standalone REAPER script that moves up to 64 AmbiEncoder sources through a 3D crystal-lattice step sequencer with real-time GUI, OSC output, and named presets."
---

Level: Intermediate | Audience: Composer, sound designer, spatial-audio technician. | **Version: 0.2.0**

ICST Kristall Motion Map is a **standalone REAPER Lua script** with a real-time graphical interface. It arranges up to 64 AmbiEncoder sources as points in a 3D crystal lattice and moves them through space using a step sequencer. Motion can be monitored live via the isometric preview, sent to an AmbiEncoder via OSC, and shaped with per-instance transforms, quantization, smoothing, and interaction.

---

## 1. Requirements

- **REAPER** v6 or later (v7 recommended)
- **ICST AmbiEncoder_64** on the target track — see [Installation](/icst-ambisonics-plugins/02_installation/)
- **Python 3** with `python-osc` — required only for the live OSC preview bridge

---

## 2. Installation

### Step 1 — Download the bundle

Download **[ICST_Kristall_Motion_Map_Bundle.zip](/downloads/lua-scripts/ICST_Kristall_Motion_Map_Bundle.zip)** (also available on the [Downloads page](/icst-ambisonics-plugins/08_downloads/)). Unzip it anywhere on your computer — for example `~/REAPER/Scripts/ICST_Kristall_Motion_Map_Bundle/`.

The bundle contains:

- `scripts/JS_ICST_Kristall_Motion_Map.lua` — the main script
- `jsfx/JS_ICST_Kristall_Controller.jsfx` — optional MIDI/JSFX control surface
- `README.md` — quick-start instructions

### Step 2 — Load as a ReaScript

1. In REAPER, go to **Actions → Load ReaScript…**
2. Navigate to `JS_ICST_Kristall_Motion_Map.lua` and click **Open**.
3. REAPER adds the script to the Actions list. Run it once — the Kristall Motion Map window opens.

### Step 3 — Optional: launcher file

If you prefer to keep the script in a version-controlled folder, create a one-line launcher anywhere in your REAPER Scripts directory:

```lua
-- JS_ICST_Kristall_Motion_Map_Launcher.lua
dofile('/path/to/JS_ICST_Kristall_Motion_Map.lua')
```

Load this launcher as the ReaScript instead. To reload after editing the main script, close the Kristall window, then re-run the launcher action.

---

## 3. The interface at a glance

![ICST Kristall Motion Map in action — lattice preview with 8 cubic sources stepping through space](/images/kristall-demo.gif)

![ICST Kristall Motion Map — full window overview showing instance list, lattice preview, parameter panel, and status bar](/images/kristall-overview.png)

The window is divided into four areas:

![Status bar overview — all 5 rows annotated](/images/kristall-status-bar-overview.svg)

```
┌─────────────────┬──────────────────────────────────────┐
│  Instance list  │       Lattice preview (3D iso)        │
│                 ├──────────────────────────────────────┤
│  [+Add] [-Rem]  │         Parameter panel               │
│  [Dup]          │    (scrollable, per-instance)         │
├─────────────────┴──────────────────────────────────────┤
│  Status bar — Row 1: OSC · Preset                      │
│  Status bar — Row 2: Speed · BPM · Fwd/Rev · Pause · Stop │
│  Status bar — Row 3: Offset X Y Z · Move X Y Z        │
│  Status bar — Row 4: Rotate Pt · Yw · Rl              │
└────────────────────────────────────────────────────────┘
```

---

## 4. Instance list

The left panel lists all active instances. Each row shows the instance number, color dot, name, and current step count.

| Control | Action |
|---------|--------|
| Click a row | Select that instance; parameter panel updates |
| **+ Add** | Create a new instance with default settings |
| **− Rem** | Delete the selected instance |
| **Dup** | Duplicate the selected instance |
| Keyboard **A** | Add instance |
| Keyboard **D** | Duplicate selected |
| Keyboard **R** | Reset selected instance to step 0 |

{{< notice warning >}}
The maximum is **64 instances**. Adding beyond this limit has no effect.
{{< /notice >}}

---

## 5. Lattice preview

![Instance list (left) and isometric lattice preview with 8 cubic sources — selected instance highlighted](/images/kristall-instance-preview.png)

The top-right panel shows all enabled instances as colored dots in an isometric 3D projection. A unit-cube guide is drawn in the background.

| Interaction | Effect |
|-------------|--------|
| Drag a dot | Move the instance in the XY plane (updates Start X and Start Y) |
| Shift + drag | Move the instance along the Z axis (updates Start Z) |
| Hover | Shows instance name and a highlight ring |

Edges are drawn between any two instances within `EDGE_DIST` world units — this gives a quick visual of the lattice topology.

---

## 6. Parameter panel

The right column below the preview shows all parameters for the **selected instance**. Use the mouse wheel to scroll.

### Identity

| Parameter | Description |
|-----------|-------------|
| **Name** | Label shown in the instance list |
| **Enabled** | If unchecked, the instance is frozen and excluded from OSC output |

### Position

| Parameter | Description |
|-----------|-------------|
| **Start X / Y / Z** | World-space origin of this instance (drag in preview to set visually) |
| **Offset X / Y / Z** | Step vector — how far the source moves per step along each axis |

Each step, the raw position is computed as:

```
position = Start + currentStep × Offset
```

### Timing

| Parameter | Description |
|-----------|-------------|
| **Rate** | Steps per second (BPM OFF) or steps per beat (BPM ON) |
| **Steps** | Total step count; determines turn-around point for Finite and Pingpong |
| **Mode** | **Infinite** — steps forever; **Finite** — stops at last step; **Pingpong** — bounces |

### Rotation

Rotation pivots around the Start position using an Euler rotation matrix. Angles are in degrees.

| Parameter | Description |
|-----------|-------------|
| **Rot X / Y / Z** | Euler angles in degrees |
| **Order** | Application order: XYZ, XZY, YXZ, YZX, ZXY, ZYX |

### Scale

Scales the offset vector relative to the Start position.

| Parameter | Description |
|-----------|-------------|
| **Scale X / Y / Z** | Per-axis stretch factor |

### Bounds

Constrains the position to a box after rotation and scale.

| Parameter | Description |
|-----------|-------------|
| **Bounds On** | Enable bounds processing |
| **Mode** | **None**, **Clamp** (stop at edge), **Wrap** (teleport to opposite side), **Mirror** (reflect) |
| **Min / Max X / Y / Z** | Bounding box corners |

### Quantize

| Parameter | Description |
|-----------|-------------|
| **Space Q.** | Snap final position to a grid before smoothing |
| **Time Q.** | Snap step advances to beat subdivisions |
| **Grid X / Y / Z** | Grid cell size per axis (Space Q.) |

### Smoothing

An exponential-decay lerp between the stepped target position and the output:

```
alpha      = 1 − exp(−dt / glideTime)
currentPos = currentPos + alpha × (targetPos − currentPos)
```

| Parameter | Description |
|-----------|-------------|
| **Smoothing** | Enable/disable the filter |
| **Glide Time** | Time constant in seconds — 0.08 s is snappy, 0.5 s is slow |

### Interaction

![Parameter panel (lower sections) — Bounds, Quantize, Smoothing, and Interaction visible](/images/kristall-param-panel.png)

Instances can influence each other's speed and direction based on proximity.

| Parameter | Description |
|-----------|-------------|
| **Interaction** | Enable for this instance |
| **Send Amount** | How strongly this instance influences others |
| **Receive Amount** | How strongly this instance accepts incoming influence |
| **Radius** | Sphere of influence in world units |
| **Falloff Mode** | Linear / Inverse Square / Gaussian |
| **Affect Offset** | Incoming influence modifies the step direction |
| **Affect Rate** | Incoming influence modifies the step rate |

---

## 7. Status bar — Row 1: OSC and Presets

![Status bar — all four control rows and the eight preset buttons at the bottom](/images/kristall-status-bar.png)

### OSC

| Control | Description |
|---------|-------------|
| Colored dot | Green = connected, red = disconnected |
| **Host** field | IP address of the OSC target (default `127.0.0.1`) |
| **Port** field | UDP port of the OSC target (default `9001`) |
| **Connect / Disconnect** | Open or close the OSC bridge |
| **in: PORT** | Shown when connected — the UDP port on which the Kristall listens for incoming OSC messages (always `output port + 1`, e.g., `9002` when the output port is `9001`) |

Click any field to edit, then press **Enter** to confirm.

### Presets

| Control | Description |
|---------|-------------|
| Name field | Type a preset name |
| **▼** | Open the saved-preset dropdown |
| **Save** | Save all current instances under the preset name |
| **Reset** | Clear all instances and revert to the default Cubic preset |

Presets are stored in REAPER's ExtState (project-independent, persistent across sessions).

---

## 8. Status bar — Row 2: Playback controls

| Control | Description |
|---------|-------------|
| **Speed ×N.NN** | Global rate multiplier — scales all instance rates uniformly. Click to type a value, Enter to confirm. |
| **BPM** | Toggle BPM sync. Off = steps/second (absolute). On = steps/beat (follows REAPER tempo). |
| **\> Fwd / < Rev** | Global direction. Fwd = all instances step forward. Rev = all instances step in reverse. |
| **‖ Pause** | Freeze all motion at the current step. Click again to resume. |
| **■ Stop** | Reset all instances to step 0 and **pause** immediately (motion does not resume automatically). Click **‖ Pause** or restart to continue. |

### BPM mode in detail

When BPM is **OFF**: `Rate = 2` means the instance advances 2 steps every second, regardless of tempo.

When BPM is **ON**: `Rate = 1` means 1 step per quarter note. At 120 BPM this is 2 steps/sec; at 60 BPM it is 1 step/sec. An instance with 64 steps and Rate 1 completes one cycle every 64 quarter notes (16 bars in 4/4).

---

## 9. Status bar — Row 3: Global offset and movement

Row 3 contains six **scrubber sliders**, all with range −2.0 to +2.0.

### Offset X / Y / Z — Global translation

Shifts all instance positions uniformly **after** all per-instance transforms. Use this to place the entire crystal anywhere in the Ambisonics space without touching individual Start positions.

Example: `Offset X = 0.5` moves all sources 0.5 units to the right.

### Move X / Y / Z — Global movement direction

Adds a per-step offset to **all** instances on top of their own Offset X/Y/Z. Use this to make the entire crystal drift through space in a chosen direction.

Example: `Move X = 0.01` adds 0.01 units per step along X to every instance — the whole crystal drifts rightward. Combine `Move X = 0.007` and `Move Y = 0.007` for a diagonal drift.

{{< notice warning >}}
Offset and Move are **not saved in presets** — they are session-level controls intended for real-time performance.
{{< /notice >}}

---

## 10. Status bar — Row 4: Global rotation

Row 4 contains three **scrubber sliders** for rotating the entire crystal around the world origin, applied after all per-instance transforms and the global Offset. Angles are in degrees, range −180 to +180.

| Slider | Axis | Effect |
|--------|------|--------|
| **Pt** (Pitch) | X | Tilts the crystal forward / backward |
| **Yw** (Yaw) | Y | Spins the crystal left / right |
| **Rl** (Roll) | Z | Rolls the crystal clockwise / counter-clockwise |

Drag a slider horizontally or click it to type a value, then press **Enter** to confirm.

{{< notice warning >}}
Rotation acts on the final **effective position** of every instance. The lattice preview updates in real time even while playback is paused.
{{< /notice >}}

![Rotation axes — Pt tilts forward/backward, Yw spins left/right, Rl rolls CW/CCW](/images/kristall-rotation-axes.svg)

The rotation can also be controlled externally — see [§11 External control](#11-external-control--osc-input-and-midi).

---

## 11. External control — OSC input and MIDI

### OSC input

When the OSC bridge is connected (Connect clicked, status dot green), the Kristall **simultaneously listens** for incoming OSC messages on **`output port + 1`** (e.g., port `9002` when the output port is `9001`). The receive port is shown as **in: PORT** next to the Connect button.

Send any of these messages from TouchOSC, Max/MSP, OSSIA, SuperCollider, or any OSC-capable tool:

| OSC address | Arguments | Effect |
|-------------|-----------|--------|
| `/kristall/pitch` | `<float degrees>` | Set global Pitch (−180…+180) |
| `/kristall/yaw` | `<float degrees>` | Set global Yaw (−180…+180) |
| `/kristall/roll` | `<float degrees>` | Set global Roll (−180…+180) |
| `/kristall/rotate` | `<float pitch> <float yaw> <float roll>` | Set all three at once |

The values are applied immediately and override the on-screen sliders. Clipping to −180…+180 is applied automatically.

![OSC/MIDI signal flow — two input paths converging to global rotation](/images/kristall-osc-signal-flow.svg)

**Example** — rotate the crystal with TouchOSC:
1. Connect in the Kristall GUI (output port `9001`, target `127.0.0.1`).
2. In TouchOSC, set the OSC target to `127.0.0.1:9002`.
3. Assign a fader to `/kristall/yaw`, range −180 to +180.
4. Moving the fader spins the crystal in real time.

### MIDI via JSFX controller bridge

If a **Kristall Controller** JSFX is present on any track, the Kristall script reads its parameters automatically:

| JSFX slider | Parameter index | Range | Effect |
|-------------|-----------------|-------|--------|
| slider6 | 5 | −180…+180° | Global Pitch |
| slider7 | 6 | −180…+180° | Global Yaw |
| slider8 | 7 | −180…+180° | Global Roll |

Map MIDI CCs to these sliders in REAPER's FX parameter lane or via the MIDI Learn dialog. A MIDI CC sweep from 0 to 127 maps linearly to −180° to +180°. The sliders are read every frame as long as the JSFX is present on any track.

{{< notice warning >}}
JSFX Pitch/Yaw/Roll take effect **only when at least one of the three is non-zero**. If all three are 0 (or the JSFX does not expose these sliders), the on-screen sliders retain their values.
{{< /notice >}}

---

## 12. Built-in presets (quick-select)

![Preset layouts — top-view dot patterns for all 8 presets](/images/kristall-preset-layouts.svg)

Eight preset buttons appear at the very bottom of the window. Each clears all current instances and places new ones. Buttons 1–4 (teal) are abstract motion layouts; buttons 5–8 (amber) are crystallographic unit-cell shapes.

| # | Preset | What it creates |
|---|--------|-----------------|
| 1 | **Cubic** | 8 instances at the corners of a unit cube (−0.5 to +0.5 on all axes) |
| 2 | **Tetragonal** | Grid with equal XY spacing and different Z spacing |
| 3 | **Hexagonal** | 2D hexagonal ring tiled along Z (mirrors typical dome layouts) |
| 4 | **Rnd.Swarm** | 20 instances scattered randomly within a sphere |
| 5 | **Orthorhombic** | Unit cell with three unequal orthogonal axes (α=β=γ=90°) |
| 6 | **Rhombohedral** | Unit cell with equal axes and equal non-orthogonal angles (α=β=γ≠90°) |
| 7 | **Monoclinic** | Unit cell with one inclined axis (α=γ=90°, β≠90°) |
| 8 | **Triclinic** | Unit cell with no equal axes and no right angles — maximum asymmetry |

---

## 13. First session walkthrough

### Step 1 — Apply a preset

Click **Cubic** in the status bar. Eight instances appear in the lattice preview, one at each corner of a cube.

### Step 2 — Start motion

Set Speed to `×1.00`, make sure BPM is off. The instances are moving — watch the step counters in the instance list increment.

### Step 3 — Adjust direction

In the parameter panel, select instance 1. Set **Offset X = 0.02**, **Offset Y = 0.01**, **Offset Z = 0**. This instance now drifts diagonally in XY.

### Step 4 — Bounce with Pingpong

Set **Mode = Pingpong** and **Steps = 64**. The source travels 64 steps out and bounces back. Repeat for other instances with different offsets.

### Step 5 — Add global drift

Drag the **Move X** slider in Row 3 slightly to the right (e.g., `0.008`). The entire crystal now drifts rightward while individual instances still bounce within it.

### Step 6 — Rotate the crystal

Drag the **Yw** (Yaw) slider in Row 4 to spin the whole crystal around the vertical axis. Combine **Pt** and **Rl** for compound orientations. The lattice preview updates in real time.

### Step 7 — Connect OSC

Enter your AmbiEncoder host and port in Row 1, then click **Connect**. Positions are streamed as OSC messages to the encoder in real time. After connecting, **in: 9002** appears — this is the port for incoming rotation control (see [§11](#11-external-control--osc-input-and-midi)).

---

## 14. Troubleshooting

**Sources do not move.**
Check that Speed > 0 and that the instance is Enabled. In BPM mode, REAPER transport must be running.

**All instances are at the same position.**
Apply a preset (e.g., Cubic) to distribute them, or set unique Start positions manually.

**Positions drift outside the speaker array.**
Mode is set to Infinite with a non-zero Offset. Switch to Pingpong, or enable Bounds with Mirror mode.

**Move slider changes are too coarse.**
Drag slowly — the slider covers the full −2 to +2 range. For fine control, click the slider to enter a numeric value, then press Enter.

**OSC not connecting.**
Verify that the Python OSC bridge is running (`python-osc` required). Check host IP and port. The status dot turns green on a successful connection.

**OSC input (rotation) has no effect.**
The OSC bridge must be connected first (output port active). Check that your controller is sending to `output port + 1` (default: `9002`), not `9001`. Confirm the messages arrive with a UDP monitor (e.g., Protokol).

**Stop button does not pause — it starts playing.**
This was a bug in v0.1.0, fixed in v0.2.0. Update to the latest script.

---

## See also

- [ICST Ambi Motion Map](/icst-ambisonics-plugins/15_icst_ambi_motion_map/) — step-based 2D/3D motion shapes
- [OSC Reference](/icst-ambisonics-plugins/13_osc/) — AmbiEncoder OSC format and coordinate system
- [Downloads](/icst-ambisonics-plugins/08_downloads/) — script downloads
