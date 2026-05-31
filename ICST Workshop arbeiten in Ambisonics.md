---
categories:
  - ICST Ambisonics Workshop
date: 2026-05-18T12:26:00
---
----
  
# **ICST Ambisonics**

Institute for Computer Music and Sound Technology (ICST)
Zurich University of the Arts (ZHdK)

Date and time: Tuesday 19 May 2026, 13:00 to 17:00
- Language: English

**Learning objectives**
After the workshop, participants will be able to:
•  explain the Ambisonics signal flow from recording to playback
•  set up and route a Zylia ZM-1 HOA recording in Reaper
•  position sound sources in three-dimensional space using the ICST AmbiEncoder_64
•  convert FOA/HOA material between FuMa and AmbiX formats
•  carry out a guided practical exercise (encoding → mixing → decoding) independently

> [!NOTE]
> Participant preparation
> •  Reaper is pre-installed on all studio computers (v7+, incl. ICST plugins)
> •  Please bring your own headphones (binaural monitoring)
> •  Download the pre-configured Reaper session in advance from the ICST website
---

### 1  Workshop schedule (4 hours)
Total duration: 240 minutes (including a 10-minute break)

|             |                                     |              |                   |
| ----------- | ----------------------------------- | ------------ | ----------------- |
| **Time**    | **Content**                         | **Duration** | **Content block** |
| 13:00–13:10 | **Getting started**                 | 10'          | —                 |
| 13:10–13:40 | **Preparation & Perception**        | 30'          | A                 |
| 13:40–14:20 | **Recording basics**                | 40'          | B                 |
| 14:20–14:35 | **Formats & Convention**            | 15'          | B2                |
| 14:35–14:45 | ⏸  **Break**                        | 10'          | —                 |
| 14:45–15:15 | Overall Workflow                    | 30'          | A (Part 2)        |
| 15:15–16:15 | Practical session (guided exercise) | 60'          | C                 |
| 16:15–17:00 | Presentation & conclusion           | 45'          | G                 |

---
### 2  Preparation & Perception

Ex.01  **Stereo was a nice try**

---
### 3 Content blocks A – G
An overview of all seven content blocks:

