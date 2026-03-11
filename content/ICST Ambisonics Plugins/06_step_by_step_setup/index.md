---
weight: 70
title: Step by Step Setup
date: 2025-01-23T15:38:00
---

# Step-by-Step Setup Guide for the ICST AmbiPlugins in Reaper

---
### Prerequisites

Before we begin, make sure you have **Reaper**, the **ICST Ambisonics plugins**, and any recommended **3rd-party plugins** installed.

> [!Important]
> Recommended baseline before starting:
> - Reaper project sample rate: **48 kHz**
> - All Ambisonics tracks set to **64 channels**
> - ICST plugin set installed and visible in the FX browser
> - Audio interface output mapping verified

### Creating a Reaper template

We will create the template step by step from top to bottom.

#### 1. Prepare Reaper

1. Open a **new, empty Reaper session**.
    ![empty_reaper](empty_reaper.png)
2. Create a new track (**double-click** or use the menu).
3. Name the track **Decoder** and remove the master bus.
    ![01_dec](01_Decoder_A.gif)

> [!Tip]
> Create all tracks with **64 channels** by default and keep an eye on routing.

#### 2. Set up decoder routing

Decoder routing for an Oktagon setup:
- **Inputs:** 64 channels from the **Bformat Master** track
- **Outputs:** 8 channels to the audio interface

1. Open **ICST AmbiPlugins Decoder** in the **FX** window.
   ![open__FX_decoder](FX_Decoder.png)
2. Open the AmbiDecoder.
   ![open_decoder](open_decoder.gif)
3. Select a **speaker preset** (e.g. Oktagon).
   ![open_dec](choose_dec_preset.gif)
4. Customize AmbiDecoder settings:
   - Ambisonics weighting
   - Ambisonics order (1st to 7th order)
   ![Dec-setting](7_choose_dec_setting.gif)
5. Run a speaker test:
   - Press the **Speaker Test** button or test individual speakers.
   ![speaker_test](speaker_test.png)

> [!Attention]
> Keep an eye on output volume.

> [!Tip]
> **Routing sanity check (20 sec):**
> 1. Send pink noise or a test signal into the Bformat Master.
> 2. Confirm level activity on Decoder input meters.
> 3. Trigger speaker test and verify output order physically in the room.

#### 3. Create a Bformat master track

Create the **Bformat Master** track:

![02_BF-Master | 700](02_BF-Master.gif)

- This track receives signals from:
  - Ambience encoders
  - B-format SFX
  - B-format players
- This is the main recording/render point for the final **B-format** signal.
- Set the track color to **red** (recommended).
- Route it to the **AmbiDecoder** and in parallel to a **binaural monitor** track.

#### 4. Create a Bformat player track

- Create a **64-channel track** and route it into the **Bformat Master** track.

![bformat-player](bformat-player.png)
> [!Tip]
> This allows **B-format files from 1st to 7th order** to be played.

#### 5. Enable binaural listening

- Create a new **64-channel track** and load a **binaural plugin** (e.g. _DearVR Ambi Micro.vst3_).
- Move the track to the top of your Reaper project.
- Route the **output of Bformat Master** to this binaural track.
- Mute **AmbiDecoder** if you want to monitor only the binaural output.

![Binaural-track](Binaural_Track.gif)
![DearVR_binaural](DearVR_binaurl.png)

> [!Tip]
> Compare playback with **Solo/Mute** between AmbiDecoder and binaural decoder.

![1.order_bf](first-order.png)
Example B below shows a 5th-order B-format Ambisonic file:

![5th-order_bf](5th-order-bf.png)
Now you can play and monitor B-format files on speakers or headphones.

### Naming Convention (recommended)

Use stable names early to avoid routing mistakes:
- `DECODER`
- `BFORMAT_MASTER`
- `BINAURAL_MONITOR`
- `SRC_01` ... `SRC_08`
- `MULTIENCODER_8SRC`

### 6. Mono Source & Ambisonics Encoder

- Create a new **Mono Source** track and load a mono audio file.

