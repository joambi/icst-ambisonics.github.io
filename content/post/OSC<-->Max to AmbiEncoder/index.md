---
date: ""
draft: false
params:
  author: Johannes Schuett
weight: 10
tags: 
title: icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication
---


Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *
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

