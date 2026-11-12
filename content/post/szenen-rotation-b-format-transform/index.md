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
kind: "tutorial"
tool: ["REAPER", "OSC"]
---

Level: Intermediate | **Audience:** Composers, live technicians, recording engineers.

---

Ambisonics has a decisive advantage over channel-based formats: the B-format field is rotation-invariant. A stored Ambisonics scene can be rotated at any time afterwards – without loss of quality, without new encoder passes, without touching the sources individually. This article shows how this rotation works in practice.

---

## Scene rotation vs. object rotation

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
