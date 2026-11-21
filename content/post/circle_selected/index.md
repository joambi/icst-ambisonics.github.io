---
title: ICST AmbiEncoder – CircleSelected
description: "Describes the CircleSelected Lua presets for ICST AmbiEncoder to position, rotate, and save source points and recall presets."
date: 2025-07-19T13:28:00
slug: circle-selected
aliases:
  - /post/circle_selected/
  - /post/circleselected/
year: 2025
month: 2025-07
weight: 9
tags: ["ambiencoder", "lua", "reaper", "automation", "presets"]
key_points:
  - "Position sources on a circle using CircleSelected Lua presets in REAPER"
  - "Save, recall, and manage source position presets interactively"
difficulty: "intermediate"
post_kind: "tutorial"
tool: ["AmbiEncoder", "Lua"]
---

## ICST_AmbiEncoder_64_CircleSelected_Lua-Presets

Level: Intermediate | **Audience:** Reaper power user, Performance artist.

## 📃 User documentation
**Script:** `ICST_AmbiEncoder_64_CircleSelected_Presets.lua`  
**Function:** Select points of the ICST AmbiEncoder_64 plugin graphically, arrange them in a circle, move them (rotation/random walk) and save/load them as presets.

<video autoplay muted loop playsinline preload="metadata" poster="Circle_Selected-poster.jpg" aria-label="circleselected" style="max-width:100%;height:auto"><source src="Circle_Selected.mp4" type="video/mp4"></video>

---

## 🚀 Installation

1. **Save the file**  
   Put the file `ICST_AmbiEncoder_64_CircleSelected_Presets.lua` into your REAPER scripts folder:  
   ```
   /Users/<name>/Library/Application Support/REAPER/Scripts/ICST_AMBI/
   ```

2. **Register in REAPER**  
   - Open REAPER → `Actions` → `Show Action List...`  
   - Click `ReaScript: Load...`  
   - Select the file and confirm.  
   - The script is now available as an action.

3. **Load the AmbiEncoder**  
   - Put the plugin `AmbiEncoder_64 (ICST)` on a track and select the track.  
   - Start the script from the Action List.

---

## 🖥️ GUI elements & operation

### ✅ Select points
- All 64 points appear as checkboxes.
- Enable only the points you want to control.
- Buttons:
  - **Select all**
  - **Deselect all**

---

### 🔄 Set circle offsets
- **Circle radius:** distance of the points from the centre.
- **Number of points:** number of points on the circle.
- **Start angle:** rotates the circle.
- **Clockwise:** reverses the order.
- **Angle spacing:** scales the angle between the points.
- **Distance increment:** each following point can sit further out.

**Apply circle:** 👉 applies the parameters to the enabled points.

---

### 💾 Preset management
- **Preset name:** input field for the name.
- **Save preset:** saves the current circle parameters in
  `REAPER/ResourcePath/AmbiPresets/`.
- **Select preset:** dropdown with all existing presets.
- **Load preset:** applies the saved values.

---

### 📤 Export/import points
- **Export points:** saves the current selection to `points_export.txt` in the REAPER resource path.
- **Import points:** loads a saved selection via a dialog.

---

### ⚙️ Movement
- **Rotation speed:** revolutions per second.
- **RandomWalk speed:** step size of the random movement.
- **Random range:** maximum movement radius.
- **Z axis:** also move points in Z.
- **Start movement / Stop movement:** starts or stops the animation.

> On start, the current positions are taken as the base.

---

## 🎨 Visualisation
- The window shows a real-time display:
  - White dots = current positions of the selected points.
  - Lines connect the points in order.
  - Blue circle = maximum movement radius (random range).

---

## 📁 Storage locations
- **Preset files:** `REAPER/ResourcePath/AmbiPresets/<presetname>.txt`
- **Exported point sets:** `REAPER/ResourcePath/points_export.txt`

---

## ✨ Tips & notes
- Select only the points you need → clearer and lighter on resources.
- Save different presets (small radius, large radius, etc.).
- Preset files are plain text files and can also be edited externally.

---

## 🔧 Requirements
- REAPER with an active `ICST AmbiEncoder_64 (VST3)`
- ReaPack with ReaImGui installed:
  - `Extensions → ReaPack → Browse Packages → ReaImGui`
- REAPER 6.x or higher recommended.

---

## 🏷️ Version & author
- **Version:** July 2025
- **Author:** Johannes Schütt & Reaper assistant ✨
- **Features:** presets, export/import, visualisation, selectable points


