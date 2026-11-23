---
title: CPU Load of Ambisonics Orders in REAPER – Measurement Protocol (FOA to HOA7)
description: "How the CPU load of the ICST AmbiEncoder_64 and AmbiDecoder was measured in REAPER for FOA, HOA3, HOA5 and HOA7 with 1 to 32 sources: method, results, limitations and machine data."
date: 2026-11-23T19:00:00+01:00
year: 2026
month: 2026-11
weight: 39
tags: ["hoa", "foa", "cpu", "measurement", "reaper", "performance", "reference"]
key_points:
  - "Encoder load grows with the number of sources and the order; decoder load does not depend on the number of sources"
  - "Highest total load: 5.8 % (HOA3, 32 sources) on an Apple M2 Pro – no dropouts in any of the 17 cells"
  - "REAPER's RT CPU does not reflect plugin load – use FX CPU per track and total CPU"
difficulty: "intermediate"
post_kind: "reference"
tool: ["AmbiEncoder", "AmbiDecoder"]
---

**Purpose:** Documents how the CPU table in [Which Ambisonics Order Do I Need?](/post/hoa-ordnung-wahl-praxis/) was measured. Series of 22 November 2026.

---

## Summary

- The **encoder** (ICST AmbiEncoder_64) grows roughly linearly with the number of sources, and the slope rises with the order: at 32 sources FOA 1.0 %, HOA3 1.3 %, HOA5 1.8 %, HOA7 2.2 %. With one source it is independent of the order (0.22–0.33 %).
- The **decoder** (ICST AmbiDecoder, 18 loudspeakers) does not depend on the number of sources. It stays at 0.55–1.0 % for FOA to HOA5 and rises to 1.0–1.7 % at HOA7.
- **Highest total load:** 5.8 % (HOA3, 32 sources). No dropouts in any cell.
- **Freeze** removes almost all encoder load at HOA7 with 32 sources (2.2 %); playing the frozen file costs 0.14 %.

---

## Method

**Machine and settings:** MacBook Pro 16" (2023, Apple M2 Pro, 16 GB), macOS 27.2.1, REAPER 7.86 (macOS arm64), audio device AUDIO4c, 48 kHz, 512 samples (the Performance Meter budget of 10.67 ms corresponds to this). ICST AmbiEncoder_64 and AmbiDecoder as VST3, plugin windows closed. The plugin version was not recorded.

**Test project:** a pink-noise generator track (JSFX ICST_Pink_Noise_Multi, 64 channels, adjustable number of sources, equal level on all sources), one encoder track and one decoder track (18 loudspeakers). The sources do not move. 16 sessions: order 1, 3, 5, 7 × 1, 8, 16, 32 sources.

**Reading:** start playback, wait 60 seconds, read the Performance Meter (View → Performance Meter) with the track table visible. The main value is the per-track **FX CPU**, plus **total CPU** and the xrun counter. The difference of the xrun counter over the measurement window counts as dropouts.

**Extra cell:** HOA7 with 32 sources after Freeze. A media track plays a 64-channel file (noise at −30 dB, synthetic instead of a real encoder result) and the decoder track receives it by send.

---

## Results

FX CPU of ICST AmbiEncoder_64 / ICST AmbiDecoder in percent, one reading at about 60 s per cell:

| Order | Channels | 1 source | 8 sources | 16 sources | 32 sources |
|---|---|---|---|---|---|
| FOA | 4 | 0.26 / 0.55 | 0.57 / 0.86 | 0.64 / 0.67 | 1.0 / 0.69 |
| HOA3 | 16 | 0.26 / 0.95 | 0.54 / 0.87 | 0.79 / 0.94 | 1.3 / 0.68 |
| HOA5 | 36 | 0.22 / 0.88 | 0.75 / 1.0 | 1.1 / 1.0 | 1.8 / 0.83 |
| HOA7 | 64 | 0.33 / 1.7 | 0.87 / 1.3 | 1.6 / 1.4 | 2.2 / 1.0 |
| HOA7 after Freeze | 64 | – | – | – | – / 1.6 (media 0.14) |

Total CPU (current value, percent):

| Order | Channels | 1 source | 8 sources | 16 sources | 32 sources |
|---|---|---|---|---|---|
| FOA | 4 | 3.0 | 4.4 | 4.5 | 5.5 |
| HOA3 | 16 | 3.4 | 4.0 | 4.8 | 5.8 |
| HOA5 | 36 | 2.4 | 3.8 | 4.5 | 5.7 |
| HOA7 | 64 | 4.2 | 3.9 | 5.6 | 5.5 |
| HOA7 after Freeze | 64 | – | – | – | 3.0 |

**Dropouts:** none. The xrun counter stood at 12 in all 17 cells (already before the first cell), the difference in the measurement window is 0. Media xruns: 0.

**Freeze cell:** encoder absent, media CPU 0.14 %, decoder 1.6 %, total 3.0 %, disk read 5.81 MB/s. Live HOA7 with 32 sources: encoder 2.2 % + decoder 1.0 %, total 5.5 %.

---

## Limitations

- Only one reading per cell instead of a median of three; decoder scatter about ±0.15 %.
- System memory was temporarily low (91–762 MB free).
- Pink noise at equal level instead of music; sources not moving, so there is no Animator load; no reverb or other effects in the chain.
- The freeze cell uses a synthetic 64-channel file instead of a real encoder freeze.
- REAPER's **RT CPU** stayed at about 1.1 % (0.6–1.4 %) in almost all cells and does not reflect the rising load; the plugins probably run outside the real-time audio thread. That is why FX CPU and total CPU are used.
- The values apply to this machine and this plugin chain. Repeat the measurement after major plugin version jumps.

---

## Further reading

- [Which Ambisonics Order Do I Need? – Choosing HOA in Practice](/post/hoa-ordnung-wahl-praxis/)