Tip: Watch this [Video](https://www.youtube.com/watch?v=aDa-vNWriLM&t=119s)

Mono AmbiEncoder overview:
![open monoencoder](MonoEncoder_01.png)
![open_MonoEncoder](MonoEncoder_load.png)

- In the FX window, load the **ICST MonoEncoder**.
- Add an **AmbiEncoder (ICST)** (1-4) to the mono source.

Routing:
- MonoEncoder -> 64-channel output -> Bformat Master.

![MonnoEncoder](MonoEncoder.png)

#### 7. Record motions in the Reaper track

Record motions in the MonoEncoder:
![rec_xyz](rec_xyz.gif)

Play back saved motion:
![play_xyt](play_xyz.gif)

### 8. Using the Multi-Encoder

In the next example, we use the **Multi-Encoder**:

1. **Insert the Multi-Encoder Track**

   - Right-click in an empty Reaper track area and select **Insert Track from Template**.
   - Navigate to **ICST AmbiPlugins** and choose **ICST_AmbiEncoder_Multi_8src**.
   - This opens a Multi-Encoder with **8 mono sources** already routed into the encoder.

   ![MultiEncoder_routing | 550](MultiEncoder_routing.png)

2. **Control Sources in the Multi-Encoder**

   - If routing is correct, you can control the **placement and movement** of up to **8 sources**.

### AmbiEncoder Settings

3. **Understanding AmbiEncoder settings**

- AmbiEncoder settings are central to the workflow.
- The GIF below shows key AmbiEncoder features:

![Enc_Settings](Enc_Settings.gif)

> [!Tip]
> Watch the AmbiEncoder [Video tutorial](https://www.youtube.com/watch?v=aDa-vNWriLM&t=31s) for more details.

4. **ICST Distance Function**

- A unique feature of the **ICST Ambisonics Encoder** is its **distance function**, developed by **Martin Neukom** at ICST.
- This function enables different spatial configurations, from very fast to very slow movement behavior.
![Distanc_overview](Distance.gif)

For in-depth instructions, refer to the **Distance tutorial**.

> [!Tip]
> If you work with **distance**, define it at the start of the project to keep **XYZ scaling** consistent (example: `0.0` to `1.0`).

### Recording & Editing Source Movements

> [!Tip]
> **Automation mode quick guide:**
> - **Write:** overwrite completely (best for first pass)
> - **Touch:** write only while touching control
> - **Latch:** keeps writing after first touch until stop
>
> For clean results, record in **Write**, then refine in **Touch**.

5. **Recording Movements in the Multi-Encoder**

To understand Multi-Encoder behavior, run this recording example:
- Set automation envelopes to **Write** mode.
- Press **Play** (Spacebar) and move **Src_1** in the Multi-Encoder radar.
- Repeat for other sources.

![MultiEnc_01_write](MultiEnc_01_write.gif)
Example with **Src_3**:
![Encoder_move_03](Move_03.gif)

The next step shows manual editing of XYZ envelopes:
![Manuel_edit](MultiEnc_Manuell_edit.gif)

6. **Manually Editing XYZ Envelopes**

- To refine motion, edit **XYZ envelopes** manually.
- Hold **Shift** and click an envelope to create a new edit point.
- Move the point to adjust XYZ coordinates.

7. **Playing Back the Recorded Ambisonic Scene**

![MultiEnc_plays_scene](play_multienc.gif)

### Working with Groups

8. **Creating a Group in the Multi-Encoder**

- In the **Radar Display**, select multiple **Src points** to form a group.
- Assign a **group name** (e.g. **G1**).

![create_a_GP](GP_select_scaled.png)
![GP_name](GP_edit_scaled.png)

9. **Recording Group Movements**

- Choose a recording mode:
  - **Latch**: records after touching a source
  - **Touch**: records only while touching
  - **Write**: overwrites existing automation

![Rec_GP](Rec_GP.gif)

10. **Playback & Evaluation**

![Play_GP](play_GP.gif)

- Listen to the final group movement via **speakers (Decoder)** or **headphones (Binaural Decoder)**.

### Finalizing & Exporting

### Pre-Render Checklist

Before rendering, confirm:
- **Bformat Master** is soloed
- Ambisonics format/order matches your target pipeline
- No unintended limiter/compressor on the master path
- Filename contains order and take (example: `scene01_O5_take03.wav`)

11. **Rendering the Bformat Master**

Once satisfied, export the B-format:
- Select **Bformat Master** track and set it to **Solo**
- Open **Menu > Render**

**Render Settings:**

![Render_Master | 200](render-master.png)

1. **Select Track (Stem Render)** → Choose **Bformat Master**.
2. **File Name** → Assign a **B-Format filename**.
3. **Sample Rate** → **48,000 Hz**.
4. **Channels** → 64 (for **7th-order Ambisonics**).
5. **Multichannel Format** → Set to **Multichannel Files**.
6. **Large File Support** → Use **Wave/RF64**.
7. **Click “Render”**.

Rendering info:
![render-info](render_info.png)
After rendering, Reaper shows a **Rendering Info** window with peak and LUFS values.

12. Drag and drop the rendered B-format file onto the **Bformat player** track, set it to **Solo**, and verify playback through the ICST decoder or binaural decoder.

### Troubleshooting (Quick)

- **No movement playback:** check automation lane visibility and write/touch/latch mode.
- **No decoder output:** verify send from Bformat Master to Decoder input.
- **Wrong speaker localization:** run speaker test again and verify hardware output mapping.
- **Binaural only / no speakers:** check mute/solo state between Decoder and Binaural track.
