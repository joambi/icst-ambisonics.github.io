---
categories:
  - ICST Ambisonics Workshop
---
title: "Working with Ambisonics: Advanced Workshop" description: "Four-hour ICST workshop on HOA signal chains, Ambisonics recording, ambiX/FuMa formats, production, live performance, Max/MSP, Csound, and compositional practice." date: 2026-05-03T00:00:00 draft: true slug: working-with-ambisonics-workshop languageCode: en tags:

- ambisonics
- hoa
- workshop
- reaper
- maxmsp
- csound

---

<style> /* ══════════════════════════════════════════════════════════ WORKSHOP PAGE STYLES — Light + Dark Mode Dark mode: .theme--dark class on <body> ══════════════════════════════════════════════════════════ */ /* ── Workshop Header ─────────────────────────────────────── */ .post__content > h1 { font-size: clamp(2.8rem, 4.2vw, 4.3rem); line-height: 1.08; letter-spacing: 0.01em; margin-bottom: 1.5rem; } .post__content h2 { font-size: clamp(2rem, 2.6vw, 2.7rem); line-height: 1.18; } .post__content h3 { font-size: clamp(1.45rem, 1.6vw, 1.8rem); line-height: 1.25; } .post__content p, .post__content li, .post__content td, .post__content th { font-size: 1.55rem; line-height: 1.62; } .post__content code { font-size: 0.95em; } .ws-hero { background: linear-gradient(135deg, #1a2a3a 0%, #2c4a6e 100%); border-radius: 10px; padding: 2.1rem 2.25rem 1.95rem; color: #fff; margin-bottom: 2rem; } .ws-hero__title { font-size: 2.25rem; font-weight: 800; letter-spacing: 0.02em; margin: 0 0 0.3rem 0; } .ws-hero__subtitle { font-size: 1.45rem; opacity: 0.75; margin: 0 0 1.2rem 0; } .ws-badges { display: flex; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 1rem; } .ws-badge { background: rgba(255,255,255,0.15); border: 1px solid rgba(255,255,255,0.25); border-radius: 20px; padding: 0.32rem 0.95rem; font-size: 1.3rem; color: #fff; white-space: nowrap; } .ws-badge--highlight { background: #4a9eda; border-color: #4a9eda; } .ws-meta { display: flex; flex-wrap: wrap; gap: 1.5rem; margin-top: 1rem; font-size: 1.38rem; opacity: 0.85; } .ws-meta span { white-space: nowrap; } .ws-meta a { color: inherit; text-decoration-color: rgba(255,255,255,0.45); text-underline-offset: 0.18em; } .ws-meta a:hover { text-decoration-color: rgba(255,255,255,0.9); } /* ── Learning Goals ──────────────────────────────────────── */ .ws-goals { background: #f0f6ff; border-left: 4px solid #4a9eda; border-radius: 0 8px 8px 0; padding: 1.4rem 1.6rem; margin: 1.5rem 0 2rem; } .theme--dark .ws-goals { background: #1a2d3d; } .ws-goals__title { font-weight: 700; font-size: 1.5rem; margin: 0 0 0.8rem; color: #1a2a3a; } .theme--dark .ws-goals__title { color: #d0e8f7; } .ws-goals ul { margin: 0; padding-left: 0; list-style: none; } .ws-goals li { padding: 0.34rem 0 0.34rem 1.9rem; position: relative; font-size: 1.52rem; line-height: 1.5; } .ws-goals li::before { content: "✓"; position: absolute; left: 0; color: #4a9eda; font-weight: 700; } /* ── Schedule Table ──────────────────────────────────────── */ .ws-schedule { width: 100%; border-collapse: collapse; font-size: 1.45rem; margin: 1.2rem 0 2rem; border-radius: 8px; overflow: hidden; box-shadow: 0 1px 4px rgba(0,0,0,0.1); } .ws-schedule th { background: #2c4a6e; color: #fff; padding: 0.72rem 1.05rem; text-align: left; font-weight: 600; } .ws-schedule td { padding: 0.7rem 1.05rem; border-bottom: 1px solid #e8eef5; vertical-align: middle; } .theme--dark .ws-schedule td { border-bottom-color: #2a3d4f; } .ws-schedule tr:last-child td { border-bottom: none; } .ws-schedule tr.ws-block-row { background: #f5f9ff; } .ws-schedule tr.ws-block-row td:first-child { font-weight: 600; color: #2c4a6e; } .theme--dark .ws-schedule tr.ws-block-row { background: #1a2d3d; } .theme--dark .ws-schedule tr.ws-block-row td:first-child { color: #7ec8f0; } .ws-schedule tr.ws-pause-row { background: #fafafa; color: #888; font-style: italic; } .theme--dark .ws-schedule tr.ws-pause-row { background: #182430; color: #666; } .ws-schedule tr.ws-total-row { background: #2c4a6e; color: #fff; font-weight: 700; } .ws-schedule .ws-dur { text-align: right; font-variant-numeric: tabular-nums; white-space: nowrap; padding-right: 1.2rem; } /* ── Block Headers ───────────────────────────────────────── */ .ws-block { border-top: 3px solid #4a9eda; margin: 2.5rem 0 1.2rem; padding-top: 1rem; } .ws-block__head { display: flex; align-items: baseline; flex-wrap: wrap; gap: 0.7rem; margin-bottom: 0.4rem; } .ws-block__num { background: #4a9eda; color: #fff; border-radius: 4px; padding: 0.1rem 0.5rem; font-size: 1.12rem; font-weight: 700; letter-spacing: 0.05em; white-space: nowrap; } .ws-block__title { font-size: 1.9rem; font-weight: 700; color: #1a2a3a; margin: 0; } .theme--dark .ws-block__title { color: #d0e8f7; } .ws-block__meta { font-size: 1.35rem; color: #666; margin: 0.2rem 0 1rem; display: flex; flex-wrap: wrap; gap: 1rem; } .theme--dark .ws-block__meta { color: #7a9ab0; } .ws-block__meta span::before { content: "· "; } .ws-block__meta span:first-child::before { content: ""; } /* ── Hands-on Callout ────────────────────────────────────── */ .ws-handson { background: #fff8e6; border: 1px solid #f0c040; border-left: 4px solid #f0c040; border-radius: 0 8px 8px 0; padding: 1.1rem 1.4rem; margin: 1.4rem 0; } .theme--dark .ws-handson { background: #231f0e; border-color: #a07c10; border-left-color: #f0c040; } .ws-handson__title { font-weight: 700; font-size: 1.5rem; color: #7a5800; margin: 0 0 0.6rem; } .theme--dark .ws-handson__title { color: #f0c040; } .ws-handson p, .ws-handson li { font-size: 1.5rem; margin-bottom: 0.4rem; line-height: 1.5; } /* ── Intro Box ───────────────────────────────────────────── */ .ws-intro { background: #f7f9fc; border-radius: 8px; padding: 1.2rem 1.5rem; margin: 1rem 0 1.5rem; font-size: 1.55rem; line-height: 1.62; } .theme--dark .ws-intro { background: #1a2530; } /* ── Reflection ──────────────────────────────────────────── */ .ws-reflect { background: #f0faf4; border-left: 4px solid #48bb78; border-radius: 0 8px 8px 0; padding: 0.8rem 1.2rem; font-style: italic; font-size: 1.4rem; color: #276749; margin: 1rem 0; } .theme--dark .ws-reflect { background: #0f2018; color: #7dd3a8; } /* ── Resources ───────────────────────────────────────────── */ .ws-resources { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 0.8rem; margin: 1rem 0; } .ws-resource-link { display: block; background: #f5f9ff; border: 1px solid #d0e4f7; border-radius: 7px; padding: 0.7rem 1rem; text-decoration: none; font-size: 1.35rem; color: #2c4a6e; transition: background 0.15s; } .ws-resource-link:hover { background: #e0eefa; text-decoration: none; } .ws-resource-link strong { display: block; font-size: 1.18rem; color: #888; font-weight: 400; } .theme--dark .ws-resource-link { background: #1a2d3d; border-color: #2a4560; color: #7ec8f0; } .theme--dark .ws-resource-link:hover { background: #1e3548; } .theme--dark .ws-resource-link strong { color: #7a9ab0; } </style> <div class="ws-hero"> <p class="ws-hero__title">Working with Ambisonics</p> <p class="ws-hero__subtitle">Advanced Workshop · ICST / ZHdK · ambisonics.ch</p> <div class="ws-badges"> <span class="ws-badge ws-badge--highlight">4 Stunden</span> <span class="ws-badge">Tonmeister:innen</span> <span class="ws-badge">Electroacoustic Composers</span> <span class="ws-badge">HOA-Practitioners</span> </div> <div class="ws-meta"> <span>⚙️ <a href="/de/icst-ambisonics-plugins/15_best_practices/">Vorbereitung: Best Practices abgearbeitet</a></span> <span>🎛️ <a href="/de/icst-ambisonics-plugins/">REAPER + ICST Plugins</a></span> <span>🧊 <a href="/de/icst-ambisonics-tools/">Max/MSP</a> &amp; <a href="https://cabbageaudio.com/">Csound</a> optional</span> </div> </div>

---

## Übergeordnete Lernziele

<div class="ws-goals"> <p class="ws-goals__title">Nach diesem Workshop kannst du:</p> <ul> <li>eine vorbereitete ICST-Session anhand der Best-Practices auditieren und stabilisieren</li> <li>Ambisonics-Aufnahmen technisch professionell planen und durchführen</li> <li>Dateiformate und Konventionen wie ambiX, FuMa und ACN/SN3D sicher einsetzen</li> <li>den Produktions-Workflow von Aufnahme bis Delivery als zusammenhängende Kette denken</li> <li>HOA-Systeme für Live-Performance und Installation konzipieren</li> <li>Raum als kompositorisches Material gestalten: Bewegung, Tiefe, Kontrapunkt</li> <li>typische Fehler aus Routing, Monitoring, Decoder-Presets, OSC und Export gezielt diagnostizieren</li> <li>ein eigenes Beispiel aus dem persönlichen Arbeitsfeld vorstellen und mit den anderen Teilnehmenden diskutieren</li> </ul> </div>

---

## Ablauf

<table class="ws-schedule"> <thead> <tr><th>Teil</th><th class="ws-dur">Dauer</th><th>Inhalt</th></tr> </thead> <tbody> <tr class="ws-block-row"><td>Einstieg</td><td class="ws-dur">5 min</td><td>Was kann HOA, was Stereo nicht kann?</td></tr> <tr class="ws-block-row"><td>Block 1</td><td class="ws-dur">40 min</td><td>Best-Practices Audit · Preflight-Check · gezieltes Troubleshooting</td></tr> <tr class="ws-pause-row"><td colspan="2" class="ws-dur">Pause</td><td>10 min</td></tr> <tr class="ws-block-row"><td>Block 2</td><td class="ws-dur">45 min</td><td>Ambisonics aufnehmen: Mikrofone · A-to-B · Fieldrecording</td></tr> <tr class="ws-pause-row"><td colspan="2" class="ws-dur">Pause</td><td>10 min</td></tr> <tr class="ws-block-row"><td>Block 3</td><td class="ws-dur">40 min</td><td>Dateiformate &amp; Workflow: ambiX/FuMa · von der Aufnahme bis Delivery</td></tr> <tr class="ws-pause-row"><td colspan="2" class="ws-dur">Pause</td><td>10 min</td></tr> <tr class="ws-block-row"><td>Block 4</td><td class="ws-dur">25 min</td><td>Live-Performance und Installation: System-Design · Max/MSP · OSC</td></tr> <tr class="ws-block-row"><td>Block 5</td><td class="ws-dur">35 min</td><td>Eigene Beispiele · kompositorische Praxis · Raum · Bewegung · Csound</td></tr> <tr class="ws-block-row"><td>Abschluss</td><td class="ws-dur">10 min</td><td>Diskussion · Feedback · Ressourcen</td></tr> <tr class="ws-total-row"><td><strong>Total</strong></td><td class="ws-dur">~4 h</td><td>inkl. Puffern bei Überläufen</td></tr> </tbody> </table>

---

## Einstieg: Was kann HOA kompositorisch, was Stereo nicht kann?

Stereo organisiert Klang primär auf einer Links-Rechts-Achse. HOA beschreibt dagegen ein Schallfeld um einen Hörpunkt — das macht Ambisonics nicht nur zu einer technischen Erweiterung, sondern zu einer anderen kompositorischen Denkweise.

|Eigenschaft|Stereo|HOA|
|---|---|---|
|**Szenenbasierung**|Lautsprecherfeeds|B-Format, decoder-agnostisch|
|**Elevation**|—|Volle Kugel: oben, unten, hinten, vorne|
|**Skalierbarkeit**|Fix|Binaural → 24-Kanal → Dome: gleicher Stream|
|**Kontrapunkt**|Übersprechen unvermeidbar|Unabhängige Raumkurven pro Stimme|
#### Example: 01 

---

<div class="ws-block"> <div class="ws-block__head"> <span class="ws-block__num">BLOCK 1</span> <h2 class="ws-block__title">Best Practices in der Praxis: Audit und Troubleshooting</h2> </div> <div class="ws-block__meta"> <span>40 Minuten</span><span>Preflight-Audit</span><span>Monitoring-Trennung</span><span>Export-Check</span><span>Failure Points</span> </div> </div>

**Ziel:** Die vorbereiteten Best Practices nicht erneut lesen, sondern an echten Sessions anwenden: prüfen, Fehler sichtbar machen, korrigieren und eine belastbare Arbeitsroutine für Recording, Probe und Export entwickeln.

### Preflight-Audit

|Prüffeld|Erwarteter Zustand|
|---|---|
|Baseline|HOA-Ordnung gewählt, relevante Tracks auf passende Kanalzahl gesetzt|
|Routing|`Source → HOA Bus → Decoder`, kein direkter Source-to-Master-Pfad|
|Decoder|Preset passt zum realen Setup, Lautsprecherreihenfolge getestet|
|Monitoring|Lautsprecher- und Binaural-Pfad sind getrennte, bewusste Branches|
|Export|B-Format wird vom B-Format-Master gerendert, nicht vom Decoder-Output|
|Dokumentation|Preset, Kanalzahl, Ordering, OSC-Ports und Version sind notiert|

### Vom Regelwissen zur Routine

Die Best Practices sind im Workshop der gemeinsame Nenner. Wir beginnen deshalb nicht bei „Was ist der richtige Signalfluss?“, sondern bei: „Woran erkenne ich in 90 Sekunden, ob diese Session robust ist?“

|Situation|Workshop-Frage|
|---|---|
|Projekt geöffnet|Ist der HOA-Bus eindeutig und vollständig?|
|Decoder geladen|Stimmt das Preset mit dem Raum überein?|
|Kopfhörer aktiv|Läuft der Binaural-Pfad ohne parallelen Speaker-Decoder?|
|Quelle hinzugefügt|Wurde Routing sofort geprüft?|
|Export geplant|Ist klar, ob ambiX/FuMa, Ordnung und Kanalzahl dokumentiert sind?|

### Gezielte Fehlerdiagnose

Wir bauen typische Failure Points bewusst ein und lösen sie gemeinsam:

- ein Track im HOA-Pfad hat zu wenige Kanäle
- ein direkter Source-to-Master-Pfad färbt das Monitoring
- Binaural- und Lautsprecher-Decoder laufen unbeabsichtigt parallel
- das Decoder-Preset passt nicht zur realen Lautsprecherreihenfolge
- Export wurde vom Decoder-Output statt vom B-Format-Master vorbereitet
- OSC-Port oder Message-Namespace ist nicht dokumentiert

<div class="ws-handson"> <p class="ws-handson__title">🛠 Hands-on: Best-Practices Audit (10 min)</p> <ul> <li>Mitgebrachte oder vorbereitete REAPER-Session gegen die Preflight-Tabelle prüfen.</li> <li>Eine Mono-Testquelle setzen und Bewegung, Pegel, Decoder-Preset und Monitoring-Branches verifizieren.</li> <li>Einen bewusst eingebauten Fehler diagnostizieren und die Reparatur dokumentieren.</li> </ul> </div>

---

<div class="ws-block"> <div class="ws-block__head"> <span class="ws-block__num">BLOCK 2</span> <h2 class="ws-block__title">How to Record Ambisonics</h2> </div> <div class="ws-block__meta"> <span>45 Minuten</span><span>Mikrofontypen</span><span>A-to-B-Konversion</span><span>Fieldrecording</span> </div> </div>

**Ziel:** Ambisonics-Aufnahmen sicher planen und durchführen — von der Mikrofonposition bis zur sauberen B-Format-Datei. → [Ambisonics-Formate](/de/learn/ambisonics-formats/)

### Mikrofonvergleich

|Mikrofon|Ordnung|Stärken|Einschränkungen|
|---|---|---|---|
|Zoom H3-VR|1st / 4 ch|Günstig · integrierter A-to-B-Encoder · direkt B-Format-Output möglich|FOA-Auflösung · Consumer-Qualität|
|Sennheiser Ambeo VR|1st / 4 ch|Robust, weit verbreitet, guter Klang|FOA-Auflösung|
|Rode NT-SF1|1st / 4 ch|Günstiger Einstieg, solide Qualität|FOA-Auflösung|
|Zylia ZM-1|3rd / 19 ch|Hohe Auflösung|Empfindlicher, teurer|
|EigenMike em32|4th / 32 ch|Referenz-HOA, Studio-Einsatz|Hoher Aufwand|
|DPA d:mension|1st / 4 ch|Sehr linearer Klang, Musikaufnahmen|FOA-Auflösung|

### A-to-B-Konversion

- **A-Format** = Rohdaten der Kapseln, noch kein Ambisonics-Kugelformat.
- Die Konversionsmatrix kompensiert Kapselabstand, Frequenzgang und Phasenfehler.
- Tools: Sennheiser Ambeo Orbiter · SoundField Ambisonic Toolkit · JS-Plugin in REAPER.
- Qualitätskontrolle: Phasen- und Kanalzuordnung testen, bevor Material archiviert wird.

### Fieldrecording-Workflow

- Akustische Kartierung des Ortes: Reflexionen, Störquellen, begehbare Hörzonen.
- Aufstellungshöhe ca. 1.5 m für immersive Hörperspektive.
- Pegelmanagement: ca. −18 dBFS Zielpegel, 12 dB Headroom.
- Binaural während der Aufnahme monitoren.
- Metadaten direkt nach der Aufnahme notieren: Ort · Mikrofonposition · Wetter · Take-Nr.

### Troubleshooting

|Problem|Ursache|Lösung|
|---|---|---|
|Kanalvertauschung|Falsches ACN-Ordering|W/X/Y/Z-Zuordnung vor Ort testen|
|Kammfilter / instabile Richtung|Falsche A-to-B-Konversion|Spektrale Artefakte prüfen|
|Clipping auf einer Kapsel|Überlastung|Alle Rohkanäle separat monitoren|
|Windgeräusche|Fehlendes Windschutz-Setup|LF-Roll-off unter 80 Hz, Doppelwindschutz|

<div class="ws-handson"> <p class="ws-handson__title">🛠 Hands-on: Aufnahme-Simulation (15 min)</p> <ul> <li>Vorhandene A-Format-Datei laden und A-to-B-Konversion durchführen.</li> <li>Kapsel- und Kanalzuordnung verifizieren und Ergebnis binaural abhören.</li> <li><em>Deliberate Error:</em> falsche Kanalzuordnung erkennen und beheben.</li> </ul> </div> <div class="ws-reflect">💬 Reflexionsfrage: Welcher Schritt im Aufnahme- oder Konvertierungs-Workflow war bisher eine Blackbox?</div>

---

<div class="ws-block"> <div class="ws-block__head"> <span class="ws-block__num">BLOCK 3</span> <h2 class="ws-block__title">Dateiformate &amp; Overall Workflow</h2> </div> <div class="ws-block__meta"> <span>40 Minuten</span><span>A-Format · B-Format · FuMa · ambiX · ACN/SN3D</span><span>Von der Aufnahme bis zur Delivery</span> </div> </div>

**Ziel:** Dateiformate und Konventionen sicher einsetzen. Falsches Channel-Ordering klingt nicht einfach falsch — sondern oft nur seltsam.

> **Die bessere Frage** lautet nicht: _"Ist das B-Format?"_, sondern: _"Ist das ambiX B-Format mit ACN-Ordering und SN3D-Normalisierung, und welche Ordnung?"_

### A-Format vs. B-Format

||A-Format|B-Format|
|---|---|---|
|**Was ist es?**|Rohsignal der Kapseln|Ambisonics-Schallfeld-Repräsentation|
|**Mikrofon-spezifisch?**|Ja|Nein — universell|
|**Einsatz**|Nur vor A-to-B-Konversion|Produktion · Austausch · Archiv|

### FuMa vs. ambiX

|Konvention|Bedeutung|Empfehlung|
|---|---|---|
|**FuMa**|Ältere Konvention, W/X/Y/Z, MaxN-Normalisierung|Legacy · historisches Material|
|**ambiX**|ACN Channel-Ordering + SN3D-Normalisierung|✅ Neue ICST-Produktionen|

### Kanalzahl nach Ordnung

|Ordnung|Kanäle|Formel|
|---|---|---|
|1st Order / FOA|4|`(1+1)²`|
|2nd Order|9|`(2+1)²`|
|3rd Order|16|`(3+1)²`|
|5th Order|36|`(5+1)²`|
|7th Order|64|`(7+1)²`|

### Export: welches Format wann?

- **ambiX** für neue Produktionen, HOA-Tools und Archiv-Master.
- **A-Format** nur für Rohaufnahmen vor A-to-B-Konversion.
- **FuMa** nur wenn ein älteres Tool es explizit erfordert.
- Immer dokumentieren: Ordnung · Kanäle · Ordering · Normalisierung · SR · Bit Depth.

<div class="ws-handson"> <p class="ws-handson__title">🛠 Hands-on: Format-Audit &amp; Export (15 min)</p> <ul> <li>Unbekannte WAV-Datei öffnen: Kanalzahl, Ordering und Normalisierung identifizieren.</li> <li>FuMa nach ambiX konvertieren und in REAPER laden.</li> <li>B-Format-Master-Track solo schalten, kurzen Test-Render vorbereiten und Meta-Text in Project Notes eintragen.</li> </ul> </div>

### Overall Workflow: von der Aufnahme bis zur Delivery

|Aufnahme|Konversion|Komposition|Mix|Decode|Delivery|
|---|---|---|---|---|---|
|A-Format WAV|A-to-B / ambiX|REAPER + ICST|HOA-Bus, FX|Binaural / Array|WAV · Binaural · YouTube|

**Goldene Regel:** B-Format Master solo rendern — nie den Decoder-Output. Zuerst einen kurzen Test-Render machen, re-importieren und per Binaural-Pfad verifizieren.

|Delivery|Format|Anmerkung|
|---|---|---|
|Archiv / Master|Multichannel WAV/RF64, ambiX, 48 kHz / 32-bit float|Unveränderter B-Format Master|
|Binaural Stereo|2-Kanal WAV|Streaming · Preview|
|Lautsprecher-Stems|N-Kanal WAV|Aufführung · Installation|
|YouTube 360|Binaural + Spatial Metadata|Spatial Media Metadata Tool|

---

<div class="ws-block"> <div class="ws-block__head"> <span class="ws-block__num">BLOCK 4</span> <h2 class="ws-block__title">Live-Performance und Installation</h2> </div> <div class="ws-block__meta"> <span>25 Minuten</span><span>System-Design</span><span>Max/MSP</span><span>OSC</span><span>Lautsprecher-Arrays</span> </div> </div>

**Ziel:** HOA-Systeme für Echtzeit-Kontexte konzipieren. Bühne, Club und Galerie haben andere Prioritäten als Studio: Latenz · Robustheit · Flexibilität.

### Kontexte im Vergleich

|Kontext|Prioritäten|Empfohlene Tools|
|---|---|---|
|Konzert / Bühne|Latenz · Robustheit · FOH-Kompatibilität|Max/MSP + ICST + REAPER Backup|
|Club / Electronic|Echtzeit-Panning · Interaktion · Beat-Sync|Max/MSP + OSC + Ableton Link|
|Galerie / Installation|Dauerbetrieb · Sensorik · mehrere Zonen|Max/MSP + Binaural-Station|
|Hybrid Studio/Live|Produktion + Performance|REAPER als Recorder · Max als Spatializer|

### System-Design

- **Kernfrage:** Wer decodiert wo? Laptop on stage · FOH-System · dedizierter Render-Rechner?
- Backup-Binaural-Mix bei Array-Ausfall einplanen.
- ICST AmbiDecoder: Lautsprecherlayout als Preset laden und ohne Projektumbau austauschen.
- Irregular Arrays: AllRADecoder aus der IEM Suite prüfen.

### Max/MSP für Live-HOA

- Externals: `ambiencode~`, `ambidecode~`, `ambipanning~` direkt im Performance-Patch.
- Generatives Panning: `drunk`, `noise~` oder `cycle~` auf Azimut und Elevation.
- OSC-Steuerung: Raumparameter über Netzwerk, Tablet oder Sensor.
- Installation: Patch muss stundenlang stabil laufen — Dauerbetrieb testen.

---

<div class="ws-block"> <div class="ws-block__head"> <span class="ws-block__num">BLOCK 5</span> <h2 class="ws-block__title">Kompositorische Praxis</h2> </div> <div class="ws-block__meta"> <span>35 Minuten</span><span>Eigene Beispiele</span><span>Raum als Material</span><span>Bewegung</span><span>Csound</span><span>Hands-on</span> </div> </div>

**Ziel:** Räumliche Parameter nicht als technische Notwendigkeit, sondern als kompositorisches Ausdrucksmittel einsetzen und anhand eigener Beispiele aus den Fach- und Interessensfeldern der Teilnehmenden diskutieren.

### Eigene Beispiele der Teilnehmenden

Jede Person bringt ein kurzes Beispiel aus dem eigenen Fach oder Interesse mit. Das kann eine REAPER-Session, ein kurzer Klang, ein Aufnahme-Setup, ein Max/MSP- oder Csound-Ansatz, eine Installationsidee, eine kompositorische Skizze oder ein technisches Problem sein.

Die Vorstellung soll kurz und konkret bleiben:

- Was ist das musikalische, technische oder künstlerische Ziel?
- Wo kommt Ambisonics oder räumliches Denken ins Spiel?
- Welche Best-Practice-Frage taucht dabei auf: Routing, Monitoring, Export, Format, Decoder, Live-Setup?
- Was sollen die anderen daran verstehen, hören oder mitdiskutieren?

### Raum als kompositorisches Material

|Parameter|Beschreibung|
|---|---|
|**Azimut**|Horizontale Bewegung · Rotation · Kreisen|
|**Elevation**|Dramaturgisches Heben und Senken|
|**Tiefe / Distanz**|Near/Far durch Pegel · Hallanteil · Spektrum|
|**Statik**|Ruhende Quelle als Kontrast zu Bewegung|

Referenzen: Natasha Barrett · Luigi Nono · François Bayle.

### Räumlicher Kontrapunkt

- Unabhängige Stimmen erhalten unabhängige Raumkurven.
- **Konsonanz im Raum:** Quellen konvergieren auf eine Position.
- **Dissonanz im Raum:** Quellen bewegen sich auseinander oder kreuzen sich.
- Textur vs. Linie: diffuse Klangfelder gegen geführte Einzelstimmen.

### Tools im Vergleich

|Tool|Integration|Stärken|Typischer Einsatz|
|---|---|---|---|
|REAPER + ICST|Nativ|Mixing · Automation · Postproduction|Studio · Unterricht · Produktion|
|Max/MSP + ICST|Audio-Routing|Live-Performance · generatives Panning|Bühne · Installation|
|Csound + Cabbage|VST3 in REAPER|Algorithmische Komposition · Score-basiert|Komposition · Experiment|

**Max/MSP:** `ambiencode~` → HOA-Bus → `ambidecode~` → Multichannel-Out. Generatives Panning mit `drunk`, `line~`, `cycle~`.

<a class="ws-resource-link" href="/downloads/reaper-workshop/spatial_counterpoint_workshop_package.zip" download style="display:inline-flex;align-items:center;gap:0.5rem;margin-top:0.4rem;margin-bottom:0.8rem;">⬇ REAPER Workshop-Paket<strong>Projekt, Routing-Script, drei Mono-Stems und Automation-Plan fuer Raumkurven · Bewegung · Tiefe · Kontrapunkt</strong></a>

<a class="ws-resource-link" href="/downloads/reaper-workshop/README.md" download style="display:inline-flex;align-items:center;gap:0.5rem;margin-top:0.4rem;margin-bottom:0.8rem;">⬇ REAPER Setup Notes<strong>Routing-Idee fuer ICST MultiEncoder, B-Format Master und Binaural Monitor</strong></a>

<a class="ws-resource-link" href="icst_hoa_generative_panner.maxpat" download style="display:inline-flex;align-items:center;gap:0.5rem;margin-top:0.4rem;margin-bottom:0.8rem;">⬇ icst_hoa_generative_panner.maxpat<strong>3-Source Generative HOA Panner · Max 8 Patch</strong></a>

**Csound + Cabbage:** Cabbage kompiliert Csound-Instrumente als VST3/AU. Opcodes `bformenc1` / `bformdec1`. Score-basierte Raumpositionierung als p-Felder.

<a class="ws-resource-link" href="icst_cabbage_to_icst_multiencoder.csd" download style="display:inline-flex;align-items:center;gap:0.5rem;margin-top:0.4rem;margin-bottom:0.8rem;">⬇ icst_cabbage_to_icst_multiencoder.csd<strong>Cabbage audio sources + OSC control for ICST MultiEncoder</strong></a>

<a class="ws-resource-link" href="icst_cabbage_to_icst_multiencoder_setup.txt" download style="display:inline-flex;align-items:center;gap:0.5rem;margin-top:0.4rem;margin-bottom:0.8rem;">⬇ Setup Guide<strong>REAPER routing: Cabbage → ICST MultiEncoder → Bformat Master → Decoder</strong></a>

<a class="ws-resource-link" href="icst_hoa_spatial_synth.csd" download style="display:inline-flex;align-items:center;gap:0.5rem;margin-top:0.4rem;margin-bottom:0.8rem;">⬇ icst_hoa_spatial_synth.csd<strong>2-Source Generative Synth · Csound/Cabbage VST · HOA 3rd Order (16ch)</strong></a>

<div class="ws-handson"> <p class="ws-handson__title">🛠 Hands-on: Kompositorische Miniatur (20 min)</p> <p>Vorbereitete Templates: REAPER-Session mit drei Quellen · Max/MSP-Patch mit <code>ambiencode~</code> · Cabbage-VST mit <code>bformenc1</code>. Teilnehmende wählen ihr Tool oder beziehen die Übung auf ihr mitgebrachtes Beispiel.</p>

|Zeit|Aufgabe|
|---|---|
|0–5 min|1–2 Kurzbeispiele vorstellen: Ziel, Material, offene Frage|
|5–12 min|Template oder eigenes Beispiel laden, Signalfluss verifizieren, Raumkurven entwerfen|
|12–18 min|Binaural-Render exportieren oder Live-Output abhören|
|18–20 min|Gemeinsames Feedback: Was wirkt räumlich überzeugend, und warum?|

</div>

---

## Abschluss · 10 min

- Was war neu, was hat sich bestätigt?
- Welche Lücken bleiben?
- Welche eigenen Projekte lassen sich direkt weiterentwickeln?

### Weiterführende Ressourcen

<div class="ws-resources"> <a class="ws-resource-link" href="https://ambisonics.ch/">ambisonics.ch<strong>Tutorials · Best Practices · Formats</strong></a> <a class="ws-resource-link" href="/de/learn/ambisonics-formats/">Ambisonics-Formate<strong>A-Format · B-Format · ambiX · FuMa</strong></a> <a class="ws-resource-link" href="/de/icst-ambisonics-plugins/15_best_practices/">Best Practices<strong>Setup-Regeln und Troubleshooting</strong></a> <a class="ws-resource-link" href="/de/icst-ambisonics-plugins/12_render_bformat/">B-Format rendern<strong>Export-Guide für REAPER</strong></a> <a class="ws-resource-link" href="/de/blog/download-pack-1-hoa-reaper-template/">Download Pack #1<strong>REAPER Template + HOA Routing Checklist</strong></a> <a class="ws-resource-link" href="/de/icst-ambisonics-plugins/">ICST Plugins Docs<strong>Plugin-Dokumentation für REAPER und Max/MSP</strong></a> <a class="ws-resource-link" href="https://cabbageaudio.com/">Cabbage Audio<strong>Csound als VST3/AU</strong></a> <a class="ws-resource-link" href="https://www.openairlib.net/">OpenAIR / SOFA-HRTF<strong>HRTF-Files für binaurale Renderer</strong></a> </div>