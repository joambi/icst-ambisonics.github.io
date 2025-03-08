---
tags: 
title: 03_how_it_works
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

----

The ICST Ambisonics plugins are designed for an intuitive and easy-to-use workflow. 
In this tutorial, we will show you three “how it works” workflows.

To create Ambisonic content, we need the following workflow setup in our DAW:   
-  Mono sources   
- Encoder for the mono movement or placement  
- A B-format master track for bouncing or recording the encoded files  
- A decoder for decoding the B-format (encoded data) for the physical speaker arrangement or binaural (headphone) monitoring.

Overview for the easy signalflow:
  ![01_easyworkflow](content/ICST%20Ambisonics%20Plugins/03_how_it_works/01_easy_workflow.png)
This image shows a schematic representation of a paradigmatic Ambisonics workflow.

The next image shows a schematic overview of the signal flow of the ICST Ambisonics plugins.
![0_workflow_](content/ICST%20Ambisonics%20Plugins/03_how_it_works/02_workflow.png)
In the DAW Reaper, it looks like this:
![03_reaper_workflow](content/ICST%20Ambisonics%20Plugins/03_how_it_works/03_reaper_workflow.png)
-  Master output
- Decoder
- Bformat master
- Bformat (ambiX) player
- MultiEncoder with 16-channel mono source as children tracks.
Of couse your ar free to create your own workflow (see in workflow  '03_step_by_step')

----

## 01 Quick start with the ICST_AmbiPlugins_MultiEncoder.RPP  
  
This workflow is the quick start with the MultiEncoder template.

1. Open the Reaper DAW
2. Open “ICST_AmbiPlugins_MultiEncoder.RPP” via the Reaper menu.
3. Save the template under a new name.

![open_multiencoder_temp](content/ICST%20Ambisonics%20Plugins/03_how_it_works/open_multiencoder_temp.gif)


## 02 Open the TrackTemplates

1. Right-click in the empty Reaper track field
2. Select 'Insert track from template
3. Select the desired 'TrackTemplate'

![tracktemplate.png](content/ICST%20Ambisonics%20Plugins/03_how_it_works/tracktemplate.png)
Make sure you create the correct audio routing from channel track to channel track!

----

## 03 step by step setup

This tutorial assumes that you have already installed Reaper, the ICST Ambisonics plugins, and all other recommended third-party plugins!

### So let's create this template for Reaper together step by step.

We begin from the top down:

1. Open a empty Reaper session
    ![empty_reaper](content/ICST%20Ambisonics%20Plugins/03_how_it_works/empty_reaper.png)
2. Double-click in the empty field in Reaper or open a new track from the menu.
3. Name this track 'decoder' and remove the master bus.
    ![01_dec](content/ICST%20Ambisonics%20Plugins/03_how_it_works/01_Decoder_A.gif)

> [!Tip:]
>  Generally, always enter 64ch tracks and 'routing'.

- The decoder routing for this example is an octagon.
	- Inputs = 64ch from 'Bformat Master track'
    - Outputs = 8 channels to your audio interface
4. Add ICST AmbiPlugins 'Decoder in the FX
   ![open__FX_decoder](content/ICST%20Ambisonics%20Plugins/03_how_it_works/FX_Decoder.png)
5. open the AmbiDecoder
   ![open_decoder](content/ICST%20Ambisonics%20Plugins/03_how_it_works/open_decoder.gif)
6. Choose the speaker-preset. (in this example the octagon)
    ![open_dec](content/ICST%20Ambisonics%20Plugins/03_how_it_works/choose_dec_preset.gif)
7.Now select your AmbiDec settings
- Ambisonics weighting
- Ambisonics order (1. to 7th order)
![Dec-setting](content/ICST%20Ambisonics%20Plugins/03_how_it_works/7_choose_dec_setting.gif)
8. If everything is set up correctly in this AmbiDec setting, you can test your 8 speakers.
- Press the “Speaker Test” button or each speaker individually, and you will hear “white noise” in each of the 8 speakers.
![speaker_test](content/ICST%20Ambisonics%20Plugins/03_how_it_works/speaker_test.png)
> [!Tip:]
> If you don't hear the sound, make sure the output routing is correct.

> [!Attention:]
> Watch your volume!


9. Create the 'Bformat-Master track'
![02_BF-Master](content/ICST%20Ambisonics%20Plugins/03_how_it_works/02_BF-Master.gif)

The 'Bformat-Master' track should receive all outputs from these tracks:
- All ambient encoders
- All BFormat_SFX
- All BFormat players
Since it is the master track we need to bounce or record our final B-format.
So in the future, route all outputs that contain or generate a B-format signal to this 'B-format master track'!
We will therefore color it red.
It is also the only track that leads to the AmbiDecoder and in parallel to a binaural track.

10. Create a B-Format player track with (64 channels) and route this track into the B-Format master track.
![bformat-player](content/ICST%20Ambisonics%20Plugins/03_how_it_works/bformat-player.png)
> [!Tip:]
With this method, you can play back any B-Format from the 1st to the 7th order.

Example A shows a first-order b-format Ambisonic.
![1.order_bf](content/ICST%20Ambisonics%20Plugins/03_how_it_works/first-order.png)
Example B shows a 5th-order b-format Ambisonic.
![5th-order_bf](content/ICST%20Ambisonics%20Plugins/03_how_it_works/5th-order-bf.png)
Now we can play back and listen to B-format files on eight speakers.
11. So that we can also listen to the B format using headphones, we will now create a decoder for binaural listening. 
	- Create a new 64channel track and open the binaural plugin of your choice in the FX. (in this example the 'DearVR Ambi Micro.vst3')  
	- Move the new track to the top of the Reaper rack.  
	- Then route the output from the 'Bformat-Master track' to this binaural decoder. (as shown in the gif)
![Binaural-track](content/ICST%20Ambisonics%20Plugins/03_how_it_works/Binaural_Track.gif)
- Then we mute the AmbiDecoder track and listen to the binaurally decoded signal through headphones.
![DearVR_binaural](content/ICST%20Ambisonics%20Plugins/03_how_it_works/DearVR_binaurl.png)

>[!Tip:] 
>You can switch between the AmbiDecoder and the Binaural Decoder for an acoustic comparison. Press the 'solo' button on the muted track (on/off).

You will have noticed that a new track (mono source) has already been created in the last two images.  You should now do the same: create a new track called 'Mono-source' and insert a 'Mono-audiofile' into it. Please note that this channel also contains a 64-channel bus in the 'Route'! 

12. Mono AmbieEncoder overview.
	![open monoencoder](content/ICST%20Ambisonics%20Plugins/03_how_it_works/MonoEncoder_01.png)

- in the FX, open the 
![open_MonoEncoder](content/ICST%20Ambisonics%20Plugins/03_how_it_works/MonoEncoder_load.png)
Overview of the ICST MonoEncoder:
![MonnoEncoder](content/ICST%20Ambisonics%20Plugins/03_how_it_works/MonoEncoder.png)
13. Record the MonoEncoder movements in the Reaper-Track:
![rec_movement](content/ICST%20Ambisonics%20Plugins/03_how_it_works/record_movement.gif)
14. Play the recorded movement.

