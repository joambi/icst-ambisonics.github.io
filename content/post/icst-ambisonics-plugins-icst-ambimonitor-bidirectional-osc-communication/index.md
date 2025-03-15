---
title: icst-ambisonics-plucst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

---
### Bidirectional OSC Communication: icst-ambisonics-plugins ↔ icst-ambimonitor

Generate motion data in Max and send it via OSC to the _ICST AmbiEncoder_ in your DAW. Alternatively, transfer a motion composition from your DAW to the _icst.ambisonics-externals_.

### **Required Software:**

- **MaxMSP v.8.0+** → [cycling74.com](http://cycling74.com)
- **ICST Ambisonics Tools v3** → [cycling74.com](http://cycling74.com)
- **ICST Ambisonics Plugins (VST3/AU)** → [ICST AmbiPlugins](https://github.com/schweizerweb/icst-ambisonics-plugins/releases)
- **Reaper (DAW)** → [reaper.fm](http://reaper.fm/download.php)

### **Setup Guide:**

#### 1. Configure OSC in ICST AmbiEncoder

- Open the _ICST AmbiEncoder_ in an FX slot and navigate to **Encoder Settings**.
- Under **OSC In**, activate the OSC input port (e.g., `50001`).
   ![OSC-IN](content/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/osc-port.png)
- - Click **OSC Out** and enable the OSC output port.
    - Uses **ICST AmbiPlugins Standard XYZ Index**.
- The Max demo patch listens for:  
    `'/icst/ambi/sourceindex/xyz'`

![OSC-OUT](content/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/osc-out.png)
#### 2. Open MaxMSP and Load the Patch

- Find the _OSC communication with ICST plugins in DAW_ patch.

See the demo Gifs:
- ![Max_Reaper](content/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/Max_Reaper.gif)

Next Gif: How it works:
 ![Max-AmbiEnc](content/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/max_osc_to_AmbiPlugins.gif)

----
©2025 ICST

