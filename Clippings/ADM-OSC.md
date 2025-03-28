---
title: "ADM-OSC"
source: "https://immersive-audio-live.github.io/ADM-OSC/"
author:
published: 2025-02-07
created: 2025-03-26
description:
tags:
  - "clippings"
---
## 1\. IntroductionADM-OSC has been designed to solve real problems for live and broadcast sound producers. Since 2019, a growing workgroup of industry stakeholders from live music and broadcast domains has gathered to exchange needs and experiences from real-life production cases. These companies have already expressed interest or have implemented ADM-OSC:


- [Atlas](https://www.atlas-control.app/)
- [Adamson](http://www.adamsonsystems.com/)
- [Amadeus Acoustics GmbH](https://amadeus-acoustics.com/)
- [BBC](https://www.bbc.com/)
- [d&b audiotechnik](https://www.dbaudio.com/)
- [DiGiCo](https://digico.biz/)
- [Dolby](https://www.dolby.com/)
- [FLUX::SE](https://www.flux.audio/)
- [FollowMe](https://follow-me.nu/)
- [Grapes3D](https://www.grapes3d.com/)
- [Holophonix](https://holophonix.xyz/)
- [L-Acoustics](https://www.l-acoustics.com/)
- [Lawo](https://lawo.com/)
- [Merging Technologies](https://www.merging.com/)
- [Meyer Sound Laboratories](https://meyersound.com/)
- [Modulo Pi](https://www.modulo-pi.com/)
- [Naostage](https://www.naostage.com/)
- [New Audio Technology](https://www.newaudiotechnology.com/)
- [QLab](https://qlab.app/)
- [Radio-France](https://www.radiofrance.com/innovation-nouveaux-formats)
- [Steinberg](https://www.steinberg.net/)
- [TiMax Spatial](https://timaxspatial.com/)

Version 1.0 of the ADM-OSC specification was announced at the AES Show in 2024 [\[ADM-OSC-1\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-adm-osc-1 "Implementation of ADM-OSC v1.0").

### 1.1. Why ADM?Immersive audio is gaining ground in different industries, from music streaming to gaming, from live sound to broadcast. [ADM](https://immersive-audio-live.github.io/ADM-OSC/#audio-definition-model) is becoming a popular standard metadata model in some of these industries, with serialADM used in broadcast or ADM bwf or xml files used in the studio.

### 1.2. Why OSC?- Lightweight network protocol
- Easy to implement
- Human readable
- Supports wildcards and bundles
- Specification: [\[OpenSoundControl.org\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-opensoundcontrolorg "OpenSoundControl website")
- Available in a plethora of professional audio hardware and software devices

### 1.3. Motivation & goals- To facilitate the sharing of audio objects metadata between a live ecosystem and a broadcast or studio ecosystem.
- To define a basic layer of interoperability between Object Editors and Object renderers while not aiming at replacing more complete manufacturer specific protocols or grammars.
- To define a direct translation of the most relevant [ADM](https://immersive-audio-live.github.io/ADM-OSC/#audio-definition-model) Object Properties onto a communication protocol widely used in the live industry, [OSC](https://immersive-audio-live.github.io/ADM-OSC/#open-sound-control).
- Keeping the grammar scope aligned with the [ADM](https://immersive-audio-live.github.io/ADM-OSC/#audio-definition-model) properties.
- Share this proposal with the EBU so they can become a relay, publish and support this initiative.
- Extend this small grammar to more [ADM](https://immersive-audio-live.github.io/ADM-OSC/#audio-definition-model) properties (beds, etc.) in the future.

### 1.4. Project Originators[L-Acoustics](https://www.l-acoustics.com/), [FLUX::SE](https://www.flux.audio/), [Radio-France](https://www.radiofrance.com/innovation-nouveaux-formats)

### 1.5. Project Contributors[Adamson](http://www.adamsonsystems.com/), [BBC](https://www.bbc.com/), [d&b audiotechnik](https://www.dbaudio.com/), [DiGiCo](https://digico.biz/), [Dolby](https://www.dolby.com/), [Lawo](https://lawo.com/), [Magix](https://www.magix.com/), [Merging Technologies](https://www.merging.com/), [Meyer Sound Laboratories](https://meyersound.com/), [Steinberg](https://www.steinberg.net/)

## 2\. Current spec (v1.0)### 2.1. Object position messagesNote: These messages take the form of /adm/obj/n..., where n signifies object number

<table><thead><tr><th>address</th><th>type</th><th>units</th><th>min</th><th>max</th><th>default</th><th>description</th><th>example</th></tr></thead><tbody><tr><td>/adm/obj/<i>n</i>/azim</td><td>f</td><td>degrees</td><td>-180.0</td><td>180.0</td><td></td><td><b>azimuth</b> “theta - θ” of sound location<br><a href="https://immersive-audio-live.github.io/ADM-OSC/#polar">§ 4.4.1 Polar</a></td><td>/adm/obj/4/azim -22.5</td></tr><tr><td>/adm/obj/<i>n</i>/elev</td><td>f</td><td>degrees</td><td>-90.0</td><td>90.0</td><td></td><td><b>elevation</b> “phi - ɸ” of sound location<br><a href="https://immersive-audio-live.github.io/ADM-OSC/#polar">§ 4.4.1 Polar</a></td><td>/adm/obj/4/elev 12.7</td></tr><tr><td>/adm/obj/<i>n</i>/dist</td><td>f</td><td>normalized</td><td>0.0</td><td>1.0</td><td>1.0</td><td><b>distance</b> “r” from origin<br><a href="https://immersive-audio-live.github.io/ADM-OSC/#polar">§ 4.4.1 Polar</a></td><td>/adm/obj/4/dist 0.9</td></tr><tr><td>/adm/obj/<i>n</i>/aed</td><td>f f f</td><td colspan="4">azimuth elevation distance</td><td>synchronicity and reduced network traffic</td><td>/adm/obj/4/aed -22.5 12.7 0.9</td></tr><tr><td>/adm/obj/<i>n</i>/x</td><td>f</td><td>normalized</td><td>-1.0</td><td>1.0</td><td>0.0</td><td>left/right<br><a href="https://immersive-audio-live.github.io/ADM-OSC/#cartesian">§ 4.4.2 Cartesian</a></td><td>/adm/obj/4/x -0.9</td></tr><tr><td>/adm/obj/<i>n</i>/y</td><td>f</td><td>normalized</td><td>-1.0</td><td>1.0</td><td>0.0</td><td>front/back<br><a href="https://immersive-audio-live.github.io/ADM-OSC/#cartesian">§ 4.4.2 Cartesian</a></td><td>/adm/obj/4/y 0.15</td></tr><tr><td>/adm/obj/<i>n</i>/z</td><td>f</td><td>normalized</td><td>-1.0</td><td>1.0</td><td>0.0</td><td>top/bottom<br><a href="https://immersive-audio-live.github.io/ADM-OSC/#cartesian">§ 4.4.2 Cartesian</a></td><td>/adm/obj/4/z 0.7</td></tr><tr><td>/adm/obj/<i>n</i>/xy</td><td>f f</td><td colspan="4">see above</td><td>synchronicity and reduced network traffic</td><td>/adm/obj/4/xy 0.62 -0.33</td></tr><tr><td>/adm/obj/<i>n</i>/xyz</td><td>f f f</td><td colspan="4">see above</td><td>synchronicity and reduced network traffic</td><td>/adm/obj/4/xyz -0.9 0.15 0.7</td></tr><tr><td>/adm/obj/<i>n</i>/w</td><td>f</td><td>normalized</td><td>0.0</td><td>1.0</td><td>0.0</td><td>horizontal extent in normalized units</td><td>/adm/obj/3/w 0.2</td></tr><tr><td>/adm/obj/<var>n</var>/gain</td><td>f</td><td>linear</td><td>0.</td><td></td><td>1.0</td><td>Apply a gain to the audio in the object.</td><td>/adm/obj/3/gain 0.707</td></tr><tr><td>/adm/obj/<var>n</var>/dref</td><td>f</td><td>normalized</td><td>0.0</td><td>1.0</td><td>1.0</td><td>Distance where dimensionless rendering is replaced with with physics-based rendering.<br><a href="https://immersive-audio-live.github.io/ADM-OSC/#distance">§ 4.4.4 Distance</a></td><td>/adm/obj/1/dref 0.2</td></tr><tr><td>/adm/obj/<var>n</var>/dmax</td><td>f</td><td>meters</td><td>0.</td><td></td><td></td><td>Distance signified by a normalized dref value of 1<br><a href="https://immersive-audio-live.github.io/ADM-OSC/#distance">§ 4.4.4 Distance</a></td><td>/adm/obj/1/dmax 21.3</td></tr><tr><td>/adm/obj/<var>n</var>/mute</td><td>i</td><td>integer</td><td>0</td><td>1</td><td>0</td><td>1 means “true”, so muted</td><td>/adm/obj/2/mute 0</td></tr><tr><td>/adm/obj/<var>n</var>/name</td><td>s</td><td>string</td><td>0</td><td>128 char</td><td></td><td>object nice name</td><td>/adm/obj/1/name kickdrum</td></tr></tbody></table>

Note: Type tags are defined as OSC 1.0 specification: i=int32, f=float32, s=OSC-string

### 2.2. Environment messagesThese could be expanded to include program changes and other global data. They are not specific to any individual object.

| address | type | units | min | max | default | description | example |
| --- | --- | --- | --- | --- | --- | --- | --- |
| /adm/env/change | s | string | 0 | 128 char | 128 char | program changes | /adm/env/change day |

### 2.3. Listener messagesThese messages could be used by a binaural renderer [\[EBU-Tech-3396\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-ebu-tech-3396 "BINAURAL EBU ADM RENDERER (BEAR) FOR OBJECT-BASED SOUND OVER HEADPHONES") for head tracking data and listener position in a [6DOF](https://immersive-audio-live.github.io/ADM-OSC/#six-degrees-of-freedom) setting.

| address | type | units | min | max | default | description | example |
| --- | --- | --- | --- | --- | --- | --- | --- |
| /adm/lis/ypr | f f f | degrees | \-180.0 | 180.0 | 0.0 | orientation: yaw, pitch, roll | /adm/lis/ypr -45.0 30.0 5.0 |
| /adm/lis/xyz | f f f | normalized | \-1.0 | 11.0 | 0.0 | listener position | /adm/lis/xyz 0.0 0.5 -0.2 |

### 2.4. Queries and bi-directional communicationThe [OSC](https://immersive-audio-live.github.io/ADM-OSC/#open-sound-control) protocol is unidirectional, so the commands should be considered as **SET** from a sender to a receiver. A particular device might also be interested to **GET** the state of a particular parameter in another device. To do so, it should send a command without any arguments. The receiver should answer back to this IP with the data.sending `/adm/obj/4/xyz` to a device should trigger a reply like `/adm/obj/4/xyz -0.9 0.15 0.0`

## 3\. Implementation Matrix| ✓ = transmit and receive   tx = transmit only   rx = receive only | [Zactrack](https://www.zactrack.com/) | [(Merging Technologies)   Ovation](https://www.merging.com/products/ovation/) | [(Merging Technologies)   Pyramix](https://www.merging.com/products/pyramix) | [(Figure 53)   QLab](https://qlab.app/) | [(FLUX::)   SPAT Revolution](https://www.flux.audio/project/spat-revolution/) | [(L-Acoustics)   L-ISA Controller](https://l-isa.l-acoustics.com/) | [(Lawo)   mc<sup>2</sup> consoles](https://lawo.com//) | [(d&b Soundscape)   En-Bridge](https://www.dbsoundscape.com/) | [(Meyer Sound Laboratories)   SpaceMap Go](https://meyersound.com/product/spacemap-go/) | [(Steinberg)   Nuendo](https://www.steinberg.net/nuendo/) | [(Adamson)   FletcherMachine](https://adamson-fletcher-machine.com/) | [(New Audio Technology)   Spatial Audio Designer](https://www.newaudiotechnology.com/) | [(Modulo Pi)   Modulo Kinetic](https://www.modulo-pi.com/) | [(TiMax Spatial)   Timax panLab](https://timaxspatial.com/) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| /adm/obj/n/azim |  |  |  | tx | ✓ | ✓ | ✓ | rx | rx |  | ✓ | ✓ | ✓ | rx |
| /adm/obj/n/elev |  |  |  | tx | ✓ | ✓ | ✓ | rx | rx |  | ✓ | ✓ | ✓ | rx |
| /adm/obj/n/dist |  |  |  | tx | ✓ | ✓ | ✓ | rx | rx |  | ✓ | ✓ | ✓ | rx |
| /adm/obj/n/aed |  | ✓ |  | tx | ✓ | ✓ | ✓ | rx | rx |  | ✓ | ✓ | ✓ | rx |
| /adm/obj/n/x |  | ✓ |  | tx | ✓ | ✓ | ✓ | ✓ | rx | ✓ | ✓ | ✓ | ✓ | rx |
| /adm/obj/n/y |  | ✓ |  | tx | ✓ | ✓ | ✓ | ✓ | rx | ✓ | ✓ | ✓ | ✓ | rx |
| /adm/obj/n/z |  | ✓ |  | tx | ✓ | ✓ | ✓ | ✓ | rx | ✓ | ✓ | ✓ | ✓ | rx |
| /adm/obj/n/xy |  |  |  |  | rx |  |  | ✓ | rx |  | ✓ | ✓ |  |  |
| /adm/obj/n/xyz | tx | ✓ | tx | tx | ✓ | ✓ | ✓ | ✓ | rx | ✓ | ✓ | ✓ | ✓ | rx |
| /adm/obj/n/w |  | ✓ | tx |  | ✓ | ✓ | ✓ |  | rx | ✓ | ✓ | ✓ | ✓ |  |
| /adm/obj/n/dref |  |  |  |  | ✓ |  |  |  |  |  | ✓ |  |  |  |
| /adm/obj/n/dmax |  |  |  |  | ✓ \* |  |  |  |  |  | ✓ |  |  |  |
| /adm/obj/n/gain |  | ✓ |  | tx | ✓ | ✓ |  | ✓ | rx |  | ✓ | ✓ | ✓ | rx |
| /adm/obj/n/mute |  | ✓ |  |  | ✓ | ✓ |  |  | rx |  | ✓ | ✓ |  |  |
| /adm/obj/n/name |  |  | tx |  | ✓ |  |  |  | rx |  | ✓ | ✓ |  |  |
| /adm/env/change |  |  |  |  | ✓ |  |  |  | ✓ |  | ✓ |  |  |  |
| /adm/lis/xyz | tx |  |  |  | rx |  |  |  | rx |  | ✓ | ✓ |  |  |
| /adm/lis/ypr |  |  |  |  | rx |  |  |  | rx |  | ✓ | ✓ |  |  |

Note: \* FletcherMachine and SPAT Revolution supports *dmax* as a global message only: */adm/obj/\*/dmax*

## 4\. Basic ADM-OSC principals### 4.1. Roles#### 4.1.1. Sender (client)- Object Editor sending positioning data to one or more receivers.
- Cartesian position data is always normalized

#### 4.1.2. Receiver (server)- Handles the (optional) local scaling of normalized data: x, y, z, distance
- The receiver can be a DAW, an [ADM](https://immersive-audio-live.github.io/ADM-OSC/#audio-definition-model) renderer, an object editor, a bridge (ADM-OSC <-> sADM)

### 4.2. PortsADM-OSC typically uses UDP protocol. It is recommended to use port **4001** [\[ADMix\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-admix "Admix Player") for one-way communication (so, default for senders and receivers) and **4002** for return messages (if used).

Those ports should be user editable if needed.

### 4.3. Message ratePosition data is typically sent at a high data rate, although care must be taken not to overload the capibilities of the receiver. S-ADM is usually half of the video frame rate, or approximatly one message every 20 ms, or 50 Hz. Similarly, the Dolby Atmos ADM Profile [\[Atmos-Profile\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-atmos-profile "Dolby Atmos ADM Profile specification") recommends that the sampling period be "less than 20 ms," although sampling is optional if the parameter does not change.

Interpolation messages have not been implemented in ADM-OSC 1.0.

### 4.4. Coordinates#### 4.4.1. Polar- 0° azimuth is straight ahead
- Positive azimuth is on the left, so a front-left speaker is +30°
- +90° elevation is straight up

#### 4.4.2. Cartesian```
(-1, 1) --------- (1, 1)  
   |                |  
   |                |  
   |                |  
   |                |  
(-1, -1) ---------(1, -1)  
```

- Values are normalized between -1.0 and 1.0
- $x = 1.0$  is right
- $y = 1.0$  is forward
- $z = 1.0$  is up

#### 4.4.3. ConversionsTo convert the coordinate system, Euler trigonometry can be used to represent the polar sphere in cartesian coordinates. The equations are provided in ITU-R BS.2127 section 6.8 [\[EBU-BS-2127\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-ebu-bs-2127 "Audio Definition Model renderer for advanced sound systems")

$x = - d sin \left(\right. \frac{\pi}{2} - e \frac{2 \pi}{360} \left.\right) \cdot sin \left(\right. a \frac{2 \pi}{360} \left.\right)$  
$y = d sin \left(\right. \frac{\pi}{2} - e \frac{2 \pi}{360} \left.\right) \cdot cos \left(\right. a \frac{2 \pi}{360} \left.\right)$  
$z = d cos \left(\right. \frac{\pi}{2} - e \frac{2 \pi}{360} \left.\right)$  

Cartesian to polar conversion

$a = \frac{360}{2 \pi} \cdot atan2 \left(\right. x y \left.\right)$  
$e = \frac{360}{2 \pi} \cdot asin \left(\right. \frac{z}{d} \left.\right)$  
$d = \sqrt{x^{2} + y^{2} + z^{2}}$  

polar to Cartesian converision

To help conversions seamlessly, here are code examples on GitHub in SWIFT [\[convert-swift\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-convert-swift "SWIFT polar<>cartesian code examples"), in CPP [\[convert-cpp\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-convert-cpp "CPP polar<>cartesian code example") or JavaScript [\[convert-js\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-convert-js "Javascript polar<>cartesian code example").

For full [ADM](https://immersive-audio-live.github.io/ADM-OSC/#audio-definition-model) compatibility, there is another recommended conversion approach in section 10.1 of: [\[EBU-BS-2127\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-ebu-bs-2127 "Audio Definition Model renderer for advanced sound systems"). C++ code for that conversion can be found at [\[EBU-convert-cpp\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-ebu-convert-cpp "EBU conversion between polar and cartesian coordinates").

#### 4.4.4. DistanceThe 3D paradigm chosen by the ADM standard is a normalised (dimensionless) reference volume, defined in Cartesian or spherical coordinates.

$-1.0 \leq x \leq 1.0$  
$-1.0 \leq y \leq 1.0$  
$-1.0 \leq z \leq 1.0$ 

dimensionless ADM cube

$0.0 \leq d \leq 1.0$  
$d = distance or radius$ 

dimensionless ADM sphere

This paradigm is used by studio/broadcast mixing tools such as Dolby Atmos or MPEG-H.

On the other hand, some audio renderers represent a physics-based world, and the notion of source distance relates to a physical unit, such as meters. Aside from direct sound gain, the source physics-based distance d<sub>m</sub> relates to advanced audio object parameters such as propagation delay, air at- tenuation, and energy levels of early/cluster reflections and late reverberation, or sound field behaviors (plane vs spherical waves).

These audio renderers include L-Acoustics L-ISA, Flux:Spat, d&B Soundscape, but also, more generally in the AR/VR domain, game audio engines such as Unreal, Unity, Wwise, or XR audio engines such as Magic Leap Soundfield Audio. A common challenge for all these renderers based on physical distance is that if the gain follows physical attenuation laws (such as “-6dB per doubling of distance”), there are some singularities when d<sub>m</sub> gets close to 0. Hence, most of these renderers include a “volume of reference” or “unit volume” where the rendering (and in particular the gain) do not follow physically-informed laws anymore. This is true for Unreal and Spat, for example.

An object position in a physics-based world can be described as:

$x_{min} \leq x \leq x_{max} (\text{meters})$  
$y_{min} \leq y \leq xMax (\text{meters})$  
$z_{min} \leq z \leq xMax (\text{meters})$ 

physics-based Cartesian

$0.0 \leq d_{mimn} \leq d_{max} (\text{meters})$  

physics-based spherical

In ADM-OSC, **/dmax** corresponds to the `absoluteDistance` parameter in an ADM audioPackFormat element.

**/dref** is a new parameter can be defined as the radius in meters of a volume of reference, which would serve the two purposes. It coincides with the dimensionless volume used in the ADM standard and it is used by physically informed renderers as the “volume of reference” where the laws of physics do not apply, and the gain(dB) is constant regardless of distance.

By definition:

 $0 \leq \frac{d_{ref}}{d_{max}} \leq 1$ 

and the following cases arise:

 $d_{ref} = 1$  : the world is a dimensionless reference $d_{max}$  volume, matching the ADM standard  
$d_{ref} = 0$  : no reference volume within the physical $d_{max}$  world[Issue #12 on GitHub: “Distance”](https://github.com/immersive-audio-live/adm-osc/issues/12)

Different rendering systems handle distance differently. ADM uses a "dimensionless" reference volume, the interior of a cube or sphere. There are also physics-based renderers (eg Game engines) that try to acoustically represent distance based on a simulation of distance in meters, for example.

The proposal is to define both reference distance (dRef) and a maximum distance (dMax) messages in ADM-OSC so to communicate the intended rendering approach. The default (and current behaviour of the ADM standard) would be dRef = dMax = 1m. If dRef < dMax, then distance based tranforms (such as gain changes) could be applied when an object's distance is > dRef. Inside of dRef, no transforms would be applied.

### 5.1. [Chataigne module](https://github.com/madees/ADM-OSC-Chataigne-Module)(Mathieu Delquignies / d&b audiotechnik)

To retreive parameters or control ADM-OSC [object-based audio](https://immersive-audio-live.github.io/ADM-OSC/#object-based-audio) software or hardware with [OSC](https://immersive-audio-live.github.io/ADM-OSC/#open-sound-control) protocol.

### 5.2. Tester Desktop application(Jose Gaudin / Meyer Sound Laboratories)

[download from resources directory](https://github.com/immersive-audio-live/ADM-OSC/tree/main/Resources)

### 5.3. Validator, Test and Stress Test Python Module(Gael Martinet / FLUX::)

adm\_osc module is available to install through pip:

```shell
pip install adm-osc
```

quick examples:

```python
from adm_osc import OscClientServer

# create a basic client/server that implement basic ADM-OSC communication with stable parameters 
# + command monitoring and analyze
cs = OscClientServer(address='127.0.0.1', out_port=9000, in_port=9001)

# send some individual parameters  
cs.send_object_position_azimuth(object_number=1, v=-30.0)
cs.send_object_position_elevation(object_number=1, v=0.0)
cs.send_object_position_distance(object_number=1, v=2.0)

# or pack them
cs.send_object_polar_position(object_number=1, pos=[-30.0, 0.0, 2.0])

# in cartesian coordinates
cs.send_object_cartesian_position(object_number=1, pos=[-5.0, 8.0, 0.0])

# see documentation for full list of available functions

# when receiving an adm osc command its analyze will be printed on the command output window
#
# e.g.
#
# >> received valid adm message for obj :: 1 :: gain (0.7943282127380371)
# >> received valid adm message for obj :: 1 :: position aed (20.33701515197754, 0.0, 0.8807612657546997)
# >> received valid adm message for obj :: 1 :: position xyz (-0.2606865465641022, 0.8273822069168091, 0.0)
# >>
# >> ERROR: unrecognized ADM address : "/adm/obj/1/bril" ! unknown command "/bril/"
# >> ERROR: arguments are malformed for "/adm/obj/1/gain :: (1.4791083335876465,)":
# >>     argument 0 "1.4791083335876465" out of range ! it should be less or equal than "1.0"
```
```python
from adm_osc import TestClient
# create a test client, assume default address (local: '127.0.0.1')
# test client can be used to test how receiver will handle all kind of parameters and parameters value range
sender = TestClient(out_port=9000)

# all stable parameters for a specific object
sender.set_object_stable_parameters_to_minimum(object_number=1)
sender.set_object_stable_parameters_to_maximum(object_number=1)
sender.set_object_stable_parameters_to_default(object_number=1)
sender.set_object_stable_parameters_to_random(object_number=1)

# all stable parameters for a range of objects
sender.set_objects_stable_parameters_minimum(objects_range=range(1, 64))
sender.set_objects_stable_parameters_maximum(objects_range=range(1, 64))
sender.set_objects_stable_parameters_default(objects_range=range(1, 64))
sender.set_objects_stable_parameters_random(objects_range=range(1, 64))

# all stable parameters for all objects
sender.set_all_objects_stable_parameters_minimum()
sender.set_all_objects_stable_parameters_maximum()
sender.set_all_objects_stable_parameters_default()
sender.set_all_objects_stable_parameters_random()

# see documentation for full list of available functions
```
```python
from adm_osc import StressClient
# create a stress client, assume default address (local: '127.0.0.1')
# stress client will send huge amount of data to stress test the receivers
sender = StressClient(out_port=9000)
# do stress test in cartesian coordinates
sender.stress_cartesian_position(number_of_objects=64, duration_in_second=60.0, interval_in_milliseconds=10.0)
# do stress test in polar coordinates
sender.stress_polar_position(number_of_objects=64, duration_in_second=60.0, interval_in_milliseconds=10.0)
```

- [Full documentation](https://github.com/immersive-audio-live/ADM-OSC/tree/main/Source/adm_osc/doc/documentation.md)
- [Source directory](https://github.com/immersive-audio-live/ADM-OSC/tree/main/Source)

## 6\. Discussion### 6.1. Draft 0.5A [draft for version 0.5](https://immersive-audio-live.github.io/ADM-OSC/html/adm_spec_0.5_draft.html) was proposed but not adopted. This draft contains messages for greater compatibility with [ADM](https://immersive-audio-live.github.io/ADM-OSC/#audio-definition-model) in broadcast use cases. It brings up a potential problem of sending critical configuration messages over UDP. Whereas loosing a few high-rate

### 6.2. Relationship to ADMADM-OSC messages are designed to be translatable to (S-)ADM if needed. Messages that don’t translate into one (or more) [ADM](https://immersive-audio-live.github.io/ADM-OSC/#audio-definition-model) tag should not be in the `/adm` namespace.[Issue #33 on GitHub: “Quaternions?”](https://github.com/immersive-audio-live/adm-osc/issues/33)

We've added some head tracker messages to ADM-OSC 1.0. Specifically, yaw-pitch-roll like:

Quaternions are more useful in many situations. Should we also have something like `/quat`?

## 7\. DefinitionsAudio Definition Model

The Audio Definition Model (ADM) was first published by the European Broadcast Union (EBU) in 2015 as a standard representation of audio metadata \[1\]. The goal of ADM is to support a broad range of use cases that include spatial and immersive audio, as well as interactive personalization and accessibility features [\[What-is-ADM\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-what-is-adm "What is the ADM?"). ADM can be used to represent channel-based, scene-based, and [object-based audio](https://immersive-audio-live.github.io/ADM-OSC/#object-based-audio). It is defined by the EBU in ITU-R BS.2076 [\[EBU-BS-2076\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-ebu-bs-2076 "Audio Definition Model")

Object-Based Audio

Object-based representation encodes audio tracks along with positional and other data about how that audio should be reproduced, or rendered, during playback. Positional data is speaker-agnostic, allowing object-based mixes to be highly portable. A musician might audition a mix on headphones using a binaural renderer [\[EBU-Tech-3396\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-ebu-tech-3396 "BINAURAL EBU ADM RENDERER (BEAR) FOR OBJECT-BASED SOUND OVER HEADPHONES") then perform at a venue with dozens of loudspeakers using a spatial renderer. That mix might then be rendered for streaming with a third renderer. [\[Tsingos-2017\]](https://immersive-audio-live.github.io/ADM-OSC/#biblio-tsingos-2017 "Object-based audio")

Open Sound Control

OpenSoundControl (OSC) is a data transport specification (an encoding) for realtime message communication among applications and hardware. OSC was developed by researchers Matt Wright and Adrian Freed during their time at the Center for New Music & Audio Technologies (CNMAT). OSC was originally designed as a highly accurate, low latency, lightweight, and flexible method of communication for use in realtime musical performance. They proposed OSC in 1997 as “a new protocol for communication among computers, sound synthesizers, and other multimedia devices that is optimized for modern networking technology”.

There are several open-source implementations that simplify developers’ adoption, The OSC 1.0 specification has been published in 2002.

Renderer

Six Degrees of Freedom

Forward/backward, up/down, left/right translation, combined orientation (yaw, pitch, and roll).