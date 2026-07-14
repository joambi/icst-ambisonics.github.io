---
title: ICST AmbiEncoder – OSC Syntax
description: "Übersicht zur OSC-Syntax des AmbiEncoder mit Message-Formaten und unterstützten Tools wie TouchOSC oder Max."
date: 2025-03-16T09:44:58+01:00
year: 2025
month: 2025-03
weight: 1
tags: ["osc", "syntax", "ambiencoder", "reference"]

key_points:
  - "Alle OSC-Adressen und Parameterformate des ICST AmbiEncoders nachschlagen"
  - "Quellposition in AED- oder XYZ-Koordinaten von beliebigen OSC-Sendern steuern"
DisableComments: false
difficulty: "intermediate"
---

## OSC Syntax für das ICST AmbiEncoder Plugin

**Für wen:** Level: Advanced | Zielgruppe: Techniker:in, Developer, Max/OSC-User.

Der **ICST AmbiEncoder** unterstützt **OSC** und **JavaScript**, was eine nahtlose Kommunikation mit OSC-Tools wie **TouchOSC, IanniX, MaxMSP** und andere OSC-fähige Software ermöglicht.
Diese Seite ist die **Syntax-Referenz**.
Für Quickstart und Debugging-Reihenfolge nutze:
- [OSC im ICST AmbiEncoder - Die 10 wichtigsten Messages](/post/osc-10-key-messages/)

## **OSC Syntax & Adressspezifikation**

### **1. Zugriff auf OSC-Spezifikationen**

Klicke auf das **Fragezeichen** im ICST AmbiEncoder.
   ![osc-in-help](OSX-Syntax.png)

   _Abbildung: OSC-Spezifikationen im Help-Bereich._

Verfügbare Abschnitte:
- Help (**?**)
- OSC Syntax
- Sections
### **2. Eingehende OSC-Nachrichten**

Nachrichten können sein:

- **Index-basiert** (Quellen-Index), z.B. `1`
- **Name-basiert** (Quellenname), z.B. `flute`
#### **Quellenposition setzen (AED Format)**
```
	/icst/ambi/source/aed [ChannelName] [Azimuth] [Elevation] [Distance]
	/icst/ambi/source/aed 'S1' 45 10 0.8
```

#### **Quellenposition setzen (XYZ Format)**

```
	/icst/ambi/source/xyz [ChannelName] [X] [Y] [Z]
	/icst/ambi/source/xyz 'S2' 0.2 0.2 0.0
```

**Hinweis:** Der Kanalname (z.B S1, S2) wird als **Symbol** gesendet.

#### **Quellenposition nach Index setzen (AED Format)**

```
/icst/ambi/sourceindex/aed [ChannelIndex] [Azimuth] [Elevation] [Distance]
/icst/ambi/sourceindex/aed 1 45 10 0.8
```
#### **Quellenposition nach Index setzen (XYZ Format)**

```
/icst/ambi/sourceindex/xyz [ChannelIndex] [X] [Y] [Z]
/icst/ambi/sourceindex/xyz 2 0.2 0.2 0.0
```
**Hinweis:** Kanal-Indizes werden als **Ganzzahlen** gesendet.

* * *

## **Positionen für externe Verwendung senden**

1. Öffne den Tab **'OSC Out'**.

![OSC IN-OUT](osc-in-out.png)

**Hinweis:** Das Standard-Format der ICST AmbiPlugins sendet **Quellennamen als Symbole**. Max-Benutzer sollten eine **Custom OSC Message** definieren:

```
/icst/ambi/sourceindex/xyz {i} {x} {y} {z}
/icst/ambi/sourceindex/aed {i} {a} {e} {d}

```

![OSC-Out](osc.png)

_Abbildung: Custom 'OSC Out' Editor_

#### **Interne OSC-Kommunikation**

Um **alle AmbiEncoder-Bewegungen** zum ICST AmbiDecoder zu senden:
1. Deaktiviere **Speaker Edit Mode** im AmbiDecoder.
2. Aktiviere den OSC-Port.

![Edit_off](intern_osc2.png)

![Intern_osc_port](aktivate_osc.png)

![OSC_internal](Intern_osc.png)

Jetzt empfängt der AmbiDecoder **alle OSC-Nachrichten** von allen verbundenen AmbiEncodern.

---
* * *


## Vollständige OSC-Referenz (aus GitHub-Quellcode)

