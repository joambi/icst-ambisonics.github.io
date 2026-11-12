---
title: "Motion Markers – Bewegung mit REAPER-Markern steuern"
description: "Schritt-für-Schritt-Anleitung: Ambi-Marker in REAPER setzen, Bewegungen zwischen zwei Markern per OSC an den AmbiEncoder senden und als Automation aufnehmen."
date: 2026-11-12
slug: motion-markers-reaper
translationKey: motion-markers-reaper
year: 2026
month: 2026-11
weight: 5
tags: ["motion-markers", "ambiencoder", "automation", "osc", "reaper", "lua"]
key_points:
  - "Marker als Start- und Endpunkte einer Bewegung im Takt der Musik setzen"
  - "Bewegung live per OSC vorhören und als Automation auf die AmbiEncoder-Spur aufnehmen"
  - "Typische Fehler (python-osc, Ambi host, Web-Interface) selbst beheben"
difficulty: "intermediate"
post_kind: "tutorial"
tool: ["AmbiEncoder", "Lua", "OSC"]
---

Level: Intermediate | **Zielgruppe:** Komponist:innen, Sound Designer:innen, Spatial-Audio-Techniker:innen.

Mit **JS Ambi Motion Markers** definierst du Bewegungen direkt auf der REAPER-Timeline: Zwei Marker markieren Start und Ende, das Skript berechnet den Weg dazwischen, sendet ihn per OSC an den ICST AmbiEncoder und schreibt ihn auf Wunsch als Automation. Das passt, wenn Bewegungen **musikalisch getaktet** sein sollen, also an Cues, Taktpositionen oder Schnitte gebunden. Für frei gezeichnete Figuren über viele Quellen ist die [Motion Map](/de/icst-ambisonics-plugins/15_icst_ambi_motion_map/) das bessere Werkzeug.

Das Skript steckt im [ICST Ambi REAPER Bundle](/de/ecosystem/) und kann auch einzeln als [Motion-Markers-Paket](/downloads/ICST_Ambi_Motion_Markers_Bundle.zip) geladen werden. Die vollständige Referenz steht auf der Seite [ICST Ambi Motion Markers](/de/icst-ambisonics-plugins/14_icst_ambi_motion_markers/).

## 1. Einmalige Vorbereitung

1. **Python 3 und python-osc** installieren (Terminal): `python3 -m pip install python-osc`
2. **REAPER-Web-Interface** aktivieren, nur für „Record": Einstellungen (Cmd+,) → Control/OSC/web → Add → *Web browser interface* → Port **8080**.
3. Eine Spur mit dem **ICST AmbiEncoder** anlegen. Dessen OSC-In muss auf Port **50001** stehen (Host `127.0.0.1`).

## 2. Marker setzen

Marker oder Projektmarker nach diesem Muster benennen:

`ambi <Index> a=<Azimut> e=<Elevation> d=<Distanz>`

Beispiel: `ambi 1 a=-45 e=0 d=0.8`. Alternativ importierst du eine CSV-Datei über das Toolbar-Icon *Import Ambi Markers From CSV* (Beispiele im Ordner `examples/`).

## 3. GUI starten

Toolbar-Icon *Motion Markers* klicken oder in den Actions `JS_Ambi_Motion_Marker_GUI.lua` starten. Läuft bereits eine Instanz, im Dialog **Terminate instances** wählen und neu starten.

## 4. Felder prüfen

| Feld | Wert |
|---|---|
| Ambi host | `127.0.0.1` (keine Leerzeichen!) |
| Ambi port | `50001` |
| Steps/sec | `40` |
| Python | leer lassen (automatische Erkennung), sonst vollständiger Pfad |

## 5. Markerpaar wählen

- In der Liste **Ambi Markers** wählst du mit Linksklick den Start (S) und mit Rechtsklick das Ende (E). Alternativ blätterst du mit **< Pair / Pair >**.
- **Set Selection** setzt die Zeitauswahl zwischen S und E. Unten siehst du Dauer, Start und Ende.
- Danach die Kurve wählen, etwa Smoothstep oder Linear.

## 6. Senden oder aufnehmen

- **Send pair:** Bewegung live per OSC an den AmbiEncoder, der Cursor läuft mit.
- **Send series:** alle Paare nacheinander.
- **Record pair / Record series:** schreibt die Bewegung als Automation auf die AmbiEncoder-Spur (braucht das Web-Interface auf Port 8080).
- **Stop transport:** bricht ab.

Ein guter Ablauf: erst mit *Send* vorhören und die Kurve anpassen, dann mit *Record* festhalten.

## Wenn etwas nicht klappt

| Meldung / Symptom | Lösung |
|---|---|
| `No module named 'pythonosc'` | `python3 -m pip install python-osc`, dann Skript neu starten (Terminate instances) |
| `[Errno 8] nodename nor servname` | Leerzeichen im Feld *Ambi host* entfernen |
| Record tut nichts | Web-Interface auf Port 8080 aktivieren |
| Keine Bewegung hörbar | AmbiEncoder-OSC-In auf 50001 prüfen, Spur nicht stummgeschaltet |
| Alte Meldungen bleiben | Skript beenden (Terminate instances) und neu starten |

Mit **Console ON** erscheinen Meldungen im ReaScript-Konsolenfenster.

## Weiterlesen

- [ICST Ambi Motion Markers](/de/icst-ambisonics-plugins/14_icst_ambi_motion_markers/): vollständige Referenz
- [Motion Map](/de/icst-ambisonics-plugins/15_icst_ambi_motion_map/): Bewegungsformen für viele Quellen
- [OSC-Syntax für den AmbiEncoder](/de/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
