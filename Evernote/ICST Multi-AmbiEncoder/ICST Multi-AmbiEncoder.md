---

tags: 
  - published

---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *

## Overview

![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-12 um 16.25.09.png]]
If you'd like more info, please see [ICST AmbiEncoder Specification](https://bitbucket.org/christian_schweizer/icst-ambisonics-plugins/wiki/Encoder_specification).

* * *

### ICST Multi-AmbiEncoder Signalflow

![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-18 um 13.35.23.png]]
This is the signal flow of a single ICST Multi-AmbiEncoder with a max of 64 mono sources tracks.
Depending on the computer CPU, several Multi-AmbiEncoders may be routed into the Bformat master or directly into the ICST decoder.

### ICST Multi-AmbiEncoder Audio routing

![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-16 um 11.27.10.png]]
This is the example with the Reaper Multi-AmbiEncoder template for Ambisonics 3rd-order.
It shows the signal flow of a single ICST Multi-AmbiEncoder with a maximum of 64 mono-source tracks.
Depending on the computer CPU, multiple Multi-AmbiEncoders can be panned into the Bformat master or directly into the ICST decoder.

* * *

### Radar Interaction

![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-18 um 13.40.28.png]]

* see [Radar Interaction](https://bitbucket.org/christian_schweizer/icst-ambisonics-plugins/wiki/Radar_Interaction/)

* * *

### Multi-AmbiEncoder settings (Sources)

![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-16 um 13.15.46.png]]
**Groups:**
Up to 8 groups can be defined for position manipulation, affecting multiple audio sources at the same time.
For each group, the following parameters can be defined:

* Stretches
* Rotations

![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-18 um 16.04.51.png]]

![[./_resources/ICST_Multi-AmbiEncoder.resources/Group_Manipulation.gif]]![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-16 um 14.19.01.png]]
Example Group Interaction (Animation)                             Key commands for 'Group manipulation'

* * *

### Encoder-Plugin settings (Encoding)

![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-18 um 14.41.58.png]]![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-18 um 14.50.14.png]]
(see also [here](https://bitbucket.org/christian_schweizer/icst-ambisonics-plugins/wiki/Distance_Encoding))

* * *

### ICST Multi-AmbiEncoder OSC (Send & Receives)

![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-18 um 15.33.18.png]]
The ICST Multi-Ambiencoder can send or receive almost all encoder parameters via OSC (Open Sound Control).
Open the 'Help' and then the OSC syntax to get the necessary OSC messages.

### OSC In

![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-18 um 16.20.26.png]]
Listen for Standard OSC
If activated, the Plugin listens to the standard OSC patterns, otherwise, the standard patterns are ignored and only user defined patterns are evaluated.
```
If activated, the Plugin listens to the standard OSC patterns, otherwise, the standard patterns are ignored and only user defined patterns are evaluated.

Standard patterns (details can be found in the main help section):
/icst/ambi/source/aed
/icst/ambi/source/xyz
/icst/ambi/source/gain
/icst/ambi/group/aed
/icst/ambi/group/xyz
/icst/ambi/sourceindex/aed
/icst/ambi/sourceindex/xyz
/icst/ambi/sourceindex/gain
/icst/ambi/group/rotate
/icst/ambi/group/rotateorigin
/icst/ambi/group/stretch
/icst/ambi/distanceencoding/mode
/icst/ambi/distanceencoding/unitcircle
/icst/ambi/distanceencoding/dbunit
/icst/ambi/distanceencoding/distanceattenuation
/icst/ambi/distanceencoding/centercurve
/icst/ambi/distanceencoding/advancedfactor
/icst/ambi/distanceencoding/advancedexponent
/icst/ambi/distanceencoding/standard
/icst/ambi/distanceencoding/advanced
/icst/ambi/distanceencoding/exponential
/icst/ambi/distanceencoding/inverseproportional
```

### OSC-Message & JS-Code

![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-18 um 17.13.16.png]]

