---
title: OSC
date: 2025-01-01T00:00:00
weight: 120
draft: false
description: "Practical entry page for OSC control with the ICST AmbiEncoder: what it can control, first test steps, and where to go for syntax and advanced workflows."
---

Level: Intermediate | Audience: Composer, technician, student, interactive-media user.

Use this page when you want to control the ICST AmbiEncoder from external hardware, sensors, scripts, or network-based controller software.

OSC (Open Sound Control) lets external hardware and software control the ICST AmbiEncoder in real time. Source positions, movement data, and parameter changes can be sent directly into REAPER without touching the encoder interface.

## What OSC does here

OSC is the bridge between the encoder and external control systems. Typical parameters include:

- source position in **AED** or **XYZ**
- source movement over time
- group movement, scaling, or rotation
- gain and mute states
- bidirectional state feedback from the encoder

## Typical use cases

- tablet-based control with **TouchOSC** or **Lemur**
- motion control from **GyrOSC** on iOS
- algorithmic control from **Max/MSP**, **SuperCollider**, or Python
- mapping encoder data to FX parameters
- remote control from a second computer on the same network

## First test in two minutes

For a fast first OSC check:

1. Open a working ICST REAPER session with an encoder already loaded.
2. Open the encoder OSC settings and confirm the input port.
3. Send one simple OSC message from your controller or test environment.
4. Move one source and verify that the change is visible inside the encoder.
5. Confirm that the source also moves audibly in the decoder or binaural monitor.

If this does not work, check:

- the correct UDP port is open
- sender and REAPER are on the same network
- the OSC address matches the supported syntax
- the encoder is the plugin receiving the OSC input

## Start here

- [The 10 Most Important OSC Messages](/post/osc-10-key-messages/)  
  Fast practical entry point with a short setup path and debugging checklist.
- [OSC Syntax Reference](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)  
  Full address and parameter reference for supported OSC messages.

## Common workflows

- [OSC to FX Mapping](/post/osc-2-fx/)  
  Use encoder OSC output to drive effect parameters such as reverb depth or diffusion.
- [MaxMSP & ICST AmbiEncoder — OSC Communication](/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/)  
  Bidirectional OSC communication between Max/MSP and the encoder.
- [GyrOSC — iOS Motion Control](/post/gyrosc/)  
  Stream iOS motion sensor data into the encoder.

## When OSC is worth using

Use OSC when:

- mouse-based control feels too limited for live movement
- you want to connect motion sensors or mobile devices
- you need repeatable external control from another software environment
- you want bidirectional feedback between REAPER and a controller

If you only need static placement or simple automation inside REAPER, the encoder UI and REAPER automation lanes are often enough.

## Related pages

- [ICST Encoders](/icst-ambisonics-plugins/10_icst_encoders/)
- [Step by Step Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)
- [Best Practices](/icst-ambisonics-plugins/15_best_practices/)
- [YouTube — OSC Tutorial](https://www.youtube.com/watch?v=7_s-jaUQa14&t=10s)
