---
title: Der Filter-Tab im ICST AmbiDecoder – Praxisbeispiele und Anwendungsfälle
description: "Wie du kanalspezifische Filter im ICST AmbiDecoder einsetzt: von raumakustischer Korrektur über Höhenabbildung bis zur experimentellen Gewichtung einzelner Lautsprecherpositionen."
date: 2026-03-21T11:30:00+01:00
year: 2026
month: 2026-03
weight: 33
tags: ["decoder", "filter", "eq", "raumakustik", "multidecoder", "klanganpassung", "tutorial"]
key_points:
  - "Jeder Lautsprecher kann individuell mit bis zu acht Filtertypen bearbeitet werden"
  - "Filter kompensieren raumakustische Probleme oder unterstützen psychoakustische Tiefenstaffelung"
  - "Im MultiDecoder-Modus kann jede Decoder-Einheit eine eigene Filtersektion erhalten"
difficulty: "intermediate"
---

Level: Intermediate | **Audience:** Techniker:in, Komponist:in mit technischem Interesse, Studiobetreiber:in.

Diese Seite erklärt, wie du den Filter-Tab des ICST AmbiDecoders praktisch nutzt – und zeigt konkrete Szenarien, wann welche Filterstrategie sinnvoll ist.

---

## Was der Filter-Tab kann

Über die Registerkarte **Filter** im Speaker-Settings-Fenster lassen sich einzelne Lautsprecher separat bearbeiten. Jedem Lautsprecher stehen bis zu **acht unabhängige Filterslots** zur Verfügung. Die verfügbaren Filtertypen sind:

- **Peak** – schmalbandige Anhebung oder Absenkung (parametrischer EQ)
- **High Shelf / Low Shelf** – Anhebung oder Absenkung oberhalb/unterhalb einer Grenzfrequenz
- **High Pass / Low Pass** – Frequenzschnitt mit einstellbarer Flankensteilheit
- **Off** – Slot deaktiviert

Jeder Slot hat drei Parameter: **Frequenz**, **Gain (dB)** und **Q-Wert** (Güte / Bandbreite).

Der **FFT-Toggle** zeigt das gemessene oder simulierte Spektrum des Lautsprechers im Hintergrund des Displays – hilfreich zur visuellen Kontrolle der Filterkurve.

---

## Öffnen des Filters für einen Lautsprecher

1. Öffne **Speaker Settings** (Zahnrad-Icon im Decoder).
2. Wähle einen Lautsprecher in der Tabelle aus.
3. Klicke auf den **Filter**-Button rechts in der Zeile – das Filter-Panel öffnet sich.
4. Wähle einen Filtertyp aus dem Dropdown-Menü und setze Frequenz, Gain und Q.

> **Tipp:** Aktiviere **Bypass filter** im Panel, um den Filter vorübergehend zu deaktivieren und die Wirkung direkt A/B zu hören.

---

## Praxisbeispiel 1: Hochtöner ist zu hell

**Problem:** Lautsprecher 7 hat einen zu präsenten Hochtonanteil – er klingt scharf und stört die Einheitlichkeit des Arrays.

**Lösung:**
- Filtertyp: **High Shelf**
- Frequenz: ca. 8.000 Hz
- Gain: -3.0 bis -5.0 dB
- Q: 0.7 (breit)

Das dämpft den Hochton oberhalb 8 kHz sanft ab, ohne den Mittenbereich zu beeinflussen. Vergleiche mit dem Nachbar-Lautsprecher per Solo/Mute.

---

## Praxisbeispiel 2: Raummoden bei einem Subwoofer

**Problem:** Der Subwoofer (SUB) hat eine ausgeprägte Raummode bei 63 Hz – ein deutlicher Anstieg, der Bass-Phantomquellen aufbläht.

**Lösung:**
- Filtertyp: **Peak** (absenkend)
- Frequenz: 63 Hz
- Gain: -6.0 bis -9.0 dB
- Q: 4.0 (schmalbandig)

Damit wird die Mode gezielt adressiert, ohne den gesamten Bassbereich zu schwächen.

---

## Praxisbeispiel 3: Höhenabbildung mit Hochtonanhebung

