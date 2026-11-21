---
title: Scene Rotation – Rotating the Entire B-Format Field
description: "How to rotate an Ambisonics scene as a whole: IEM SceneRotator and SPARTA Rotator in the REAPER workflow, OSC addresses, REAPER automation envelopes and three typical use cases – live correction, post-production and compositional rotation."
date: 2026-03-21T18:30:00+01:00
year: 2026
month: 2026-03
weight: 39
tags: ["rotation", "scenerotator", "sparta", "iem", "osc", "automation", "b-format", "transform", "live", "workflow"]
key_points:
  - "Scene rotation turns the entire B-format field – all sources rotate at the same time"
  - "The IEM SceneRotator supports Euler angles (yaw/pitch/roll) and quaternions – both controllable via OSC"
  - "REAPER automation envelopes allow compositional rotation as a parametric curve"
difficulty: "intermediate"
post_kind: "tutorial"
tool: ["REAPER", "OSC"]
---

Level: Intermediate | **Audience:** Composers, live technicians, recording engineers.

---

Ambisonics has a decisive advantage over channel-based formats: the B-format field is rotation-invariant. A stored Ambisonics scene can be rotated at any time afterwards – without loss of quality, without new encoder passes, without touching the sources individually. This article shows how this rotation works in practice.

---

## Scene rotation vs. object rotation

<figure class="explainer-video" style="margin:1.8rem 0">
<video controls muted loop playsinline preload="metadata" style="width:100%;max-width:720px;height:auto;display:block;border-radius:8px" src="/videos/scene-rotation-en.mp4"></video>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Short video: scene rotation turns the whole field, the sources keep their positions relative to each other.</figcaption>
</figure>

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Left: one source moves to a new position. Right: the whole scene rotates around the listener." xmlns="http://www.w3.org/2000/svg"><defs><marker id="mr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="180" y="22" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Object rotation</text><circle cx="180" cy="132" r="72" fill="none" stroke="currentColor" stroke-opacity=".35" stroke-width="1.5"/><circle cx="180" cy="132" r="4" fill="currentColor"/><text x="540" y="22" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Scene rotation</text><circle cx="540" cy="132" r="72" fill="none" stroke="currentColor" stroke-opacity=".35" stroke-width="1.5"/><circle cx="540" cy="132" r="4" fill="currentColor"/><circle cx="180.0" cy="86.0" r="9" fill="#3fa968" fill-opacity=".85"/><circle cx="140.2" cy="155.0" r="9" fill="#3fa968" fill-opacity=".85"/><circle cx="217.7" cy="158.4" r="9" fill="none" stroke="#d9534f" stroke-width="1.5" stroke-dasharray="3 3"/><circle cx="221.7" cy="112.6" r="9" fill="#d9534f" fill-opacity=".9"/><path d="M230.6 151.6 A56 56 0 0 0 234.6 126.9" fill="none" stroke="currentColor" stroke-width="1.6" marker-end="url(#mr)"/><circle cx="540.0" cy="86.0" r="9" fill="none" stroke="#3fa968" stroke-width="1.5" stroke-dasharray="3 3"/><circle cx="577.7" cy="105.6" r="9" fill="#3fa968" fill-opacity=".85"/><circle cx="577.7" cy="158.4" r="9" fill="none" stroke="#d9534f" stroke-width="1.5" stroke-dasharray="3 3"/><circle cx="540.0" cy="178.0" r="9" fill="#d9534f" fill-opacity=".85"/><circle cx="500.2" cy="155.0" r="9" fill="none" stroke="#3fa968" stroke-width="1.5" stroke-dasharray="3 3"/><circle cx="498.3" cy="112.6" r="9" fill="#3fa968" fill-opacity=".85"/><path d="M462.1 87.0 A90 90 0 0 1 585.0 54.1" fill="none" stroke="currentColor" stroke-width="1.6" marker-end="url(#mr)"/><text x="180" y="238" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">AmbiEncoder / Animator: one source moves</text><text x="540" y="238" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">SceneRotator on the B-format bus: the whole field turns</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Object rotation moves one source; scene rotation turns everything at once.</figcaption>
</figure>




