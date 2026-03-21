---
title: ICST MultiDecoder
date: 2025-01-01T00:00:00
weight: 100
draft: false
description: "Leitfaden zum ICST MultiDecoder für geschichtete oder segmentierte Lautsprecher-Arrays: wann er sinnvoll ist, wie die Einheiten arbeiten und welche Fehler man vermeiden sollte."
---

Level: Advanced | Zielgruppe: Techniker:in, fortgeschrittene Komponist:in, Studio-Operator, Forscher:in.

Nutze diese Seite, wenn ein einzelner Decoder für dein Lautsprecher-Setup nicht mehr ausreicht und du getrennte Decoding-Strategien für verschiedene Lautsprecher-Subsets oder Ebenen brauchst.

## Wann du MultiDecoder verwenden solltest

Nutze den **ICST MultiDecoder**, wenn:

- dein Lautsprecher-Array klar unterschiedliche **Höhenebenen** hat
- verschiedene Lautsprecher-Subsets unterschiedliche **Ordnung, Gewichtung oder Filterung** brauchen
- du Decoding-Strategien innerhalb eines Plugins vergleichen willst
- du ein gemeinsames B-Format-Signal auf mehrere Zonen unterschiedlich verteilen möchtest

## Wann ein normaler Decoder genügt

Der normale **ICST Decoder** reicht meistens aus, wenn:

- das Array symmetrisch und einschichtig ist
- eine Decoding-Strategie für alle Lautsprecher gelten soll
- keine segmentierte Filterung oder Ebenentrennung nötig ist

Nutze MultiDecoder nicht nur deshalb, weil er vorhanden ist. Er schafft mehr Flexibilität, aber auch mehr Setup-Komplexität.

## Was MultiDecoder macht

Der **ICST MultiDecoder** erweitert den normalen Decoder um bis zu vier parallel arbeitende Decodereinheiten innerhalb eines Plugins. Alle Einheiten erhalten denselben B-Format-Eingang, können aber jeweils eigene Lautsprecher-Subsets und eigene Einstellungen verwenden.

Damit lassen sich zum Beispiel:

- `Top`
- `Mid`
- `Bottom`
- oder andere benutzerdefinierte Subsets

als getrennte Wiedergabeebenen behandeln, ohne den B-Format-Workflow zu verlassen.

![MultiDecoder Übersicht](CleanShot%202026-02-11%20at%2013.46.56@2x.png)

Die wichtigsten Bedienelemente im Überblick:

| # | Steuerelement | Funktion |
|---|---------------|----------|
| 1 | **Multi-Decoder Schalter** | Aktiviert / deaktiviert den MultiDecoder-Modus |
| 2 | **Decoder hinzufügen** | Fügt eine neue Decodereinheit hinzu (max. 4) |
| 3 | **Lautstärke & Mute** | Pegel und Mute pro Einheit |
| 4 | **Filterbänder** | Öffnet die Filtersektion der jeweiligen Einheit |

## Grundaufbau

Starte mit dieser Minimal-Logik:

1. Einen stabilen **Bformat Master** in den Decoder routen.
2. **MultiDecoder**-Modus aktivieren.
3. Nur die Einheiten hinzufügen, die wirklich gebraucht werden.
4. Jeder Einheit ein klares Lautsprecher-Subset zuweisen.
5. Einheiten nach Funktion benennen, zum Beispiel `Mid Ring`, `Top`, `Sub`.
6. Für jede Einheit Lautsprecherreihenfolge und Pegel prüfen, bevor Gewichtung oder EQ verändert werden.

Die praktische Regel ist: zuerst das Routing stabil machen, dann das Decoding verfeinern.

## Decoder-Logik in drei Schritten

Der MultiDecoder ersetzt die Grundlogik des Decoders nicht, sondern erweitert sie auf mehrere Lautsprecherzonen:

1. **Geometrie**  
   Jedes Lautsprecher-Subset klar definieren und prüfen, **wo** jede Einheit projiziert.
2. **Laufzeit**  
   Sicherstellen, dass Skalierung, Distanzen und Laufzeitverhältnisse stabil sind, bevor Ebenen verglichen werden.
3. **Abstimmung**  
   Erst dann Ordnung, Gewichtung, Gain und Filterung vergleichen, um zu hören, **wie** sich die Ebenen wahrnehmungsbezogen unterscheiden.

Praktisch heißt das: keine Abstimmungs-Experimente starten, solange Geometrie oder Laufzeit noch unklar sind.

> [!tip]
> **Decoder-Serie:**
> - **Geometrie:** [XYZ und AED – Zwei Koordinatensysteme, ein Lautsprecher](/post/xyz-vs-aed-koordinatensysteme/)
> - **Laufzeit:** [Skalierung und Laufzeitkompensation](/post/decoder-skalierung-laufzeitkompensation/)
> - **Abstimmung:** [Der Filter-Tab – Praxisbeispiele und Anwendungsfälle](/post/decoder-filter-praxisbeispiele/)

## Typische Layer-Strategien

Typische Anwendungsfälle:

- Trennung von **Top / Mid / Bottom**
- frequenzabhängige Bearbeitung verschiedener Ebenen
- separate Decodierung spezieller Lautsprecherzonen
- A/B-Vergleich verschiedener Decoding-Strategien in einer Session

