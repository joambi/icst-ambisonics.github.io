---
weight: 50
tags:
title: How it Works
date: 2025-02-01T19:26:00
---

Reference outline of the standard Ambisonics signal flow in REAPER: source, encoder, B-format bus, and decoder.

## Core workflow model

To create **Ambisonic content**, your setup should include:

- **Mono sources** – Individual sound sources
- **Encoder** – Positions or moves mono sources in the Ambisonic field
- **B-format master track** – Captures the encoded audio for bouncing or recording
- **Decoder** – Converts B-format audio for speaker playback or binaural headphone monitoring

### Signal flow overview

The following image shows a typical Ambisonics workflow:
  ![01_easyworkflow](01_easy_workflow.png)

The next image shows the ICST plugin signal flow:
  ![0_workflow_](02_workflow.png)

In **REAPER**, the signal flow appears as follows:

  ![03_reaper_workflow](03_reaper_workflow.png)

- **Master Output**
- **Decoder**
- **B-format Master**
- **B-format (ambiX) Player**
- **MultiEncoder** with 16-channel mono sources as child tracks

![Ambi_Signalflow](Ambi_Signalflow.jpg)

Of course, you can also customize your workflow to fit your needs!

----
