---
title: ICST AmbiEncoder – OSC Syntax
description: "Reference for the OSC syntax supported by ICST AmbiEncoder, covering message formats and TouchOSC/MaxMSP-compatible parameters."
date: 2025-03-16T09:44:58+01:00
year: 2025
month: 2025-03
weight: 1
tags: ["osc", "syntax", "ambiencoder", "reference"]

key_points:
  - "Look up every OSC address and parameter format for ICST AmbiEncoder"
  - "Control source position in AED or XYZ coordinates from any OSC sender"
DisableComments: false
difficulty: "intermediate"
---

## OSC Syntax for the ICST AmbiEncoder Plugin

Level: Advanced | **Audience:** Technician, Developer, Max/OSC user.

The **ICST AmbiEncoder** supports **OSC** and **JavaScript**, enabling seamless communication with OSC tools such as **TouchOSC, IanniX, MaxMSP**, and other OSC-enabled software.
This page is the **syntax reference**.
For a practical quickstart and debugging sequence, use:
- [OSC im ICST AmbiEncoder - Die 10 wichtigsten Messages](/post/osc-10-key-messages/)

## **OSC Syntax & Address Specification**

### **1. Accessing OSC Specifications**

Click the **question mark** in the ICST AmbiEncoder.
   ![osc-in-help](OSX-Syntax.png)
   
   _Figure: OSC specifications in the Help section._

Available sections:
- Help (**?**)
- OSC Syntax
- Sections
### **2. Incoming OSC Messages**

Messages can be:

- **Index-based** (source index), e.g., `1`
- **Name-based** (source name), e.g., `flute`
#### **Set Source Position (AED Format)**
```
	/icst/ambi/source/aed [ChannelName] [Azimuth] [Elevation] [Distance]
	/icst/ambi/source/aed 'S1' 45 10 0.8
```

#### **Set Source Position (XYZ Format)**
	
```
	/icst/ambi/source/xyz [ChannelName] [X] [Y] [Z]
	/icst/ambi/source/xyz 'S2' 0.2 0.2 0.0
```

**Note:** The channel name (e.g S1, S2) will be sent as **symbol**.

#### **Set Source (Index) Position (AED Format)**

```
/icst/ambi/sourceindex/aed [ChannelIndex] [Azimuth] [Elevation] [Distance]
/icst/ambi/sourceindex/aed 1 45 10 0.8
```
#### **Set Source (Index) Position (XYZ Format)**

```
/icst/ambi/sourceindex/xyz [ChannelIndex] [X] [Y] [Z]
/icst/ambi/sourceindex/xyz 2 0.2 0.2 0.0
```
**Note:** Channel indices are sent as **integers**.

* * *

## **Sending Positions for External Usage**

1. Open the **'OSC Out'** tab.

![OSC IN-OUT](osc-in-out.png)

**Note:** The ICST AmbiPlugins standard format sends **source names as symbols**. Max users should define a **Custom OSC Message**:

```
/icst/ambi/sourceindex/xyz {i} {x} {y} {z}
/icst/ambi/sourceindex/aed {i} {a} {e} {d}

```

![OSC-Out](osc.png)

_Figure: Custom 'OSC Out' Editor_

#### **Internal OSC Communication**

To send **all AmbiEncoder movements** to the ICST AmbiDecoder:
1. Deactivate **Speaker Edit Mode** in the AmbiDecoder.
2. Activate the OSC port.

![Edit_off](intern_osc2.png)

![Intern_osc_port](aktivate_osc.png)

![OSC_internal](Intern_osc.png)

Now, the AmbiDecoder receives **all OSC messages** from all connected AmbiEncoders.

---
* * *

