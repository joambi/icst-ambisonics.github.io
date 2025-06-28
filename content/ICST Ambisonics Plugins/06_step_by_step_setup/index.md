---
title: 06_step_by_step_setup
date: 2025-01-23T15:38:00
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

---
# Step-by-Step Setup Guide for the ICST AmbiPlugins in Reaper

---
### Prerequisites

Before we begin, make sure you have **Reaper**, the **ICST Ambisonics plugins** and any recommended **3rd party plugins**installed.

### Creating a Reaper template

We will create the template step by step from top to bottom.

#### 1. Prepare Reaper

1. Open a **new, empty Reaper session**.
    ![empty_reaper](empty_reaper.png)
2. Create a new track (**double click** or use the menu).
3. Name the track **Decoder** and remove the master bus.
    ![01_dec](01_Decoder_A.gif)

> [!Tip:]
>  Create all tracks with **64 channels** by default and keep an eye on the **routing**.

#### 2. Set up decoder routing

-  **Decoder routing for an Oktagon setup:**
- **Inputs:** 64 channels from the “Bformat Master Track”  
- **outputs**: 8 channels to the audio interface
1. **ICST AmbiPlugins Decoder** in the **FX window**.
   ![open__FX_decoder](FX_Decoder.png)
2. open the AmbiDecoder
   ![open_decoder](open_decoder.gif)
3. Select a **speaker preset** (e.g. Oktagon).
    ![open_dec](choose_dec_preset.gif)
4. **Customize AmbiDecoder settings**:
- Ambisonics Weighting
- Ambisonics Order (1st to 7th order)
  ![Dec-setting](7_choose_dec_setting.gif)5. **Run speaker test**:  
	- press the “Speaker Test” button or test individual speakers.
![speaker_test](speaker_test.png)

> [!Attention:]  Keep an eye on the volume level!


9. Create the 'Bformat-Master track'
![02_BF-Master | 700](02_BF-Master.gif)

#### 3. Create a Bformat master track

- The **Bformat master track** receives all signals from:
- **Ambience Encoders**
- **BFormat SFX**
- **BFormat players**
- Since this is the master track, the final **B format is recorded** or bounced here.  
- This track is colored **red**.
- It leads both to the **AmbiDecoder** and in parallel to a **binaural track**.

#### 4. Create a Bformat player track

- Create a **64-channel track** and route it into the **Bformat master track**.

![bformat-player](bformat-player.png)
> [!Tip:] This allows **B-format files from the 1st to the 7th order** to be played.

#### 5. Enable binaural listening

- Create a new **64-channel track** and load a **binaural plug-in** (e.g. _DearVR Ambi Micro.vst3_).
- Move the track **upwards**.
- Route the output from the **format master** to this **binaural decoder**.
- **Mute AmbiDecoder** to hear only the binaurally decoded signal.  
    
> [!Tip:] Compare with _Solo/Mute_ between AmbiDecoder and Binaural Decoder.


![1.order_bf](first-order.png)
Example B shows a 5th-order b-format Ambisonic.

![5th-order_bf](5th-order-bf.png)
Now we can play back and listen to B-format files on eight speakers.

To be able to listen to the B format through headphones, we will now set up a binaural decoder:  
- Create a new **64-channel track** and load a **binaural plugin** of your choice into the FX window (e.g. _DearVR Ambi Micro.vst3_).
- Move the track **to the beginning** of the Reaper rack.
- Route the **output of the Bformat master track** to this binaural decoder (see GIF).

![Binaural-track](Binaural_Track.gif)
- Mute the AmbiDecoder to hear only the binaurally decoded signal.
![DearVR_binaural](DearVR_binaurl.png)

>[!Tip:] 
>Compare solo/mute between AmbiDecoder and binaural decoder.

### 6. Mono Source & Ambisonics Encoder

- Create a new track Mono-Source and load a mono audio file.

