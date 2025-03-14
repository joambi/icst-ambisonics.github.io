---
title:
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

---
### icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication

This tutorial requires the installation of the following components:

- MaxMSP v.8.0+ --> [cycling74.com](http://cycling74.com)
- ICST Ambisonics Tools v3 Packages --> [cycling74.com](http://cycling74.com)
- ICST Ambisonics Plugins (VST3/AU) --> [ICST AmbiPlugins](https://github.com/schweizerweb/icst-ambisonics-plugins/releases)
- Reaper.app (DAW) --> [http://reaper.fm/download.php](http://reaper.fm/download.php)

Generate movement data in Max and send it via an OSC message to the _ICST AmbiEncoder_  in your DAW.

_ICST AmbiEncoder_ --> DAW:

Send a motion composition created in your DAW to the _icst.ambisonics-externals_.

  

**How it works:**

### OSC <-->  MaxMSP to the ICST AmbiEncoder

1. Prepare MaxMSP and the ICST AmbiEncoder for communicate over OSC.
	- Open the “ICST AmbiEncoder” in an FX slot and go to “Encoder Settings”
	- Go to “OSC In” and activate the incoming OSC port: (eg. 50001)
   ![OSC-IN](content/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/osc-port.png)
- Click on the 'OSC Out' tap and activate the OSC Out port: 
   - ICST AmbiPlugins Standard XYZ Index

> [!Note:] In the Max-demo patch we will wait for this  '/icst/ambi/sourceindex/xyz'

![OSC-OUT](content/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/osc-out.png)
2. Open MaxMSP and look for the 'OSC-communication with ICST plugins in DAW' patch.
- See the next demo gif.
![Max-AmbiEnc](content/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/max_osc_to_AmbiPlugins.gif)

----
©2025 ICST

