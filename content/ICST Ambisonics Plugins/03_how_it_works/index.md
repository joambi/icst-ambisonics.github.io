---
tags:
title: How it Works
date: 2025-02-01T19:26:00
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

----

### Intuitive Ambisonics Workflow with ICST Plugins

The **ICST Ambisonics plugins** are designed for a seamless and intuitive workflow.
In this tutorial, we’ll guide you through three essential **"how it works"** workflows.

### Setting Up an Ambisonic Workflow in Your DAW

To create **Ambisonic content**, your setup should include:

- **Mono sources** – Individual sound sources
- **Encoder** – Positions or moves mono sources in the Ambisonic field
- **B-format master track** – Captures the encoded audio for bouncing or recording
- **Decoder** – Converts B-format audio for speaker playback or binaural headphone monitoring

#### Signal Flow Overview

Below is a schematic representation of a **typical Ambisonics workflow**:
  ![01_easyworkflow](01_easy_workflow.png)

The next image provides an **overview of the ICST Ambisonics plugin signal flow**:
  ![0_workflow_](02_workflow.png)

In **Reaper**, the signal flow appears as follows:

  ![03_reaper_workflow](03_reaper_workflow.png)

- **Master Output**
- **Decoder**
- **B-format Master**
- **B-format (ambiX) Player**
- **MultiEncoder** with 16-channel mono sources as child tracks

![Ambi_Signalflow](Ambi_Signalflow.jpg)

Of course, you can also customize your workflow to fit your needs!

----
©2025 ICST