**Problem:** Bei einem 3D-Array klingen die Höhenlautsprecher im Hochton schwächer als die Ringlautsprecher – Klangereignisse, die nach oben steigen sollen, verschwinden im Diffusfeld.

**Lösung (für alle Höhenlautsprecher):**
- Filtertyp: **High Shelf**
- Frequenz: 3.000 Hz
- Gain: +3.0 bis +5.0 dB
- Q: 1.0

Das unterstützt die psychoakustische Höhenwahrnehmung über den Precedence-Effekt und macht Bewegungen nach oben plastischer. Dieses Prinzip nutzt das PDF selbst als Beispiel für frequenzabhängige Modulation im MultiDecoder-Modus.

---

## Praxisbeispiel 4: Tieffrequenzen in Höhenebenen unterdrücken

**Problem:** In einem mehrstöckigen Array (unten, mitte, oben) produzieren die oberen Lautsprecher störende Tieftonanteile, die Phantomquellen in der Horizontalebene destabilisieren.

**Lösung (für obere Lautsprecher-Gruppe):**
- Filtertyp: **High Pass**
- Frequenz: 250–400 Hz
- Q: 0.7

Das schneidet Tieffrequenzen unterhalb der Grenzfrequenz ab. Kombiniert mit dem MultiDecoder-Modus kann diese Einstellung für eine gesamte Decoder-Einheit (z.B. die „Top"-Gruppe) angewendet werden, ohne die anderen Ebenen zu beeinflussen.

---

## Filter im MultiDecoder-Modus

Im **MultiDecoder-Modus** hat jede der bis zu vier Decoder-Einheiten eine eigene Filtersektion. Das ermöglicht frequenzbandabhängige Raumabbildung über verschiedene Lautsprechergruppen hinweg:

| Decoder-Einheit | Lautsprecher | Filterstrategie |
|---|---|---|
| Hight (oben) | 12 Speaker | High Shelf +4 dB ab 3 kHz |
| Middle (mitte) | 16 Speaker | flach (keine Filterung) |
| Deep (unten/sub) | 12 Speaker | Low Pass 300 Hz |

Dieser Ansatz orientiert sich an psychoakustischen Wahrnehmungsmodellen: Tieffrequenzen tragen zur Umhüllung bei, Hochfrequenzen zur Lokalisationsschärfe in der Vertikalen. Durch die getrennte Filterung kann beides gezielt optimiert werden, ohne das B-Format zu verändern.

---

## Filter-Presets speichern

Filter-Einstellungen werden mit dem Lautsprecher-Preset gespeichert. Wenn du ein Preset lädst, werden auch alle Filter-Einstellungen aller Lautsprecher wiederhergestellt.

Zum expliziten Speichern eines Filter-Presets für einen einzelnen Lautsprecher:
- Klicke auf **Save** oben rechts im Filter-Panel
- Gib dem Preset einen beschreibenden Namen (z.B. `LS7_Hochton_Korrektur_ICST`)

Presets können zwischen Lautsprechern kopiert werden – sinnvoll, wenn mehrere Lautsprecher desselben Typs im Array dieselbe Korrektur brauchen.

---

## Was der Filter nicht ersetzt

Der Filter-Tab ist kein Ersatz für:

- **Raumakkustische Behandlung** (Absorber, Diffusoren)
- **Ordentliches Lautsprecher-Routing** (falsch geroutete Kanäle klingt auch mit Filter nicht richtig)
- **Exakte Lautsprecherkalibrierung** (ein vollständiger Messdurchgang mit z.B. Room EQ Wizard ist genauer)

Nutze die Filter im Decoder für gezielte, spezifische Korrekturen – nicht als pauschale Klangfärbung des gesamten Systems.

---

## Weiterführende Seiten

- [ICST Decoder – Einrichtung und Bedienung](/icst-ambisonics-plugins/08_icst_decoder/)
- [ICST MultiDecoder](/icst-ambisonics-plugins/09_icst_multidecoder/)
- [Warum der Decoder klingt wie er klingt – Methodischer Kontext](/post/decoder-methodischer-kontext/)
- [Best Practices](/icst-ambisonics-plugins/15_best_practices/)
