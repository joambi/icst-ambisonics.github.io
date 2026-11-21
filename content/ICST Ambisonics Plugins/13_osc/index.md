---
title: OSC
date: 2025-01-01T00:00:00
weight: 160
draft: false
description: "Practical entry page for OSC control with the ICST AmbiEncoder: what it can control, first test steps, and where to go for syntax and advanced workflows."
docs_nav_group: "Plugins"
---

Level: Intermediate | Audience: Composer, technician, student, interactive-media user.

Use this page when you want to control the ICST AmbiEncoder from external hardware, sensors, scripts, or network-based controller software.

OSC (Open Sound Control) lets external hardware and software control the ICST AmbiEncoder in real time. Source positions, movement data, and parameter changes can be sent directly into REAPER without touching the encoder interface.

## What OSC does here

<figure data-gen="g19" style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Signal flow: controllers send OSC over the network to the ICST AmbiEncoder in REAPER, which sends state back" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="aro1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="24" width="190" height="50" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="110" y="46" text-anchor="middle" font-weight="600" font-size="13">Tablet</text><text x="110" y="63" text-anchor="middle" font-size="10.5">TouchOSC, Lemur</text><line x1="205" y1="49" x2="275" y2="150" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#aro1)"/><rect x="15" y="86" width="190" height="50" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="110" y="108" text-anchor="middle" font-weight="600" font-size="13">Phone</text><text x="110" y="125" text-anchor="middle" font-size="10.5">GyrOSC motion data</text><line x1="205" y1="111" x2="275" y2="150" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#aro1)"/><rect x="15" y="148" width="190" height="50" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="110" y="170" text-anchor="middle" font-weight="600" font-size="13">Software</text><text x="110" y="187" text-anchor="middle" font-size="10.5">Max/MSP, SuperCollider, Python</text><line x1="205" y1="173" x2="275" y2="150" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#aro1)"/><rect x="15" y="210" width="190" height="50" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="110" y="232" text-anchor="middle" font-weight="600" font-size="13">Second computer</text><text x="110" y="249" text-anchor="middle" font-size="10.5">same network</text><line x1="205" y1="235" x2="275" y2="150" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#aro1)"/><text x="240" y="285" text-anchor="middle" font-size="11">UDP over the network</text><rect x="280" y="95" width="170" height="110" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="365" y="125" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="15">REAPER</text><text x="365" y="148" text-anchor="middle" font-size="13">ICST AmbiEncoder</text><text x="365" y="170" text-anchor="middle" font-size="10.5">receives OSC input</text><text x="365" y="187" text-anchor="middle" font-size="10.5">reports its state</text><line x1="450" y1="130" x2="540" y2="130" stroke="currentColor" stroke-width="2" opacity="1" marker-end="url(#aro1)"/><line x1="540" y1="170" x2="450" y2="170" stroke="#3fa968" stroke-width="2" opacity="1" marker-end="url(#aro1)"/><text x="495" y="121" text-anchor="middle" font-size="10.5">control</text><text x="495" y="190" text-anchor="middle" fill="#3fa968" font-size="10.5">feedback</text><rect x="545" y="95" width="160" height="110" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="625" y="125" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="13">Monitoring</text><text x="625" y="148" text-anchor="middle" font-size="12">AmbiDecoder</text><text x="625" y="168" text-anchor="middle" font-size="12">or binaural</text><text x="495" y="230" text-anchor="middle" font-weight="600" font-size="11">bidirectional</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">OSC is the bridge between external control and the encoder. Controllers move sources, the encoder sends its state back.</figcaption>
</figure>



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

<figure data-gen="g19" style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Five-step first OSC test and what to check if it fails" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="aro2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="10" y="45" width="128" height="78" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="74.0" y="68" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="17">1</text><text x="74.0" y="90" text-anchor="middle" font-weight="600" font-size="11.5">Open session</text><text x="74.0" y="106" text-anchor="middle" font-size="10.5">encoder loaded</text><line x1="138" y1="84" x2="152" y2="84" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#aro2)"/><rect x="152" y="45" width="128" height="78" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="216.0" y="68" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="17">2</text><text x="216.0" y="90" text-anchor="middle" font-weight="600" font-size="11.5">Check port</text><text x="216.0" y="106" text-anchor="middle" font-size="10.5">encoder OSC settings</text><line x1="280" y1="84" x2="294" y2="84" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#aro2)"/><rect x="294" y="45" width="128" height="78" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="358.0" y="68" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="17">3</text><text x="358.0" y="90" text-anchor="middle" font-weight="600" font-size="11.5">Send message</text><text x="358.0" y="106" text-anchor="middle" font-size="10.5">one simple OSC</text><line x1="422" y1="84" x2="436" y2="84" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#aro2)"/><rect x="436" y="45" width="128" height="78" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="500.0" y="68" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="17">4</text><text x="500.0" y="90" text-anchor="middle" font-weight="600" font-size="11.5">Move one source</text><text x="500.0" y="106" text-anchor="middle" font-size="10.5">visible in encoder</text><line x1="564" y1="84" x2="578" y2="84" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#aro2)"/><rect x="578" y="45" width="128" height="78" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="642.0" y="68" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="17">5</text><text x="642.0" y="90" text-anchor="middle" font-weight="600" font-size="11.5">Listen</text><text x="642.0" y="106" text-anchor="middle" font-size="10.5">decoder or binaural</text><text x="360" y="26" text-anchor="middle" font-weight="600">First test in two minutes</text><line x1="360" y1="123" x2="360" y2="150" stroke="#d9534f" stroke-width="1.6" opacity="1" marker-end="url(#aro2)" stroke-dasharray="4 3"/><rect x="110" y="152" width="500" height="80" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="360" y="174" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="12.5">If nothing moves, check</text><text x="130" y="196" text-anchor="start" font-size="11.5">• UDP port is open</text><text x="380" y="196" text-anchor="start" font-size="11.5">• same network as REAPER</text><text x="130" y="216" text-anchor="start" font-size="11.5">• address matches the syntax</text><text x="380" y="216" text-anchor="start" font-size="11.5">• encoder receives the input</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Work through the five steps in order. The check list helps when step 4 shows no movement.</figcaption>
</figure>



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