This is the 'JS-Help' you can finde in the Encoder
```
Custom OSC - JS Help:

Title (optional):");
  If the first line starts with a comment (//), this comment
  is used as title and will be shown in the Custom OSC list.

Access to OSC data:
  s.path([index]);
    Returns the specified part of the OSC path.
    Example: /this/is/my/path -> s.path(3); -> 'my'
  s.arg([index]);
    Returns the specified argument of the OSC message.
    Example: /demo 1 2 3 -> s.arg(2); -> 2

Access to current data:
  s.getX([index]); (*)
  s.getY([index]); (*)
  s.getZ([index]); (*)
  s.getA([index]); (*)
  s.getE([index]); (*)
  s.getD([index]); (*)
  s.getName([index]);
  s.getAbsX([index]); (group mode only)
  s.getAbsY([index]); (group mode only)
  s.getAbsZ([index]); (group mode only)
  s.getGroupX([index]);
  s.getGroupY([index]);
  s.getGroupZ([index]);
  s.getGroupA([index]);
  s.getGroupE([index]);
  s.getGroupD([index]);
(*) Note: in group mode, positions are relative to the attached group!

Manipulation of data set:
  s.setXYZ([index], [x], [y], [z]);
    Sets XYZ coordinates of the specified source index.
    Example: s.setXYZ(1, 1.0, 0.5, 0.1);
  s.setXYZbyName([name], [x], [y], [z]);
    Sets XYZ coordinates of the source with the specified name.
    Example: s.setXYZbyName(\"flute\", 0.5, 0.5, 0);
  s.setAED([index], [x], [y], [z]);
  s.setAEDbyName([name], [x], [y], [z]);
    Same for AED coordinates.

Group manipulations:
  s.setGroupXYZ([index], [x], [y], [z], [optional: moveSub]);
    Sets XYZ coordinates of the specified group index.
    Example: s.setGroupXYZ(1, 1.0, 0.5, 0.1, 1);
  s.setXYZbyName([name], [x], [y], [z], [optional: moveSub]);
    Sets XYZ coordinates of the source with the specified name.
    Example: s.setXYZbyName(\"woodwinds\", 0.5, 0.5, 0, 0);
  s.setGroupAED([index], [x], [y], [z], [optional: moveSub]);
  s.setGroupAEDbyName([name], [x], [y], [z], [optional: moveSub]);
    Same for AED coordinates.
  s.rotateGroup([index], [x], [y], [z]);
    Rotates the attached sources around the group point.
    x, y, z define the relative axis-rotation in degrees.
    Example: s.rotateGroup(1, 0.0, 0.0, 10.0);
  s.rotateAroundOrigin([index], [x], [y], [z], [optional: moveSub]);
    Rotates the group point around the origin (0,0,0).
    x, y, z define the relative axis-rotation in degrees.
    Example: s.rotateGroupAroundOrigin(1, 0.0, 0.0, 10.0);
  s.rotateGroupByName([name], [x], [y], [z]);
  s.rotateAroundOriginByName([name], [x], [y], [z], [optional: moveSub]);
    Same with identification of the group by name.

  The optional parameter moveSub defines:
    0: group point only
    1: group point and attached sources, preserving relative positions.
    (default is 1)

Additional methods for group mode (absolute rotation and stretch):
  s.setGroupRotation([index], [x], [y], [z], [w]);
    Sets the absolute rotation of the group to the specified quaternion.
  s.setGroupStretch([index], [stretchFactor]);
    Sets the absolute stretch factor.
  s.setGroupRotationByName([name], [x], [y], [z], [w]);
  s.setGroupStretchByName([name], [stretchFactor]);
    Same with identification of the group by name.

Local buffer:
  The local buffer allows to store values between OSC messages.
  Up to 1000 float values can be stored and recalled anytime.
  s.setBufferValue([index], [value]);
    Saves the specified value at buffer position [index].
    Example: s.setBufferValue(1, 25.0);
  s.getBufferValue([index]);
    Gets the value stored at buffer position [index].
    Example: s.getBufferValue(1);

Error handling:
  Java Script syntax errors will be displayed at interpretation time.
  Errors in the methods defined above, will be automatically displayed,
  however, it's possible to handle these errors in the Java Script code:
    All getter-methods return the value if available, 'undefined' otherwise.
    All setter-methods return true if successful, 'undefined' otherwise.
    s.reportError([message]);
      Allows custom error reporting.
      Example: if(s.setXYZ(i, x, y, z) != true) s.reportError("beep");
    s.reportError("");
      Resets the automatically generated error message to ignore the error.

Note: all 'index' parameters are 1-based, except for the 'Local Buffer' methods
```

### OSC Out

![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-18 um 16.47.12.png]]

### Send Positions for External Usage:

The positions of the audio sources can be sent as OSC message to a defined target/port.
![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-19 um 09.06.42.png]]

### Send OSC to External Usage.

![[./_resources/ICST_Multi-AmbiEncoder.resources/Bildschirmfoto 2022-12-18 um 17.04.30.png]]

### 

### Example OSC Communication MaxMSP <-> Reaper

![[./_resources/ICST_Multi-AmbiEncoder.resources/Max---Reaper.gif]]

* * *

[[ICST Mono-AmbiEncoders]]

* * *

<<[Content](https://icst-ambiplugins.postach.io/page/content)
