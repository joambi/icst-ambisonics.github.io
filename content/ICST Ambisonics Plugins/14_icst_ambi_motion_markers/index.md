---
title: ICST Ambi Motion Markers
date: 2026-06-21T00:00:00
weight: 85
draft: false
description: "Marker-based OSC preview and automation recording workflow for ICST AmbiEncoder in REAPER, including CSV-first cue import and good practices."
---

Level: Intermediate | Audience: Composer, sound designer, spatial-audio technician, student.

Use this page when you want to define AmbiEncoder movements with REAPER markers, preview them over OSC, and record them as automation.

## What it does

`ICST Ambi Motion Markers` is a REAPER workflow built around timeline markers.

It lets you:

- define source positions as marker cues
- preview one pair or a whole series over OSC
- record the same movement path as AmbiEncoder automation
- import cue sets from CSV instead of typing marker text manually

Core files:

- `JS_Ambi_Motion_Marker_GUI.lua`
- `JS_Import_Ambi_Markers_From_CSV.lua`
- `reaper_marker_ambi_motion.py`

![ICST Ambi Motion Marker GUI with four markers loaded](/motion-markers/gui-overview.gif)

## Installation

### 1. Add the scripts to REAPER

Import these ReaScripts:

- `Scripts/JS_Ambi_Motion_Marker_GUI.lua`
- `Scripts/JS_Import_Ambi_Markers_From_CSV.lua`

### 2. Install Python dependency

The GUI launches `reaper_marker_ambi_motion.py` as a background worker to send OSC commands.

**Place the file** anywhere on disk — a common choice is alongside the Lua scripts:

```text
Scripts/reaper_marker_ambi_motion.py
```

**Install the required package:**

```bash
pip install python-osc
```

**Set the Python executable path** in the GUI (`Python` field):

```text
/Users/yourname/.pyenv/versions/3.11.8/bin/python3
```

Use `which python3` in a terminal to find the correct path on your system. The GUI passes `reaper_marker_ambi_motion.py` and OSC parameters to this executable at runtime — no manual launch needed.

### 3. Configure the ICST plugin

Insert `AmbiEncoder_64` on the target track and enable OSC input.

Make sure the plugin OSC port matches the GUI setting.

Typical default:

```text
50001
```

## Marker workflow

Markers can be entered manually in this form:

```text
ambi 1 a=-45 e=0 d=0.8
ambi 2 a=20 e=0 d=0.7
```

Multiple sources at one cue time can be combined in one marker:

```text
ambi 1 a=-45 e=0 d=0.8 | ambi 2 a=20 e=0 d=0.7
```

In the marker list:

- click left side of a row to set `S`
- click right side of a row to set `E`
- click `Set Selection` to create the REAPER time range

![S/E selection active with console output visible](/motion-markers/se-selection-console.gif)

## CSV-first workflow

For larger projects, CSV import is the recommended method.

### Supported format: azimuth/elevation/distance

```csv
time,index,source,azimuth,elevation,distance
1.2,1,1,-45,0,0.8
1.2,1,2,20,0,0.7
9.2,2,1,45,20,0.5
9.2,2,2,90,0,0.2
```

### Supported format: x/y/z

```csv
time,index,source,x,y,z
1.2,1,1,-0.566,0.566,0.000
1.2,1,2,0.239,0.658,0.000
```

### Import in the GUI

Use `Load CSV` in the marker panel:

1. click `Load CSV`
2. choose a CSV file
3. matching markers in the project are replaced automatically

![Import Ambi Markers From CSV dialog](/motion-markers/csv-import-dialog.png)

Example CSV files:

- `ambi_markers_aed_example.csv`
- `ambi_markers_xyz_example.csv`

## Main controls

### Send pair

Sends the currently selected `S -> E` pair over OSC.

Use this to test one movement segment.

![Send pair workflow — console output after motion playback](/motion-markers/opt_workflow-03.gif)

### Send series

Sends a whole marker series from the current `S` marker to the last marker in the list.

Use this when you want to preview a complete phrase or scene.

### Record pair

Records the selected pair as AmbiEncoder automation.

### Record series

Uses the same range logic as `Send series`, but writes automation while the movement is played.

## Step-by-step test workflow

### Test 1: single pair preview

1. load the GUI
2. set `S` and `E`
3. click `Set Selection`
4. click `Send pair`
5. verify the source moves in the ICST plugin

Expected result:

- preview cursor moves
- OSC motion is visible
- no automation is written

### Test 2: series preview

1. set `S` on the first marker you want
2. click `Send series`
3. verify playback continues segment by segment until the last marker

Expected result:

- all segments after `S` are played
- the end of the series is the last marker

### Test 3: pair recording

1. select the AmbiEncoder track
2. choose `S` and `E`
3. click `Record pair`
4. verify automation is written

Expected result:

- transport runs
- plugin moves
- automation lanes receive data

### Test 4: series recording

1. select the AmbiEncoder track
2. set the desired `S`
3. click `Record series`
4. verify the same series path as `Send series` is recorded

Expected result:

- transport runs through the complete series
- movement matches `Send series`
- automation is written for each segment

## Good practices

- use CSV as the source of truth for larger cue sets
- preview with `Send pair` before recording
- keep marker indices stable across revisions
- use one source per CSV row
- keep start and end cues musically meaningful
- enable console output when debugging, disable it during performance work

## Troubleshooting

### "No markers or regions with 'ambi...' found"

The marker list is empty. Add markers manually or run `Load CSV` to import them. Make sure each marker name starts with `ambi` (case-sensitive).

### No motion in the plugin

Check:

- OSC input enabled in the plugin
- correct OSC port
- marker positions differ between start and end

### `Send series` looks like `Send pair`

Usually this means there is only one segment left between the current `S` marker and the last marker.

### CSV import fails

Check:

- header names
- decimal points
- one source per row
- valid times and indices

## Downloads

Use the prepared bundle for the workflow:

- [Download ICST Ambi Motion Markers Bundle](https://github.com/joambi/icst_ambisonics/raw/main/Scripts/bundles/ICST_Ambi_Motion_Markers_Bundle.zip)
- [Browse bundle contents on GitHub](https://github.com/joambi/icst_ambisonics/tree/main/Scripts/bundles/ICST_Ambi_Motion_Markers_Bundle)

Recommended bundle contents:

- GUI script
- CSV import script
- Python OSC worker
- example CSV files
- handbook