Tip: Watch this  [Video](https://www.youtube.com/watch?v=aDa-vNWriLM&t=119s)

12. Mono AmbieEncoder overview.
	![open monoencoder](MonoEncoder_01.png)
    ![open_MonoEncoder](MonoEncoder_load.png)
- In the FX window, load the ICST MonoEncoder.
- Add a AmbiEncoder(ICST) (1-4) --> Mono-Encoder
Routing:
- MonoEncoder → 64-channel output → Bformat master.

  ![MonnoEncoder](MonoEncoder.png)
#### 7. Record motions in the Reaper track

 Record motions in the MonoEncoder:
 ![rec_xyz](rec_xyz.gif)
 
 Play back saved motion:

![play_xyt](play_xyz.gif)

### 8. Using the Multi-Encoder

In the next example, I'll demonstrate how we use the **Multi-Encoder**:

1. **Insert the Multi-Encoder Track**

    - Right-click in the empty Reaper track area and select **“Insert Track from Template”**.
    - Navigate to **ICST AmbiPlugins** and choose **“ICST_AmbiEncoder_Multi_8src”**.
    - This will open a Multi-Encoder with **8 mono sources**, already routed into the encoder.

    ![MultiEncoder_routing | 550](MultiEncoder_routing.png)
	2. **Controlling Sources in the Multi-Encoder**

	- If the routing is set up correctly, you can now control the **placement and movement** of up to **8 sources** within the Multi-Encoder.
### AmbiEncoder Settings

  3. Understanding AmbiEncoder Settings**- The **AmbiEncoder settings** are crucial for your workflow. - The following GIF showcases the key **AmbiEncoder features**:  

        ![Enc_Settings](Enc_Settings.gif)
	 ![Enc_Settings](Enc_Settings.gif)

>[!Tip: ] Watch the AmbiEncoder [Video tutorial](https://www.youtube.com/watch?v=aDa-vNWriLM&t=31s)  for more details.

4. **ICST Distance Function**
    - A unique feature of the **ICST Ambisonics Encoder** is its **distance function**, developed by **Martin Neukom** at ICST.
    - This function allows you to create various **spatial configurations**, simulating movement speeds from very fast to extremely slow.
      ![Distanc_overview](Distance.gif)For in-depth instructions, refer to the **Distance tutorial**.

> [!Tip:] If working with **distance**, define it **at the start** of your project to scale all **XYZ coordinates** correctly. _(Example: Distance scale from 0.0 to 1.0).

### Recording & Editing Source Movements

5. **Recording Movements in the Multi-Encoder**

    - To understand how the Multi-Encoder works, let’s go through a **recording example**:
        - **Set automation envelopes** to **“Write” mode**.
        - Press **Play** (Spacebar) in Reaper and move **Src_1** in the Multi-Encoder Radar.
        - Repeat the process for other sources.
		
		MultiEnc_01_write:
     ![MultiEnc_01_write](MultiEnc_01_write.gif)
     
	  Here’s an example with **Src_3**:
	  
       ![Encoder_move_03](Move_03.gif)

Here’s an example with **Src_3**:The next step demonstrates how to manually edit the xyz envelopes.
![Manuel_edit](MultiEnc_Manuell_edit.gif)

6. **Manually Editing XYZ Envelopes**

	- To refine movements, manually adjust the **XYZ envelopes**:
	- Hold **Shift** and click on the envelope to create a new edit point.
	- Move the point to adjust the **XYZ coordinates**.

7. Playing Back the Recorded Ambisonic Scene

![MultiEnc_plays_scene](play_multienc.gif)

### Working with Groups

8. **Creating a Group in the Multi-Encoder**
    
    - In the **Radar Display**, select multiple **Src points** to form a group.
    - Assign a **group name** (e.g., **G1**).

![create_a_GP](GP_select_scaled.png)
![GP_name](GP_edit_scaled.png)

9. **Recording Group Movements**

- Choose a recording mode:
    - **“Latch”** – Records only one source point.
    - **“Touch”** – Starts recording when a point is touched.
    - **“Write”** – Overwrites previous recordings.
     ![Rec_GP](Rec_GP.gif)
	
	9. **Playback & Evaluation**
     ![Play_GP](play_GP.gif)
	- Listen to the final **group movement recording** via **speakers (Decoder)** or **headphones (Binaural Decoder)**.

### Finalizing & Exporting

11. **Rendering the B-Format Master**
	- Once satisfied, follow these steps to **export the B-Format**:
	    - Select **Bformat-Master Track** and set it to **Solo**.
	    - Open **Menu > Render**.

**Render Settings:**

  ![Render_Master | 200](render-master.png)


1. **Select Track (Stem Render)** → Choose **Bformat-Master**.
2. **File Name** → Assign a **B-Format filename**.
3. **Sample Rate** → 48,000 kHz.
4. **Channels** → 64 (for **7th-order Ambisonics**).
5. **Multichannel Format** → Set to **Multichannel Files**.
6. **Large File Support** → Use **Wave/RF64**.
7. **Click “Render”**.

Rendering-info:
     ![render-info](render_info.png)
		After the rendering process, you will get a Rendering Info window with the Peak and LUFS information.

8. That's all, now you can drag and drop your B-Format onto the B-Format player track, set it to “Solo” and listen to the final result via the ICST decoder or the binaural decoder.


🎧 Happy ambisonics!

---
©2025 ICST