| **ID** | **Block**               | **Content**                                                                                                                                                          |
| ------ | ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **A**  | **Zylia Recording**     | Zylia ZM-1 microphone (19 capsules, 3rd-order HOA). Setup in Reaper: 16-channel track, AmbiDecoder, binaural monitor.                                                |
| **B**  | **Overall Workflow**    | Ambisonics signal flow: Recording → Encoding → Processing → Decoding. Formats: FuMa, AmbiX, HOA orders 1–3.                                                          |
| **C**  | **Reaper workflow**     | Encoding (ICST AmbiEncoder_64), processing (gain, EQ, reverb in the Ambisonics room), decoding (binaural / speakers). Lua automation scripts.                        |
| **D**  | **External Tools**      | Overview: MaxMSP patches and Csound instruments for Ambisonics. → Follow-up workshop recommended.                                                                    |
| **E**  | Csound                  | Csound opcodes for spatial audio ([bformdec2](https://csound.com/manual/opcodes/bformdec2/), [bformenc1](https://csound.com/manual/opcodes/bformenc1/)). → Overview. |
| **F**  | MaxMSP                  | ICST Ambisonics externals for MaxMSP. → Overview                                                                                                                     |
| **G**  | **Composer Discussion** | Guided discussion: Composition strategies with Ambisonics, practical experience, Q&A.                                                                                |
> [!NOTE]
>  Note: Content blocks D (External Tools), E (Csound) and F (MaxMSP) cannot be integrated into the 4-hour framework. They will be discussed and can be covered in a follow-up workshop.
>   

---
### A  Zylia ZM-1 Recording
Microphone specifications
•  19-element capsule array (omnidirectional)
•  Output: 19 raw channels → encoded via Zylia software in 3rd-order HOA (16 channels, AmbiX)
•  Connection: USB-C, no external power supply required

#### Zylia Recording Example: ([zylia_recording_example](http://localhost:1313/downloads/zylia-recording-example/zylia_recording_example.RPP))

**Reaper Session Overview:**
•  Track 1 – Notes:  Notes track (muted)
• Track 2 – Zylia ZM-1: 16 channels, armed for recording, VU: Multichannel Peaks
•  Track 3 – HOA Bus:  16 channels, AUX REC from Zylia, no direct out
• Track 4 – ICST AmbiDecoder: 18 channels (16 in + 2 aux), decoder plugin
•  Track 5 – Binaural Monitor:  2 channels, headphone monitoring
•  Track 6 – HOA Render Bus:  16 channels (muted, for offline rendering)

---

### B Overall Workflow in Reaper (DAW)

Block B is the theoretical introduction — it follows directly after the introduction (demo). Here, we explain what lies behind what you hear. Ambisonics is a channel-format-independent, fully spherical audio system. The signal flow always follows the same principle:

•  Sound source → Encoder (azimuth, elevation, distance) → B-format / HOA bus
•  HOA bus → Processing (EQ, reverb, panning in the Ambisonics space)
•  HOA bus → decoder (binaural, speaker array, stereo downmix)

#### B2 Formats & Standardisation

•  FuMa (Furse-Malham):  Channel order WXYZ, MaxN normalisation, older format
•  AmbiX (ACN / SN3D):  Channel order WYZX (ACN 0–3), newer standard
•  HOA Order 1 (FOA):  4 channels  | Order 2: 9 channels  | Order 3: 16 channels

AmbiX Channel Order (ACN):
- ACN 0:  W  (0th order, omnidirectional)
- ACN 1–3:  Y, Z, X  (1st order)
- ACN 4–8:  2nd order 
- ACN 9–15:  3rd order
  
#### B3 Appendix  FuMa → AmbiX conversion (FOA)

For legacy material in FuMa format (e.g. SoundField, older productions), the ICST script automatically provides a JSFX plugin:

| **FuMa input** | **AmbiX output (ACN)** | **Channel function** | **Gain correction** |
| -------------- | ---------------------- | -------------------- | ------------------- |
| Ch1 = W        | ACN 0 = W              | Omnidirectional      | × √2  = +3.01 dB    |
| Ch2 = X        | ACN 3 = X              | Front/Rear           | × 1/√3  = −4.77 dB  |
| Ch3 = Y        | ACN 1 = Y              | Left/Right           | × 1/√3  = −4.77 dB  |
| Ch4 = Z        | ACN 2 = Z              | Top/Bottom           | × 1/√3  = −4.77 dB  |

•  The Lua script icst_fuma_to_ambix_foa.lua automatically writes the JSFX to the Reaper Effects folder and loads it onto the selected track.
•  Manual alternative: Channel routing via Reaper FX Chain + 4 gain envelopes
 In Reaper -> Actions -> Load new Script --> icst_fuma_to_ambix_foa.lua

DOWNLOAD   

---
### C  Reaper Workflow (Encoding · Processing · Decoding)

#### Encoding with ICST AmbiEncoder_64
•  Plugin: ICST AmbiEncoder_64 (VST3), installed in ~/Library/Audio/Plug-Ins/VST3/
•  Important parameters (parameter index for Lua automation):
•  Param 11 – Azimuth (0 = front, 0.5 = rear, normalised [0, 1] → [−180°, +180°])
•  Param 12 – Elevation (0.5 = centre/horizon, normalised [0, 1] → [−90°, +90°])
•  Param 13 – Distance (0 = near, 1 = far, normalised to room size)
•  Encoding example: Voice at azimuth −45°, elevation +20° → Lua script available

#### Processing
•  EQ and gain on source track (before the encoder)
•  Ambisonics reverb (e.g. Ambix Reverb) on HOA bus track
•  Automation: Lua envelopes via GetFXEnvelope + InsertEnvelopePoint

#### Decoding

•  Binaural:  ICST AmbiDecoder with HRTF file → 2-channel headphone output
•  Speakers:  Decoder with speaker array configuration (.spk file)
•  Screensets:  Ctrl+Alt+1 (Recording), Ctrl+Alt+2 (Mixing), Ctrl+Alt+3 (Decoding)

### Resources & Downloads

**ICST Website**
• [icst-ambisonics.github.io](https://github.com/schweizerweb/icst-ambisonics-plugins/releases) –-> Documentation, Lua scripts, Reaper sessions
• [ambisonics.ch](https://ambisonics.ch/)--> Best practices & Tutorials 

**Downloads** (on the website)
•  zylia_recording_example.RPP – Preconfigured Reaper session for Zylia ZM-1
•  icst_ambi_encoding_voice.lua – Encoding example: voice at azimuth −45°, elevation +20°
•  icst_ambi_zug_langsam.lua – Slow train (28 s, physics-based trajectory)
•  icst_ambi_zug_schnell.lua – Fast train (4 s, Doppler-like effect)
•  icst_ambi_zug_vergleich.lua – Pause + Slow + Pause + Fast in sequence
•  FuMa_to_AmbiX_FOA.jsfx – JSFX plugin for FuMa→AmbiX FOA conversion
•  icst_fuma_to_ambix_foa.lua – Lua installer for the JSFX plugin

**External references
•  IEM Plug-in Suite  –   iem.kug.ac.at  (free Ambisonics VST3 plugins)
•  Ambix Tools  – matthiaskronlachner.com/ambiX  (encoder/decoder/rotator)
•  Zylia ZM-1  –   zylia.co  (microphone and conversion software)
•  REAPER  – cockos.com/reaper (DAW, v7+ recommended)


