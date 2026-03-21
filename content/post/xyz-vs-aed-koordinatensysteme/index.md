---
title: XYZ und AED – Zwei Koordinatensysteme, ein Lautsprecher
description: "Der ICST AmbiDecoder erlaubt die Eingabe von Lautsprecherpositionen sowohl in kartesischen (XYZ) als auch in Polarkoordinaten (AED). Dieser Artikel erklärt den Unterschied und wann welches System sinnvoll ist."
date: 2026-03-21T10:30:00+01:00
year: 2026
month: 2026-03
weight: 31
tags: ["decoder", "koordinaten", "xyz", "aed", "lautsprecher", "setup", "konfiguration"]
key_points:
  - "XYZ beschreibt Positionen im euklidischen Raum – ideal für eingemessene Installationen"
  - "AED (Azimut, Elevation, Distanz) orientiert sich an Hörwahrnehmung und Kompassrichtungen"
  - "Beide Systeme sind jederzeit parallel im Decoder sichtbar und editierbar"
difficulty: "beginner"
---

Level: Beginner | **Audience:** Techniker:in, Komponist:in, Studierende.

Diese Seite erklärt, warum der ICST AmbiDecoder zwei Koordinatensysteme anbietet und wie du entscheidest, welches du verwenden solltest.

> **Gemeinsamer Kernsatz dieser Decoder-Serie:** Der Decoder erzeugt den Raum nicht neu, sondern projiziert ein B-Format-Feld auf ein reales System.
>
> In diesem Artikel geht es um den ersten Schritt dieser Projektion: **Geometrie**. Koordinaten bestimmen, **wo** der Decoder Lautsprecher im Raum verortet.

---

## Das Problem: Wie beschreibt man, wo ein Lautsprecher steht?

Ein Lautsprecher im Raum hat eine Position – aber diese Position lässt sich auf verschiedene Arten beschreiben. Der ICST AmbiDecoder bietet zwei Systeme gleichzeitig an:

- **XYZ** – Kartesische Koordinaten (euklidischer Raum)
- **AED** – Polarkoordinaten: Azimut, Elevation, Distanz

Beide Systeme beschreiben denselben Punkt im Raum. Der Decoder rechnet intern mit XYZ, zeigt aber immer beide Werte an. Du kannst jederzeit in beiden Systemen editieren – Doppelklick auf ein Parameterfeld genügt.

---

## XYZ – Kartesische Koordinaten

XYZ beschreibt die Position eines Lautsprechers als Punkt im dreidimensionalen euklidischen Raum:

- **X** – Richtung links/rechts (negativ = links, positiv = rechts)
- **Y** – Richtung vorne/hinten (positiv = vorne, negativ = hinten)
- **Z** – Richtung oben/unten (positiv = oben, negativ = unten)

**Wann XYZ verwenden?** Immer dann, wenn du Messdaten aus einem Laservermessungsgerät, einer CAD-Zeichnung oder einer Architekturdokumentation hast. Solche Daten liegen fast immer in kartesischen Koordinaten vor. Du kannst sie direkt in den Decoder übertragen, ohne umzurechnen.

XYZ-Eingabe ist präzise und reproduzierbar. Sie eignet sich besonders für:

- Konzertinstallationen mit eingemessenen Lautsprechern
- wissenschaftliche Forschungsumgebungen
- Setups, die zwischen Aufführungsorten übertragen werden sollen

---

## AED – Azimut, Elevation, Distanz

AED beschreibt dieselbe Position wahrnehmungsorientiert, ausgehend vom Zentrum des Hörraums:

- **A (Azimut)** – horizontaler Winkel in Grad (0° = vorne, 90° = links, 180° / -180° = hinten, 270° / -90° = rechts)
- **E (Elevation)** – vertikaler Winkel in Grad (0° = Horizontalebene, +90° = direkt oben, -90° = direkt unten)
- **D (Distanz)** – Abstand des Lautsprechers vom Zentrum in Metern

**Wann AED verwenden?** Wenn du intuitiv nach Richtung und Höhe denkst, nicht nach Koordinaten. AED entspricht der Art, wie Menschen Richtung beschreiben: „Der Lautsprecher hängt links oben, 45° seitlich und 30° erhöht."

AED ist besonders nützlich für:

