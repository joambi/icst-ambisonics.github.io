# ICST Ambi Motion Markers Handbook

## Overview

`ICST Ambi Motion Markers` is a REAPER-based workflow for defining ambisonic
movements with timeline markers, previewing them over OSC, and optionally
recording them as AmbiEncoder automation.

The system is built around:

- `Scripts/JS_Ambi_Motion_Marker_GUI.lua`
- `Scripts/JS_Import_Ambi_Markers_From_CSV.lua`
- `OSC/reaper_marker_ambi_motion.py`

Typical use cases:

- sketching spatial trajectories with timeline markers
- previewing ambisonic motion without recording
- recording spatial motion as plugin automation
- importing cue sets from CSV instead of typing marker text by hand

## Requirements

### REAPER

- REAPER installed and working
- REAPER ReaScript enabled
- REAPER Web Browser Control enabled if you use OSC bridge workflows elsewhere

### Python

The GUI uses a Python worker:

- Python 3
- `python-osc`

Install with:

```bash
pip install python-osc
```

### ICST Plugin

The workflow is designed for the ICST Ambisonics plugin family, especially:

- `AmbiEncoder_64`

Make sure:

- the plugin is inserted on the target track
- OSC input is enabled in the plugin
- the OSC port matches the GUI setting, typically `50001`

## Installation

### 1. Copy or keep the repository

Keep the repository in a stable location, for example:

```text
/Users/yourname/GitHub/Reaper_Scripts_JS
```

### 2. Import the main GUI script into REAPER

Import this script as a ReaScript action:

```text
Scripts/JS_Ambi_Motion_Marker_GUI.lua
```

Optional but recommended:

```text
Scripts/JS_Import_Ambi_Markers_From_CSV.lua
```

### 3. Set Python path in the GUI

In the GUI, make sure the `Python` field points to your Python interpreter.

Example:

```text
/Users/yourname/.pyenv/versions/3.11.8/bin/python3
```

### 4. Verify OSC connection

In the plugin:

- enable OSC input
- set the OSC port to the same value as in the GUI

Default:

```text
50001
```

### 5. Optional: prepare CSV templates

Example CSV files are included:

- [Scripts/examples/ambi_markers_aed_example.csv](/Users/jschuet1/GitHub/Reaper_Scripts_JS/Scripts/examples/ambi_markers_aed_example.csv)
- [Scripts/examples/ambi_markers_xyz_example.csv](/Users/jschuet1/GitHub/Reaper_Scripts_JS/Scripts/examples/ambi_markers_xyz_example.csv)

## Main GUI

The main GUI provides:

- OSC host and port
- steps per second
- marker tolerance
- stop tail
- interpolation curve
- preview and record controls
- marker list with start/end selection
- direct CSV import

### Key buttons

- `Send pair`
  Sends only the currently selected start/end pair over OSC.

- `Send series`
  Sends the series from current `S` marker to the last marker in the list.

- `Record pair`
  Records the selected pair as automation.

- `Record series`
  Records the same series range as `Send series`, but writes automation.

- `Load CSV`
  Imports marker cues from a CSV file directly from the GUI.

- `Set Selection`
  Sets the REAPER time selection between the selected `S` and `E` markers.

## Marker Workflow

### Manual marker format

Markers can still be entered directly as text:

```text
ambi 1 a=-45 e=0 d=0.8
ambi 2 a=20 e=0 d=0.7
```

Multiple sources can be written in one marker:

```text
ambi 1 a=-45 e=0 d=0.8 | ambi 2 a=20 e=0 d=0.7
```

### Start and end markers

Inside the marker list:

- click left half of a row to set `S`
- click right half of a row to set `E`

Then click:

- `Set Selection`

This defines the time range used by preview or recording.

## CSV-first Workflow

For larger cue sets, CSV is the recommended workflow.

### Supported CSV formats

#### AED format

```csv
time,index,source,azimuth,elevation,distance
1.2,1,1,-45,0,0.8
1.2,1,2,20,0,0.7
9.2,2,1,45,20,0.5
9.2,2,2,90,0,0.2
```

#### XYZ format

```csv
time,index,source,x,y,z
1.2,1,1,-0.566,0.566,0.000
1.2,1,2,0.239,0.658,0.000
```

#### Legacy marker export format

```csv
#,Name,Start
M1,"ambi 1 a=-45 e=0 d=0.8
ambi 2 a=20 e=0 d=0.7",1.2.00000000
```

### How `Load CSV` works

