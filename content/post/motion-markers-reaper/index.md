---
title: "Motion Markers – steer movement with REAPER markers"
description: "Step-by-step guide: set Ambi markers in REAPER, send movement between two markers to the AmbiEncoder via OSC and record it as automation."
date: 2026-11-12
slug: motion-markers-reaper
translationKey: motion-markers-reaper
year: 2026
month: 2026-11
weight: 5
tags: ["motion-markers", "ambiencoder", "automation", "osc", "reaper", "lua"]
key_points:
  - "Use markers as start and end points of a movement, in time with the music"
  - "Preview movement live via OSC and record it as automation on the AmbiEncoder track"
  - "Fix typical problems (python-osc, Ambi host, web interface) yourself"
difficulty: "intermediate"
kind: "tutorial"
tool: ["AmbiEncoder", "Lua", "OSC"]
---

Level: Intermediate | **Audience:** Composers, sound designers, spatial audio engineers.

**JS Ambi Motion Markers** lets you define movement directly on the REAPER timeline: two markers set start and end, the script calculates the path in between, sends it to the ICST AmbiEncoder via OSC and, if you want, writes it as automation. This fits movements that are **musically timed**, tied to cues, bar positions or edits. For freely drawn figures across many sources, the [Motion Map](/icst-ambisonics-plugins/15_icst_ambi_motion_map/) is the better tool.

The script is part of the [ICST Ambi REAPER Bundle](/ecosystem/) and is also available as a separate [Motion Markers package](/downloads/ICST_Ambi_Motion_Markers_Bundle.zip). The full reference is on the [ICST Ambi Motion Markers](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) page.

## 1. One-time preparation

1. Install **Python 3 and python-osc** (Terminal): `python3 -m pip install python-osc`
2. Enable the **REAPER web interface**, only needed for "Record": Preferences (Cmd+,) → Control/OSC/web → Add → *Web browser interface* → port **8080**.
3. Create a track with the **ICST AmbiEncoder**. Its OSC In must be set to port **50001** (host `127.0.0.1`).

## 2. Set markers

Name markers or project markers using this pattern:

`ambi <index> a=<azimuth> e=<elevation> d=<distance>`

Example: `ambi 1 a=-45 e=0 d=0.8`. Alternatively import a CSV file with the toolbar icon *Import Ambi Markers From CSV* (examples are in the `examples/` folder).

## 3. Start the GUI

Click the toolbar icon *Motion Markers* or run `JS_Ambi_Motion_Marker_GUI.lua` from the Actions list. If an instance is already running, choose **Terminate instances** in the dialog and start again.

## 4. Check the fields

| Field | Value |
|---|---|
| Ambi host | `127.0.0.1` (no spaces!) |
| Ambi port | `50001` |
| Steps/sec | `40` |
| Python | leave empty (auto-detect), otherwise the full path |

## 5. Choose a marker pair

- In the **Ambi Markers** list, left-click sets the start (S) and right-click sets the end (E). You can also step through pairs with **< Pair / Pair >**.
- **Set Selection** sets the time selection between S and E. Duration, start and end are shown below.
- Then choose the curve, for example Smoothstep or Linear.

## 6. Send or record

- **Send pair:** sends the movement live via OSC to the AmbiEncoder; the cursor follows.
- **Send series:** all pairs one after the other.
- **Record pair / Record series:** writes the movement as automation on the AmbiEncoder track (needs the web interface on port 8080).
- **Stop transport:** aborts.

A good routine: preview with *Send* first and adjust the curve, then commit with *Record*.

## If something does not work

| Message / symptom | Fix |
|---|---|
| `No module named 'pythonosc'` | `python3 -m pip install python-osc`, then restart the script (Terminate instances) |
| `[Errno 8] nodename nor servname` | Remove spaces from the *Ambi host* field |
| Record does nothing | Enable the web interface on port 8080 |
| No movement audible | Check AmbiEncoder OSC In is 50001 and the track is not muted |
| Old messages remain | End the script (Terminate instances) and restart |

Turn **Console ON** to see messages in the ReaScript console window.

## Further reading

- [ICST Ambi Motion Markers](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/): full reference
- [Motion Map](/icst-ambisonics-plugins/15_icst_ambi_motion_map/): motion figures for many sources
- [OSC syntax for the AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
