---
title: Ambisonics-Mikrofon aufnehmen – A-Format, B-Format und die ICST-Integration
description: "Wie du mit Ambisonics-Mikrofonen (Sennheiser Ambeo, Rode NT-SF1, Zylia ZM-1) arbeitest: A-Format verstehen, A→B-Konvertierung, Integration ins ICST-Workflow und was FOA-Aufnahmen leisten können und wo ihre Grenzen liegen."
date: 2026-03-21T17:00:00+01:00
year: 2026
month: 2026-03
weight: 37
tags: ["mikrofon", "a-format", "b-format", "aufnahme", "ambeo", "nt-sf1", "zylia", "foa", "reaper", "workflow"]
key_points:
  - "A-Format ist das rohe Kapsel-Signal – es klingt nicht nach Ambisonics, bis es zu B-Format matriziert wird"
  - "Die A→B-Konvertierung braucht ein mikrofonspezifisches Plugin – keine generische Matrix"
  - "FOA-Mikrofone liefern 1st-Order-B-Format: räumlich begrenzt, aber ideal für Raumakustik, Atmo und Texturen"
difficulty: "intermediate"
---

Level: Intermediate | **Audience:** Komponist:in, Sounddesigner:in, Recording-Techniker:in.

---

Ambisonics-Mikrofone nehmen den Raum auf – nicht als Stereo, nicht als Surround, sondern als vollständiges sphärisches Schallfeld. Das klingt nach mehr als es zunächst ist: Fast alle käuflichen Ambisonics-Mikrofone sind First-Order-Geräte (FOA). Sie liefern vier Kanäle, die das Feld in einer Auflösung beschreiben, die für Raumatmosphären, Texturen und Klangobjekte hervorragend ist, für die scharfe Lokalisation eines HOA3- oder HOA7-Systems aber nicht ausreicht. Dieser Artikel erklärt den Aufnahmeprozess, die Konvertierung und wie das Ergebnis in den ICST-Workflow integriert wird.

---

## A-Format: Was aus dem Mikrofon kommt

Ein Ambisonics-Mikrofon besteht aus vier Kapseln in tetraedrischer Anordnung – typischerweise eine Kapsel oben vorne links, eine unten vorne rechts, eine unten hinten links, eine oben hinten rechts. Jede Kapsel nimmt ihr eigenes Signal auf. Diese vier rohen Kapsel-Signale heißen **A-Format**.

A-Format klingt nicht wie Ambisonics. Es ist das Rohmaterial: vier leicht unterschiedliche Perspektiven desselben Raums, mit Kapseldistanz-Artefakten und ohne direkten Bezug zu W, X, Y, Z. Du kannst A-Format nicht direkt in den ICST-Workflow einspeisen.

Was du brauchst, ist die **A→B-Konvertierung**: eine Matrizierung, die aus den vier Kapsel-Signalen die vier B-Format-Komponenten W (Druck), X (vorne-hinten), Y (links-rechts) und Z (oben-unten) berechnet.

---

## Warum ein mikrofonspezifisches Plugin nötig ist

Die Konvertierungsmatrix ist nicht universell. Sie hängt von der exakten Kapsel-Geometrie, der Kapselpolarität und den Frequenzgang-Eigenschaften des jeweiligen Mikrofons ab. Dazu kommt das **Non-Koinzidenz-Problem**: Die vier Kapseln sind physisch voneinander getrennt, meist ca. 1 cm. Bei hohen Frequenzen führt diese Distanz zu Richtungsabweichungen, die eine einfache feste Matrix nicht kompensieren kann. Moderne Konvertierungs-Plugins arbeiten deshalb frequenzabhängig – sie korrigieren die Non-Koinzidenz-Artefakte im Frequenzbereich.

Jeder Mikrofonhersteller liefert sein eigenes Konvertierungs-Plugin mit, das auf die Messdaten des jeweiligen Mikrofons kalibriert ist. Drittanbieter-Plugins können generische Matrizen anwenden – das funktioniert, ist aber weniger präzise.

