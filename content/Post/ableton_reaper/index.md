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

### Ableton to ICST MultiEncoder in Reaper

Ableton plays the audio channel via “Blackhole” (up to 64 channels)
to the Reaper Blackhole input devices.

![Ableton_outs](Ableton_output.png)
The Multi-Panner-OSC can send up to 16 OSC channels to the ICST Multi-AmbiEncoder via the localhost at port 50001.  
  
In the Reaper DAW, you receive the audio inputs from BlackHole (1-4) and in the ICST Multi-AmbiEncoder the OSC sources (1-16).

![Ableton_to_MultiEncoder](Ableton_OSC_BlackHole.gif)

This allows you, to record  a Bformat up to the 7th order of Ableton Live 12.

### How it works

#### Preparation:

- Install [AbletonLive 12](https://www.ableton.com/de/live/)
- Install [Reaper (DAW)](https://www.reaper.fm/)
- Download: [E4L_Multi-Panner_OSC.adv](https://github.com/joambi/icst-ambisonics.github.io/tree/main/static/downloads) This is a modified panner from [EnvelopforLive](https://github.com/EnvelopSound/EnvelopForLive/wiki)

#### Setup:


----
©2025 ICST