- schnelle manuelle Konfiguration symmetrischer Arrays
- konzeptuelle Planung von Lautsprecheranordnungen
- Anpassungen im Betrieb, wenn die Geometrie im Kopf schon klar ist

---

## Beide Systeme gleichzeitig

Im Speaker-Parameter-Editor des ICST AmbiDecoders siehst du für jeden Lautsprecher immer beide Darstellungen:

```
Cartesian XYZ:   -1.186    3.110    0.000
Polar AED:        339.12   0.00     3.328
```

Änderst du einen Wert in XYZ, aktualisiert sich AED automatisch – und umgekehrt. Du verlierst keine Präzision, egal welches System du verwendest.

> **Tipp:** Doppelklick auf ein Parameterfeld öffnet die direkte numerische Eingabe. So kannst du Messwerte ohne Umrechnungsfehler übertragen.

---

## Typisches Praxisszenario

**Szenario:** Du baust ein Oktagon-Array auf (8 Lautsprecher gleichmäßig im Kreis, alle auf Ohrhöhe, alle 3 Meter vom Zentrum entfernt).

Mit **AED** geht das schnell:

| Lautsprecher | Azimut (A) | Elevation (E) | Distanz (D) |
|---|---|---|---|
| LS 1 | 0° | 0° | 3.0 m |
| LS 2 | 45° | 0° | 3.0 m |
| LS 3 | 90° | 0° | 3.0 m |
| LS 4 | 135° | 0° | 3.0 m |
| LS 5 | 180° | 0° | 3.0 m |
| ... | ... | ... | ... |

Mit **XYZ** wäre dafür Trigonometrie nötig. AED ist hier eindeutig schneller.

**Gegenbeispiel:** Du hast ein Konzertsaal-Setup eingemessen und erhältst die Positionen als CAD-Export. Die Koordinaten liegen als `X=2.45, Y=-3.11, Z=1.20` vor. Hier nimmst du die XYZ-Werte direkt – keine Umrechnung, kein Fehler.

---

## Häufige Fehlerquelle: Azimut-Konvention

Nicht alle Systeme verwenden dieselbe Azimut-Richtung. Im ICST AmbiDecoder gilt:

- **0°** = Front (Richtung Y+)
- **90°** = Links (Richtung X-)
- **180° / -180°** = Back

Das ist die mathematische Konvention, nicht die Navigation (wo 90° oft Ost = rechts bedeutet). Wenn du Koordinaten aus anderen Quellen importierst, prüfe die Konvention.

---

## Zusammenfassung

### Decoder-Serie: Geometrie

Wenn du den Decoder als Dreischritt denkst, ist diese Seite der Teil **Geometrie**:

- **Geometrie** bestimmt, **wo** Lautsprecher im Raum stehen
- **Laufzeit** bestimmt, **wann** Signale dort ankommen
- **Abstimmung** bestimmt, **wie deutlich** oder **wie gefärbt** das Ergebnis wahrgenommen wird

Falsche Koordinaten sind deshalb kein klanglicher Charakterzug, sondern ein Setup-Fehler. Erst wenn die Geometrie stimmt, sind spätere Entscheidungen über Delay, Gewichtung oder Filterung sinnvoll beurteilbar.

| | XYZ | AED |
|---|---|---|
| **Sinnvoll wenn…** | Messdaten vorhanden | Intuitive Winkelplanung |
| **Stärke** | präzise, direkt aus CAD/Laser | wahrnehmungsorientiert, schnell |
| **Typischer Kontext** | Konzertinstallation, Forschung | Studio, Probe, Schnelleinstieg |
| **Editierbar im Decoder** | ja | ja |

Du musst dich nicht entscheiden. Der Decoder zeigt immer beide – nutze das, was die Situation gerade erfordert.

---

## Weiterführende Seiten

- [ICST Decoder – Einrichtung und Bedienung](/icst-ambisonics-plugins/08_icst_decoder/)
- [Skalierung und Laufzeitkompensation](/post/decoder-skalierung-laufzeitkompensation/)
- [Der Filter-Tab – Praxisbeispiele und Anwendungsfälle](/post/decoder-filter-praxisbeispiele/)
- [Warum der Decoder klingt wie er klingt – Methodischer Kontext](/post/decoder-methodischer-kontext/)
