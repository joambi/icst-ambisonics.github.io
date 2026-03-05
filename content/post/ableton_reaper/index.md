---
title: Ableton Live & ICST Ambisonics Integration
description: "Step-by-step guide for recording 7th-order Ambisonics from Ableton Live into Reaper via BlackHole, OSC-driven MultiEncoder automation, and LTC sync."
date: 2025-03-16T09:44:58+01:00
year: 2025
month: 2025-03
weight: 7
tags: ["ableton", "reaper", "workflow", "ambiencoder", "tutorial", "blackhole"]
DisableComments: false
---

Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *
# AbletonLive to ICST Ambisonics MultiEncoder in Reaper

This tutorial provides a detailed guide to recording 7th-Order Ambisonics using Ableton Live and Reaper. It is aimed at users with a basic knowledge of both programs. If you are familiar with the concepts of Ableton Live, Reaper, and Ambisonics, the steps should be straightforward. Otherwise, some sections may be challenging. In this case, it is recommended that you first learn the basics of this software and Ambisonics technology.
### Ableton to ICST MultiEncoder in Reaper

Ableton transmits audio via "BlackHole" (up to 64 channels) to Reaper's BlackHole input devices.

![Ableton_outs](Ableton_output.png)
The Multi-Panner-OSC can send up to 16 OSC channels to the ICST Multi-AmbiEncoder via localhost on port 50001. In Reaper, audio inputs from BlackHole (1-4) are received, while the ICST Multi-AmbiEncoder processes OSC sources (1-16).

![Ableton_to_MultiEncoder](Ableton_OSC_BlackHole.gif)

This setup allows recording B-format up to the 7th order from Ableton Live 12.

---

### How It Works

#### Schematic Overview:

![Ableton_routing64ch](Ableton_routing_64ch.png)
#### Preparation:

- Install [AbletonLive 12](https://www.ableton.com/de/live/)
- Install [Reaper (DAW)](https://www.reaper.fm/)
- Install [BlackHole64](https://www.blackhole.audio/)
- Download: [E4L_Multi-Panner_OSC.adv](https://github.com/joambi/icst-ambisonics.github.io/blob/main/static/downloads/E4L%20Multi-Panner_OSC.adv)  This is a modified panner from [EnvelopforLive](https://github.com/EnvelopSound/EnvelopForLive/wiki)

----
### Setup
#### In Ableton Live

1. Create up to 64 mono/stereo tracks with audio or MIDI content.
2. Route outputs as external outs (1-64).
3. Reserve Track 64 for the LTC timecode. 

**Note**: I read that there could be difficulties with bi-directional synchronization between Reaper and Ableton Live. So I decided on the stable LTC Timecode variant.

4. Create spatialization tracks using 'E4L_Multi-Panner_OSC.adv' for automation (max 16 sources per panner).
5. Optionally, send custom OSC spatialization data from Max to ensure consistent OSC port numbers in Reaper (port: 50001).

    ![Max-OSC | 400](Max-OSC-Out2.png)
Tip: Make sure you use the same OSC port numbers in Reaper. (port: 50001)

#### In Reaper

1. Create a session with 63 mono tracks (Track 64 for LTC timecode).
2. Enable LTC sync input on Track 64 by right-clicking the Playbar.![LTC](LTC.png)
     
3. Set all active tracks to "Record: Disable (monitor only)."
   ![Rec_disable](rec_disable.png)

4. Route Tracks 1-63 to ICST MultiEncoder_64.

![Routing_Inputs](Routing_Overview.png)
- When correctly routed, the source appears in the encoder radar for verification.

5. Configure OSC connection between Ableton and ICST MultiEncoder. Each encoder requires its own OSC port.

    ![OSC-Ports](OSC-Port.png)
6. Activate OSC transmission in E4L_Multi-Panner. The ICST MultiEncoder will display moving dots when receiving OSC data.
   ![OSC_ON](OSC_ON.png)
7. In Reaper press Record -Output for recording your Bformat see next image.
   ![Rec_BF](Rec_BF.png)
8. Then press REC in Reaper -> you get the follow message "Waiting for Timecode"
   ![Rec](Rec.png)

9. Press play in Ableton Live to synchronize Reaper via LTC Sync (Input 64), enabling B-format 7th-order ambix recording.
10. Move to the **Start Marker** at **01:00:000** (LTC has a 60' offset), then press **Fire** or **Play** in Ableton Live to start recording.
![recoding_bf](Live_Reper_BF.gif)

For more details, refer to the documentation for Ableton Live, Reaper, and the ICST MultiEncoder.

----
<span style="font-size:9px;color:#9f9f9f;">©2025 ICST</span>