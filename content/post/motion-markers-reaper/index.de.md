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

<figure data-gen="g23" style="margin:0 0 1.5rem 0;">
  <video controls playsinline preload="metadata" poster="/motion-markers/install-tutorial-de-poster.jpg" style="max-width:100%;height:auto">
    <source src="/motion-markers/install-tutorial-de.mp4" type="video/mp4">
  </video>
  <figcaption>Video: Installation und erste Bewegung, Schritt für Schritt (rund 75 Sekunden).</figcaption>
</figure>

## 1. Einmalige Vorbereitung

1. **Python 3 und python-osc** installieren (Terminal): `python3 -m pip install python-osc`
2. **REAPER-Web-Interface** aktivieren, nur für „Record": Einstellungen (Cmd+,) → Control/OSC/web → Add → *Web browser interface* → Port **8080**.
3. Eine Spur mit dem **ICST AmbiEncoder** anlegen. Dessen OSC-In muss auf Port **50001** stehen (Host `127.0.0.1`).

## 2. Marker setzen

<figure data-gen="g23" style="margin:1.8rem 0">
<svg viewBox="0 0 720 350" role="img" aria-label="Zwei Marker legen Start S und Ende E einer Bewegung fest; das Skript interpoliert dazwischen und sendet oder nimmt auf" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arc3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><line x1="40" y1="60" x2="680" y2="60" stroke="currentColor" stroke-width="1.2" opacity="0.5"/><line x1="40" y1="56" x2="40" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="80" y1="56" x2="80" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="120" y1="56" x2="120" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="160" y1="56" x2="160" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="200" y1="56" x2="200" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="240" y1="56" x2="240" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="280" y1="56" x2="280" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="320" y1="56" x2="320" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="360" y1="56" x2="360" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="400" y1="56" x2="400" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="440" y1="56" x2="440" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="480" y1="56" x2="480" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="520" y1="56" x2="520" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="560" y1="56" x2="560" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="600" y1="56" x2="600" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="640" y1="56" x2="640" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><line x1="680" y1="56" x2="680" y2="64" stroke="currentColor" stroke-width="1" opacity="0.5"/><text x="40" y="50" text-anchor="start" font-size="10">0:00</text><rect x="140" y="64" width="380" height="76" fill="#d9a441" fill-opacity=".14" stroke="#d9a441" stroke-width="1.2" stroke-dasharray="4 3"/><text x="330" y="158" text-anchor="middle" fill="#d9a441" font-size="11">Zeitauswahl zwischen S und E (Set Selection)</text><line x1="140" y1="30" x2="140" y2="140" stroke="#d9534f" stroke-width="2" opacity="1"/><rect x="130" y="18" width="20" height="20" rx="4" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="140" y="33" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="12">S</text><text x="140" y="176" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="11">ambi 1 a=-45 e=0 d=0.8</text><line x1="520" y1="30" x2="520" y2="140" stroke="#d9534f" stroke-width="2" opacity="1"/><rect x="510" y="18" width="20" height="20" rx="4" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="520" y="33" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="12">E</text><text x="520" y="176" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="11">ambi 1 a=45 e=20 d=0.5</text><polyline points="140.0,132.0 149.5,131.9 159.0,131.6 168.5,131.1 178.0,130.4 187.5,129.6 197.0,128.6 206.5,127.5 216.0,126.2 225.5,124.8 235.0,123.2 244.5,121.6 254.0,119.9 263.5,118.1 273.0,116.2 282.5,114.3 292.0,112.3 301.5,110.3 311.0,108.2 320.5,106.1 330.0,104.0 339.5,101.9 349.0,99.8 358.5,97.7 368.0,95.7 377.5,93.7 387.0,91.8 396.5,89.9 406.0,88.1 415.5,86.4 425.0,84.8 434.5,83.2 444.0,81.8 453.5,80.5 463.0,79.4 472.5,78.4 482.0,77.6 491.5,76.9 501.0,76.4 510.5,76.1 520.0,76.0" fill="none" stroke="#4a8fe0" stroke-width="2.4"/><line x1="140" y1="132" x2="520" y2="76" stroke="currentColor" stroke-width="1.2" opacity="0.6" stroke-dasharray="5 4"/><text x="430" y="118" text-anchor="start" fill="#4a8fe0" font-size="11">Smoothstep</text><text x="250" y="112" text-anchor="start" font-size="10">Linear</text><circle cx="130" cy="268" r="52" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 3"/><circle cx="130" cy="268" r="3" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="130" y="208" text-anchor="middle" font-size="10">vorne</text><text x="130" y="336" text-anchor="middle" font-size="10">Draufsicht</text><polyline points="100.6,238.6 102.5,237.5 104.5,236.5 106.5,235.6 108.5,234.9 110.5,234.2 112.5,233.7 114.6,233.3 116.6,233.0 118.6,232.9 120.6,232.8 122.5,232.9 124.5,233.1 126.4,233.4 128.2,233.7 130.0,234.2 131.7,234.8 133.4,235.4 135.0,236.2 136.6,237.0 138.1,237.9 139.5,238.8 140.8,239.8 142.1,240.9 143.2,242.1 144.3,243.2 145.3,244.5 146.2,245.7 147.0,247.0 147.7,248.3 148.4,249.6" fill="none" stroke="#4a8fe0" stroke-width="2.4"/><circle cx="100.58435790263962" cy="238.58435790263962" r="6" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="148.38477631085024" cy="249.61522368914976" r="6" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="90.58435790263962" y="242.58435790263962" text-anchor="end" font-weight="600" fill="#d9534f" font-size="12">S</text><text x="158.38477631085024" y="253.61522368914976" text-anchor="start" font-weight="600" fill="#d9534f" font-size="12">E</text><rect x="300" y="214" width="400" height="40" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="500" y="231" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="12">Send pair / Send series</text><text x="500" y="246" text-anchor="middle" font-size="10">OSC · 127.0.0.1 : 50001</text><rect x="300" y="268" width="400" height="40" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="500" y="285" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="12">Record pair / Record series</text><text x="500" y="300" text-anchor="middle" font-size="10">Automation · Web-Interface Port 8080</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Zwei Marker legen Start und Ende fest. Das Skript interpoliert dazwischen (Smoothstep oder Linear) und sendet die Bewegung live oder nimmt sie als Automation auf.</figcaption>
</figure>





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

<p class="ai-credit" style="font-size:.85em;opacity:.7"><em>Diagramme und Erklärvideos mit Hilfe von Claude (Anthropic) erstellt. <a href="/de/about/#about-this-site">→</a></em></p>
