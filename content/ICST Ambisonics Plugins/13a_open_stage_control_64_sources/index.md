---
title: "User Guide: 64 Sources with open-stage-control and ICST AmbiEncoder_64"
date: 2026-08-19T00:00:00
weight: 121
draft: false
toc: true
description: "User guide for controlling 64 sources with open-stage-control and the ICST AmbiEncoder_64 in REAPER."
---

Level: Intermediate | Audience: Composer, technician, student, live-electronics user.

{{< figure
  src="ICST-AmbiPlugin_Open-Stage-control.jpeg"
  alt="open-stage-control with ICST AmbiEncoder_64"
  caption="open-stage-control session for controlling 64 sources with the ICST AmbiEncoder_64."
>}}

This user guide describes the current `XYZ` session for `open-stage-control` in combination with the `ICST AmbiEncoder_64`.

Download:

- [64-source-points-tablet-xyz.session.json](/icst-ambisonics-plugins/13a_open_stage_control_64_sources/64-source-points-tablet-xyz.session.json)

The session controls the sources in Cartesian `XYZ` and is built for working directly with the plugin radar:

- top = front
- right = right
- `+X` points right
- `+Y` points forward

The left fader controls `Z` (height, `-1..1`) instead of `Distance`. Pad and plugin radar therefore correspond directly in this session.

The session sends ICST-compatible OSC to the `AmbiEncoder_64`:

- `/icst/ambi/sourceindex/xyz [Index] [X] [Y] [Z]`
- `/icst/ambi/sourceindex/gain [Index] [Gain]`

