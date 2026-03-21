---
title: Skalierung und Laufzeitkompensation im ICST AmbiDecoder
description: "Wie die Scaling-Funktion des ICST AmbiDecoders Raumgröße und Lautsprecherabstände berücksichtigt und warum Laufzeitkompensation für geometrisch kohärente Wiedergabe entscheidend ist."
date: 2026-03-21T11:00:00+01:00
year: 2026
month: 2026-03
weight: 32
tags: ["decoder", "skalierung", "delay", "laufzeitkompensation", "setup", "installation", "konfiguration"]
key_points:
  - "Die Scaling-Funktion skaliert alle Lautsprecherkoordinaten auf eine reale Raumgröße"
  - "Laufzeit-Delays werden automatisch aus den Distanzangaben berechnet"
  - "Ohne Laufzeitkompensation bei ungleichen Abständen entsteht ein inkohärentes Klangbild"
difficulty: "intermediate"
---

Level: Intermediate | **Audience:** Techniker:in, Installationskünstler:in, Studiobetreiber:in.

Diese Seite erklärt, wie die Scaling- und Delay-Kompensationsfunktion des ICST AmbiDecoders funktioniert und wann du sie brauchst.

> **Gemeinsamer Kernsatz dieser Decoder-Serie:** Der Decoder erzeugt den Raum nicht neu, sondern projiziert ein B-Format-Feld auf ein reales System.
>
> In diesem Artikel geht es um den zweiten Schritt dieser Projektion: **Laufzeit**. Delay-Kompensation bestimmt, **wann** Signale am Hörzentrum ankommen, nachdem die Geometrie bereits festgelegt wurde.

---

## Das Problem: Lautsprecher stehen nicht alle gleich weit weg

In idealen Setups – z.B. einem gleichmäßigen Oktagon oder einer Kugelform – haben alle Lautsprecher denselben Abstand vom Hörzentrum. Die Signale kommen also gleichzeitig an.

In realen Räumen ist das fast nie der Fall:

- Konzerthäuser haben asymmetrische Wände
- Lautsprecher hängen auf verschiedenen Ebenen
- Subwoofer stehen oft anders platziert als Breitbänder
- Installationen passen sich vorhandenen Strukturen an

Wenn Lautsprecher unterschiedlich weit entfernt sind, erreichen die Signale das Hörzentrum zu unterschiedlichen Zeiten. Das verschlechtert Phantomschallquellenbildung, Lokalisationsschärfe und das Kohärenzgefühl des Klangfeldes deutlich.

---

## Die Lösung: Delay-Kompensation

Der ICST AmbiDecoder berechnet aus den Distanzangaben jedes Lautsprechers automatisch einen individuellen Delay-Wert. Weiter entfernte Lautsprecher erhalten ein größeres vorangestelltes Delay – so dass alle Signale (akustisch gesehen) gleichzeitig am Hörzentrum ankommen.

Die Delay-Werte sind in der Speaker-Tabelle sichtbar:

| CH | Name | D [m] | Delay [ms] | Delay comp. [ms] |
|----|------|--------|------------|------------------|
| 1  | L    | 3.376  | 9.84       | 3.57             |
| 2  | R    | 3.347  | 9.76       | 3.65             |
| 5  | SUB  | 2.709  | 7.88       | 5.45             |

- **D [m]** – gemessene Distanz des Lautsprechers vom Zentrum
- **Delay [ms]** – berechnete Laufzeit des Schalls (Distanz / Schallgeschwindigkeit)
- **Delay comp. [ms]** – tatsächlich angewendete Verzögerung zur Kompensation

> **Merksatz:** Der Lautsprecher, der am weitesten entfernt ist, braucht keine Verzögerung – er ist ohnehin am langsamsten. Alle anderen werden so verzögert, dass sie auf ihn warten.

---

## Die Scaling-Funktion

Wenn du ein Lautsprecher-Preset für einen Raum konfigurierst, sind die Koordinaten manchmal in normierten Einheiten angegeben (z.B. als Vektoren der Länge 1, also alle Lautsprecher auf einer Einheitskugel). Das ist praktisch für Presets, die in verschiedenen Räumen funktionieren sollen – aber es bildet die reale Geometrie nicht ab.

Die **Scaling-Funktion** erlaubt dir, alle Lautsprecherkoordinaten auf eine tatsächliche Raumgröße zu skalieren:

1. Klicke auf **Scaling** im Speaker-Settings-Fenster.
2. Gib die Raummaße ein: **X** (Breite), **Y** (Tiefe), **Z** (Höhe) in Metern.
3. Der Decoder skaliert alle Koordinaten proportional – und berechnet danach die Laufzeit-Delays neu.

