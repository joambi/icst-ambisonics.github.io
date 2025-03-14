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
    

_icst.ambimonitor --> ICST Ambisonics Multi-Encoder Plugin:_


Generate movement data in Max and send it via an OSC message to the _ICST AmbiEncoder_  in your DAW.

_ICST AmbiEncoder_ --> DAW:

Send a motion composition created in your DAW to the _icst.ambisonics-externals_.

  

**How it works:**

For more detailed information about the OSC syntax of the _ICST AmbiEncoder:_ Help - OSC - Syntax.

See the example patch from the _ICST_Ambisonics_v3 Packages_ ([cycling74.com](https://cycling74.com/)) in the following picture.

![](en-cache://tokenKey%3D%22AuthToken%3AUser%3A528449%22+ff2aef3d-e327-5c14-f5a1-a436074a5e90+6597d2be81e5923fb01676b64a84bb60+https://public.www.evernote.com/resources/s1/09b8b6ba-661e-e92e-fb62-29410f5a96d5)

_Picture: Communicate with ICST plugins via OSC_

**Receive OSC Messages from icst.ambimonitor max-externals:**

1. In Max, open the  patch _Communicate with ICST plugins via OSC_.
2. In Reaper create a new track.
3. In [FX] load the _AmbiEncoder Plugin_ (/Library/Audio/Plug-Ins/).
    
    ![](en-cache://tokenKey%3D%22AuthToken%3AUser%3A528449%22+ff2aef3d-e327-5c14-f5a1-a436074a5e90+e5aa1f2c109501fb6d213eabc0c6f13f+https://public.www.evernote.com/resources/s1/d6ad3ed8-a6c4-aa53-7a25-13b44a720f83)

_Picture: prepare the AmbiEncoder Plugin to receive OSC-messages from extern._

A: Open the _Encoder Setting_ window.
B: Activate _Receive OSC_.
C: Per default, the Plugin is listening on UDP on port 50001.

The _ICST AmbiEncoder_ is now listening on port 50001 for incoming external OSC Messages.

In _icst.ambimonitor_, move any point(s) and you can see the same movement(s) in the _AmbiEncoder._

Optionally, you can record the movements in your DAW. 

  

[Demo - Video](https://www.loom.com/share/544a425e0a9149749847794e8141fe4a)

---

**Send OSC Messages to the icst.ambimonitor max-external:**

  

1. In _AmbiEncoder_ _Plugin_, Settings -> _OSC_.
2. Activate _Send Positions for External Usage._
3. Click _edit..._
4. In _Custom OSC_, click _add_.
5. Write or copy&paste the following OSC Message (replace _/demo/{n} {d}_):
    

/icst/ambi/sourceindex/xyz {i} {x} {y} {z}

  

![](en-cache://tokenKey%3D%22AuthToken%3AUser%3A528449%22+ff2aef3d-e327-5c14-f5a1-a436074a5e90+d9c8811df57b276db03acca3aef2cee4+https://public.www.evernote.com/resources/s1/e22e8e38-1548-6665-f2d1-80ecfb01e8ec)

_Picture: prepare the AmbiEncoder Plugin to send OSC Messages for external usage._

8. Activate _Enable_ and close the window.
    
9. When you move or playback your spatialization recording, you can see the same movements in the _icst.ambimonitor_.
    

[Demo - Video](https://www.loom.com/share/fffdd4a9e5124931b496ef1384016d45)