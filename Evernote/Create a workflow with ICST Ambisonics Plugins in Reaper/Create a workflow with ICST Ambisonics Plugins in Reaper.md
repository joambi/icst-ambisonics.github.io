---
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *

This tutorial assumes that you have already installed Reaper, the ICST Ambisonics plugins, and all other recommended plugins!
(-> see [Installation](https://workshop-ambisonics.postach.io/post/04-1-step-by-step-setting-up-the-icst-ambisonics-plugin-template))

* * *

## ICST Ambisonics Plugins Basic Template Overview

![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/Bildschirmfoto 2022-11-16 um 16.54.32.png]]

* * *

### So let's create this template for Reaper together step by step.

![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/Bildschirmfoto 2022-11-16 um 15.04.32.png]]

### Decoder Track

Open the Reaper Digital Audio Workstation (DAW)
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/e843ddb23139291ce1a8695feaa7494c.png]]
Create a new track in Reaper.
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/e7dbdd995a9c15829909741c2af92371.png]]
Remove the master output. (Alt & click)
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/7c07eed90c061c0abb0d40a3df8884a6.png]]
 Configure in 'Route' the 'ICST Ambisonics Decoder ' in 3rd-Order Ambisonics.

* Track channels = 16 (since the decoder in our example expects a 16-channel interleaved audio signal in Third-Order Ambisonics at the input).
* For this example, we have chosen the 8th circuit for our speaker setting. So we need eight physical outputs.

![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/09981c6202879f67beed956cd1d69c98.png]]
  Click on "FX"; this opens the effect selection in Reaper (All Plugins). In the filter, you can enter "ICST", which will take you directly to the ICST plugins.
		For our example, select "VST3:AmbiDecoder\_O3\_64CH (16->64ch)".

* VST3:AmbiDecoder\_O3\_64CH (16->64ch) means
* VST3 = latest VST standard
* AmbiDecoder\_O3\_64CH = Ambisonics Decoder 3rdOrder for 64-channels.
* The plugin expects a 16-channel input and can output up to 64 channels.

![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/755314c5ea7bafa0aa744cc28cb1015c.png]]
Select your speaker setting (for this example, the "Octagon"(8) --> press "Apply."
     ◦ or select it from the preset list.

![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/6ffb0838caa4d97a32d07bba1b8caf1e.png]]![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/e4f489eb05757e192f748162afe79d9a.png]]
To make further settings, please click on the gear wheel.
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/73d8398df2fb2415db3cafffd5115ccb.png]]
The decoder settings window "Speaker settings" opens, where you can make further settings for the ICST decoder.
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/48a77728571d1f13aed14bab09d5ad93.png]]
The decoder is set. You can find more information in the "Help" or our Wiki under Decoder specifications.
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/Bildschirmfoto 2022-11-16 um 14.44.57.png]]![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/b33bda682c92519205d92b069ec5ee7c.png]]
Show also here: [DECODER](https://ambisonics.ch/post/the-icst-ambisonics-decoder)

* * *

### Binaural Decoder Track

Repeat the decoder steps above for the binaural decoder track and load the FX 'dearVR AMBI MICRO' instead of the 'ICST Decoder Plugin.'
Note: The audio routing looks a little different from the decoder! Because for Binaural, we need 16ch from the B-Format master (3rd order Ambisonics), but only 2ch (Binaural) for the output. So choose the physical audio output that your headphones are connected to.
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/Bildschirmfoto 2022-11-16 um 15.14.25.png]]
Note: The audio routing looks a little different from the decoder! Because for Binaural, we need 16ch from the B-Format master (3rd order Ambisonics), but only 2ch (Binaural) for the output. So choose the physical audio output that your headphones are connected to.

* * *

### Bformat Master Track  

 With the keyboard command "command & T" we can create a new track.
We can give this track a nice color.
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/0de1f89fc0b2ca9ed639ff94b73d16bc.png]]
We call it theSend 16-channel B-format to the decoders It should also be specified in the routing with 16 channels. Because this track, receives all encoder tracks and sends them to the decoder and the 'Binaural Decoder' (DearVR Ambi Micro).
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/Bildschirmfoto 2022-11-16 um 15.20.36.png]]
The 'B-Format Master' track contains all encoded B-formats or B-formats recorded with microphones (here in the example 3rd-order).

