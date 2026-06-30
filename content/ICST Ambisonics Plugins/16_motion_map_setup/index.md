---
title: Motion Map Setup
date: 2026-06-28T00:00:00
weight: 88
draft: false
toc: true
translationKey: motion-map-setup
description: "Step-by-step installation for the ICST Ambi Motion Map — loading Lua scripts into REAPER and configuring Python for live OSC preview. macOS and Windows."
---

Level: Beginner | Audience: Composer, sound designer, spatial-audio technician.

This page covers everything you need to install before using the [Motion Map GUI](/icst-ambisonics-plugins/15_icst_ambi_motion_map/): loading the Lua scripts into REAPER and — if you want live OSC preview — verifying your Python 3 installation. No additional Python packages are required.

---

## What you need

| Component | Required for | Where to get it |
|-----------|-------------|-----------------|
| REAPER v6+ | Running the scripts | [reaper.fm](https://reaper.fm) |
| ICST AmbiEncoder_64 | Writing automation | [Downloads](/icst-ambisonics-plugins/08_downloads/) |
| Motion Map Bundle | The scripts themselves | [Download below](#download-the-bundle) |
| Python 3 | Live OSC preview only | Pre-installed on macOS 12+; [python.org](https://www.python.org/downloads/) on Windows |

{{< notice warning >}}
Python 3 is **only needed for live OSC preview**. Writing automation works without it.
{{< /notice >}}

---

## 1. Download the bundle

Download the [ICST Ambi Motion Map Bundle](/downloads/ICST_Ambi_Motion_Map_Bundle.zip) and unzip it. You will find two Lua files:

```
JS_AmbiEncoder64_Motion_Map_GUI.lua          ← load this one into REAPER
JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua  ← keep in the same folder
```

Place both files in a permanent location — for example your REAPER Scripts folder:

- **macOS:** `~/Library/Application Support/REAPER/Scripts/`
- **Windows:** `%APPDATA%\REAPER\Scripts\`

{{< notice warning >}}
Both files must always stay in the **same folder**. The GUI finds the writer by looking in its own directory at runtime.
{{< /notice >}}

---

## 2. Load the script into REAPER

1. Open REAPER.
2. Go to **Actions → Load ReaScript…**

   ![REAPER Actions menu](actions-menu.png)

3. Navigate to the folder where you saved the bundle.
4. Select `JS_AmbiEncoder64_Motion_Map_GUI.lua` and click **Open**.

   You only load the GUI script — the writer is called automatically.

5. REAPER confirms: *"Script loaded successfully."*

---

## 3. Run the script for the first time

1. In REAPER, select a track that contains **ICST AmbiEncoder_64** as an FX.
2. Set a time selection (loop range) in the timeline.
3. Open **Actions → Show action list…** (or press `?`).
4. Search for `JS_AmbiEncoder64_Motion_Map_GUI`.
5. Click **Run** — the Motion Map window opens.

---

## 4. Assign a keyboard shortcut (recommended)

In the Actions window:

1. Find `JS_AmbiEncoder64_Motion_Map_GUI` in the list.
2. Click **Add…** next to the *Shortcut* field.
3. Press the key combination you want (e.g. `Ctrl+Shift+M`).
4. Click **OK**.

From now on, that shortcut opens the GUI instantly.

---

## 5. Python setup for live OSC preview

The live OSC preview sends position data to the AmbiEncoder in real time so you can hear movement before committing it as automation. It uses a small Python helper that relies only on Python's built-in `socket` and `struct` modules — **no pip install is needed**.

### Check if Python 3 is already installed

Open a terminal (macOS: **Terminal.app** / Windows: **Command Prompt** or **PowerShell**) and run:

```bash
python3 --version
```

If you see something like `Python 3.11.4`, you are ready. Skip to [step 6](#6-configure-osc-in-reaper).

### macOS — install Python 3

**Option A — Xcode Command Line Tools** (simplest):

```bash
xcode-select --install
```

Follow the on-screen prompt. This installs `python3` at `/usr/bin/python3`.

**Option B — Homebrew** (recommended if you already use Homebrew):

```bash
brew install python
```

After installation, verify:

```bash
python3 --version
```

### Windows — install Python 3

1. Go to [python.org/downloads](https://www.python.org/downloads/).
2. Download the latest **Python 3.x** installer.
3. Run the installer. **Important:** check *"Add Python to PATH"* before clicking Install.
4. After installation, open a new Command Prompt and verify:

```cmd
python3 --version
```

   If that fails, try `python --version` — some Windows installs use `python` instead of `python3`. The GUI tries both automatically.

{{< notice warning >}}
On Windows, if Python is installed from the Microsoft Store, the `python3` command may not work from scripts launched inside REAPER. If OSC preview fails, use the [python.org](https://www.python.org/downloads/) installer instead, which adds Python to PATH correctly.
{{< /notice >}}

---

## 6. Configure OSC in REAPER

The OSC preview sends UDP packets to REAPER's built-in OSC listener, which the AmbiEncoder_64 responds to.

1. In REAPER: **Preferences → Control/OSC/web** (or **Options → Preferences → Control/OSC/web**).
2. Click **Add** in the *Control surface / OSC / web* list.
3. Choose **OSC (Open Sound Control)** as the mode.
4. Set the **Local listen port** — for example `9001`.
5. Leave *Allow binding…* enabled.
6. Click **OK** and close Preferences.

Back in the Motion Map GUI:

- Set **Host** to `127.0.0.1`
- Set **Port** to `9001` (must match what you set in step 4 above)
- Click **Connect**

The status dot turns green when the Python helper starts successfully.

---

## 7. Test the full setup

1. Open the Motion Map GUI.
2. Enable source S0 and assign **Circle** as its shape.
3. Click **Connect** in the OSC Preview section — status dot turns green.
4. Enable **Live Preview**.

You should see the AmbiEncoder_64 plugin display moving in a circle. If it does, both the Lua scripts and Python OSC are working correctly.

---

## Troubleshooting

### "Script loaded, but writer not found" error when clicking Write

The two Lua files are not in the same folder. Move `JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua` into the same directory as `JS_AmbiEncoder64_Motion_Map_GUI.lua` and reload the GUI.

### OSC connect — status dot stays red

Check each of these in order:

1. **Python 3 installed?** Run `python3 --version` in a terminal.
2. **Port matches?** REAPER OSC listen port must equal the Port field in the GUI.
3. **REAPER OSC enabled?** Preferences → Control/OSC/web — confirm the OSC entry is listed and not disabled.
4. **Firewall?** On Windows, a firewall dialog may block UDP on first use. Allow access.
5. **Restart:** Click Disconnect, then Connect again to restart the Python helper.

### macOS — `python3` not found after xcode-select install

Run:

```bash
sudo xcode-select --reset
python3 --version
```

### Windows — `python3` not recognized

If Python is installed but `python3` is not recognized, the GUI falls back to `python` automatically. If neither works, reinstall from [python.org](https://www.python.org/downloads/) with *"Add to PATH"* checked.

---

## Next steps

Once setup is complete:

- [Motion Map User Guide](/icst-ambisonics-plugins/15_icst_ambi_motion_map/) — full walkthrough of all features
- [ICST Ambi Motion Markers](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) — cue-based spatial movement alternative
