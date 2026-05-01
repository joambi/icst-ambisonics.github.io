---
weight: 110
title: B-Format in REAPER rendern
date: 2026-03-18T12:15:00+01:00
description: "Kompakter REAPER-Leitfaden zum korrekten Rendern des Bformat Master, zur passenden Kanalzahl und zur Dokumentation der Export-Metadaten."
---

Level: Beginner | Zielgruppe: Komponist:in, Techniker:in, Studierende, Studio-User.

Nutze diese Seite, wenn du den kürzesten verlässlichen Weg zu einem sauberen Ambisonics-Export aus REAPER brauchst. Das Ziel ist einfach: den **Bformat Master** rendern, nicht den Decoder-Ausgang.

Wenn du ambiX, ACN/SN3D, FOA/HOA oder die Bedeutung der Kanalzahl klären willst, halte [Ambisonics-Formate erklärt](/de/learn/ambisonics-formats/) neben dieser Anleitung offen.

## Was du am Ende erreicht hast

Am Ende hast du:

- einen korrekten B-Format-Export vom **Bformat Master**
- die passende Kanalzahl für deine HOA-Ordnung
- eine wiederverwendbare Metanotiz für Übergabe und spätere Verifikation

## REAPER-Tutorial: B-Format korrekt rendern

Nutze diese kurze REAPER-Sequenz für einen sauberen Ambisonics-Export:

1. Den Track **Bformat Master** auf **Solo** setzen.
2. **Datei -> Rendern** öffnen.
3. **Quelle: Stems (ausgewählte Tracks)** oder den entsprechenden spurbezogenen Render-Modus wählen.
4. **Bformat Master** als Render-Ziel auswählen.
5. **Sample Rate** auf `48000` setzen.
6. Als Format **Multichannel WAV / RF64** wählen.
7. Die **Kanalanzahl** passend zur HOA-Ordnung setzen:
   - `4` Kanäle für FOA / 1. Ordnung
   - `9` Kanäle für 2. Ordnung
   - `16` Kanäle für 3. Ordnung
   - bis `64` Kanäle für 7. Ordnung
8. Zuerst eine kurze Testdatei rendern, danach wieder in REAPER importieren und über Decoder oder binauralen Pfad kontrollieren.

## Kanalzahl-Kurzreferenz

| HOA-Ordnung | Kanäle |
|---|---:|
| 1. Ordnung / FOA | 4 |
| 2. Ordnung | 9 |
| 3. Ordnung | 16 |
| 4. Ordnung | 25 |
| 5. Ordnung | 36 |
| 6. Ordnung | 49 |
| 7. Ordnung | 64 |

## Meta-Text in REAPER

Halte eine kurze Exportnotiz in **Project Settings -> Notes** oder in einer Session-Textdatei neben dem Render fest. Das erleichtert Übergabe und spätere Verifikation deutlich.

Vorgeschlagener Meta-Text:

```text
Render: B-format master
Format: ambiX (ACN / SN3D)
Sample rate: 48000 Hz
Channels: 64
HOA order: 7th
Source track: BFORMAT_MASTER
Decoder preset used for monitoring: [speaker preset name]
Binaural check: yes / no
Filename: scene01_O7_take01.wav
Notes: rendered from B-format master, not decoder output
```

## Häufige Fehler

- Den **Decoder-Ausgang** statt des **Bformat Master** rendern
- Falsche Kanalzahl für die gewählte HOA-Ordnung
- Nicht dokumentieren, ob über Lautsprecher, Kopfhörer oder beides kontrolliert wurde
- Eine Datei ohne klare Ordnung und Take-Information im Dateinamen abgeben

## Verwandte Seiten

- [Schritt-für-Schritt-Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)
- [Ambisonics-Formate erklärt](/de/learn/ambisonics-formats/)
- [Best Practices](/icst-ambisonics-plugins/15_best_practices/)
- [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/)
