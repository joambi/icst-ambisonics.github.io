---
title: Den B-Format-Master exportieren – AmbiX, Kanalreihenfolge und Normalisierung
description: "Wie du in REAPER einen korrekten Ambisonics-Master exportierst: AmbiX-Format, ACN-Kanalreihenfolge, SN3D-Normalisierung, Render-Dialog-Einstellungen und die häufigsten Fehler beim Multichannel-Export."
date: 2026-03-21T16:30:00+01:00
year: 2026
month: 2026-03
weight: 36
tags: ["export", "render", "ambix", "acn", "sn3d", "reaper", "b-format", "workflow", "delivery"]
key_points:
  - "AmbiX = ACN-Kanalreihenfolge + SN3D-Normalisierung – das ist der heutige Standard"
  - "REAPER: 'Multichannel tracks to multichannel files' muss im Render-Dialog aktiv sein"
  - "Kanalzahl am B-Format-Bus und Ordnungszahl im Decoder müssen identisch sein"
difficulty: "intermediate"
---

Level: Intermediate | **Audience:** Komponist:in, Techniker:in, Toningenieur:in.

---

Eine fertige Ambisonics-Produktion zu exportieren klingt trivial – ist es aber nicht. Ein falsch konfigurierter Render erzeugt stille Kanäle, vertauschte Kanalreihenfolge oder falsch normalisierte Signale, die in der nächsten Produktionsstufe falsch klingen, ohne dass ein offensichtlicher Fehler sichtbar ist. Dieser Artikel zeigt, wie du einen korrekten AmbiX-Master aus REAPER heraus erzeugst.

---

## Das Format: AmbiX

Der heutige Industriestandard für Ambisonics-Austausch ist **AmbiX**. AmbiX definiert zwei Dinge:

**ACN – Ambisonic Channel Number**: Die Reihenfolge, in der die sphärischen Harmonischen in der Datei abgelegt werden. ACN nummeriert die Kanäle nach der Formel `n(n+1) + m`, wobei `n` die Ordnung und `m` den Grad bezeichnet.

**SN3D – Semi-Normalized 3D**: Das Normalisierungsschema, das bestimmt, wie stark die einzelnen Harmonischen gewichtet werden. SN3D stellt sicher, dass der Peak-Pegel einer Punktquelle den W-Kanal nicht übersteigt – keine Übersteuerung durch höhere Ordnungen.

Die Kombination ACN/SN3D ist das, was alle aktuellen Plugins – IEM Suite, SPARTA, ICST AmbiPlugins – als Standard verwenden. Wann immer du ein File übergibst oder empfängst, stelle sicher, dass beide Seiten dasselbe Format sprechen.

### Kanalzahlen pro Ordnung

| Ordnung | Kanäle gesamt | Neue Kanäle dieser Ordnung |
|---|---|---|
| 1st Order (FOA) | 4 | 4 |
| 2nd Order | 9 | 5 |
| 3rd Order | 16 | 7 |
| 4th Order | 25 | 9 |
| 5th Order | 36 | 11 |
| 7th Order | 64 | 15 |

Die Formel: `(n+1)²` Kanäle für Ordnung `n`.

### FuMa – das alte Format

FuMa (Furse-Malham) ist das Legacy-Format aus der Zeit vor AmbiX. Die Unterschiede:

- **Kanalreihenfolge**: WXYZ statt ACN (bei 1st Order: W ist Kanal 1, dann X, Y, Z)
- **W-Pegel**: 3 dB schwächer als in AmbiX/SN3D
- **Höhere Ordnungen**: Abweichende Bezeichnungen und Normalisierung

FuMa ist noch in älteren Plugins und einigen Archiv-Files anzutreffen (Endung `.amb`). Im ICST-Workflow alles auf AmbiX/SN3D halten; FuMa nur verwenden, wenn ein Empfänger das explizit fordert. Für Konvertierungen zwischen Formaten: **ambix_converter** (kostenlos, Kommandozeile) oder **dearVR AMBI MICRO** mit eingebautem Konverter.

---

## REAPER: Render-Setup Schritt für Schritt

### 1. B-Format-Bus korrekt konfigurieren

Bevor du renderst, muss der B-Format-Master-Bus die richtige Kanalzahl haben. Rechtsklick auf den Track → *Track Channels* → Kanalzahl auf die Summe aller aktiven Harmonischen setzen:

- HOA1: 4 Kanäle
- HOA3: 16 Kanäle
- HOA7: 64 Kanäle

Ein Bus mit zu wenigen Kanälen schneidet höhere Harmonische still ab – der Render enthält dann stille Kanäle ohne Fehlermeldung.

### 2. Alle Encoder-Sends auf den Bus prüfen

Jeder AmbiEncoder muss seinen Ausgang vollständig auf den B-Format-Bus senden. In REAPER: Send-Routing kontrollieren, Kanaloffset = 0, Source Channels = alle aktiven Kanäle. Ein einzelner falsch konfigurierter Send kann Kanäle überlagern oder auslassen.

