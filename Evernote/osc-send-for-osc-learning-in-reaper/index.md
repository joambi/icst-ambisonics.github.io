---
tags: 
title: osc-send-for-osc-learning-in-reaper
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *
# osc-for-fx-learning-in-reaper


1. Activate  the OSC in Reaper

    ![OSC_Reaper](Evernote/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/osc_Reaper.png)

2. Activate the OSC-Send in the 'ICST Ambisonics Encoder'
3. Choose your 'FX' in Reaper  
4. choose 'Midi-Learn' for the 'FX- Parameter'
   ![OSC-learn](Evernote/osc-send-for-osc-learning-in-reaper/fx_learn.png)

```
/track/2/fx/1/fxparam/9/value {d} {sd, -0.0, 0.0}
```
- The IEM FDNReverb is included in track 2   
- The IEM FDNReverb is the first (fx) plug-in in the track  
- Dry/Wet is the 9th parameter of the IEM FDNReverb  
- The “Dry/Wet” parameter is determined by the incoming distance (the further away the sound, the more reverb it gets).  
  
**Example:** The “IEM FDNReverb” follows the AmbiEncoder distance.
![Demo_OSC-FX](Evernote/osc-send-for-osc-learning-in-reaper/osx_fx.gif)

  Gif example: zero distance 0.0 = dry in FX FDNReverb and distance 1.0 = wet

* * *
©2025 ICST

