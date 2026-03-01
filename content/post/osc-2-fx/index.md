---
title: ICST AmbiEncoder – OSC to FX Mapping
date: 2025-05-16T09:44:58
weight: 3
tags:
Categories:
DisableComments: false
---

Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

-----
# ICST AmbiEncoder sends OSC to FX-Plugins-parameter


### Integrating ICST AmbiEncoder with IEM FdnReverb via OSC

This example demonstrates a simple synchronization between **ICST AmbiEncoder** and **IEM Ambisonics plugins**, using **FdnReverb** to apply distance-dependent reverb. The **IEM plugins' OSC interface** makes this process straightforward.

### OSC <--> OSC Communication

**FdnReverb** (by IEM) is a CPU-efficient reverb for B-format. The goal is to **increase reverb as the source moves further away** in the spatialization.

![OSC to FX-Reverb](FX-Reverb_osc.gif)

#### 1. Set Up the DAW (Reaper)

- Create three tracks:
    - **ICST Decoder** → Stereo
    - **ICST Encoder (Mono/Panner)**
    - **IEM FdnReverb** → Reverb processing

#### 2. Configure OSC Communication

1. Open the **ICST AmbiEncoder** settings and navigate to the **OSC window**.
2. Enable **OSC Send** for external use.
3. Add the **Dry/Wet parameter** from **IEM FdnReverb**.
4. **OSC Input for IEM FdnReverb:**
    `/FdnReverb/dryWet {d}`
5. In **IEM FdnReverb**, activate the **OSC Listener** (e.g., Port: 9001).
6. Click **IEM OSC**, set the port number, and press **Connect** (should turn green when active).
7. Moving the **panner** in ICST AmbiEncoder will now dynamically adjust the **Dry/Wet** parameter in FdnReverb.

As the distance increases, reverb intensity will also increase. Experiment with other reverb parameters for additional effects.



----
©2025 ICST
