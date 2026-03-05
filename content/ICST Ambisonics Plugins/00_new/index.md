---
title: What's New
date: 2025-11-03T16:13:00
weight: 20
---

Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

----
# ICST Ambisonics Plugins v3.2 

_**Now Available!**_

**Download:**  
🔗 **GitHub Releases**  
[GitHub Releases](https://github.com/schweizerweb/icst-ambisonics-plugins/releases)

We’re pleased to announce **v3.2**, featuring a major update to the **Multi-Decoder**, new user interface layouts, enhanced filter options, improved OSC control, and numerous workflow improvements based on ongoing empirical research at ICST.

📖 **Full Documentation:**  
🔗 [**Wiki**](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)


---
# ICST AmbiDecoder v3.2

## **New Features & Improvements**

### Bidirectional Solo & Mute
- Easily solo or mute individual loudspeakers or groups.
- **Keyboard shortcuts (macOS):**  
	`Shift + Control + S` / `Shift + Control + M`

  ![bidi_mute](bidi_mute.gif)
### Redesigned Layout
A clearer and more modular structure:
- **Speaker Settings**
- **Decoder Settings**
- **Filter Options**
- **Additional Features** _(coming soon)_
  ![New_layout](Layout_v3_1.png)
### New CSV Export & Preset Management
- Export speaker coordinates to **CSV** for use in Max (and vice versa).
- Backup and export all presets as **XML**.
- Import preset backups directly.

![CSV](Speaker_setting_managment.gif)
### Improved Filter Interface

- Eight new filter options
- Updated UI for easier comparison and tuning

	![filters](filters.png)
	![filter UI](filter_UI.png)

### New Multi-Decoder Mode

- Four fully independent decoders
- Custom names and colors
- Per-decoder loudspeaker selection
- Independent Ambisonics order, weighting, filters, mute, and gain
- Precise spatial tuning for complex arrays

📖 **Multi-Decoder Tutorial:** [ICST AmbiDecoder – Multi-Decoder Mode](content/ICST Ambisonics Plugins/09_icst_multidecoder)
![MultiDecoder](Multidecoder.png)

### New Project-templates

- ICST_AmbiPlugins_MonoEncoder
- ICST_AmbiPlugins_MultiEncoder

### New Track Templates

- ICST AmbiPlugins
  ![ICST | 400](Track_temp_icst.png)
- ICST AmbiPlugins 3rdParty
  ![3rdParty | 400](Track_temp_3rd.png)

---
# **ICST AmbiEncoder v3.2**

## New Features & Layout

- New tap-based layout structure
- Ambisonics order selector
- Bidirectional solo & mute

![Enc_layout](Enc_layout.png)
🔹 **Example:** Layout

![Enc_M_S](Enc_M_S.gif)
🔹 **Example:** Mute & Solo (bidirectional)

## **OSC Control**

Control groups via OSC using **absolute Euler angles**:
- Activate OSC input (e.g., **50001**)
- Send absolute angles from external tools (Max, TouchDesigner, etc.)
- Smooth, precise rotation and movement of encoded sources

![absolut_angel](OSC_abs_angel.gif)
🔹 **Example:** OSC from Max 9.0+ to ICST AmbiEncoder  

💡 For more details, visit the [Wiki](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder).

---
# **Bug Fixes**

- Decoder audio output initialization fixed
- Radar frame visibility issue resolved
- Point label flipping corrected
- Crash caused by closing OSC windows in the wrong order resolved
- Updated the tutorial link in the Help section
- Speaker test updated: White-Noise → **Pink-Noise**

---
<span style="font-size:9px;color:#9f9f9f;">©2025 ICST</span>