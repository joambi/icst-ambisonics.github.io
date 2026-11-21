---
title: MaxMSP & ICST AmbiEncoder – OSC Communication
description: "Details bidirectional OSC communication between Max/MSP and ICST AmbiEncoder, including angle formats and motion data exchanges."
date: 2025-03-16T09:44:58
year: 2025
month: 2025-03
weight: 2
tags: ["maxmsp", "osc", "ambimonitor", "ambiencoder", "bidirectional"]

key_points:
  - "Set up bidirectional OSC communication between Max/MSP and ICST AmbiEncoder"
  - "Send and receive source angles in Euler format between Max patches and REAPER"
DisableComments: false
difficulty: "advanced"
post_kind: "tutorial"
tool: ["Max", "OSC"]
---

## Bidirectional OSC Communication with MaxMSP

Level: Advanced | **Audience:** Max/MSP and OSC integrator.

Generate motion data in Max and send it via OSC to the _ICST AmbiEncoder_ in your DAW. Alternatively, transfer a motion composition from your DAW to the _icst.ambisonics-externals_.

<figure data-gen="g25" style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Bidirectional OSC: Max sends source positions to the ICST AmbiEncoder in the DAW, and the encoder sends its positions back to Max" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="are5" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="20" y="60" width="230" height="170" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="135" y="86" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="14">MaxMSP</text><text x="135" y="106" text-anchor="middle" font-size="11">generates motion data</text><text x="135" y="124" text-anchor="middle" font-size="11">e.g. ambimonitor, ambicontrol</text><rect x="40" y="140" width="190" height="34" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.6"/><text x="135" y="162" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="11">ambimonitor / ambicontrol</text><rect x="40" y="184" width="190" height="34" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.6"/><text x="135" y="206" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="11">icst.ambisonics-externals</text><rect x="470" y="60" width="230" height="170" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="585" y="86" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="14">REAPER (DAW)</text><text x="585" y="106" text-anchor="middle" font-size="12">ICST AmbiEncoder</text><text x="585" y="124" text-anchor="middle" font-size="11">positions and automation</text><rect x="490" y="140" width="190" height="34" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.6"/><text x="585" y="162" text-anchor="middle" font-weight="600" font-size="12">OSC In</text><rect x="490" y="184" width="190" height="34" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.6"/><text x="585" y="206" text-anchor="middle" font-weight="600" font-size="12">OSC Out</text><line x1="252" y1="135" x2="468" y2="135" stroke="#3fa968" stroke-width="2" opacity="1" marker-end="url(#are5)"/><text x="360" y="124" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="12">Max → DAW</text><text x="360" y="153" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="10">OSC In · port 50001</text><line x1="468" y1="201" x2="252" y2="201" stroke="#4a8fe0" stroke-width="2" opacity="1" marker-end="url(#are5)" stroke-dasharray="6 4"/><text x="360" y="190" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="12">DAW → Max</text><text x="360" y="219" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="10">/icst/ambi/sourceindex/xyz</text><text x="360" y="262" text-anchor="middle" font-size="11">Max sends to the OSC In port of the encoder,</text><text x="360" y="280" text-anchor="middle" font-size="11">and listens to the encoder's OSC Out (ICST AmbiPlugins Standard XYZ Index).</text><text x="360" y="36" text-anchor="middle" font-weight="600" font-size="13">Two directions, one address</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Both directions: Max generates motion and sends it to the encoder; the encoder reports its positions back so a composition from the DAW can be used in Max.</figcaption>
</figure>

### **Required Software:**