There are two fundamentally different ways of moving spatial positions in Ambisonics:

**Object rotation** (ICST AmbiEncoder / AmbiAnimator): individual sources are moved to other positions. The azimuth, elevation and distance of one source change. All other sources stay where they are.

**Scene rotation** (IEM SceneRotator / SPARTA Rotator): the entire B-format field is turned as a unit. All sources in the scene rotate at the same time – including recorded Ambisonics fields that no longer have individual objects. This is the type of tool covered in this article.

| | Object rotation | Scene rotation |
|---|---|---|
| Input | individual sources with position parameters | B-format master bus |
| Granularity | per source | entire field |
| Plugin | ICST AmbiEncoder / Animator | IEM SceneRotator, SPARTA Rotator |
| Typical use | compositional movement | orientation correction, live head tracking |

---

## IEM SceneRotator

<figure data-gen="g21" style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Yaw, pitch and roll as rotations about the vertical, lateral and front axes" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arr1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><circle cx="120" cy="100" r="42" fill="none" stroke="currentColor" stroke-width="1.5"/><path d="M111,60 L120,44 L129,60" fill="none" stroke="currentColor" stroke-width="1.5"/><path d="M141.9,39.9 A64,64 0 0 1 183.0,111.1" fill="none" stroke="#4a8fe0" stroke-width="2.2" marker-end="url(#arr1)"/><text x="120" y="104" text-anchor="middle" font-size="11">listener</text><text x="120" y="180" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="14">Yaw</text><text x="120" y="200" text-anchor="middle" font-size="11">about Z (up):</text><text x="120" y="216" text-anchor="middle" font-size="11">turn left / right</text><circle cx="360" cy="100" r="42" fill="none" stroke="currentColor" stroke-width="1.5"/><path d="M400,91 L416,100 L400,109" fill="none" stroke="currentColor" stroke-width="1.5"/><path d="M381.9,39.9 A64,64 0 0 1 423.0,111.1" fill="none" stroke="#3fa968" stroke-width="2.2" marker-end="url(#arr1)"/><text x="360" y="104" text-anchor="middle" font-size="11">listener</text><text x="360" y="180" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="14">Pitch</text><text x="360" y="200" text-anchor="middle" font-size="11">about X (right):</text><text x="360" y="216" text-anchor="middle" font-size="11">tilt up / down</text><circle cx="600" cy="100" r="42" fill="none" stroke="currentColor" stroke-width="1.5"/><rect x="552" y="91" width="8" height="18" rx="3" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><rect x="640" y="91" width="8" height="18" rx="3" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><path d="M621.9,39.9 A64,64 0 0 1 663.0,111.1" fill="none" stroke="#d9a441" stroke-width="2.2" marker-end="url(#arr1)"/><text x="600" y="104" text-anchor="middle" font-size="11">listener</text><text x="600" y="180" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="14">Roll</text><text x="600" y="200" text-anchor="middle" font-size="11">about Y (front):</text><text x="600" y="216" text-anchor="middle" font-size="11">tilt sideways</text><text x="360" y="242" text-anchor="middle" font-size="11">ICST axes: X right, Y front, Z up. Sign conventions of rotators and head trackers differ, so check or invert them.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Three rotations turn the whole sound field around the listener.</figcaption>
</figure>



The plugin from the IEM Plug-in Suite is the recommended solution in the ICST workflow because it is SN3D/ACN-compatible and works seamlessly with the other IEM plugins.

### Placement in the signal chain

```
[Sources] → [ICST AmbiEncoder] → [B-format bus] → [IEM SceneRotator] → [ICST AmbiDecoder / BinauralDecoder]
```

The SceneRotator sits **on the B-format master bus**, after the encoders and before the decoder. It receives the complete multichannel signal and passes it on rotated.

### Parameters

**Euler angle mode (default):**