---

## Mikrofon-Übersicht

### Sennheiser Ambeo VR Mic

- **Kapseln**: 4 × KE 14 Kardioid, tetraedrisch
- **A-Format Bezeichnung**: FLU (Front Left Up), FRD (Front Right Down), BLD (Back Left Down), BRU (Back Right Up)
- **Konvertierungs-Plugin**: **Sennheiser AMBEO A-B Converter** (kostenlos, VST/AU/AAX) – kalibriert auf dieses Mikrofon, mit EQ-Kompensation
- **Ausgang**: 4-Kanal XLR, 48V Phantom Power benötigt

### Rode NT-SF1

- **Kapseln**: 4 × 1/2" TF45C Kardioid, tetraedrisch
- **Anschluss**: 10-Pin XLR → 4 × XLR-Adapter (mitgeliefert)
- **Konvertierungs-Plugin**: **SoundField by RØDE** (kostenlos, VST/AU/AAX) – frequenzabhängige Konvertierung, besonders gut bei hohen Frequenzen
- **Ausgabeformate**: AmbiX (ACN/SN3D), FuMa, Stereo, 5.1, 7.1, und Atmos-kompatible Formate direkt aus dem Plugin
- **Besonderheit**: Das SoundField-Plugin bietet Richtungsmanipulation (Rotation, Tilt, Tumble) direkt im Konvertierungs-Schritt

### Zylia ZM-1

- **Kapseln**: 19 MEMS-Mikrofone (Infineon XENSIV)
- **Ambisonics-Ordnung**: Nativ **3rd Order** (herunterskalierbar auf 2nd oder 1st)
- **Anschluss**: USB direkt an Rechner oder an Zylia ZR-1 Recorder
- **Besonderheit**: Einziges hier genanntes Mikrofon mit HOA-Ausgabe ab Werk. Kein A→B-Konvertierungs-Plugin nötig – der Zylia-Treiber liefert direkt AmbiX/SN3D
- **Einschränkung**: Durch MEMS-Kapseln höheres Eigenrauschen als Kondensator-Mikrofone; SNR 69 dB

| Mikrofon | Ordnung | Konvertierungs-Plugin | Anschluss | Stärken |
|---|---|---|---|---|
| Sennheiser Ambeo VR | FOA | AMBEO A-B Converter | 4× XLR | Klangqualität, Kalibrierung |
| Rode NT-SF1 | FOA | SoundField by RØDE | 10-Pin XLR | Formatflexibilität, Richtungskorrektur |
| Zylia ZM-1 | HOA3 | Nicht nötig (direkt AmbiX) | USB | Einzige günstige HOA-Option |

---

## Workflow in REAPER: Schritt für Schritt

### 1. Vier Kanäle aufnehmen

Das A-Format-Mikrofon braucht 4 Eingangskanäle am Audio-Interface – jeweils mit 48V Phantom Power. In REAPER einen 4-Kanal-Track anlegen und die vier Kapsel-Signale als Mehrkanal-Aufnahme routen. Beim Abhören während der Aufnahme klingt es noch nicht nach Ambisonics – das ist normal.

### 2. A→B-Konvertierungs-Plugin auf den Aufnahme-Track legen

Nach der Aufnahme (oder direkt im Monitoring-Pfad): Konvertierungs-Plugin auf den 4-Kanal-Track legen. Der Output des Plugins sind 4 Kanäle B-Format (W, X, Y, Z in ACN-Reihenfolge, SN3D-normalisiert).

- Sennheiser Ambeo: AMBEO A-B Converter → Output auf AmbiX/SN3D stellen
- Rode NT-SF1: SoundField by RØDE → Format auf AmbiX stellen, Order = 1st
- Zylia ZM-1: Kein Plugin nötig, direkt als HOA3-Track routen

### 3. Output auf den B-Format-Master-Bus routen

Den 4-Kanal-Output des Konvertierungs-Plugins auf den B-Format-Master-Bus senden. Kanaloffset = 0, alle 4 Kanäle senden. Ab hier verhält sich das Mikrofon-Signal wie jede andere Ambisonics-Quelle in der Session – es wird zusammen mit Encoder-Quellen im B-Format-Bus summiert.