Dabei werden automatisch aktualisiert:

- alle kartesischen Lautsprecherkoordinaten (XYZ)
- alle polaren Distanzwerte (D in AED)
- alle daraus resultierenden Delay-Werte

---

## Wann brauchst du Scaling?

**Szenario 1: Preset aus einer anderen Raumgröße**
Du verwendest ein vorhandenes Oktagon-Preset, das für einen 6×6 m Raum konfiguriert wurde. Dein Raum ist aber 8×9 m. Mit Scaling passt du das Preset in wenigen Sekunden an, ohne jeden Lautsprecher manuell editieren zu müssen.

**Szenario 2: Normiertes Preset, realer Raum**
Viele Standard-Presets verwenden Einheitsvektoren (Distanz = 1.0 m). Du gibst deine echten Raumdimensionen ein – und alle Lautsprecherkoordinaten werden korrekt skaliert.

**Szenario 3: Tournee oder Gastspiel**
Du spielst dasselbe Stück in drei verschiedenen Räumen. Statt drei separate Presets zu pflegen, hast du ein normiertes Basis-Preset und skalierst es für jeden Raum individuell – mit automatischer Delay-Neuberechnung.

---

## Manueller Delay-Override

Neben der automatischen Berechnung kannst du Delay-Werte für einzelne Lautsprecher auch manuell überschreiben. Das ist sinnvoll, wenn:

- ein Lautsprecher baubedingt eine andere akustische Charakteristik hat (z.B. eingebaut hinter einer Membran)
- du raumakustische Korrekturen machst, die über reine Laufzeit hinausgehen
- du im Betrieb kleine Feinkorrekturen vornehmen willst

> **Vorsicht:** Manuelle Delay-Eingriffe werden beim nächsten Scaling-Vorgang überschrieben. Speichere dein Preset vorher.

---

## Quick-Check vor der Aufführung

Bevor du einen Raum abspielst, prüfe folgende Punkte:

1. Sind die **Distanzwerte (D)** für alle Lautsprecher eingetragen und plausibel?
2. Stimmen die **Delay comp.**-Werte ungefähr mit den erwarteten Laufzeitunterschieden überein?
3. Hast du nach einer Skalierung das Preset **neu gespeichert**?
4. Ist die **Ambisonics Order** im Decoder auf das Quellmaterial abgestimmt?

Ein kurzer Pink-Noise-Test mit Mute/Solo-Überprüfung zeigt sofort, ob die zeitliche Kohärenz stimmt.

---

## Decoder-Serie: Laufzeit

Wenn du den Decoder als Dreischritt denkst, ist diese Seite der Teil **Laufzeit**:

- **Geometrie** bestimmt, **wo** Lautsprecher stehen
- **Laufzeit** bestimmt, **wann** ihre Signale ankommen
- **Abstimmung** bestimmt, **wie deutlich** oder **wie gefärbt** das Ergebnis erscheint

Scaling und Delay-Kompensation sind deshalb keine kreative Klangformung, sondern ein Übersetzungsschritt zwischen normiertem Preset und realem Raum. Erst wenn die Zeitverhältnisse stimmen, lassen sich Gewichtung, Filter oder MultiDecoder-Layer sinnvoll beurteilen.

---

## Preset speichern und exportieren

Nach jeder Skalierung solltest du das Setup als Preset speichern:

- **Speichern:** Speaker → Save preset → Namen vergeben (z.B. `ICST-Studio_HOA7_2026-03`)
- **Exportieren:** Die Konfiguration kann als **TXT-Datei** exportiert werden (Speaker → Export)

Die exportierte TXT-Datei enthält alle Lautsprecherpositionen im AED-Format und kann in externe Systeme (z.B. Max/MSP via `coll`-Objekt oder `ambidecode~`) geladen werden. Das ermöglicht eine plattformübergreifende Integration der Lautsprechergeometrie in hybride Systeme.

---

## Weiterführende Seiten

- [ICST Decoder – Einrichtung und Bedienung](/icst-ambisonics-plugins/08_icst_decoder/)
- [XYZ und AED – Koordinatensysteme im Vergleich](/post/xyz-vs-aed-koordinatensysteme/)
- [ICST MultiDecoder](/icst-ambisonics-plugins/09_icst_multidecoder/)
- [Der Filter-Tab – Praxisbeispiele und Anwendungsfälle](/post/decoder-filter-praxisbeispiele/)
- [Best Practices](/icst-ambisonics-plugins/15_best_practices/)