| Parameter | Range | Meaning |
|---|---|---|
| Yaw | –180° to +180° | horizontal rotation (compass turn) |
| Pitch | –180° to +180° | vertical tilt (tilting forward / backward) |
| Roll | –180° to +180° | longitudinal-axis rotation (rolling about the front-back axis) |
| Rotation order | Yaw→Pitch→Roll or Roll→Pitch→Yaw | determines the order in which the angles are applied |

**Quaternion mode (alternative):**
Four parameters (qw, qx, qy, qz) instead of Euler angles. Advantage: no gimbal lock, more stable with continuous rotations. More directly usable for head tracking with devices that output quaternions (e.g. MrHeadTracker).

**Normalisation:**
`useSN3D`: SN3D = 1 (standard in the ICST workflow). N3D = 0 only if the entire session is normalised to N3D.

### Order detection

The IEM SceneRotator detects the channel count of the bus automatically (`orderSetting = 0 = Auto`) and adapts the rotation matrix accordingly. The plugin calculates correctly for every order from FOA to HOA7.

---

## SPARTA Rotator

Part of the SPARTA Spatial Audio Suite. Makes sense when you already use SPARTA plugins in the session or need SOFA-based head tracking.

- supports yaw/pitch/roll and quaternions
- OSC reception for head tracking via an external device
- can invert rotation axes – useful when the tracking device uses a different sign convention
- up to 10th order

---

## REAPER automation: rotation as a compositional curve

Rotation can be automated in REAPER like any other parameter. This allows compositional rotation as an envelope – a slowly rotating scene, an abrupt change of orientation as a dramatic device, or an oscillating pendulum movement.

**Creating an envelope:**

1. Set up the SceneRotator as FX on the B-format bus
2. In the track panel click the automation button (Trim/Read) → choose *Write*
3. In the arrange view below the track, open the yaw envelope (FX parameter → SceneRotator → Yaw)
4. Set envelope points manually or record them live in *Write* mode
5. Switch the envelope mode back to *Read* for playback

**Envelope types for rotation:**

- *Slow overall rotation*: linear yaw envelope from 0° to 360° over the length of the piece – the scene turns continuously
- *Quick reorientation*: stepped envelope (hold point) – the scene jumps abruptly to a new angle
- *Pendulum*: sinusoidal LFO curve on the yaw – the scene swings between two directions

---

## OSC control

<figure data-gen="g21" style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Scene rotator between B-format bus and decoder, driven by automation, OSC or head tracking" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arr2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="20" y="50" width="150" height="56" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="95" y="74" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="13">B-format bus</text><text x="95" y="92" text-anchor="middle" font-size="11">16 ch (HOA3)</text><line x1="172" y1="78" x2="250" y2="78" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#arr2)"/><rect x="255" y="40" width="210" height="76" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="360" y="68" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="14">Scene rotator</text><text x="360" y="88" text-anchor="middle" font-size="12">yaw · pitch · roll</text><text x="360" y="104" text-anchor="middle" font-size="11">same order, same channel count</text><line x1="467" y1="78" x2="545" y2="78" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#arr2)"/><rect x="550" y="50" width="150" height="56" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="625" y="74" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="13">Decoder</text><text x="625" y="92" text-anchor="middle" font-size="11">loudspeaker or binaural</text><rect x="20" y="160" width="200" height="56" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.9"/><text x="120" y="184" text-anchor="middle" font-weight="600" font-size="13">REAPER automation</text><text x="120" y="202" text-anchor="middle" font-size="11">rotation as a curve</text><line x1="120" y1="158" x2="252.0" y2="120" stroke="currentColor" stroke-width="1.4" opacity="1" marker-end="url(#arr2)" stroke-dasharray="5 4"/><rect x="260" y="160" width="200" height="56" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.9"/><text x="360" y="184" text-anchor="middle" font-weight="600" font-size="13">OSC</text><text x="360" y="202" text-anchor="middle" font-size="11">remote control</text><line x1="360" y1="158" x2="360.0" y2="120" stroke="currentColor" stroke-width="1.4" opacity="1" marker-end="url(#arr2)" stroke-dasharray="5 4"/><rect x="500" y="160" width="200" height="56" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.9"/><text x="600" y="184" text-anchor="middle" font-weight="600" font-size="13">Head tracker</text><text x="600" y="202" text-anchor="middle" font-size="11">live orientation</text><line x1="600" y1="158" x2="468.0" y2="120" stroke="currentColor" stroke-width="1.4" opacity="1" marker-end="url(#arr2)" stroke-dasharray="5 4"/><text x="360" y="242" text-anchor="middle" font-size="11">Any of these can drive the rotator. The B-format content itself stays untouched.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">One rotator, three ways to control it.</figcaption>
</figure>