* * *

### ICST Encoder Track  

Exactly these 'ICSTEncoder' tracks we want to create now.
Now create two new tracks and give them both this routing. 16-channel track input and a 16-channel send to the 'B-Format Master.
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/ec50767771367e861156b3deedaba79e.png]]
Good, now we can load the ICST Encoder plugins.
Click on "FX"; this opens the effect selection in Reaper (All Plugins). In the filter, you can enter "ICST", which will take you directly to the ICST plugins.
For the 'ICST Encoder-Mono' and the FX 'ICST Multi-Encoder.' (see further below)
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/Bildschirmfoto 2022-11-16 um 15.50.15.png]]
Load an ICST AmbiEncoder-Mono and once an ICST AmbiEncoder-Multi under "FX."
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/4bc57e75e69c8daba1d0c7b9525aaf2b.png]]
The AmbiEncoder-Mono (1 -> 16ch) expects a mono audio signal as input and sends 16ch to the 'B-Format Master' in the third order.
The ICST AmbiEncoder-Mono automatically receives the name of the Reaper track in which it is hosted. (here " ICST Encoder-Mono").
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/756f6291d9fdaefbbf81f8ab605bdf77.png]]
The AmbiEncoder-Multi (64 -> 16ch) expects 64 times a mono audio signal as input and sends in third order (16ch) to the 'B-Format Master. '
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/Bildschirmfoto 2022-11-16 um 15.46.22.png]]
This is the 'Routing-window' from 'B-Format Master' after the routing with the ICST Encoders.
By default, the ICST-AmbiEncoder-Multi receives one source (here, "1"). To receive multiple sources (max. 64), we must select them in the "Encoder Settings." Click on the gear in AmbiEncoder\_O3\_64CH (64->16ch) or double-click in the radar.
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/73d8398df2fb2415db3cafffd5115ccb.png]]![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/4cabad9e0b78e84e58833082dc7898e7.png]]
Select the source numbers you want to activate and give them a nice color. In the radar, you need to drag the number from the center of the radar and drop it in the desired position.
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/6577d65623af5eff85cf6924b0cf02a8.png]]
Depending on the settings of the distance parameters and the number of selected sources, the volume of the AmbiEncoder is calculated. Often it is necessary to turn up the "Master Gain" control a little bit because the encoded signal can be very quiet (see also ICST AmbiEncoder-Multi).

* * *

The following figure shows the ICST mono encoder.
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/Bildschirmfoto 2022-11-16 um 16.12.27.png]]
With the 'Routing' to the 'B-Format Master' track.
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/4be19cf67dce769d1c04267389e8f7c9.png]]
In AmbiEncoder-mono, each track is spatially layered with its mono audio file. This has the advantage of moving or editing the automation in sync with the audio.

* * *

Create four new mono audio tracks in Reaper and name them "Source\_01...source04 (Image). Unlike AmbiEncoder-Mono, we need to route the 'mono-sources' (mono tracks) to the ICST Multi Encoder.
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/50bffecc6df3888085c2856e9bd9b01d.png]]
This routing looks like the following image.
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/Bildschirmfoto 2022-11-16 um 16.08.26.png]]
The four mono audio signals from \[Source\_01...Source04 \] must now be routed to AmbiEncoder-Multi.
![[./_resources/Create_a_workflow_with_ICST_Ambisonics_Plugins_in_Reaper.resources/613eb8871966994329db6e20cf1240a9.png]]
In the AmbiEncoder Multi we now receive "Receives" from each "source track" and route them to a movement point in the radar.
Congratulations, you have just created your first Ambisonics Reaper template with the latest ICST Ambisonics plugins!

* * *

Next step -> [Create a workflow from the ICST Track templates](https://ambisonics.ch/post/create-a-workflow-from-the-icst-track-templates)

* * *

<<[Content](https://ambisonics.ch/post/content)