![Lautsprecherauswahl](CleanShot%202026-02-11%20at%2013.55.43@2x.png)

## Psychoakustische Einordnung

Der MultiDecoder implementiert die Blauertschen Bänder nicht direkt. Er bietet vielmehr eine praktische Möglichkeit, **verschiedene Lautsprecherebenen unterschiedlich abzustimmen**, während ein gemeinsamer B-Format-Eingang erhalten bleibt.

Das kann sinnvoll sein, weil unterschiedliche Wahrnehmungsaufgaben nicht auf dieselben Hinweise gleich stark reagieren:

- **Elevation** hängt oft stark von spektralen Details ab, besonders im oberen Frequenzbereich
- die **horizontale Hauptabbildung** profitiert meist von einem möglichst stabilen und neutralen Decoding
- **tieffrequente Stütze** trägt häufig stärker zu Gewicht und Umhüllung bei als zu klarer vertikaler Lokalisation

Deshalb kann eine layer-basierte Abstimmung in vertikal erweiterten Arrays hilfreich sein. Eine `Top`-Ebene kann von anderer Ordnung, Gewichtung oder behutsamer Filterung profitieren als der Hauptring, während eine `Bottom`- oder `Sub`-Ebene wiederum eine andere wahrnehmungsbezogene Rolle erfüllt.

Wichtig: Eine Lautsprecherebene ist **nicht automatisch eine Tiefenebene der Wahrnehmung**. Höhe, Breite, Umhüllung und Distanz hängen zusammen, sind aber nicht identisch.

### Ambisonics-Ordnung und Gewichtung

Jede Decodereinheit kann ihre eigene **Ambisonics-Ordnung** und **Gewichtung** verwenden.

- niedrigere Ordnungen klingen oft breiter und weicher
- höhere Ordnungen liefern schärfere Lokalisation
- Gewichtungen verändern das Verhältnis zwischen Fokus und Energieverteilung

![Ambisonics-Sequenz](CleanShot%202026-02-11%20at%2013.59.16@2x.png)

### Filterung pro Ebene

Jede Einheit besitzt auch ihre eigene Filtersektion. Das ist besonders nützlich, wenn eine Ebene anders behandelt werden soll als eine andere, zum Beispiel Deckenlautsprecher gegenüber dem Hauptring.

![Filtersektion](CleanShot%202026-02-11%20at%2014.05.58@2x.png)

> [!note]
> Nutze Filter zurückhaltend. Meist geht es nicht darum, das Schallfeld in künstliche Frequenzbänder zu zerlegen, sondern kleine Korrekturen vorzunehmen, die Klarheit, Stabilität oder Übersetzbarkeit auf einem konkreten Array verbessern.

### Audio-Parameter pro Einheit

![Audio-Parameter](CleanShot%202026-02-11%20at%2014.09.04@2x.png)

Pro Einheit lassen sich steuern:

1. **Filter an / aus**
2. **Individueller Gain**
3. **Mute / Unmute**

### Typische wahrnehmungsbezogene Rollen von Ebenen

| Ebene | Typisches Ziel | Typische Behandlung |
|---|---|---|
| **Top** | klarere Höhenhinweise | sorgfältiger Vergleich von Ordnung/Gewichtung, eventuell leichte HF-Stützung |
| **Mid** | stabiles Hauptbild | möglichst neutrales Decoding, oft die Referenzebene |
| **Bottom / Sub** | Gewicht, Stütze, Umhüllung | zurückhaltende LF-orientierte Behandlung, kein „Distanz-Decoder“ an sich |

## Warum das wichtig ist

Klassisches Ambisonics-Decoding behandelt den gesamten Lautsprechersatz mit einer einheitlichen Strategie. In vertikal erweiterten Arrays kann das zu einer unscharfen Höhenabbildung führen, weil obere und mittlere Ebenen zu gleich behandelt werden.

Durch die Trennung in Decodereinheiten lässt sich **mit psychoakustischer Abstimmung pro Ebene experimentieren**, während die feldbasierte Ambisonics-Struktur erhalten bleibt. Der Hauptvorteil ist nicht, dass der MultiDecoder „Wahrnehmung kennt“, sondern dass er einen kontrollierten Vergleich verschiedener Einstellungen für verschiedene Lautsprecherzonen erlaubt.

Deshalb ist MultiDecoder besonders sinnvoll in:

- komplexen Studio-Arrays
- vertikal erweiterten Konzertsystemen
- Forschungs-Setups mit Vergleichsbedarf

## Häufige Fehler

- Lautsprecher-Subsets überlappen unbeabsichtigt
- Ordnung, Gewichtung, EQ und Gain werden gleichzeitig verändert, bevor das Routing geprüft wurde
- MultiDecoder wird eingesetzt, obwohl ein normaler Decoder einfacher und klarer wäre
- Einheiten werden zu vage benannt, was spätere Fehlersuche erschwert
- die Lautsprecherreihenfolge wird nach neuer Zuweisung nicht erneut geprüft

## Verwandte Seiten

- [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/)
- [Schritt-für-Schritt-Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)
- [Best Practices](/icst-ambisonics-plugins/15_best_practices/)
- [ICST AmbiDecoder — Multi-Decoder Modus](/post/multi-decoder-mode/)
