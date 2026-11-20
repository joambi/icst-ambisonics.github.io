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
post_kind: "tutorial"
tool: ["Recording"]
---

Level: Intermediate | **Audience:** Komponist:in, Sounddesigner:in, Recording-Techniker:in.

---

Ambisonics-Mikrofone nehmen den Raum auf – nicht als Stereo, nicht als Surround, sondern als vollständiges sphärisches Schallfeld. Das klingt nach mehr als es zunächst ist: Fast alle käuflichen Ambisonics-Mikrofone sind First-Order-Geräte (FOA). Sie liefern vier Kanäle, die das Feld in einer Auflösung beschreiben, die für Raumatmosphären, Texturen und Klangobjekte hervorragend ist, für die scharfe Lokalisation eines HOA3- oder HOA7-Systems aber nicht ausreicht. Dieser Artikel erklärt den Aufnahmeprozess, die Konvertierung und wie das Ergebnis in den ICST-Workflow integriert wird.

---

## A-Format: Was aus dem Mikrofon kommt

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 240" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Vier tetraedrische Kapselsignale werden von einem mikrofonspezifischen Plugin in die vier B-Format-Komponenten W, X, Y und Z umgerechnet." xmlns="http://www.w3.org/2000/svg"><defs><marker id="ma" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="10" y="20" text-anchor="start" font-size="12" font-weight="600" fill="currentColor" fill-opacity="1">A-Format (rohe Kapseln)</text><text x="710" y="20" text-anchor="end" font-size="12" font-weight="600" fill="currentColor" fill-opacity="1">B-Format (ACN / SN3D)</text><rect x="272" y="85" width="186" height="80" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="365.0" y="122.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">A→B-Konvertierung</text><text x="365.0" y="139.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">mikrofonspezifisches Plugin</text><rect x="10" y="40" width="130" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="75.0" y="57.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">FLU</text><text x="75.0" y="74.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">vorne links oben</text><line x1="142" y1="60" x2="270" y2="125" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><line x1="460" y1="125" x2="588" y2="60" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><rect x="590" y="40" width="120" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="650.0" y="57.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">W</text><text x="650.0" y="74.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">Druck (Kugel)</text><rect x="10" y="90" width="130" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="75.0" y="107.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">FRD</text><text x="75.0" y="124.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">vorne rechts unten</text><line x1="142" y1="110" x2="270" y2="125" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><line x1="460" y1="125" x2="588" y2="110" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><rect x="590" y="90" width="120" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="650.0" y="107.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">X</text><text x="650.0" y="124.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">vorne–hinten</text><rect x="10" y="140" width="130" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="75.0" y="157.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">BLD</text><text x="75.0" y="174.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">hinten links unten</text><line x1="142" y1="160" x2="270" y2="125" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><line x1="460" y1="125" x2="588" y2="160" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><rect x="590" y="140" width="120" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="650.0" y="157.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Y</text><text x="650.0" y="174.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">links–rechts</text><rect x="10" y="190" width="130" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="75.0" y="207.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">BRU</text><text x="75.0" y="224.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">hinten rechts oben</text><line x1="142" y1="210" x2="270" y2="125" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><line x1="460" y1="125" x2="588" y2="210" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><rect x="590" y="190" width="120" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="650.0" y="207.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Z</text><text x="650.0" y="224.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">oben–unten</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">A-Format ist das rohe Kapselsignal; die A→B-Konvertierung macht daraus W, X, Y, Z.</figcaption>
</figure>


Ein Ambisonics-Mikrofon besteht aus vier Kapseln in tetraedrischer Anordnung – typischerweise eine Kapsel oben vorne links, eine unten vorne rechts, eine unten hinten links, eine oben hinten rechts. Jede Kapsel nimmt ihr eigenes Signal auf. Diese vier rohen Kapsel-Signale heissen **A-Format**.

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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 210" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Zwei Aufnahmewege in den B-Format-Bus: A-Format-Mikrofone laufen über ein A→B-Plugin, das Zylia ZM-1 liefert direkt AmbiX." xmlns="http://www.w3.org/2000/svg"><defs><marker id="mw" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="10" y="18" text-anchor="start" font-size="12" font-weight="600" fill="currentColor" fill-opacity="1">Ambeo / Rode NT-SF1 (A-Format)</text><rect x="10" y="28" width="130" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="75.0" y="53.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Mikrofon</text><text x="75.0" y="70.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">4 × XLR, 48 V</text><line x1="142" y1="56" x2="168" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#mw)"/><rect x="170" y="28" width="150" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="245.0" y="53.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">4-Kanal-Spur</text><text x="245.0" y="70.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">A-Format-Aufnahme</text><line x1="322" y1="56" x2="348" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#mw)"/><rect x="350" y="28" width="150" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="425.0" y="53.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">A→B-Plugin</text><text x="425.0" y="70.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">AmbiX, 1. Ordnung</text><line x1="502" y1="56" x2="548" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#mw)"/><rect x="550" y="28" width="160" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="630.0" y="53.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">B-Format-Bus</text><text x="630.0" y="70.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">64 Kanäle</text><text x="10" y="122" text-anchor="start" font-size="12" font-weight="600" fill="currentColor" fill-opacity="1">Zylia ZM-1 (HOA3, direkt AmbiX)</text><rect x="10" y="132" width="130" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="75.0" y="157.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Zylia ZM-1</text><text x="75.0" y="174.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">USB</text><line x1="142" y1="160" x2="168" y2="160" stroke="currentColor" stroke-width="1.6" marker-end="url(#mw)"/><rect x="170" y="132" width="150" height="56" rx="8" stroke="#3fa968" fill="#3fa968" fill-opacity=".16" stroke-width="1.5"/><text x="245.0" y="157.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">HOA3-Spur</text><text x="245.0" y="174.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">16 Kanäle, AmbiX</text><line x1="322" y1="160" x2="548" y2="160" stroke="currentColor" stroke-width="1.6" marker-end="url(#mw)"/><text x="435" y="150" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">kein A→B-Plugin nötig</text><rect x="550" y="132" width="160" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="630.0" y="157.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">B-Format-Bus</text><text x="630.0" y="174.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">64 Kanäle</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Beide Wege enden im selben B-Format-Bus.</figcaption>
</figure>


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
- Raumatmosphären (Atmo, Ambience, Aussenaufnahmen)
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

- [Den B-Format-Master exportieren](/de/post/b-format-export-reaper/)
- [Binaural Monitoring im ICST-Workflow](/de/post/binaural-monitoring-icst-workflow/)
- [XYZ und AED – Zwei Koordinatensysteme, ein Lautsprecher](/de/post/xyz-vs-aed-koordinatensysteme/)
- [ICST AmbiDecoder – Skalierung und Laufzeitkompensation](/de/post/decoder-skalierung-laufzeitkompensation/)