<figure data-gen="g19" style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Anatomy of an OSC message for the ICST AmbiEncoder" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="aro3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="360" y="34" text-anchor="middle" font-weight="600" font-size="13">Example: place source 1</text><rect x="50" y="56" width="110" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="105.0" y="84" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="15">/icst/ambi/</text><text x="105.0" y="122" text-anchor="middle" font-size="11">namespace</text><rect x="170" y="56" width="110" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="225.0" y="84" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="15">sourceindex</text><text x="225.0" y="122" text-anchor="middle" font-size="11">by index</text><rect x="290" y="56" width="60" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="320.0" y="84" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="15">aed</text><text x="320.0" y="122" text-anchor="middle" font-size="11">coordinates</text><rect x="360" y="56" width="70" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="395.0" y="84" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="15">1</text><text x="395.0" y="122" text-anchor="middle" font-size="11">source 1</text><rect x="440" y="56" width="70" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="475.0" y="84" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="15">45</text><text x="475.0" y="122" text-anchor="middle" font-size="11">azimuth</text><rect x="520" y="56" width="70" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="555.0" y="84" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="15">10</text><text x="555.0" y="122" text-anchor="middle" font-size="11">elevation</text><rect x="600" y="56" width="70" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="635.0" y="84" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="15">0.8</text><text x="635.0" y="122" text-anchor="middle" font-size="11">distance</text><line x1="50" y1="140" x2="350" y2="140" stroke="currentColor" stroke-width="1.5" opacity="0.5"/><text x="200.0" y="158" text-anchor="middle" font-size="11">address: what to control</text><line x1="360" y1="140" x2="670" y2="140" stroke="currentColor" stroke-width="1.5" opacity="0.5"/><text x="515.0" y="158" text-anchor="middle" font-size="11">arguments: how</text><text x="360" y="196" text-anchor="middle" font-size="12">Address a source by name instead:</text><text x="360" y="214" text-anchor="middle" font-weight="600" font-size="12">/icst/ambi/source/aed 'S1' 45 10 0.8</text><text x="360" y="236" text-anchor="middle" font-size="11">Cartesian positions use xyz:  /icst/ambi/sourceindex/xyz 2 0.2 0.2 0.0</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">An address says what to control, the numbers after it say how. Sources can be addressed by index or by name.</figcaption>
</figure>



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

<figure data-gen="g19" style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="When OSC is worth using and when REAPER automation is enough" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="aro4" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="20" width="330" height="210" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="180" y="46" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="14">OSC is worth it</text><text x="30" y="78" text-anchor="start" font-size="12.5">• mouse control is too limited for live movement</text><text x="30" y="110" text-anchor="start" font-size="12.5">• motion sensors or mobile devices</text><text x="30" y="142" text-anchor="start" font-size="12.5">• repeatable control from other software</text><text x="30" y="174" text-anchor="start" font-size="12.5">• feedback between REAPER and controller</text><rect x="375" y="20" width="330" height="210" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="540" y="46" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="14">REAPER alone is enough</text><text x="390" y="78" text-anchor="start" font-size="12.5">• static source placement</text><text x="390" y="110" text-anchor="start" font-size="12.5">• simple automation lanes</text><text x="390" y="142" text-anchor="start" font-size="12.5">• no external controller involved</text><text x="390" y="174" text-anchor="start" font-size="12.5">• no need for live input</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Use OSC when the movement comes from outside REAPER or must be live. Static placement and simple automation need no OSC.</figcaption>
</figure>



Use OSC when:

- mouse-based control feels too limited for live movement
- you want to connect motion sensors or mobile devices
- you need repeatable external control from another software environment
- you want bidirectional feedback between REAPER and a controller

If you only need static placement or simple automation inside REAPER, the encoder UI and REAPER automation lanes are often enough.

## Related pages

- [ICST Encoders](/icst-ambisonics-plugins/10_icst_encoders/)
- [Step by Step Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)
- [Best Practices](/icst-ambisonics-plugins/17_best_practices/)
**OSC Tutorial Video**

{{< youtube 7_s-jaUQa14 >}}