### 4. Monitoring und Orientierungskontrolle

Beim ersten Abhören prüfen, ob die Hauptrichtung stimmt. Ein Ambisonics-Mikrofon hat eine Referenzachse – typischerweise die Vorderkante des Mikrofons, die in Richtung der Hauptschallquelle zeigen soll. Wenn die Szene gespiegelt oder rotiert klingt: Im SoundField-Plugin (Rode) oder über ein separates SPARTA Rotator-Plugin die Orientierung korrigieren.

---

## Was FOA-Aufnahmen leisten – und wo die Grenze liegt

First-Order-Ambisonics aus einem 4-Kapsel-Mikrofon beschreibt das Schallfeld mit begrenzter räumlicher Auflösung. Das hat praktische Konsequenzen:

**Gut geeignet für:**
- Raumatmosphären (Atmo, Ambience, Außenaufnahmen)
- Diffuse Klangtexturen
- Raumakustik-Impulse (Konvolutions-Hall)
- Natürliche Klangumgebungen für kompositorischen Hintergrund

**Begrenzt geeignet für:**
- Scharfe Punktquelle-Lokalisation (ein einzelner Lautsprecher in einem Cluster klingt unscharf)
- Elevationsabbildung mit hoher Präzision
- Mischung mit HOA3- oder HOA7-Encoder-Quellen, wenn dieselbe Lokalisation erwartet wird

FOA-Material und HOA-Encoder-Quellen **können im selben B-Format-Bus summiert werden** – das ist kein technisches Problem. Die räumliche Kohärenz hängt dann davon ab, wie gut sich die FOA-Textur gegen die schärferen HOA-Quellen verhält. In vielen kompositorischen Kontexten ist genau diese Differenz interessant: ein diffuses FOA-Feld als Untergrund, scharfe HOA-Objekte darüber.

---

## FOA auf HOA skalieren?

Prinzipiell gibt es neuronale Netzwerk-Ansätze, die FOA zu HOA3 hochrechnen – experimentelle Werkzeuge, die in der Forschung existieren (z.B. Conv-TasNet-basierte Modelle). Für den Produktionsalltag gilt: Diese Verfahren verbessern die räumliche Repräsentation, können aber keine Information zurückgewinnen, die die Mikrofon-Physik nie aufgenommen hat. FOA-Aufnahmen bleiben FOA – upscaling ist Enhancement, kein Ersatz.

Wer native HOA-Mikrofonaufnahmen braucht, greift zum Zylia ZM-1 (HOA3) oder zu Mehr-Mikrofon-Arrayaufnahmen.

---

## Gain-Staging und Headroom

FOA-Mikrofone, insbesondere mit MEMS-Kapseln (Zylia), haben höheres Eigenrauschen als Studio-Kondensatormikrofone. Empfehlungen:

- Aufnahmelautstärke so wählen, dass der W-Kanal (Omnidirektional) bei lauten Momenten etwa –12 dBFS Peak hat
- Keine Gain-Normalisierung nach der Aufnahme, bevor die A→B-Konvertierung nicht abgeschlossen ist – das Pegelgleichgewicht zwischen den Kapseln ist für die Matrizierung entscheidend
- Nach der Konvertierung: W-Kanal sollte den höchsten Pegel haben; wenn X, Y oder Z dominieren, stimmt die Matrizierung oder der Gain nicht

---

## Weiterführende Seiten

- [Den B-Format-Master exportieren](/post/b-format-export-reaper/)
- [Binaural Monitoring im ICST-Workflow](/post/binaural-monitoring-icst-workflow/)
- [XYZ und AED – Zwei Koordinatensysteme, ein Lautsprecher](/post/xyz-vs-aed-koordinatensysteme/)
- [ICST AmbiDecoder – Skalierung und Laufzeitkompensation](/post/decoder-skalierung-laufzeitkompensation/)
