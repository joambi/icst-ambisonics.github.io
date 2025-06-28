---
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *

The first example shows a simple integration/synchronization together with the IEM Ambisonics plugins, using the FndReverb effect.
Simple, because the IEM plugins also have a comfortable OSC interface.

### OSC <--> OSC Communication:

The FX plugin "FNDReverb" from IEM is a CPU-friendly reverb for our B format.
The idea of this example is that we want to add a reverb to the source in the distance.
This should happen synchronously with the distance parameter in the spatialization. So the greater the distance, the more reverb should be added. To achieve this easily, please follow these steps:

1. Open the DAW Reaper.app

![[./_resources/Send_OSC_from_ICST_AmbiPlugin_to_a_other_FX-Plugin.resources/Bildschirmfoto 2020-09-16 um 14.06.07.png]]

2. create three new tracks:
	* ICST decoder -> stereo in this example
	* ICST-Encoder-Mono (Panner)
	* IEM-FdnReverb for reverb generation

![[./_resources/Send_OSC_from_ICST_AmbiPlugin_to_a_other_FX-Plugin.resources/Bildschirmfoto 2020-09-16 um 14.07.08.png]]
Next, we need  to establish the OSC connectors of the two plugins.
![[./_resources/Send_OSC_from_ICST_AmbiPlugin_to_a_other_FX-Plugin.resources/Bildschirmfoto 2022-02-19 um 13.48.53.png]]

* open in the 'ICST AmbiEncoder' Settings the OSC - Window (1.)
* Then activate the OSC-Send to the 'External' Usage. (2.)
* Add the OSC-Parameter from the 'IEM FdnReverb' in this example. It is the 'Dry/Wet' (6.) Parameter.
* In the 'IEM FdnReverb', we have to activate also the OSC-Listener port (ex. port:9001) (4.)
* Click on the 'IEM OSC, ‘set the port number, and press ‚connect.' When the color change to green, it is activated. (5.)
* Now, when you move the panner in the ICST AmbiEncoder, you should see moving the 'Dry/Wet' parameters in the 'IEM FdnReverb.‘ (6.)

Now we should get more and more reverb as the distance increases. Experiment with the other reverb parameters.

OSC-Input for  the 'IEM FdnReverb':
```
/FdnReverb/dryWet {d}
```

* * *


