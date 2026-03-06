---
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *

**The ICST Ambisonics Plugins**
The "ICST Ambisonics Plugins"\[[1](https://www.zhdk.ch/forschungsprojekt/icst-ambisonics-plugins-555245)\] complements the "ICST Ambisonics Tools"\[[2](https://www.zhdk.ch/forschung/icst/software-downloads-5379/downloads-ambisonics-externals-for-maxmsp-5381)\] for Max/MSP. The "ICST Ambisonics Tools" have been developed since 2003 and have been in use worldwide since then. They are freely available and work in 64-bit architectures for both Mac and Windows. Their modular structure allows a dedicated and very problem-specific application for the creation of Ambisonics content, but this requires rudimentary knowledge of MaxMSP handling and programming. With the first Ambisonics plugins in mind, which we created together with Dave Malham in 2003\[[3](https://www.york.ac.uk/inst/mustech/3d_audio/vst/welcome.html)\] and later with Gerzonic\[[4](http://www.gerzonic.net/)\] in 2004, we decided to create the "ICST Ambisonics Tools" also available as plugins for DAWs. The "ICST Ambisonics Plugins" in version 1.0 contains all rudimentary functions such as a graphical radar view and the ICST's own distance calculation to create Ambisonics content easily and intuitively. The plugins are freely available in the formats VST3, AU and for Windows in VST3\_win. The plugins were developed as an internal research project, completely financed and developed by the ICST. This Blog\[[5](http://www.ambisonics.ch)\] and the Bitbucket-Site \[[6](https://bitbucket.org/christian_schweizer/icst-ambisonics-plugins/wiki/Home)\] offers everything you need for installation and support. Tutorials on the plugins are constantly updated and supplemented. Important: Apart from this blog, no support can be guaranteed at the moment!
The "ICST Ambisonics Plugins" are used to create Ambisonics content. They correspond to the "ICST Max-externals" and other programs that understand the OSC (Open Sound Control) protocol and thus significantly simplify the workflow when working with 3D audio (Ambisonics) in digital audio workstations. The plugins have a graphical radar view and distance calculation. They can send and receive up to 64 audio sources. The plugins are available as VST3 / AU plugins for Windows, Linux and Mac (10.11 or higher). For working with them we recommend the DAW Ardour6.x or Reaper 6.x, as these can handle audio strips with up to 64 channels.

* * *

**The ICST Ambisonics-Plug-ins Bundle**

* ICST Ambisonics Decoder
* ICST Ambisonic Mono Encoder \[panner for a mono source\]
* ICST ambisonics Multi-Encoder  \[multi-panner for max. 64 mono sources\]

![[./_resources/Overview_of_the_ICST_Ambisonics_Plugins.resources/Bildschirmfoto 2020-12-01 um 09.47.02.png]]
_Figure 01: View of the plug-ins in the Reaper DAW. A: ICST Mono-AmbiEncoder / B: Multi-AmbiEncoder / C: ICST AmbiDecoder for 8-speakers._

* * *

**Pre-clarifications about the formats and functions of the plug-ins:**

1. The ICST Ambisonics plug-ins are encoded in AmbiX format.
2. The ICST Ambisonics plug-ins are oriented in the right hand coordinate system.
3. The ICST Ambisonics plug-ins and the audio routing of the plug-ins in the DAW.
4. The ICST Ambisonics Plug-Ins themselves

* * *

**1\. The Ambisonics Format FuMa and AmbiX** \[[1](https://plugins.iem.at/docs/compatibility/#ambix-format)\]
The ICST Ambisonics Plug-in Bundle consists of one plug-in per Ambisonics order. The ICST Ambisonics plug-ins are in AmbiX format, and created with SN3D\[[2](https://en.wikipedia.org/wiki/Ambisonic_data_exchange_formats)\] normalization. ACN\[[3](https://de.qaz.wiki/wiki/Ambisonic_data_exchange_formats#ACN)\]stands for Ambisonics Channel Order, and FuMA\[[4](https://en.wikipedia.org/wiki/Ambisonic_data_exchange_formats#Furse-Malham)\] for Furse-Mallham Ambisoncs. In FuMa, the channel order is WXYZ, and in ACN the order is WYZX. Where W stands for the omni-directional signal, and X, Y, and Z describe the direction. So if there is a FuMa format for encoding, a converter plugin\[[5](http://www.matthiaskronlachner.com/?p=2015)\] is used upstream. Otherwise the directions will be decoded incorrectly. The semi-normalization is used in the AmbiX format (SN3D). The SN3D ensures that when encoding a source, the levels of all channels do not exceed that in the first (Omni, W) channel. In general, this is very handy to avoid clipping in your DAW.
More information about Ambisonics formats can be found here:  [Ambisonics Standards](https://ambisonics.ch/post/ambisonic-channel-formats)

* * *

**2\. The 3D coordinate systems** \[[6](https://en.wikipedia.org/wiki/Three-dimensional_space)\]
A 3D coordinate system is used to represent points or other elements in the plane or with the Z axis in 3D space. There is no single coordinate system. So there is the nautical one, the mathematical one and still others. The coordinate system used is of the nautical type, which means that the angles are calculated positively in the clockwise direction. In the Cartesian coordinate system (xyz) we use the right hand system. (see figure below)
![[./_resources/Overview_of_the_ICST_Ambisonics_Plugins.resources/Bildschirmfoto 2020-11-30 um 15.45.15.png]]
Figure 01: the right hand system

Thus, in the ICST Ambisonics radar, the alignment is as described in Figure 02.
![[./_resources/Overview_of_the_ICST_Ambisonics_Plugins.resources/Bildschirmfoto-202020-11-30-20um-2015.57.17.png]]
Figure 02: ICST Ambisonics Plug-Ins Alignment

* * *

**3\. Audio routing of the plugins in the DAW.**\[[7](https://www.reaper.fm/)\]
The ICST Ambisonics plugins consist of the following components:

* AmbiDecoder plugins 1st to 7th order.
* AmbiEncoder Plugins 1st to 7th order with mono input (1 channel)
* AmbiEncoder Plugins 1st to 7th order with multi-input (up to 64 channels) 

By default, a DAW provides stereo busses. Depending on the Ambisonics order, the audio routing may look different.
As an overview: a 1st order encoder requests a mono signal as audio input, and sends four audio channels to the decoder. However, a 7th order encoder plugin sends 64 audio channels to the decoder. To help you, let's look at Figure 03:
![[./_resources/Overview_of_the_ICST_Ambisonics_Plugins.resources/Bildschirmfoto 2020-11-30 um 16.59.22.png]]
Figure 03: Image shows the available ICST Ambisonics plug-ins and their audio channels.
A: Describes the ICSTMono AmbiEncoder (VST3: AmbiEncoder\_O1\_1CH (1->4ch)
VST3: AmbiEncoder\_O1), which stands for First-Order AmbiEncoder. It expects a mono input channel (\_1CH). Encodes one channel (mono) and sends four audio signals (4ch ) to the ICST AmbiDecoder.
B: The (VST3: AmbiDecoder\_O1\_8CH (4->8ch).
The ICST AmbiDecoder\_O1 (i.e. First-Order Ambisonics) expects a B-format (wyzx) i.e. a 4-channel input signal.
Then the decoder can decode this B-format for up to 8 speakers (4->8ch)

* * *

**4\. The Ambisonics  ICST Plug-Ins:**
The selection of the ICST Ambisonics plugins is based on the Ambisonics Order wishes. So from the 1st order up to the 7th order. If you click on "Add" in the FX section, you will see "ICST" in the folder. The folder with the content of all ICST Ambisonics plugins. To select them in Reaper, click on the "FX" icon.
![[./_resources/Overview_of_the_ICST_Ambisonics_Plugins.resources/Bildschirmfoto 2020-11-30 um 17.21.28.png]]
Figure 04: Describes how to select and load an ICST Ambisonic plug-in in the Reaper DAW.

* * *