The IEM SceneRotator receives OSC messages on a configurable port. Setup:

1. Open the plugin → click the OSC status display (bottom left, next to the IEM logo)
2. Set the receive port (e.g. 9000) → click *OPEN*
3. Green status circles confirm the connection

**OSC addresses:**

```
# Individual Euler angles
/SceneRotator/yaw   45.0
/SceneRotator/pitch -15.0
/SceneRotator/roll   0.0

# All three at once
/SceneRotator/ypr   45.0 -15.0 0.0

# Quaternions
/SceneRotator/quaternions  0.707 0.0 0.707 0.0
```

OSC senders: Max/MSP, Pure Data, GyrOSC (iPhone), MrHeadTracker, or any other OSC-capable environment.

---

## Three typical use cases

### 1. Live correction of the scene orientation

An Ambisonics microphone was not held with its front exactly towards the main source. The recorded field is rotated 30° to the right. With the SceneRotator: set yaw = –30° statically. The whole scene is corrected.

In live situations: if the microphone is placed live and the orientation is not always identical, OSC control can adjust the orientation in real time.

### 2. Head tracking in binaural monitoring

In the binaural workflow (IEM BinauralDecoder or SPARTA AmbiBIN) the scene can be rotated live to compensate for the listener's head movement – the scene stays stationary, the listener moves within it. Signal chain for head tracking:

```
[GyrOSC / MrHeadTracker] → [OSC → /SceneRotator/ypr] → [IEM SceneRotator] → [IEM BinauralDecoder] → headphones
```

GyrOSC on the iPhone sends yaw/pitch/roll directly as OSC. The SceneRotator turns the scene in the opposite direction. The result: a stable spatial scene despite head movement.

### 3. Compositional rotation as a design device

The permanent rotation of an Ambisonics scene as a compositional element – similar to a camera move in film. Possible gestures:

- *Orbiting*: slow yaw rotation over several minutes – the listener stands still, the sound world turns
- *Tipping over*: pitch envelope from 0° to 90° – the scene tips from the horizontal into the vertical plane
- *Spinning*: fast yaw rotation as a rhythmic element (e.g. synchronised to the beat via a REAPER envelope)

---

## Rotation and encoder objects: combination

In a production with mixed sources (recorded Ambisonics fields + encoder objects) a SceneRotator can rotate the recorded part of the scene independently of the encoder objects:

```
[Recording track B-format]  → [SceneRotator] ──┐
                                               ├── [Summing bus] → [AmbiDecoder]
[Encoder tracks]            ───────────────────┘
```

This way only the recorded room sound rotates while the composed objects stay in their positions – or the other way round.

---

## Further reading

- [Recording with an Ambisonics microphone – A-format, B-format and ICST integration](/post/ambisonics-mikrofon-a-format-b-format/)
- [Binaural monitoring in the ICST workflow](/post/binaural-monitoring-icst-workflow/)
- [GyrOSC & ICST AmbiPlugins](/post/gyrosc/)
- [ICST AmbiEncoder – OSC syntax](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
- [Why the decoder sounds the way it does – methodological context](/post/decoder-methodological-context/)

<p class="ai-credit" style="font-size:.85em;opacity:.7"><em>Diagrams and explainer videos created with the help of Claude (Anthropic). <a href="/about/#about-this-site">→</a></em></p>