> Abgeleitet aus dem Plugin-Quellcode ([OSCHandlerEncoder.h/.cpp](https://github.com/schweizerweb/icst-ambisonics-plugins/blob/main/Encoder/Source/OSCHandlerEncoder.h)). Ergänzt die oben dokumentierten Standard-Nachrichten um alle weiteren unterstützten Adressen.

### Quellen – Name-basiert

| OSC-Adresse | Argumente | Typ | Beschreibung |
|---|---|---|---|
| `/icst/ambi/source/aed` | `[Name] [A] [E] [D]` | string, float, float, float | Position setzen (Azimut/Elevation/Distanz) per Quellname |
| `/icst/ambi/source/xyz` | `[Name] [X] [Y] [Z]` | string, float, float, float | Position setzen (kartesisch) per Quellname |
| `/icst/ambi/source/gain` | `[Name] [Gain_dB]` | string, float | Gain setzen per Quellname |

### Quellen – Index-basiert

| OSC-Adresse | Argumente | Typ | Beschreibung |
|---|---|---|---|
| `/icst/ambi/sourceindex/aed` | `[Index] [A] [E] [D]` | int, float, float, float | Position setzen (AED) per Quellindex (1-basiert) |
| `/icst/ambi/sourceindex/xyz` | `[Index] [X] [Y] [Z]` | int, float, float, float | Position setzen (XYZ) per Quellindex (1-basiert) |
| `/icst/ambi/sourceindex/gain` | `[Index] [Gain_dB]` | int, float | Gain setzen per Quellindex |
| `/icst/ambi/sourceindex/name` | `[Index] [Name]` | int, string | Name der Quelle setzen per Index |

### Gruppen

| OSC-Adresse | Argumente | Typ | Beschreibung |
|---|---|---|---|
| `/icst/ambi/group/aed` | `[Name] [A] [E] [D] [MovePoints]` | string, float, float, float, int | Gruppenposition setzen (AED); MovePoints: 0=nur Gruppe, 1=mit Quellen |
| `/icst/ambi/group/xyz` | `[Name] [X] [Y] [Z] [MovePoints]` | string, float, float, float, int | Gruppenposition setzen (XYZ); MovePoints: 0/1 |
| `/icst/ambi/group/rotate` | `[Name] [Rx] [Ry] [Rz]` | string, float, float, float | Gruppe relativ rotieren (Euler, Grad) |
| `/icst/ambi/group/setrotation/euler` | `[Name] [Rx] [Ry] [Rz]` | string, float, float, float | Absolute Gruppenrotation setzen (Euler, Grad) |
| `/icst/ambi/group/setrotation/quaternion` | `[Name] [q1] [q2] [q3] [q4]` | string, float×4 | Absolute Gruppenrotation setzen (Quaternion) |
| `/icst/ambi/group/rotateorigin` | `[Name] [Rx] [Ry] [Rz] [MovePoints]` | string, float, float, float, int | Gruppe um den Ursprung rotieren |
| `/icst/ambi/group/stretch` | `[Name] [Factor]` | string, float | Gruppe relativ strecken/stauchen (relativ) |
| `/icst/ambi/group/setstretch` | `[Name] [Factor]` | string, float | Absolute Streckung der Gruppe setzen |

### Distance Encoding – Einzelparameter

| OSC-Adresse | Argumente | Typ | Beschreibung |
|---|---|---|---|
| `/icst/ambi/distanceencoding/mode` | `[Mode]` | int | Modus: 0=Standard, 1=Advanced, 2=Exponential, 3=InverseProportional |
| `/icst/ambi/distanceencoding/unitcircle` | `[Radius]` | float | Radius des Einheitskreises |
| `/icst/ambi/distanceencoding/dbunit` | `[dB]` | float | dB-Einheit für Abstandscodierung |
| `/icst/ambi/distanceencoding/distanceattenuation` | `[Value]` | float | Distanzabschwächung (nur Inverse Proportional) |
| `/icst/ambi/distanceencoding/centercurve` | `[Value]` | float | Center-Kurven-Parameter |
| `/icst/ambi/distanceencoding/advancedfactor` | `[Value]` | float | Advanced-Faktor |
| `/icst/ambi/distanceencoding/advancedexponent` | `[Value]` | float | Advanced-Exponent |

### Distance Encoding – Kombinierte Presets

| OSC-Adresse | Argumente | Typ | Beschreibung |
|---|---|---|---|
| `/icst/ambi/distanceencoding/standard` | `[UnitCircleRadius]` | float | Standard-Modus + Einheitskreis setzen |
| `/icst/ambi/distanceencoding/advanced` | `[UnitCircle] [Factor] [Exponent]` | float, float, float | Advanced-Modus mit 3 Parametern |
| `/icst/ambi/distanceencoding/exponential` | `[UnitCircle] [dBUnit] [CenterCurve]` | float, float, float | Exponential-Modus mit 3 Parametern |
| `/icst/ambi/distanceencoding/inverseproportional` | `[UnitCircle] [dBUnit] [CenterCurve] [DistAttn]` | float, float, float, float | Inverse-Proportional-Modus mit 4 Parametern |

### OSC Out – Custom Message Formate

| Format | Beschreibung |
|---|---|
| `/icst/ambi/sourceindex/xyz {i} {x} {y} {z}` | Positions-Ausgabe per Index (XYZ) |
| `/icst/ambi/sourceindex/aed {i} {a} {e} {d}` | Positions-Ausgabe per Index (AED) |

### MuseScore SSMN-Kompatibilität

| OSC-Adresse | Argumente | Beschreibung |
|---|---|---|
| `/aed` | `[CH] [A] [E] [D] [CH_check]` | MuseScore SSMN-Format (int, float, float, float, int) |
