---

tags: 
  - published

---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *

Most of the  ICST Ambisonics Plugins Parameters can be controlled over OSC.
There are two OSC - Sections implemented: OSC In and OSC Out.

* * *

## 'OSC Out' (Send OSC)

![[./_resources/ICST_Ambisonics_Encoder_OSC.resources/Bildschirmfoto 2022-09-15 um 13.22.43.png]]
(A) The 'ICST AmbiEncoder' sends all 'Source points' to the 'ICST AmbiDecoder' via the standard UDP port (50000). This allows a total view of all incoming encoder movements in the decoder.
![[./_resources/ICST_Ambisonics_Encoder_OSC.resources/Bildschirmfoto 2022-02-18 um 17.18.52.png]]

In the 'Targets' the user could configure his one osc-presets.
![[./_resources/ICST_Ambisonics_Encoder_OSC.resources/Bildschirmfoto 2022-02-18 um 17.31.17.png]]

* You can select the IP number, the port number, and the type of OSC messages.
* It is also possible to send continuous OSC messages (when the flag is activated).
* It helps learn other plugins parameters.

* * *

## 'OSC In' (Receives OSC)

### OSC In: (Default)

The default osc input waits for this osc-messages: (example)
```
/icst/ambi/source/xyz 'S2' 0.2 0.2 0.0
```
For detailed descriptions go to the 'Help' in the Encoder Plugin
![[./_resources/ICST_Ambisonics_Encoder_OSC.resources/Bildschirmfoto 2022-09-15 um 11.55.38.png]]
You can now also scale the incoming OSC streams. See more details in the next screenshot.
![[./_resources/ICST_Ambisonics_Encoder_OSC.resources/Bildschirmfoto 2022-09-15 um 11.41.33.png]]

### 'OSC In' with JavaScript option:

![[./_resources/ICST_Ambisonics_Encoder_OSC.resources/Bildschirmfoto 2022-09-15 um 17.35.43.png]]
In 'JS-Code' click the (?) to open the Help for 'JavaScript code'
![[./_resources/ICST_Ambisonics_Encoder_OSC.resources/Bildschirmfoto 2022-07-20 um 16.58.12.png]]

* * *

## Access to OSC data:

```
s.path([index]);
```
Returns the specified part of the OSC path.
Example: /this/is/my/path -> s.path(3); -> 'my'
```
s.arg([index]);
```
Returns the specified argument of the OSC message.
Example: /demo 1 2 3 -> s.arg(2); -> 2

**Access to current data:**
  s.getX(\[index\]);
  s.getY(\[index\]);
  s.getZ(\[index\]);
  s.getA(\[index\]);
  s.getE(\[index\]);
  s.getD(\[index\]);
  s.getName(\[index\]);

**Manipulation of data set:**
s.setXYZ(\[index\], \[x\], \[y\], \[z\]);
Sets XYZ coordinates of the specified source index.   

Example:
```
s.setXYZ(1, 1.0, 0.5, 0.1);
```
s.setXYZbyName(\[name\], \[x\], \[y\], \[z\]);
Sets XYZ coordinates of the source with the specified name.

Example:
```
s.setXYZbyName("flute", 0.5, 0.5, 0);
```
s.setAED(\[index\], \[x\], \[y\], \[z\]);
s.setAEDbyName(\[name\], \[x\], \[y\], \[z\]);

Same for AED coordinates.

**Group manipulations:**
s.setGroupXYZ(\[index\], \[x\], \[y\], \[z\], \[optional: moveSub\]);
Sets XYZ coordinates of the specified group index.

Example:
```
s.setGroupXYZ(1, 1.0, 0.5, 0.1, 1);
```
  s.setXYZbyName(\[name\], \[x\], \[y\], \[z\], \[optional: moveSub\]);
  Sets XYZ coordinates of the source with the specified name.

Example:
```
s.setXYZbyName("woodwinds", 0.5, 0.5, 0, 0);
```
  s.setGroupAED(\[index\], \[x\], \[y\], \[z\], \[optional: moveSub\]);
  s.setGroupAEDbyName(\[name\], \[x\], \[y\], \[z\], \[optional: moveSub\]);

Same for AED coordinates.
```
  s.rotateGroup([index], [x], [y], [z]);
```
Rotates the attached sources around the group point.
x, y, z define the relative axis-rotation in degrees.

Example:
```
s.rotateGroup(1, 0.0, 0.0, 10.0);
```
s.rotateAroundOrigin(\[index\], \[x\], \[y\], \[z\], \[optional: moveSub\]);

Rotates the group point around the origin (0,0,0).
x, y, z define the relative axis-rotation in degrees.

**Example:**
```
s.rotateGroupAroundOrigin(1, 0.0, 0.0, 10.0);
```
s.rotateGroupByName(\[name\], \[x\], \[y\], \[z\]);
s.rotateAroundOriginByName(\[name\], \[x\], \[y\], \[z\], \[optional: moveSub\]);

Same with identification of the group by name.

The optional parameter moveSub defines:
    0: group point only
    1: group point and attached sources, preserving relative positions.

### Local buffer:

  The local buffer allows to store values between OSC messages.
  Up to 1000 float values can be stored and recalled anytime.
```
  s.setBufferValue([index], [value]);
```
Saves the specified value at buffer position \[index\].

Example:
```
s.setBufferValue(1, 25.0);
```
  s.getBufferValue(\[index\]);

    Gets the value stored at buffer position \[index\].

Example:
```
s.getBufferValue(1);
```

**Note:** all 'index' parameters are 1-based

* * *

### [Inspirations examples](https://ambisonics.ch/post/icst-ambiplugins-osc-javascript-examples)

* * *

### Save OSC Javascript Preset

![[./_resources/ICST_Ambisonics_Encoder_OSC.resources/Bildschirmfoto 2022-08-30 um 11.53.44.png]]

### Load 'presets...'

![[./_resources/ICST_Ambisonics_Encoder_OSC.resources/Bildschirmfoto 2022-08-30 um 11.59.08.png]]
Press  --> 'presets...'   -->  choose the 'preset' and click 'Apply'.

* * *

OSC (Open Sound Control) <https://en.wikipedia.org/wiki/Open_Sound_Control>

* * *

<< [Content](https://ambisonics.ch/post/content)