- **MaxMSP v.8.0+** → [cycling74.com](https://cycling74.com)
- **ICST Ambisonics Tools v3** → [cycling74.com](https://cycling74.com)
- **ICST Ambisonics Plugins (VST3/AU)** → [ICST AmbiPlugins](https://github.com/schweizerweb/icst-ambisonics-plugins/releases)
- **Reaper (DAW)** → [reaper.fm](https://reaper.fm/download.php)

### **Setup Guide:**

#### 1. Configure OSC in ICST AmbiEncoder

- Open the _ICST AmbiEncoder_ in an FX slot and navigate to **Encoder Settings**.
- Under **OSC In**, activate the OSC input port (e.g., `50001`).
   <img src="/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/osc-port.png" alt="OSC-IN" style="display:block;width:100%;max-width:520px;height:auto;margin:.8rem 0;border-radius:6px">
- Click **OSC Out** and enable the OSC output port.
    - Uses **ICST AmbiPlugins Standard XYZ Index**.
- The Max demo patch listens for:
    `'/icst/ambi/sourceindex/xyz'`

   <img src="/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/osc-out.png" alt="OSC-OUT" style="display:block;width:100%;max-width:520px;height:auto;margin:.8rem 0;border-radius:6px">

#### 2. Open MaxMSP and Load the Patch

- Find the _OSC communication with ICST plugins in DAW_ patch.

See the demo Gifs:
- <video autoplay muted loop playsinline preload="metadata" poster="Max_Reaper-poster.jpg" aria-label="Max_Reaper" style="width:100%;max-width:720px;height:auto;border-radius:6px"><source src="Max_Reaper.mp4" type="video/mp4"></video>

Next Gif: How it works:
<video autoplay muted loop playsinline preload="metadata" poster="max_osc_to_AmbiPlugins-poster.jpg" aria-label="Max-AmbiEnc" style="width:100%;max-width:720px;height:auto;border-radius:6px"><source src="max_osc_to_AmbiPlugins.mp4" type="video/mp4"></video>

---

## Sending Absolute Angles (Euler Coordinates)

<figure data-gen="g25" style="margin:1.8rem 0">
<svg viewBox="0 0 720 170" role="img" aria-label="Anatomy of an absolute Euler OSC message: address, source index, yaw, pitch and roll" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arf6" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="40" y="24" width="330" height="40" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.6"/><text x="205" y="50" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="13">/icst/ambi/sourceindex/euler</text><rect x="396" y="24" width="60" height="40" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="426" y="50" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="14">1</text><text x="426" y="86" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="11">index</text><text x="426" y="102" text-anchor="middle" font-size="10">source 1</text><rect x="468" y="24" width="60" height="40" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="498" y="50" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="14">30</text><text x="498" y="86" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="11">yaw</text><text x="498" y="102" text-anchor="middle" font-size="10">azimuth</text><rect x="540" y="24" width="60" height="40" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="570" y="50" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="14">15</text><text x="570" y="86" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="11">pitch</text><text x="570" y="102" text-anchor="middle" font-size="10">elevation</text><rect x="612" y="24" width="60" height="40" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="642" y="50" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="14">5</text><text x="642" y="86" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="11">roll</text><text x="642" y="102" text-anchor="middle" font-size="10">fwd. axis</text><text x="205" y="86" text-anchor="middle" font-weight="600" font-size="11">address</text><text x="205" y="102" text-anchor="middle" font-size="10">index-based (by name: /source/euler)</text><text x="360" y="142" text-anchor="middle" font-size="11">Example: /icst/ambi/sourceindex/euler 1 30 15 5</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Absolute angles in Euler format: first the source index, then yaw (azimuth), pitch (elevation) and roll.</figcaption>
</figure>




To send **absolute angles** using **Euler coordinates** from MaxMSP to the ICST AmbiEncoder, use the following OSC message format:

```
/icst/ambi/source/euler [ChannelName] [Yaw] [Pitch] [Roll]
/icst/ambi/source/euler 'S1' 30 15 5
```

For **index-based addressing**:

```
/icst/ambi/sourceindex/euler [ChannelIndex] [Yaw] [Pitch] [Roll]
/icst/ambi/sourceindex/euler 1 30 15 5
```

**Note:**

- `Yaw` (Azimuth): Horizontal rotation
- `Pitch` (Elevation): Vertical tilt
- `Roll`: Rotation around the forward axis

----

