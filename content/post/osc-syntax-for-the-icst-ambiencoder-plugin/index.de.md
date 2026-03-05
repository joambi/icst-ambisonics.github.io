---
title: ICST AmbiEncoder – OSC Syntax
description: "Übersicht zur OSC-Syntax des AmbiEncoder mit Message-Formaten und unterstützten Tools wie TouchOSC oder Max."
date: 2025-03-16T09:44:58+01:00
year: 2025
month: 2025-03
weight: 1
tags: ["osc", "syntax", "ambiencoder", "reference"]
DisableComments: false
---

Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

---

## OSC Syntax für das ICST AmbiEncoder Plugin

Der **ICST AmbiEncoder** unterstützt **OSC** und **JavaScript**, was eine nahtlose Kommunikation mit OSC-Tools wie **TouchOSC, IanniX, MaxMSP** und andere OSC-fähige Software ermöglicht.

### **Funktionsweise**

1. Öffne den Tab **'OSC In'**.

![OSC IN-OUT](osc-in-out.png)

_Abbildung: Encoder-Einstellung 'OSC In' empfängt auf Port 50001_

Alle Informationen findest du im **Help**-Bereich, indem du auf das Fragezeichen (**?**) klickst.

#### **OSC In**

*  **Receive OSC**: Empfange OSC-Befehle auf dem definierten Port (Standard: 50001). Die vollständige OSC-Spezifikation ist im Help-Bereich des Plugins verfügbar.
- **Send Positions for External Usage**: Diese Funktion sendet Audio-Quellenpositionen als OSC-Nachrichten an ein definiertes Ziel/einen Port. Nachrichten lösen Positionswechsel aus, und die Update-Rate ist auf **20Hz (50ms)** begrenzt.

* * *

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
### **Schritte zum Senden von OSC-Nachrichten**

Der AmbiEncoder kann auch die meisten seiner Parameter über OSC senden.

![External-osc](external_osc.png)

Öffne das Fragezeichen vor den Presets, um detaillierte Hilfeinformationen zu erhalten.

1. Aktiviere **"Send Positions for External Usage"** in den Einstellungen.
2. Im **Targets**-Bereich:
    - Aktiviere oder deaktiviere die OSC-Übertragung.
    - Definiere die **Host-IP-Adresse**.
    - Wähle einen **Port** (Standard: **50001**).
    - Doppelklick auf **OSC messages** zum Bearbeiten.

    **Hinweis:** Wenn du an einem **internen FX Learning Program** teilnimmst, wähle **"Continuous"** Modus.

3. Klicke auf **Help (?)** für detaillierte OSC-Informationen.
4. Füge OSC-Nachrichten hinzu oder lösche sie.
5. Speichere oder lade OSC-Nachrichten in **Presets**.

* * *
<span style="font-size:9px;color:#9f9f9f;">©2025 ICST</span>