The source index is 1-based. The gain fader displays dB; a linear factor is sent (see [7. Troubleshooting](#7-troubleshooting)).

## 1. Prepare REAPER and the AmbiEncoder_64

1. Open your REAPER project or create a new one.
2. Create a track for the encoder and insert `ICST AmbiEncoder_64` as an FX.
3. Make sure the track has enough channels (`Track Routing` > `Track channels`); otherwise the 64-source encoder will not work fully.
4. Open the plugin window of the `AmbiEncoder_64`.
5. Open the OSC section in the plugin and enable `OSC In` (`Receive`).
6. Note the receive port set there. The usual default in the ICST tutorials is `50001`, but what counts is the port actually set in the plugin.
7. Keep the plugin window open for the first test so you can see whether the sources move.

## 2. Start open-stage-control

1. Start `open-stage-control`. The launcher opens first.
2. In the launcher, enter the OSC target under `send`:

   - REAPER on the same computer: `127.0.0.1:50001`
   - REAPER on another computer: `IP-of-the-REAPER-computer:50001`
   - If necessary: use the port from part 1

3. Under `Port`, enter the HTTP port for the user interface, for example `8080`.
4. Click `Start`. The empty interface opens in the browser or app window.
5. Load the session via `Menu` > `Session` > `Open` and choose `64-source-points-tablet-xyz.session.json`. Alternatively, drag and drop the file into the window.

{{< figure
  src="open-stage-control-setup.png"
  alt="open-stage-control launcher with send target 127.0.0.1:50001 and port 8080"
  caption="Example launcher settings in open-stage-control: OSC target set to the AmbiEncoder port, and the HTTP port for the user interface."
>}}

## 3. Connect the tablet

1. Connect the tablet to the same network as the computer running `open-stage-control`.
2. Find out the IP address of that computer.

   - macOS: `System Settings` > `Network`
   - or in Terminal: `ipconfig getifaddr en0`

3. On the tablet, open a browser and go to `http://IP-of-the-computer:8080`. If you set a different HTTP port, use that one.
4. The interface appears in the browser. For full screen on the iPad: add the page via `Share` > `Add to Home Screen` and start it from there.
5. Important: the tablet only talks to `open-stage-control`. The OSC to REAPER is sent by the computer running `open-stage-control`.

## 4. First function test

1. In the interface, go to the `Select + Focus` tab.
2. Press the blue button `Alle 64 senden (Sync)` (send all 64) at the bottom right.

   This button sends all positions and gains to the plugin once. Afterwards, interface and plugin show the same state. This is the first step after every start of `open-stage-control`.

3. Tap `S1` in the grid on the left. The button turns orange, and `Source 1` appears on the right.
4. Move the point in the large `XY` pad.
5. Look at the plugin window of the `AmbiEncoder_64`: source 1 must move along.
6. Then move the `Z` and `Gain dB` faders and check the response in the plugin.
7. If that works, try a bank tab such as `S1-8` and move several points there at the same time.

Note on the display: in this session the pad is a top view in `XYZ`. It therefore corresponds directly to the plugin radar.

If nothing moves in step 4, see [7. Troubleshooting](#7-troubleshooting).

## 5. Operation overview

### Tab `Select + Focus`

1. Select a source: tap the desired button in the `8x8` grid on the left. The active source is marked orange.
2. Set the position: move the point in the large pad on the right. The session works in Cartesian `X/Y`.
3. Set `Z (-1..1)` and `Gain (dB) (-60..+12)` with the two horizontal faders. Both faders have a number field for precise input.
4. Rename: tap the text field at the top right, type the name and confirm. The name appears on the grid button immediately. Without a custom name the button shows `S1` to `S64`.

### Bank tabs `S1-8` to `S57-64`

1. Open the tab of the desired group.
2. In the large multi-XY pad you can move single or several points at the same time (`multitouch`).
3. Each point sends its `XYZ` message immediately.
4. The sources are evenly arranged in the pad, so you can see at once which point belongs to which source.

## 6. Saving

1. Positions and names change during the session. To keep the state, choose `Menu` > `Session` > `Save` or `Save As` in `open-stage-control`, ideally under a new name.
2. The settings of the `AmbiEncoder_64`, including the last received positions, are saved as usual with the REAPER project (`Cmd+S`).

## 7. Troubleshooting

### Nothing arrives in the plugin

1. Is `OSC In` really enabled in the `AmbiEncoder_64`?
2. Do host and port in the `send` settings of `open-stage-control` exactly match the plugin?
3. Is a firewall blocking incoming UDP packets on the REAPER computer?
4. Is a second instance of `open-stage-control` without a send target running by mistake?

### The tablet cannot find the interface

1. Are tablet and computer on the same network?
2. Do IP address and HTTP port in the browser address match?
3. Use `http://`, not `https://`.
4. Allow incoming connections for `open-stage-control` in the firewall.

### The wrong source moves

1. The source index is 1-based: `S1` in the interface corresponds to source 1 in the plugin.
2. Check that the desired source is actually marked orange in the grid.

### Movements stutter over the network

1. Check the Wi-Fi quality.
2. Connect the computer by cable if needed.
3. Take other devices with heavy traffic off the Wi-Fi.

### Plugin and interface show different positions

1. `open-stage-control` sends nothing by itself at startup. Press `Alle 64 senden (Sync)` once after every start.

### Plugin reports `Unknown OSC message received`

1. An outdated copy of the session is running, for example from `~/Downloads`.
2. Use only the current session file from this page.
3. Restart `open-stage-control` after changing the file. Running sessions do not reload changes automatically.

### Plugin reports `Malformed OSC message`

1. The source index must arrive as an integer, not as a float.
2. The session types it correctly in its scripts as `{type: 'i'}`.

### Gain fader moves, but the plugin jumps to `-88 dB`

1. This plugin build expects gain as a linear factor, not in dB.
2. The session therefore converts when sending: the fader shows dB (`-60..+12`), and `10^(dB/20)` is sent.
3. `0 dB` corresponds to a factor of `1.0`.
4. Confirmed on `18.08.2026`.

### Notes for future session changes in open-stage-control v1.29

1. Script code belongs in the widget property `onValue`, not in `script`.
2. The shared-state object is called `globals`, not `global`.
3. `send()` without a target argument sends to the launcher default. `send(false, ...)` is invalid.
4. Every widget, including panels and tabs, needs `"bypass": true`; otherwise it sends its raw value.
5. The console at the bottom of the `open-stage-control` window shows script errors. Check there first.

## 8. This session

`64-source-points-tablet-xyz.session.json` works in stage coordinates (`XYZ`). The pad is a top view like the plugin radar, and the two correspond directly. This page describes only this current `XYZ` version.

## Sources

- [ICST AmbiEncoder – OSC syntax](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
- [OSC](/icst-ambisonics-plugins/13_osc/)
- [Motion Map Setup](/icst-ambisonics-plugins/16_motion_map_setup/)
