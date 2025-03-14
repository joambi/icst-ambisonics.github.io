---
title: osc-syntax-for-the-icst-ambiencoder-plugin
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

---
### osc-syntax-for-the-icst-ambiencoder-plugin

The ICST AmbiEncoder offers OSC and JavaScript support, enabling seamless communication with OSC tools such as TouchOSC, IanniX, MaxMSP and other OCS-enabled tools.

### How it works:

1. Open the 'OSC In' tap 
![OSC IN-OUT](osc-in-out.png)
_Figure: Encoder Setting OSC - OSC In receives over the port 50001

2. You can find all the information in the “Help” section by clicking on the question mark.

OSC In:

* Receive OSC: Allows receiving commands through OSC on the defined port (default: 50001). OSC specification can be found in the help section of the Plugin.
* Send Positions for External Usage: The positions of the audio sources can be sent as OSC message to a defined target/port. Messages are triggered by position changes and the update rate is limited to 20Hz (50ms).

* * *

### **OSC - Syntax & Adress Specification**

1. Clicking on the question mark in the ICST AmbiEncoder.
   ![osc-in-help](OSX-Syntax.png)
	_Figure: OSC specification can be found in the help section of the Plugin._
	
	- Help  (?)
	- OSC Syntax
	- Sections

2. Incoming OSC Messages are:
	* either index based (source index), e.g. 1
	* or name based (source), e.g. flute

	**/icst/ambi/source**
	Set Source Position AED:
```
	/icst/ambi/source/aed [ChannelName] [Azimuth] [Elevation] [Distance]
	/icst/ambi/source/aed 'S1' 45 10 0.8
```
	Set Source Position XYZ:
```
	/icst/ambi/source/xyz [ChannelName] [X] [Y] [Z]
	/icst/ambi/source/xyz 'S2' 0.2 0.2 0.0
```
>[!Note:] The channel name (e.g S1, S2) will be sent as **symbol**.

**/icst/ambi/source index**
Set Source (Index) Position AED:
```
/icst/ambi/sourceindex/aed [ChannelIndex] [Azimuth] [Elevation] [Distance]
/icst/ambi/sourceindex/aed 1 45 10 0.8
```
Set Source (Index) Position XYZ:
```
/icst/ambi/sourceindex/xyz [ChannelIndex] [X] [Y] [Z]
/icst/ambi/sourceindex/xyz 2 0.2 0.2 0.0
```
> [!Note:] The channel index will be sent as **integer**.

* * *

### **Send Positions for External Usage**

1. Open the 'OSC Out' tap 

![OSC IN-OUT](osc-in-out.png)

Click _edit..._ to change settings (see screenshot below).
Note: The ICST AmbiPlugins Standard format sends the **source name as symbol**.

Max users, please define a Custom OSC Message as follows:
```
/icst/ambi/sourceindex/xyz {i} {x} {y} {z}
```

```
/icst/ambi/sourceindex/xyz {i} {a} {e} {d}
```

![[./_resources/OSC-Syntax_for_the_ICST_AmbiEncoder_Plugin.resources/Bildschirmfoto 2021-03-18 um 10.09.41.png]]
_Figure: Custom OSC Editor_

* * *


_Figure: Encoder Setting OSC - Address settings_