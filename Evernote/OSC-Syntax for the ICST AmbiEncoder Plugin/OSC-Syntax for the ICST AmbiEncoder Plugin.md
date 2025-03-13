---
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *

This section configures OSC sending and receiving.
![[./_resources/OSC-Syntax_for_the_ICST_AmbiEncoder_Plugin.resources/Bildschirmfoto 2021-03-18 um 10.08.08.png]]
_Figure: Encoder Setting OSC - Address settings_

External (A)

* Receive OSC: Allows receiving commands through OSC on the defined port (default: 50001). OSC specification can be found in the help section of the Plugin.
* Send Positions for External Usage: The positions of the audio sources can be sent as OSC message to a defined target/port. Messages are triggered by position changes and the update rate is limited to 20Hz (50ms).

### Internal (B)

This option allows the Encoder to send the positions of the active sources to the decoder for the position overview. The positions will be sent using the defined time interval. Make sure, it's lower than the Timeout defined in the Decoder plugin. The format of this OSC message is proprietary and should not be used for other purposes!

### Log (C)

The OSC log can be used for debugging incoming OSC messages. A detailed report of received messages will be created in real-time. Invalid messages will be marked with red color and have a description about why it failed.
**Note: Flooding the log with high frequent OSC messages can slow down the Encoder and defer user interactions.**

* * *

**OSC - Adress Specification**
![[./_resources/OSC-Syntax_for_the_ICST_AmbiEncoder_Plugin.resources/Bildschirmfoto 2021-03-18 um 10.19.07.png]]
_Figure: OSC specification can be found in the help section of the Plugin._

1. Help  (?)
2. OSC Syntax
3. Sections

Incoming OSC Messages are:

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
Note: The channel name (e.g S1, S2) will be sent as **symbol**.

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
Note: The channel index will be sent as **integer**.

* * *

**Send Positions for External Usage**

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

<< [content](https://ambisonics.ch/post/content)  -- [tutorials](https://ambisonics.ch/post/tutorials) \>>
