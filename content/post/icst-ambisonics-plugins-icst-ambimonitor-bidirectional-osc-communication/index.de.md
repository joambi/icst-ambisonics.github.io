---
title: MaxMSP & ICST AmbiEncoder – OSC Kommunikation
description: "Zeigt die bidirektionale OSC-Kommunikation zwischen Max/MSP und ICST AmbiEncoder inklusive Winkel- und Bewegungsformaten."
date: 2025-03-16T09:44:58
year: 2025
month: 2025-03
weight: 2
tags: ["maxmsp", "osc", "ambimonitor", "ambiencoder", "bidirectional"]

key_points:
  - "Bidirektionale OSC-Kommunikation zwischen Max/MSP und ICST AmbiEncoder einrichten"
  - "Quellenwinkel im Euler-Format zwischen Max-Patches und REAPER senden und empfangen"
DisableComments: false
difficulty: "advanced"
---

# Bidirektionale OSC-Kommunikation mit MaxMSP

**Für wen:** Level: Advanced | Zielgruppe: Max/MSP- und OSC-Integrator:in.

Generiere Bewegungsdaten in Max und sende sie via OSC zum _ICST AmbiEncoder_ in deiner DAW. Alternativ kannst du eine Bewegungskomposition von deiner DAW zu den _icst.ambisonics-externals_ übertragen.

### **Erforderliche Software:**

- **MaxMSP v.8.0+** → [cycling74.com](http://cycling74.com)
- **ICST Ambisonics Tools v3** → [cycling74.com](http://cycling74.com)
- **ICST Ambisonics Plugins (VST3/AU)** → [ICST AmbiPlugins](https://github.com/schweizerweb/icst-ambisonics-plugins/releases)
- **Reaper (DAW)** → [reaper.fm](http://reaper.fm/download.php)

### **Setup-Anleitung:**

#### 1. OSC im ICST AmbiEncoder konfigurieren

- Öffne den _ICST AmbiEncoder_ in einem FX-Slot und navigiere zu **Encoder Settings**.
- Unter **OSC In** aktiviere den OSC-Eingangs-Port (z.B. `50001`).
   ![OSC-IN](osc-port.png)
- Klicke auf **OSC Out** und aktiviere den OSC-Ausgangs-Port.
    - Nutzt **ICST AmbiPlugins Standard XYZ Index**.
- Der Max-Demo-Patch hört auf:
    `'/icst/ambi/sourceindex/xyz'`

   ![OSC-OUT](osc-out.png)

#### 2. Öffne MaxMSP und lade den Patch

- Finde den _OSC communication with ICST plugins in DAW_ Patch.

Siehe die Demo-GIFs:
- ![Max_Reaper](Max_Reaper.gif)

Nächstes GIF: Wie es funktioniert:
![Max-AmbiEnc](max_osc_to_AmbiPlugins.gif)

---

## Absendung absoluter Winkel (Euler-Koordinaten)

Um **absolute Winkel** mit **Euler-Koordinaten** von MaxMSP zum ICST AmbiEncoder zu senden, verwende das folgende OSC-Nachrichtenformat:

```
/icst/ambi/source/euler [ChannelName] [Yaw] [Pitch] [Roll]
/icst/ambi/source/euler 'S1' 30 15 5
```

Für **Index-basierte Adressierung**:

```
/icst/ambi/sourceindex/euler [ChannelIndex] [Yaw] [Pitch] [Roll]
/icst/ambi/sourceindex/euler 1 30 15 5
```

**Hinweis:**

- `Yaw` (Azimuth): Horizontale Rotation
- `Pitch` (Elevation): Vertikale Neigung
- `Roll`: Rotation um die Vorwärtsachse

----