1. Click `Load CSV`
2. Choose a file
3. Matching markers in the project are replaced automatically
4. The marker list updates immediately

### CSV rules

- `time` is in seconds
- `index` is the REAPER marker number
- rows with same `time` and `index` are merged into one marker
- `source` defaults to `1` if omitted
- decimals must use `.`

## Preview Workflow

### Send pair

Use `Send pair` when:

- you want to preview one single movement
- you are working on one segment only

Workflow:

1. Set `S`
2. Set `E`
3. Click `Set Selection`
4. Click `Send pair`

### Send series

Use `Send series` when:

- you want to preview a whole sequence
- you want to start at the current `S` marker and continue to the last marker

Workflow:

1. Set `S`
2. Click `Send series`

Notes:

- the end of the series is automatically the last marker
- `Send series` and `Record series` use the same range logic

## Recording Workflow

### Record pair

Use when you want automation for one segment only.

Workflow:

1. Select the AmbiEncoder track
2. Set `S`
3. Set `E`
4. Click `Set Selection`
5. Click `Record pair`

### Record series

Use when you want automation for a full marker sequence.

Workflow:

1. Select the AmbiEncoder track
2. Set the current `S` marker
3. Click `Record series`

Behavior:

- recording starts at current `S`
- recording ends at the last marker
- automation is written for all segments in between

## Good Practices

### 1. Prefer CSV for structured work

Use CSV when:

- you have more than a few markers
- you repeat similar cue sets
- you want versionable, editable motion data

### 2. Keep marker indices stable

Good:

```csv
1.2,1,...
9.2,2,...
21.1,3,...
```

This makes replacement and revision easier.

### 3. Use one source per CSV row

Do not combine multiple sources in one CSV row.
Use one line per source and let the importer merge them.

### 4. Build in pairs first, then series

Recommended order:

1. test with `Send pair`
2. verify motion in the plugin
3. then use `Send series`
4. then use `Record series`

### 5. Keep start and end cues musically meaningful

Avoid overly dense markers unless needed.
Clear cue positions make motion easier to debug.

### 6. Use `Console ON/OFF`

If you need less noise during work:

- switch console output off

If you debug import or OSC behavior:

- switch console output on

### 7. Use marker names only for human readability

For larger projects, the CSV should be the source of truth.
Imported markers can be regenerated at any time.

### 8. Preview before recording

Always preview first when:

- importing new CSV data
- changing source counts
- changing interpolation curve
- adjusting marker tolerance

## Troubleshooting

### No movement in plugin

Check:

- OSC input enabled in plugin
- matching OSC port
- correct start/end markers
- markers actually contain different positions

### `Send series` seems identical to `Send pair`

Usually this means:

- only one segment is inside the selected range
- or start marker is already close to the end of the list

### `Record series` stops immediately

This was previously caused by transport startup timing.
The current version includes a startup grace period, but if issues remain:

- verify the target track is selected
- verify time selection is valid
- verify Python worker starts correctly

### CSV import fails

Check:

- header spelling
- decimal points
- valid times
- valid marker indices
- one source per row

## Recommended Workflow Summary

### Fast manual workflow

1. place markers
2. choose `S` and `E`
3. `Send pair`
4. `Record pair`

### Recommended production workflow

1. create or edit CSV
2. `Load CSV`
3. verify marker list
4. `Send pair` for testing
5. `Send series` for sequence preview
6. `Record series` for final automation

## Files

Main GUI:

- [Scripts/JS_Ambi_Motion_Marker_GUI.lua](/Users/jschuet1/GitHub/Reaper_Scripts_JS/Scripts/JS_Ambi_Motion_Marker_GUI.lua)

CSV import:

- [Scripts/JS_Import_Ambi_Markers_From_CSV.lua](/Users/jschuet1/GitHub/Reaper_Scripts_JS/Scripts/JS_Import_Ambi_Markers_From_CSV.lua)

Example CSV files:

- [Scripts/examples/ambi_markers_aed_example.csv](/Users/jschuet1/GitHub/Reaper_Scripts_JS/Scripts/examples/ambi_markers_aed_example.csv)
- [Scripts/examples/ambi_markers_xyz_example.csv](/Users/jschuet1/GitHub/Reaper_Scripts_JS/Scripts/examples/ambi_markers_xyz_example.csv)

OSC worker:

- [OSC/reaper_marker_ambi_motion.py](/Users/jschuet1/GitHub/Reaper_Scripts_JS/OSC/reaper_marker_ambi_motion.py)
