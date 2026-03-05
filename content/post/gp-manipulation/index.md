---
title: ICST MultiEncoder – Group Animation
description: "Walks through ICST MultiEncoder group animation tools for selecting, rotating, stretching, and recording grouped sources in Reaper."
date: 2025-05-28T13:00:00
year: 2025
month: 2025-05
weight: 4
tags: ["multiencoder", "group", "animation", "reaper", "workflow"]
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

---
# Group Animation

The **ICST Multi-Ambisonics Encoder v.2+** features a **Group Animation** tool for dynamically manipulating grouped audio sources in the **Radar Display**. By selecting a group point and holding **Option (Alt) on Mac**, you unlock advanced functions like **group animation** and **group stretch**, enabling synchronized movement and transformation of multiple sources for enhanced 3D spatialization.

📺 **Tutorial:** [Points and Radar](https://youtu.be/aDa-vNWriLM) (3:15)

---
### Simple animation of a group

![simple](Gp_manipulation.gif)
1. **Select Points** – Click to select a point; use **Shift + Click** for multiple points.
2. **Create Group** – Click the **Group** symbol to generate a group point (e.g., 'S').
3. **Move Group** – Hold **Shift** and drag the group point.
4. **Rotate Points Around Group** – Hold **Alt**, then drag and drop the **Rotate-Around-Group** symbol.
5. **Stretch Group** – Hold **Alt**, use the **Stretch Symbol**, then move the mouse **up/down** to adjust.
6. **Rotate Group Around Origin** – Hold **Alt**, then drag and drop the **Rotate-Around-Origin** symbol.

💡 **Tip:** These functions also apply to height adjustments in the **Z-Radar**.

### Manual recording

1. Set **ICST MultiEncoder** (Track Automation) to **'LATCH'** (or **'WRITE'**).
2. Start playback in **Reaper**, hold **Alt**, and record your movement.
3. To play back the recorded motion, set “LATCH” to “READ”.
![GP_REC](Rec_PP.gif)



----
### LFO Animation of a Group
 ![LFO_A 1](LFO_A.png)
1. Open the **LFO Parameter Modulation** in the **AmbiEncoder** track and activate the parameters for **GX, GY, and GZ**.
 ![LFO_parm](LFO_param.png)
2. Adjust the LFO parameters, such as **speed**, to achieve the desired movement.  
Now, the group moves automatically in the radar.

 ![GP_LFO_animated](LFO_A.gif)

💡 **Tip:** Connecting the LFO parameters to a MIDI/OSC interface lets you control the movement live.

----
### LFO Group Animation with Quaternions

![LFO_B](LFO_Quarternions.gif)

This is a more advanced example of animating a group using **quaternion parameters**.

💡 **Tip:** You can also drive the parameters using an **audio control signal** via a sidechain.

---
### Group animation from an external source 

A new 'ICST Ambi-OSC-Patcher' shows the direct group animation possibilities, we’ll demonstrate how to animate groups using OSC from an external source. The MultiEncoder internally converts Euler angles into quaternions. In this example, the angles from the source point (1) are crucial for the animation.

![Max example patch](max-example-patch.png)

Download MaxPatch: [Neuer OSC-Messenger](https://github.com/joambi/icst-ambisonics.github.io/blob/main/static/downloads/OSC-GP-ICST-MultiEncoder.maxpat)
#### Group Position
1. Set Group Position AED
	- /icst/ambi/group/aed [GroupName] [Azimuth] [Elevation] [Distance] [Mode] Mode (1) = move the hole GP, Mode (0) = move only the GP-Point.
	- `/icst/ambi/group/aed 'G1' 135 0 0.1 1`
2. Set Group Position XYZ
	- /icst/ambi/group/xyz [GroupName] [X] [Y] [Z] [Mode]:
	- `/icst/ambi/group/xyz 'G2' 0.1 0.1 0 0`

### **OSC Animation**

The ICST MultiEncoder can now be controlled directly using Euler angles via OSC. 

![Euler_Winkel](OSC_abs_angel.gif)

----
<span style="font-size:9px;color:#9f9f9f;">©2025 ICST</span>

