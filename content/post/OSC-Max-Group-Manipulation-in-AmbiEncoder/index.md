---
title: 
date: 2025-03-16T09:44:58+01:00
Description: 
tags: 
Categories: 
DisableComments: false
---

Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *

### OSC <-->  MaxMSP to the ICST AmbiEncoder

1. Prepare MaxMSP and the ICST AmbiEncoder for communicate over OSC.
	- Open the “ICST AmbiEncoder” in an FX slot and go to “Encoder Settings”
	- Go to “OSC In” and activate the incoming OSC port: (eg. 50001)
   ![OSC-IN](osc-port.png)
	- 
- Click on the 'OSC Out' tap and activate the OSC Out port: 
   - ICST AmbiPlugins Standard XYZ Index

> [!Note:] In the Max-demo patch, we will wait for this  '/icst/ambi/sourceindex/xyz'

![OSC-OUT](public/post/1/01/osc-out.png)
2. Open MaxMSP and look for the 'OSC-communication with ICST plugins in DAW' patch.
- See the following demo gif.
![Max-AmbiEnc](max_osc_to_AmbiPlugins.gif)


## **Example: Sending Absolute Angles (Degrees) with Euler Coordinates from Max to ICST AmbiEncoder**

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

![osc-euler](osc-euler-abs.gif)


----
©2025 ICST

