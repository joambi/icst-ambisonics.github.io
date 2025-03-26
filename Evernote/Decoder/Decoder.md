---

tags: 
  - page
  - published
  - unpublished

---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *

**ICST Ambisonics Plugins —> AmbiDecoder** 

The AmbiDecoder plugin (One plug-in via Ambisonics order.) is the ICST Decoder Plugin for Ambisonics (AmbiX) Bformat Files, ACN channel order and SN3D normalization. To decode FuMa (Furse-Malham) Format, you must first advance a converter plugin \[1\]. Depending on the Ambisonics order, the AmbiDecoder plugin expects different input routing for the audio. As an example, let's choose this decoder plugin in the FX: AmbiDecoder\_O1\_32CH (ICST) (4-> 32ch) O1\_32CH means that we have loaded the AmbiDecoder 1.Order and can order up to 32 speakers outputs. With the specifications of (4-> 32ch), the plugin describes that it requires 4 input channels (wxyz) and, as already said, provides 32 outputs. An other example: AmbiDecoder\_O1\_32CH3\_32CH (ICST) 16—> (32ch) = third order ambisonics with 32 output channels and 16 input\_channels. So it is important to choose the correct audio routing in the respective DAW (Digital Audio Workstation). A maximum of 32 channels is supported.

**AmbiDecoder Explanation:**
If you click on "Add" in the FX area, you will see "ICST" in the folder. The folder with the contents of all ICST Ambisonics plugins.

**First-Layer:** Source-Placement and Movement Control The idea behind this 1st layer is that the user always gets an overview of the movements or placements from all AmbiEncoder sources.
![[./_resources/Decoder.resources/Speaker_settings_und_VST3__AmbiDecoder_O1_32CH__IC.png]]

A: The AmbiDecoder shows all source movements and placements in the main radar view. 
B: The Speaker Setting window, shows the currently loaded speakers location coordinates: XYZ / AED (cartesian / azimuth elevation distance) system of type Navigation is assumed (Front = +X, Right = +Y, Top = +Z). The direction of the Y-axis can optionally be flipped. (equals to azimuth increase counterclockwise instead of clockwise).

In the First-Layer it is not possible to change the speaker coordinates! 
C: The "Distance Scaler" determines the scaling of the coordinates to Absolute Space. (here from wall to wall 4.8 meters). Channel weights: here the order weighting can be adjusted. Default is set to "calculate in-phase" press "reset to basic“ button, or experiment with your own weight by entering the values (m = 0) -> W or Zero.Order or (m = 1) for First-Order Change . 
D: Here you can cascade the OSC connection of all connections to the AmbiDecoder. (Flag on / off). Occasionally if for some reason you want to use two decoder plugins, then you have to assign each AmbiDecoder its own OSC port here. To change the speaker settings or create your own, then switch to 2.Layer of the AmbiDecoder plugin. to change the AmbiDecoder Layer mode, activate the flag in "Edit mode“ (E) 
E: AmbiDecoder\_03\_32CH (ICST) 16—> (32ch) Decoder-Parameters

**AmbiDecoder - Decoder Parameter:**
Distance-Scaler: scaler for the Room - Distance in meter
Example: 1.0 meter from sweet-spot

**Channel weights:** reset to basic set all parameters to 1.00
calculate in-phase set the AmbiDecoder-Parameters to in-phase ambisonics calculation from Martin Neukom \[1\]

**Flip direction:** flips the Y-axies in the AmbiDecoder.

**OSC:**
Receive OSC messages is the flag on, the AmbiDecoder receives all movement & placement from all active ZEnc
OSC-Port for listening is 50000
Timeout (ms) chances the refresh time (1000)

* * *

**Second-Layer:** Speaker-Placement Control
![[./_resources/Decoder.resources/Speaker_settings_und_VST3__AmbiDecoder_O1_32CH__IC.1.png]]
A: shows the speaker-setting coordinates, Cartesian (XYZ) or Polar (AED).
B: represents the speaker placement in the room (horizontal) —> (Speaker-Radar)
C: represents the speaker placement in the room (vertical)

![[./_resources/Decoder.resources/Bildschirmfoto 2019-08-11 um 17.04.41.png]]
 Click on this symbol (A) to open the „speaker settings“ windows.
D: If the "Edit mode“ flag is activated, we can edit all parameters for the speaker setting.

**Manage the Speaker-Setting in AmbiDecoder:**
![[./_resources/Decoder.resources/Speaker_settings_und__unsaved_project__-_REAPER_v5.png]]
A: choose one of the default speaker-settings 
Defaults:

* 2 (Stereo)
* 4 (Quadro)
* 6 (Hexagon)
* 8 (Octagon)

B: load a speaker-setting or save your own setting 
C: Add or remove a Speaker from the list. 
D: step up or down in the list.
![[./_resources/Decoder.resources/Speaker_settings.png]]

**Speaker Audio Test:**
![[./_resources/Decoder.resources/Speaker_settings.2.png]]
A: Press the "speaker icon" to get white noise on the selected speaker. 
B: Press "Test all Speakers" and a white noise signal will be played in series 
C: Adjustment for the Speaker - Gain in dB

**Control parameters for distance and Ambisonics weighting:**
![[./_resources/Decoder.resources/Speaker_settings.1.png]]
                A: Determine the absolute distance of your space (meters) —> Ex. 4.8m
                B: Choose the Channel weight. (Default = calculate in-phase)
                C: Flip direction flips Y-axes (left<->right)

**ZOOM the AmbiDecoder Window:** (Animation)
![[./_resources/Decoder.resources/ZDec_02_zoom.gif]]

**Decoder\_specification:**

* * *

\[1\]. Ambisonics-Converter Plugins (ambix\_converter – convert between different ambisonic standards on the fly (include different standards in one project), also between 2D/3D)

* * *

