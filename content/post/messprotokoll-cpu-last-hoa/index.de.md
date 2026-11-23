---
title: CPU-Last der Ambisonics-Ordnungen in REAPER – Messprotokoll (FOA bis HOA7)
description: "Wie die CPU-Last von ICST AmbiEncoder_64 und AmbiDecoder in REAPER für FOA, HOA3, HOA5 und HOA7 mit 1 bis 32 Quellen gemessen wurde: Methode, Ergebnisse, Einschränkungen und Rechnerdaten."
date: 2026-11-23T19:00:00+01:00
year: 2026
month: 2026-11
weight: 39
tags: ["hoa", "foa", "cpu", "messung", "reaper", "performance", "reference"]
key_points:
  - "Die Encoder-Last wächst mit Quellenzahl und Ordnung; die Decoder-Last hängt nicht von der Quellenzahl ab"
  - "Höchste Gesamtlast: 5.8 % (HOA3, 32 Quellen) auf einem Apple M2 Pro – keine Aussetzer in allen 17 Zellen"
  - "Die RT CPU von REAPER bildet die Plugin-Last nicht ab – FX CPU pro Spur und CPU gesamt verwenden"
difficulty: "intermediate"
post_kind: "reference"
tool: ["AmbiEncoder", "AmbiDecoder"]
---

**Zweck:** Dokumentiert, wie die CPU-Tabelle in [Welche Ambisonics-Ordnung brauche ich?](/de/post/hoa-ordnung-wahl-praxis/) gemessen wurde. Messreihe vom 22. November 2026.

---

## Zusammenfassung

- Der **Encoder** (ICST AmbiEncoder_64) wächst annähernd linear mit der Quellenzahl, und die Steigung nimmt mit der Ordnung zu: bei 32 Quellen FOA 1.0 %, HOA3 1.3 %, HOA5 1.8 %, HOA7 2.2 %. Bei einer Quelle ist er ordnungsunabhängig (0.22–0.33 %).
- Der **Decoder** (ICST AmbiDecoder, 18 Lautsprecher) hängt nicht von der Quellenzahl ab. Er liegt bei FOA bis HOA5 zwischen 0.55 und 1.0 % und steigt bei HOA7 auf 1.0–1.7 %.
- **Höchste Gesamtlast:** 5.8 % (HOA3, 32 Quellen). Keine Aussetzer in allen Zellen.
- **Freeze** spart bei HOA7 mit 32 Quellen fast die ganze Encoder-Last (2.2 %); das Abspielen der eingefrorenen Datei kostet 0.14 %.

---

## Methode

**Rechner und Einstellungen:** MacBook Pro 16" (2023, Apple M2 Pro, 16 GB), macOS 27.2.1, REAPER 7.86 (macOS arm64), Audiogerät AUDIO4c, 48 kHz, 512 Samples (das Budget von 10.67 ms im Performance Meter entspricht dem). ICST AmbiEncoder_64 und AmbiDecoder als VST3, Plugin-Fenster geschlossen. Die Plugin-Version wurde nicht erfasst.

**Testprojekt:** eine Rosa-Rauschen-Spur (JSFX ICST_Pink_Noise_Multi, 64 Kanäle, Quellenzahl einstellbar, gleicher Pegel auf allen Quellen), eine Encoder-Spur und eine Decoder-Spur (18 Lautsprecher). Die Quellen bewegen sich nicht. 16 Sessions: Ordnung 1, 3, 5, 7 × 1, 8, 16, 32 Quellen.

**Ablesung:** Wiedergabe starten, 60 Sekunden warten, Performance Meter (View → Performance Meter) mit sichtbarer Spurtabelle ablesen. Hauptwert ist die **FX CPU** pro Spur, dazu **CPU gesamt** und der xrun-Zähler. Die Differenz des xrun-Zählers im Messfenster gilt als Aussetzer.

**Zusatzzelle:** HOA7 mit 32 Quellen nach Freeze. Eine Medienspur spielt eine 64-Kanal-Datei (Rauschen mit −30 dB, synthetisch statt echtem Encoder-Ergebnis), die Decoder-Spur bekommt sie per Send.

---

## Ergebnisse

FX CPU von ICST AmbiEncoder_64 / ICST AmbiDecoder in Prozent, eine Ablesung bei etwa 60 s pro Zelle:

| Ordnung | Kanäle | 1 Quelle | 8 Quellen | 16 Quellen | 32 Quellen |
|---|---|---|---|---|---|
| FOA | 4 | 0.26 / 0.55 | 0.57 / 0.86 | 0.64 / 0.67 | 1.0 / 0.69 |
| HOA3 | 16 | 0.26 / 0.95 | 0.54 / 0.87 | 0.79 / 0.94 | 1.3 / 0.68 |
| HOA5 | 36 | 0.22 / 0.88 | 0.75 / 1.0 | 1.1 / 1.0 | 1.8 / 0.83 |
| HOA7 | 64 | 0.33 / 1.7 | 0.87 / 1.3 | 1.6 / 1.4 | 2.2 / 1.0 |
| HOA7 nach Freeze | 64 | – | – | – | – / 1.6 (Media 0.14) |

CPU gesamt (aktueller Wert, Prozent):

| Ordnung | Kanäle | 1 Quelle | 8 Quellen | 16 Quellen | 32 Quellen |
|---|---|---|---|---|---|
| FOA | 4 | 3.0 | 4.4 | 4.5 | 5.5 |
| HOA3 | 16 | 3.4 | 4.0 | 4.8 | 5.8 |
| HOA5 | 36 | 2.4 | 3.8 | 4.5 | 5.7 |
| HOA7 | 64 | 4.2 | 3.9 | 5.6 | 5.5 |
| HOA7 nach Freeze | 64 | – | – | – | 3.0 |

**Aussetzer:** keine. Der xrun-Zähler stand in allen 17 Zellen bei 12 (schon vor der ersten Zelle), die Differenz im Messfenster ist 0. Media xruns: 0.

**Freeze-Zelle:** Encoder entfällt, Media CPU 0.14 %, Decoder 1.6 %, gesamt 3.0 %, Disk read 5.81 MB/s. HOA7 live mit 32 Quellen: Encoder 2.2 % + Decoder 1.0 %, gesamt 5.5 %.

---

## Einschränkungen

- Nur eine Ablesung pro Zelle statt Median aus drei; Streuung der Decoder-Werte etwa ±0.15 %.
- Der Systemspeicher war zeitweise knapp (91–762 MB frei).
- Rosa Rauschen mit gleichem Pegel statt Musik; die Quellen sind nicht bewegt, also keine Animator-Last; kein Hall und keine weiteren Effekte in der Kette.
- Die Freeze-Zelle nutzt eine synthetische 64-Kanal-Datei statt eines echten Encoder-Freezes.
- Die **RT CPU** von REAPER blieb in fast allen Zellen bei etwa 1.1 % (0.6–1.4 %) und bildet die steigende Last nicht ab; vermutlich laufen die Plugins ausserhalb des Echtzeit-Audio-Threads. Deshalb dienen FX CPU und CPU gesamt als Lastmass.
- Die Werte gelten für diesen Rechner und diese Plugin-Kette. Die Messung bei grossen Plugin-Versionssprüngen wiederholen.

---

## Weiterführend

- [Welche Ambisonics-Ordnung brauche ich? – HOA-Wahl in der Praxis](/de/post/hoa-ordnung-wahl-praxis/)