### 3. Render-Dialog konfigurieren

**Datei → Render** öffnen. Die entscheidende Einstellung:

> **☑ Multichannel tracks to multichannel files**

Ohne diesen Haken rendert REAPER nur die ersten zwei Kanäle (Stereo-Fallback). Die Option muss aktiv sein, damit die volle Kanalzahl des Busses in die Ausgabedatei geschrieben wird.

Weitere Einstellungen:

- **Source**: Master mix oder ausgewählter Track (je nach Session-Aufbau)
- **Format**: WAV, 32-bit float oder 24-bit PCM – für Archive immer 32-bit float; für Lieferung 24-bit PCM
- **Sample Rate**: 48 kHz Standard; 96 kHz wenn die Produktion darauf basiert
- **Dither**: Nur bei 16-bit oder 24-bit float → int Konvertierung nötig

### 4. Dateinamen-Konvention

Eine AmbiX-Datei ohne Dokumentation ist für den Empfänger nutzlos. Die Kanalreihenfolge und Normalisierung sind nicht im WAV-Standard gespeichert. Empfohlene Konvention im Dateinamen:

```
Titel_HOA3_ACN_SN3D_48k_24bit.wav
```

Oder als Begleitdokument: `.txt`-File mit Format-Angaben, Order, Kanalzahl, Normalisierung, verwendete Encoder-Suite.

---

## Validierung vor der Abgabe

Bevor du das File übergibst: kurze Kontrolle.

**Kanalzahl prüfen**: Das gerenderte File in einem Multikanal-Viewer oder direkt in REAPER öffnen. Kanalanzahl muss zur erwarteten Ordnung passen. Ein HOA3-File hat exakt 16 Kanäle.

**Keine stillen Kanäle**: Im Wellenform-Editor prüfen ob alle Kanäle Signal haben. Stille Kanäle (flat line) deuten auf falsche Bus-Konfiguration oder unterbrochene Sends hin.

**Pegel-Check W-Kanal**: Kanal 1 (W, Omnidirektional) sollte den höchsten Pegel aller Kanäle haben. Wenn Kanal 2 oder 3 stärker ist, stimmt die Normalisierung oder die Kanalreihenfolge nicht.

**A/B-Abhör**: Das File in einer frischen REAPER-Session mit IEM AllRAD-Decoder oder ICST AmbiDecoder öffnen. Die Lokalisation muss mit der Produktionssession übereinstimmen. Wenn Quellen gespiegelt oder rotiert klingen: Kanalreihenfolge prüfen.

---

## Häufige Fehler

**"Multichannel to multichannel files" vergessen**: Der häufigste Fehler. Der Render erzeugt eine 2-Kanal-Datei ohne Fehlermeldung. Immer prüfen.

**Falscher Bus-Kanal-Count**: Encoder auf HOA3, Bus auf 4 Kanäle. Die höheren 12 Kanäle sind im Render Null. Klingt wie FOA.

**N3D statt SN3D in Plugins**: Wenn ein Plugin auf N3D läuft während alle anderen SN3D verwenden, entstehen inkohärente Pegel zwischen Ordnungen. Lokalisation klingt verschoben, Pegel der höheren Harmonischen zu laut oder zu leise.

**FuMa und AmbiX mischen**: Ein FOA-Source-File in FuMa in eine HOA3-AmbiX-Session laden und nicht konvertieren erzeugt Kanalverwirrung. Alle importierten B-Format-Files zuerst auf AmbiX/SN3D bringen.

**Headroom zu knapp**: N3D-normalisierte Signale können bei höheren Ordnungen 6–12 dB mehr Pegel haben als SN3D. Wenn du in N3D arbeitest (z.B. wegen eines Plug-ins), entsprechend mehr Headroom einplanen.

---

## AmbiX-Konvertierungs-Tools

Wenn du ein FuMa-File erhalten hast oder eine andere Ordnung brauchst:

- **ambix_converter**: Kommandozeilen-Tool, konvertiert zwischen FuMa, AmbiX, verschiedenen Normalisierungen. Kostenlos.
- **IEM AmbiX Converter** (Teil der IEM Suite): GUI-Tool für Format-Konvertierungen direkt in REAPER
- **VVMicArray**: Für Mikrofon-spezifische Konvertierungen
- **dearVR AMBI MICRO**: Enthält FuMa-zu-AmbiX-Konverter als Plugin

---

## Weiterführende Seiten

- [ICST AmbiDecoder – Einrichtung und Bedienung](/icst-ambisonics-plugins/08_icst_decoder/)
- [Koordinatensysteme: XYZ und AED im Vergleich](/post/xyz-vs-aed-koordinatensysteme/)
- [Von der Ambisonics-Szene zum Atmos Bed](/post/ambisonics-to-atmos-bed/)
- [Binaural Monitoring im ICST-Workflow](/post/binaural-monitoring-icst-workflow/)
