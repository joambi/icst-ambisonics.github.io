---
title: "ICST Ambisonics Workshop: Working with Ambisonics"
description: "Online-Workshop: HOA-Aufnahme mit Zylia ZM-1, Encoding mit ICST AmbiEncoder, FuMa-AmbiX-Konvertierung, Reaper-Workflow und Praxis-Übung."
date: 2026-05-03T00:00:00
draft: false
slug: working-with-ambisonics-workshop
languageCode: de
tags:
  - ambisonics
  - hoa
  - workshop
  - reaper
  - zylia
  - fuma
  - ambix
---

<style>
/* ══════════════════════════════════════════════════════════════
   WORKSHOP PAGE STYLES — Light + Dark Mode
   ══════════════════════════════════════════════════════════════ */

.post__content > h1 {
  font-size: clamp(2.8rem, 4.2vw, 4.3rem);
  line-height: 1.08; letter-spacing: 0.01em; margin-bottom: 1.5rem;
}
.post__content h2 { font-size: clamp(2rem, 2.6vw, 2.7rem); line-height: 1.18; }
.post__content h3 { font-size: clamp(1.45rem, 1.6vw, 1.8rem); line-height: 1.25; }
.post__content p, .post__content li, .post__content td, .post__content th {
  font-size: 1.55rem; line-height: 1.62;
}
.post__content code { font-size: 0.95em; }

/* Hero */
.ws-hero {
  background: linear-gradient(135deg, #1a2a3a 0%, #2c4a6e 100%);
  border-radius: 10px; padding: 2.1rem 2.25rem 1.95rem;
  color: #fff; margin-bottom: 2rem;
}
.ws-hero__title { font-size: 2.25rem; font-weight: 800; letter-spacing: 0.02em; margin: 0 0 0.3rem 0; }
.ws-hero__subtitle { font-size: 1.45rem; opacity: 0.75; margin: 0 0 1.2rem 0; }
.ws-badges { display: flex; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 1rem; }
.ws-badge {
  background: rgba(255,255,255,0.15); border: 1px solid rgba(255,255,255,0.25);
  border-radius: 20px; padding: 0.32rem 0.95rem; font-size: 1.3rem; color: #fff; white-space: nowrap;
}
.ws-badge--blue   { background: #4a9eda; border-color: #4a9eda; }
.ws-badge--green  { background: #4a9e7a; border-color: #4a9e7a; }
.ws-meta { display: flex; flex-wrap: wrap; gap: 1.5rem; margin-top: 1rem; font-size: 1.38rem; opacity: 0.85; }
.ws-meta span { white-space: nowrap; }
.ws-meta a { color: inherit; text-decoration-color: rgba(255,255,255,0.45); text-underline-offset: 0.18em; }
.ws-meta a:hover { text-decoration-color: rgba(255,255,255,0.9); }

/* Goals */
.ws-goals {
  background: #f0f6ff; border-left: 4px solid #4a9eda;
  border-radius: 0 8px 8px 0; padding: 1.4rem 1.6rem; margin: 1.5rem 0 2rem;
}
.theme--dark .ws-goals { background: #1a2d3d; }
.ws-goals__title { font-weight: 700; font-size: 1.5rem; margin: 0 0 0.8rem; color: #1a2a3a; }
.theme--dark .ws-goals__title { color: #d0e8f7; }
.ws-goals ul { margin: 0; padding-left: 0; list-style: none; }
.ws-goals li { padding: 0.34rem 0 0.34rem 1.9rem; position: relative; font-size: 1.52rem; line-height: 1.5; }
.ws-goals li::before { content: "✓"; position: absolute; left: 0; color: #4a9eda; font-weight: 700; }

/* Block headers */
.ws-block {
  border-top: 3px solid #4a9eda; margin: 2.5rem 0 1.2rem; padding-top: 1rem;
}
.ws-block__head { display: flex; align-items: baseline; flex-wrap: wrap; gap: 0.7rem; margin-bottom: 0.4rem; }
.ws-block__num {
  background: #4a9eda; color: #fff; border-radius: 4px;
  padding: 0.1rem 0.5rem; font-size: 1.12rem; font-weight: 700; letter-spacing: 0.05em; white-space: nowrap;
}
.ws-block__title { font-size: 1.9rem; font-weight: 700; color: #1a2a3a; margin: 0; }
.theme--dark .ws-block__title { color: #d0e8f7; }
.ws-block__meta {
  font-size: 1.35rem; color: #666; margin: 0.2rem 0 1rem;
  display: flex; flex-wrap: wrap; gap: 1rem;
}
.theme--dark .ws-block__meta { color: #7a9ab0; }
.ws-block__meta span::before { content: "· "; }
.ws-block__meta span:first-child::before { content: ""; }

/* Callouts */
.ws-info {
  background: #edf5ff; border: 1px solid #b0d0f0;
  border-left: 4px solid #4a9eda; border-radius: 0 8px 8px 0;
  padding: 0.9rem 1.2rem; margin: 1rem 0 1.4rem;
  font-size: 1.4rem; line-height: 1.6; color: #2c4a6e;
}
.ws-info strong { display: block; font-size: 1.18rem; font-weight: 700; margin-bottom: 0.3rem; color: #1a3a5c; }
.ws-info a { color: #2c72bb; }
.theme--dark .ws-info { background: #0f1f30; border-color: #2a4a6a; border-left-color: #4a9eda; color: #a0c8e8; }
.theme--dark .ws-info strong { color: #7ec8f0; }
.theme--dark .ws-info a { color: #7ec8f0; }

.ws-tip {
  background: #f0faf4; border-left: 4px solid #4a9e7a;
  border-radius: 0 8px 8px 0; padding: 0.9rem 1.2rem; margin: 1rem 0 1.4rem;
  font-size: 1.4rem; line-height: 1.6; color: #1a3a2a;
}
.ws-tip strong { display: block; font-size: 1.18rem; font-weight: 700; margin-bottom: 0.3rem; color: #1a3a2a; }
.theme--dark .ws-tip { background: #0a1f14; border-left-color: #4a9e7a; color: #90d8b0; }
.theme--dark .ws-tip strong { color: #90d8b0; }

/* Figure / image */
.ws-figure {
  margin: 1.6rem 0; border-radius: 8px; overflow: hidden;
  border: 1px solid #d0e4f7;
  box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}
.ws-figure img { width: 100%; height: auto; display: block; }
.ws-figure figcaption {
  background: #f0f6ff; padding: 0.55rem 1rem;
  font-size: 1.28rem; color: #666; border-top: 1px solid #d0e4f7;
  font-style: italic;
}
.theme--dark .ws-figure { border-color: #2a4560; }
.theme--dark .ws-figure figcaption { background: #0f1f30; color: #7a9ab0; border-top-color: #2a4560; }

/* Navigation / TOC */
.ws-nav {
  display: grid; grid-template-columns: repeat(auto-fit, minmax(170px, 1fr));
  gap: 0.6rem; margin: 1.2rem 0 2rem;
}
.ws-nav-item {
  background: #f5f9ff; border: 1px solid #d0e4f7; border-radius: 7px;
  padding: 0.65rem 0.9rem; text-decoration: none; color: #2c4a6e;
  font-size: 1.32rem; display: flex; gap: 0.55rem; align-items: baseline;
  transition: background 0.15s;
}
.ws-nav-item:hover { background: #e0eefa; text-decoration: none; }
.ws-nav-ltr { font-weight: 700; color: #4a9eda; font-size: 1.25rem; }
.theme--dark .ws-nav-item { background: #1a2d3d; border-color: #2a4560; color: #7ec8f0; }
.theme--dark .ws-nav-item:hover { background: #1e3548; }
.theme--dark .ws-nav-ltr { color: #7ec8f0; }

/* Steps / numbered list */
.ws-steps { counter-reset: ws-step; padding: 0; list-style: none; margin: 1rem 0 1.5rem; }
.ws-steps li {
  counter-increment: ws-step;
  padding: 0.55rem 0 0.55rem 2.8rem; position: relative;
  font-size: 1.52rem; line-height: 1.55; border-bottom: 1px solid #e8eef5;
}
.theme--dark .ws-steps li { border-bottom-color: #2a3d4f; }
.ws-steps li:last-child { border-bottom: none; }
.ws-steps li::before {
  content: counter(ws-step);
  position: absolute; left: 0; top: 0.5rem;
  background: #4a9eda; color: #fff; border-radius: 50%;
  width: 1.8rem; height: 1.8rem; font-size: 1.15rem; font-weight: 700;
  display: flex; align-items: center; justify-content: center;
}

/* Resources */
.ws-resources {
  display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 0.8rem; margin: 1rem 0;
}
.ws-resource-link {
  display: block; background: #f5f9ff; border: 1px solid #d0e4f7;
  border-radius: 7px; padding: 0.7rem 1rem; text-decoration: none;
  font-size: 1.35rem; color: #2c4a6e; transition: background 0.15s;
}
.ws-resource-link:hover { background: #e0eefa; text-decoration: none; }
.ws-resource-link strong { display: block; font-size: 1.18rem; color: #888; font-weight: 400; }
.theme--dark .ws-resource-link { background: #1a2d3d; border-color: #2a4560; color: #7ec8f0; }
.theme--dark .ws-resource-link:hover { background: #1e3548; }
.theme--dark .ws-resource-link strong { color: #7a9ab0; }
.ws-resource-link--featured { background: #e8f4fd; border-color: #4a9eda; border-width: 2px; font-weight: 700; color: #1a5c8a; }
.ws-resource-link--featured:hover { background: #d0eaf8; }
.theme--dark .ws-resource-link--featured { background: #0d2236; border-color: #4a9eda; color: #7ec8f0; }
.theme--dark .ws-resource-link--featured:hover { background: #112a40; }

/* Schedule table */
.ws-schedule {
  width: 100%; border-collapse: collapse; font-size: 1.45rem;
  margin: 1.2rem 0 2rem; border-radius: 8px; overflow: hidden;
  box-shadow: 0 1px 4px rgba(0,0,0,0.1);
}
.ws-schedule th { background: #2c4a6e; color: #fff; padding: 0.72rem 1.05rem; text-align: left; font-weight: 600; }
.ws-schedule td { padding: 0.7rem 1.05rem; border-bottom: 1px solid #e8eef5; vertical-align: middle; }
.theme--dark .ws-schedule td { border-bottom-color: #2a3d4f; }
.ws-schedule tr:last-child td { border-bottom: none; }
.ws-schedule tr.ws-block-row { background: #f5f9ff; }
.ws-schedule tr.ws-block-row td:first-child { font-weight: 600; color: #2c4a6e; }
.theme--dark .ws-schedule tr.ws-block-row { background: #1a2d3d; }
.theme--dark .ws-schedule tr.ws-block-row td:first-child { color: #7ec8f0; }
</style>

<div class="ws-hero">
  <p class="ws-hero__title">Working with Ambisonics</p>
  <p class="ws-hero__subtitle">Online-Workshop · ICST / ZHdK · ambisonics.ch</p>
  <div class="ws-badges">
    <span class="ws-badge ws-badge--blue">Online-Kurs</span>
    <span class="ws-badge ws-badge--green">Selbstgeführt</span>
    <span class="ws-badge">Zylia ZM-1</span>
    <span class="ws-badge">ICST Plugins</span>
    <span class="ws-badge">HOA 3rd Order</span>
    <span class="ws-badge">Reaper vorinstalliert</span>
  </div>
  <div class="ws-meta">
    <span>🎛️ REAPER + ICST AmbiEncoder/Decoder</span>
    <span>🎙️ Zylia ZM-1 (16-Kanal HOA)</span>
    <span>🔄 FuMa ↔ AmbiX Konvertierung</span>
  </div>
</div>

---

## Lernziele

<div class="ws-goals">
<p class="ws-goals__title">Nach diesem Workshop kannst du:</p>
<ul>
<li>den Ambisonics-Signalfluss von der Aufnahme bis zur Wiedergabe erklären</li>
<li>A-Format (PCM-Audio) und B-Format (mathematisches Format) unterscheiden</li>
<li>eine Zylia ZM-1 HOA-Aufnahme in Reaper einrichten und routen</li>
<li>Klangquellen mit dem ICST AmbiEncoder_64 im dreidimensionalen Raum positionieren</li>
<li>FOA/HOA-Material zwischen FuMa- und AmbiX-Format konvertieren</li>
<li>eine geführte Praxisübung (Encoding → Mixing → Decoding) selbstständig durchführen</li>
<li>externe Tools (MaxMSP, Csound/Cabbage) in einen Ambisonics-Workflow einbinden</li>
</ul>
</div>

<div class="ws-info">
<strong>📋 Vorbereitung</strong>
Reaper ist auf allen Workshop-Rechnern vorinstalliert (v7+, inkl. ICST-Plugins) · Kopfhörer mitbringen (Binaural-Monitoring) · Vorkonfigurierte Reaper-Session vorab herunterladen
</div>

---

## Inhalt

<div class="ws-nav">
  <a class="ws-nav-item" href="#block-a"><span class="ws-nav-ltr">A</span> Overall Workflow</a>
  <a class="ws-nav-item" href="#block-b"><span class="ws-nav-ltr">B</span> Recording</a>
  <a class="ws-nav-item" href="#block-c"><span class="ws-nav-ltr">C</span> Reaper Workflow</a>
  <a class="ws-nav-item" href="#block-d"><span class="ws-nav-ltr">D</span> External Tools</a>
  <a class="ws-nav-item" href="#block-e"><span class="ws-nav-ltr">E</span> Csound</a>
  <a class="ws-nav-item" href="#block-f"><span class="ws-nav-ltr">F</span> MaxMSP</a>
  <a class="ws-nav-item" href="#block-g"><span class="ws-nav-ltr">G</span> Discussion</a>
</div>

---

<div class="ws-block" id="block-a">
<div class="ws-block__head">
  <span class="ws-block__num">BLOCK A</span>
  <h2 class="ws-block__title">Overall Workflow</h2>
</div>
<div class="ws-block__meta">
  <span>Signalfluss</span><span>Formate</span><span>HOA-Ordnungen</span>
</div>
</div>

Ambisonics ist ein kanalformat-unabhängiges, vollsphärisches Audio-System. Jede Produktion folgt derselben Kette — unabhängig davon, ob das Ziel Kopfhörer, ein 8-Kanal-Ring oder eine 24-Kanal-Dome ist.

### Der Ambisonics-Signalfluss

<figure class="ws-figure">
  <img src="/images/workshop/diagram-overall-workflow.png" alt="Ambisonics Overall Workflow: Aufnahme → HOA-Bus → B-Format Master / Binaural / Array" loading="lazy">
  <figcaption>Ambisonics-Signalfluss: Von der Aufnahme (A-Format → B-Format ambiX) über den HOA-Bus zur Produktion bis zu den drei Ausgabeformaten — B-Format Master, Binaural Stereo und Array/Live.</figcaption>
</figure>

| Schritt | Was passiert | Tool (Workshop) |
|---|---|---|
| **1. Aufnahme** | Mikrofon-Array → A-Format (Rohkapseln) oder direkt HOA | Zylia ZM-1 → Zylia App |
| **2. A-to-B Konversion** | Kapsel-Rohdaten → B-Format (AmbiX / HOA) | Zylia App, JS-Plugin |
| **3. Encoding** | Mono/Stereo-Quellen im Raum positionieren | ICST AmbiEncoder_64 |
| **4. Processing** | EQ, Reverb, Panning auf dem HOA-Bus | Reaper FX-Chain |
| **5. Decoding** | B-Format → Wiedergabeformat | ICST AmbiDecoder |
| **6. Delivery** | Master rendern, Format wählen | Reaper Render |

**Die goldene Regel:** Den B-Format-Master-Track rendern — nie den Decoder-Output. Der Decoder ist nur für das Monitoring. Ein und derselbe B-Format-Master funktioniert für Kopfhörer, Lautsprecher und Streaming.

<div class="ws-info">
<strong>📖 Weiterlesen: Ambisonics-Grundlagen</strong>
→ <a href="/post/ambisonics-in-30-minutes/">Ambisonics in 30 Minutes</a> — kompakter Überblick über das System<br>
→ <a href="/learn/ambisonics-workflow/">Workflow von der Aufnahme bis zur Delivery</a> — vertiefte Schritt-für-Schritt-Anleitung<br>
→ <a href="/post/getting-started-icst-plugins-reaper/">Getting Started: ICST Plugins in Reaper</a> — Einstieg in die Plugin-Kette
</div>

### Monitoring-Setup

Bevor die Aufnahme beginnt, muss das Monitoring stehen:

- **Binaural (Kopfhörer):** ICST AmbiDecoder mit HRTF-Preset laden → direktes räumliches Feedback ohne Lautsprecher
- **Decoder-Preset prüfen:** Stimmt das Layout (Kanalzahl, Lautsprechergeometrie) mit dem tatsächlichen Setup überein?
- **Binaural und Lautsprecher nie parallel:** Nur ein Decoder aktiv — sonst Phasenfehler im Mix
- **Monitoring-Branch trennen:** Binaural-Monitor-Track auf separaten Bus, nicht in den B-Format-Master einschleifen

<div class="ws-info">
<strong>📖 Weiterlesen: Binaural Monitoring</strong>
→ <a href="/post/binaural-monitoring-icst-workflow/">Binaural Monitoring im ICST-Workflow</a> — HRTF-Setup, Decoder-Presets, Monitoring-Praxis
</div>

### Formate & Normierung

| Format | Kanalreihenfolge | Normierung | Status |
|---|---|---|---|
| **FuMa** (Furse-Malham) | W, X, Y, Z | MaxN | Älter, Legacy |
| **AmbiX** (ACN / SN3D) | W, Y, Z, X | SN3D | Aktueller Standard |

**Faustregel:** Immer in AmbiX (ACN/SN3D) arbeiten und archivieren. FuMa nur für Kompatibilität mit Legacy-Material.

| HOA-Ordnung | Kanäle | Mikrofon-Beispiel | Räumliche Auflösung |
|---|---|---|---|
| 1st Order (FOA) | 4 | Zoom H3-VR, Sennheiser Ambeo | Gut für Stereo-Ersatz, grobe Richtung |
| 2nd Order | 9 | — | Deutlich schärfere Lokalisation |
| 3rd Order | 16 | Zylia ZM-1 | Hohe Auflösung, Referenz für Produktion |

<div class="ws-info">
<strong>📖 Weiterlesen: Formate & Ordnungen</strong>
→ <a href="/learn/ambisonics-formats/">Ambisonics-Formate erklärt</a> — FuMa, AmbiX, ACN, SN3D im Detail<br>
→ <a href="/post/hoa-ordnung-wahl-praxis/">Welche Ambisonics-Ordnung brauche ich?</a> — praxisorientierte Entscheidungshilfe
</div>

### Delivery-Formate

| Ziel | Format | Anmerkung |
|---|---|---|
| **Archiv / Master** | Multichannel WAV, AmbiX, 48 kHz / 32-bit float | Unveränderter B-Format-Master |
| **Binaural** | 2-Kanal WAV | Streaming, Preview, Kopfhörer |
| **Lautsprecher** | N-Kanal WAV | Aufführung, Installation |
| **YouTube 360** | Binaural + Spatial Metadata | Spatial Media Metadata Tool |

<div class="ws-info">
<strong>📖 Weiterlesen: B-Format exportieren</strong>
→ <a href="/icst-ambisonics-plugins/12_render_bformat/">Render B-Format in REAPER</a> — Step-by-step Render-Setup<br>
→ <a href="/post/b-format-export-reaper/">Den B-Format-Master exportieren</a> — Reaper-Einstellungen für Archiv und Delivery
</div>

---

<div class="ws-block" id="block-b">
<div class="ws-block__head">
  <span class="ws-block__num">BLOCK B</span>
  <h2 class="ws-block__title">How to Record Ambisonics — Zylia ZM-1</h2>
</div>
<div class="ws-block__meta">
  <span>Mikrofon-Setup</span><span>A-to-B Konversion</span><span>Reaper-Session</span>
</div>
</div>

### Recording 3D-Audio: Der Aufnahme-Workflow

<figure class="ws-figure">
  <img src="/images/workshop/diagram-recording-3daudio.png" alt="Recording 3D-Audio: Mikrofon → A-Format → A-to-B Konversion → B-Format" loading="lazy">
  <figcaption>Von der Kapsel zum B-Format: Mikrofon-Array (A-Format, Rohkapseln) → A-to-B-Konversion in der Zylia-App → 16-kanaliges B-Format (AmbiX). Alle drei Stufen sind im Workshop-Workflow abgedeckt.</figcaption>
</figure>

### Workflow (Praxis mit Zylia → Main Reaper)

<ol class="ws-steps">
<li><strong>Short Recording Session</strong> — Zylia ZM-1 aufstellen, Pegel prüfen (−18 dBFS), 30–60 Sekunden aufnehmen → 19-Kanal A-Format PCM</li>
<li><strong>A to B Converting</strong> — Zylia App: A-Format importieren, als 3rd Order HOA exportieren → 16-Kanal B-Format AmbiX WAV<br>
  <em>A-Format = PCM Audio (normale Audiodaten, Rohkapseln)</em><br>
  <em>B-Format = Mathematical format (Kugelwellen-Harmonische, nicht direkt abhörbar)</em></li>
<li><strong>Listening B-Format</strong> — In Reaper laden, über HOA-Bus + AmbiDecoder binaural abhören: klingt «vorne» wirklich vorne?</li>
<li><strong>Upsampling & FX</strong> — EQ, Reverb auf HOA-Bus, Distanz-Automation am Encoder</li>
<li><strong>Mastering B-Format</strong> — HOA Render Bus rendern: 16 ch, 48 kHz, 32-bit float WAV → B-Format-Master</li>
</ol>

<div class="ws-tip">
<strong>💡 Gewitter-Beispiel (Zylia Recording)</strong>
Eine Gewitteraufnahme zeigt, warum HOA Stereo weit übertrifft: Donner kommt von überall (volle Einhüllung), Regen fällt von oben (Elevation), Wind dreht sich (Rotation des Schallfelds). In Stereo: nur ein Links-Rechts-Smear. In Ambisonics: vollständige Sphäre.
</div>

### Mikrofon-Spezifikationen

- 19-Kapsel-Array (Kugelcharakteristik)
- Ausgabe: 19 Rohkanäle → per Zylia-Software in 3rd Order HOA (16 Kanäle, AmbiX) kodiert
- Verbindung: USB-C, keine externe Speisung nötig

### Mikrofonaufstellung

Die Position des Mikrofons bestimmt die Hörperspektive — das ist keine technische, sondern eine kompositorische Entscheidung.

- **Höhe:** ca. 1.5 m für eine natürliche Ohrhöhen-Perspektive; tiefer für einen «am Boden»-Effekt, höher für Übersichtsperspektive
- **Orientierung:** Das Mikrofon hat eine Vorzugsrichtung (Markierung). «Vorne» im B-Format entspricht dieser Richtung — dokumentieren, damit das Decoding stimmt
- **Abstand zur Quelle:** Näher = mehr Direktschall, mehr Räumlichkeit; weiter = mehr Diffusfeld, weniger Lokalisation
- **Reflexionen:** Harte Wände, Böden und Decken sind im HOA-Mikrofon sehr präsent — Aufstellungsort sorgfältig abhören, bevor aufgenommen wird
- **Windschutz:** Im Freien immer Windschutz verwenden (Blimp oder Fell). LF-Roll-off unter 80 Hz aktivieren

### Pegelmanagement

- Zielpegel: ca. **−18 dBFS** (alle 19 Kanäle einzeln prüfen)
- Headroom: mindestens **12 dB** — Transienten in HOA-Mikrofonen können unvorhergesehen spitzen
- Alle Rohkanäle separat monitoren: ein übersteuernder Kanal korrumpiert das gesamte B-Format
- Gain-Struktur in der Zylia-App festlegen, nicht erst in Reaper korrigieren

### A-to-B Konversion

Das Zylia ZM-1 liefert A-Format (19 Rohkanäle). Die Zylia-Software konvertiert diese in 3rd Order HOA (16 Kanäle, AmbiX):

- **Wann konvertieren?** Direkt nach der Aufnahme, vor dem Import in Reaper
- **Qualitätskontrolle:** Phasen- und Kanalzuordnung testen — eine Mono-Testquelle von vorne sollte im Binaural-Monitor klar vorne klingen
- **Rohdaten archivieren:** Das A-Format (19 Kanäle) immer aufbewahren — eine spätere Neu-Konversion mit besserer Software ist so möglich

<div class="ws-info">
<strong>📖 Weiterlesen: A-Format & B-Format</strong>
→ <a href="/post/ambisonics-mikrofon-a-format-b-format/">Ambisonics-Mikrofon aufnehmen – A-Format, B-Format</a> — Konversionsworkflow und Qualitätskontrolle erklärt
</div>

### Fieldrecording-Checkliste

Vor der Aufnahme:

- [ ] Akustische Kartierung: Reflexionen, Störquellen, Windrichtung
- [ ] Mikrofonaufstellung festlegen und dokumentieren (Höhe, Orientierung, Abstand)
- [ ] Pegelcheck: alle 19 Kanäle auf ca. −18 dBFS
- [ ] Binaural-Monitoring aktiv und verifiziert
- [ ] Metadaten-Template vorbereitet (Ort, Datum, Take-Nr., Wetter)

Nach der Aufnahme:

- [ ] A-to-B Konversion in Zylia-App
- [ ] HOA-Datei (16 ch AmbiX) in Reaper laden und binaural verifizieren
- [ ] Rohkanäle (A-Format) archivieren

### Reaper-Session (vorkonfiguriert)

| Track | Kanäle | Funktion |
|---|---|---|
| Notes | — | Notiz-Track (stumm) |
| Zylia ZM-1 | 16 | Armed für Recording · VU: Multichannel Peaks |
| HOA Bus | 16 | AUXRECV von Zylia · kein Direct-Out |
| ICST AmbiDecoder | 18 | 16 ch in + 2 aux · Decoder-Plugin |
| Binaural Monitor | 2 | Kopfhörer-Monitoring |
| HOA Render Bus | 16 | Stumm · für Offline-Render |

<div class="ws-info">
<strong>📥 Download: Vorkonfigurierte Reaper-Session</strong>
Alle Tracks, Routing und Decoder-Preset sind voreingestellt — einfach öffnen und loslegen.<br>
→ <a href="/downloads/zylia-recording-example/zylia_recording_example.RPP" download>zylia_recording_example.RPP</a>
</div>

<div class="ws-info">
<strong>📖 Weiterlesen: Raumaufnahme & Akustik</strong>
→ <a href="/composing-in-ambisonics/073-room-capture/">Capturing Space and Synthetically Creating Space</a> — Raumakustik und Aufnahmetechnik für HOA-Produktionen
</div>

### Typische Aufnahme-Fehler und Lösungen

| Problem | Ursache | Lösung |
|---|---|---|
| Klang klingt «falsch herum» | Mikrofon-Orientierung nicht dokumentiert | Vorne/Hinten vor Ort testen und notieren |
| Kammfilter / instabile Richtung | Fehlerhafte A-to-B-Konversion | Spektrale Artefakte prüfen, Konversion wiederholen |
| Clipping auf einzelnen Kanälen | Überlastung einzelner Kapseln | Alle 19 Rohkanäle separat monitoren, Gain senken |
| Windgeräusche im Tiefton | Fehlendes Windschutz-Setup | LF-Roll-off unter 80 Hz, Blimp verwenden |
| Elevation klingt nicht | FOA statt HOA geladen | Kanalzahl prüfen: FOA = 4 ch, HOA 3rd = 16 ch |
| B-Format-Import in Reaper falsch | Falsches Ordering (FuMa statt AmbiX) | FuMa → AmbiX Konverter verwenden (JSFX, Block C) |

---

### Composers Workflow — Die drei Stufen

<figure class="ws-figure">
  <img src="/images/workshop/diagram-three-stages.png" alt="Die drei Stufen: Encoder → Transformer → Decoder (Author / Image / Monitor)" loading="lazy">
  <figcaption>Der paradigmatische Workflow des Ambisonics Toolkit: Author → Image → Monitor. Jede Ambisonics-Produktion durchläuft dieselben drei Stufen — unabhängig von Tool und Ausgabeformat.</figcaption>
</figure>

Jede Ambisonics-Produktion — ob Feldaufnahme, Synthesizer oder Live-Performance — durchläuft drei Stufen:

| Stufe | Frage | In der Praxis |
|---|---|---|
| **Encoding** | Wo ist der Klang im 3D-Raum? | Azimut, Elevation, Distanz — via ICST AmbiEncoder_64 oder Lua-Script |
| **Processing** | Wie bewegt sich der Klang und wie interagiert er mit dem Raum? | Rotation, Bewegungs-Automation, Reverb auf HOA-Bus, Distanz-Simulation |
| **Decoding** | Wie spiele ich das auf meinem Audiosystem ab? | ICST AmbiDecoder: Binaural (HRTF), Lautsprecher-Ring, MultiDecoder |

<figure class="ws-figure">
  <img src="/images/workshop/diagram-signalflow.png" alt="Signalflow (Kommunikation): Externe Applikationen, Bridges, DAW, External-Hardware, Outputs" loading="lazy">
  <figcaption>Vollständiger Signalfluss einer Ambisonics-Produktionsumgebung: Externe Tools (AbletonLive, Csound, SuperCollider, Max 9) → Bridges → DAW (Sound-Design, Spatialization, Mix&Mastering) → B-Format → Decoding. OSC/MIDI verbindet alle Ebenen.</figcaption>
</figure>

---

<div class="ws-block" id="block-c">
<div class="ws-block__head">
  <span class="ws-block__num">BLOCK C</span>
  <h2 class="ws-block__title">Reaper Workflow: Encoding · Processing · Decoding</h2>
</div>
<div class="ws-block__meta">
  <span>ICST AmbiEncoder_64</span><span>Lua-Automation</span><span>Decoding</span>
</div>
</div>

### Encoding mit ICST AmbiEncoder_64

Plugin: **ICST AmbiEncoder_64** (VST3) — auf allen Workshop-Rechnern vorinstalliert.

| Parameter | Index | Normiert | Bedeutung |
|---|---|---|---|
| Azimut | 11 | 0–1 → −180° bis +180° | Horizontale Position |
| Elevation | 12 | 0–1 → −90° bis +90° (0.5 = Horizont) | Vertikale Position |
| Distanz | 13 | 0 = nah · 1 = fern | Tiefe |

<div class="ws-info">
<strong>📥 Lua-Skript: Encoding-Beispiel</strong>
→ <a href="/downloads/lua-scripts/icst_ambi_encoding_voice.lua" download>icst_ambi_encoding_voice.lua</a> — setzt Track, lädt AmbiEncoder, positioniert Quelle auf Azimut −45°, Elevation +20°
</div>

<div class="ws-info">
<strong>📖 Weiterlesen: ICST AmbiEncoder</strong>
→ <a href="/icst-ambisonics-plugins/10_icst_encoders/">ICST Encoders</a> — alle Parameter, Modi und Encoder-Varianten im Überblick<br>
→ <a href="/post/icst-scripts/">ICST AmbiEncoder – Spiral Walk Script</a> — Beispiel für komplexe Lua-Automation<br>
→ <a href="/post/osc-syntax-for-the-icst-ambiencoder-plugin/">ICST AmbiEncoder – OSC Syntax</a> — Encoder via OSC steuern (Touchdesigner, Max, etc.)
</div>

### Automation: Bewegende Klangquellen

Physik-basierte Trajektorie: `atan2` für Azimut, `√(x²+y²)` für Distanz.

<div class="ws-info">
<strong>📥 Lua-Skripte: Zugvorbeifahrt</strong>
→ <a href="/downloads/lua-scripts/icst_ambi_zug_langsam.lua" download>icst_ambi_zug_langsam.lua</a> — langsamer Zug, 28 Sekunden<br>
→ <a href="/downloads/lua-scripts/icst_ambi_zug_schnell.lua" download>icst_ambi_zug_schnell.lua</a> — Schnellzug, 4 Sekunden<br>
→ <a href="/downloads/lua-scripts/icst_ambi_zug_vergleich.lua" download>icst_ambi_zug_vergleich.lua</a> — Pause + langsam + Pause + schnell in Sequenz
</div>

### Processing

#### Distanz

Im ICST AmbiEncoder simuliert **Param 13 (Distanz)** die Tiefe im Raum. Das Plugin dämpft Pegel und Höhenanteil mit zunehmender Distanz — ähnlich der Luftabsorption im realen Raum:

- Nahe Quellen (Distanz ~0): präsent, direkt, hoher HF-Anteil
- Entfernte Quellen (Distanz ~1): leiser, dumpfer, mehr Diffusfeld-Anteil
- **Kombination mit Reverb:** Je mehr Distanz, desto höher der Wet-Anteil im Room-Plugin auf dem HOA-Bus

<div class="ws-info">
<strong>📥 Reaper-Beispiel: Distanz-Automation</strong>
→ <a href="/downloads/workshop-2026/reaper-setup/icst_stereo_pan_distanz.lua" download>icst_stereo_pan_distanz.lua</a>
</div>

#### Room / Reverb

Der Reverb sitzt auf dem **HOA-Bus-Track** — nicht auf dem Source-Track. Nur so bleibt der Hall im Ambisonics-Raum verankert und wird korrekt mit dem B-Format decodiert.

- **ReaVerb oder FX-Reverb** auf dem HOA-Bus (nach allen Encodern, vor dem Decoder)
- Dry/Wet-Verhältnis: sparsam beginnen (~10–20 % Wet), da HOA-Reverb sehr präsent klingt
- **Room-Size und Pre-Delay** bestimmen die Raumgrösse
- Separate Reverb-Sends pro Quelle ermöglichen unterschiedliche Raumdistanzen

<div class="ws-info">
<strong>📥 Reaper-Beispiel: Raumkurven</strong>
→ <a href="/downloads/workshop-2026/reaper-setup/icst_stereo_pan_raumkurven.lua" download>icst_stereo_pan_raumkurven.lua</a>
</div>

#### Beispiel: Helikopter-Überflug

| Phase | Azimut | Elevation | Distanz |
|---|---|---|---|
| Annäherung (vorne) | ~0° | 15° → 70° | 1.0 → 0.3 |
| Overhead | 0° → 180° | 70° → 85° → 70° | 0.3 → **min** → 0.3 |
| Abflug (hinten) | ~180° | 70° → 15° | 0.3 → 1.0 |

Das Script berechnet Position, Azimut und Elevation direkt aus den 3D-Koordinaten (`atan2`, Pythagoras) — kein manuelles Schätzen von Winkeln.

<div class="ws-info">
<strong>📖 Weiterlesen: Räumliche Parameter</strong>
→ <a href="/composing-in-ambisonics/06-spatial-parameters/">Spatial Parameters as Compositional Material</a> — kreative Nutzung von Azimut, Elevation und Distanz
</div>

<div class="ws-info">
<strong>📥 Lua-Skript: Helikopter-Überflug</strong>
→ <a href="/downloads/lua-scripts/icst_ambi_kopter.lua" download>icst_ambi_kopter.lua</a> — 18 s Überflug, 360 Punkte, konfigurierbare Höhe und Seitenversatz
</div>

### Decoding

- **Binaural:** ICST AmbiDecoder mit HRTF-Datei → 2-Kanal-Kopfhörer
- **Lautsprecher:** Decoder mit `.spk`-Konfigurationsdatei
- **Screensets:** `Ctrl+Alt+1` (Recording) · `Ctrl+Alt+2` (Mixing) · `Ctrl+Alt+3` (Decoding)

<div class="ws-info">
<strong>📖 Weiterlesen: Decoding & Delivery</strong>
→ <a href="/post/multi-decoder-mode/">ICST AmbiDecoder – Multi-Decoder Mode</a> — mehrere Ausgabeformate parallel betreiben<br>
→ <a href="/composing-in-ambisonics/082-binaural-delivery/">Binaural Rendering and Headphone Delivery</a> — Binaural-Render für Streaming und Headphones
</div>

---

### FuMa → AmbiX Konvertierung (FOA)

Für Legacy-Material im FuMa-Format (z. B. SoundField, ältere Produktionen):

| FuMa Eingang | AmbiX Ausgang (ACN) | Gain-Korrektur |
|---|---|---|
| Ch1 = W | ACN 0 = W | × √2 = **+3.01 dB** |
| Ch2 = X | ACN 3 = X | × 1/√3 = **−4.77 dB** |
| Ch3 = Y | ACN 1 = Y | × 1/√3 = **−4.77 dB** |
| Ch4 = Z | ACN 2 = Z | × 1/√3 = **−4.77 dB** |

<div class="ws-info">
<strong>📥 JSFX-Plugin + Lua-Installer</strong>
→ <a href="/downloads/lua-scripts/FuMa_to_AmbiX_FOA.jsfx" download>FuMa_to_AmbiX_FOA.jsfx</a> — JSFX-Plugin<br>
→ <a href="/downloads/lua-scripts/icst_fuma_to_ambix_foa.lua" download>icst_fuma_to_ambix_foa.lua</a> — Lua-Installer<br>
In Reaper: Actions → Load new Script → <code>icst_fuma_to_ambix_foa.lua</code>
</div>

---

<div class="ws-block" id="block-d">
<div class="ws-block__head">
  <span class="ws-block__num">BLOCK D</span>
  <h2 class="ws-block__title">External to Reaper</h2>
</div>
<div class="ws-block__meta">
  <span>MaxMSP</span><span>Csound</span><span>Max for Live</span>
</div>
</div>

Reaper ist nicht die einzige Umgebung für Ambisonics. Diese Tools werden von Komponistinnen und Forschern eingesetzt — jedes mit einem anderen Ansatz und anderen Stärken.

**Workflow mit MaxMSP:** ICST Ambisonics Externals (ambicontrol, ambiencode, ambidecode). Real-time Spatialisation, OSC-Steuerung des ICST AmbiEncoders in Reaper. Stärke: generative und algorithmische Spatialisation, Live-Elektronik.

**Workflow mit Csound (Cabbage.app):** Csound-Opcodes `bformenc1` / `bformdec2`. Cabbage wrapped Csound als VST3-Plugin. Stärke: präzise mathematische Kontrolle des Schallfelds, Additive Synthese, Granularsynthese.

**Workflow mit Max for Live:** MaxMSP integriert in Ableton Live. Kombiniert Abletons Produktions-Workflow mit Ambisonics-Spatialisation. Stärke: Live-Performance mit Ambisonics, Studio-Produktion.

<div class="ws-tip">
<strong>📌 Hinweis</strong>
Die Blöcke D, E und F gehen über den 4-Stunden-Rahmen hinaus. Sie werden hier als Überblick eingeführt und in einem Folge-Workshop vertieft.
</div>

---

<div class="ws-block" id="block-e">
<div class="ws-block__head">
  <span class="ws-block__num">BLOCK E</span>
  <h2 class="ws-block__title">Csound / Cabbage</h2>
</div>
<div class="ws-block__meta">
  <span>Additive Synthese</span><span>Spatialisation</span><span>VST3</span>
</div>
</div>

Csound ist eine programmierbare Audio-Synthesesprache. Cabbage wrapped Csound-Instrumente als VST3-Plugins und macht sie in Reaper nutzbar.

### Cabbage → Reaper (DAW)

<figure class="ws-figure">
  <img src="/images/workshop/diagram-cabbage-reaper.png" alt="Cabbage (Csound) → Reaper: Cabbage.app → BlackHole_64 → Reaper.app, mit OSC-Rückkanal" loading="lazy">
  <figcaption>Integration von Cabbage/Csound in Reaper: Cabbage.app sendet Audio über BlackHole_64 (virtuelles Audio-Interface) an Reaper. OSC ermöglicht bidirektionale Kommunikation — Reaper kann Spatialisation-Parameter steuern, Csound kann Encoder-Positionen empfangen.</figcaption>
</figure>

**Key Csound Opcodes für Ambisonics:**
- `bformenc1` — kodiert ein Mono-Signal in B-Format (1.–3. Ordnung). Input: Audio, Azimut, Elevation. Output: HOA-Kanäle.
- `bformdec2` — dekodiert B-Format auf ein Lautsprecher-Array.

**Beispiel: Additive Synth & Random Spatialisation (Cabbage)**

Ein Cabbage-Beispiel zeigt: Ein Additivsynthesizer erzeugt Partiale (Sinuswellen) in Echtzeit. Jedes Partial wird unabhängig mit `bformenc1` und randomisiertem Azimut/Elevation spatalisiert. Die Position driftet zufällig — es entsteht eine bewegende Klangwolke im 3D-Raum, die dann binaural decodiert wird.

---

<div class="ws-block" id="block-f">
<div class="ws-block__head">
  <span class="ws-block__num">BLOCK F</span>
  <h2 class="ws-block__title">MaxMSP — ICST Ambisonics Externals</h2>
</div>
<div class="ws-block__meta">
  <span>ACT-Tool</span><span>OSC</span><span>Real-time</span>
</div>
</div>

MaxMSP mit den ICST Ambisonics Externals bietet eine vollständige Real-time-Ambisonics-Umgebung. Anders als eine DAW erlaubt Max algorithmische und generative Kontrolle der Spatialisation — Positionen können durch Daten, Gesten, Sensoren oder andere Audio-Signale gesteuert werden.

### MaxMSP → Reaper (DAW)

<figure class="ws-figure">
  <img src="/images/workshop/diagram-maxmsp-reaper.png" alt="MaxMSP → Reaper: Max9.app ↔ BlackHole_64 ↔ Reaper.app, mit OSC und MIDI" loading="lazy">
  <figcaption>MaxMSP und Reaper kommunizieren über BlackHole_64 (Audio), OSC (Spatialisation-Parameter) und MIDI. Max9 kann den ICST AmbiEncoder in Reaper in Echtzeit steuern — Azimut, Elevation und Distanz als Live-Automation.</figcaption>
</figure>

**ICST Ambisonics Externals:**
- `ambiencode~` — kodiert Mono-Audio in B-Format. Message-Input für Azimut, Elevation, Distanz.
- `ambidecode~` — dekodiert B-Format auf Lautsprecher oder Binaural.
- `ambicontrol` — GUI-Panel für manuelle Spatialisation-Kontrolle.

**ACT-Tool Example:**

Das ACT-Tool (Ambisonics Composition Tool) ist ein MaxMSP-Patch entwickelt am ICST:
- 3D-visuelles Interface zum Platzieren und Animieren von Klangquellen
- Quellen können manuell (Maus/Trackpad) oder algorithmisch (LFOs, Envelopes, Datenströme) bewegt werden
- OSC-Output: sendet Azimut, Elevation und Distanz an jeden Ambisonics-Encoder — inkl. ICST AmbiEncoder in Reaper
- Das ACT-Tool kann als «räumliche Partitur» verwendet werden: Bewegung visuell definieren, OSC-Output als Automation in Reaper aufnehmen

---

## Praxis-Übung

Geführte Übung mit den vorbereiteten Sessions:

<ol class="ws-steps">
<li>Zylia-Session öffnen, Mikrofon-Routing und Decoder-Preset verifizieren</li>
<li>Mono-Testquelle auf HOA-Bus routen, binaural abhören</li>
<li>Encoding-Skript ausführen: Quelle auf Azimut −45°, Elevation +20° positionieren</li>
<li>Zugvorbeifahrt-Automation starten und Trajektorie binaural verfolgen</li>
<li>Eigene Quelle encodieren und im Raum bewegen (Automation oder manuell)</li>
<li>B-Format-Master rendern und verifizieren (16 ch, nicht 2 ch!)</li>
</ol>

<div class="ws-info">
<strong>📖 Weiterlesen: Kompositorische Praxis</strong>
→ <a href="/composing-in-ambisonics/05-spatial-counterpoint/">Spatial Counterpoint</a> — räumliche Gegenbewegung als kompositorisches Mittel<br>
→ <a href="/post/reaper-setup-20-minuten/">Reaper Ambisonics Setup in 20 Minuten</a> — schnelles Setup für eigene Projekte nach dem Workshop
</div>

---

<div class="ws-block" id="block-g">
<div class="ws-block__head">
  <span class="ws-block__num">BLOCK G</span>
  <h2 class="ws-block__title">Composer Discussion</h2>
</div>
<div class="ws-block__meta">
  <span>Themen</span><span>Q&A</span><span>Ausblick</span>
</div>
</div>

Eine geführte Diskussion zur Konsolidierung der Workshop-Erfahrung. Nicht ein Vortrag — die Teilnehmenden teilen ihre eigenen Beobachtungen und entwickeln Ideen gemeinsam.

**Themen:**

- **Raum als Kompositionsmaterial:** Kann der Raum selbst das Instrument sein? Was passiert, wenn der Raum sich bewegt und die Quelle stillsteht?
- **Die Composer-Perspektive:** Wie verändert das Arbeiten in Ambisonics die kompositorischen Entscheidungen im Vergleich zu Stereo?
- **Elevation und Expressivität:** Wann fühlt sich Höhe natürlich an, wann künstlich? Was ermöglicht die vertikale Achse, was Stereo nie konnte?
- **Distanz und Reverb:** Wie interagieren Distanz und Hall? Wann klingt eine Quelle «im Raum» statt «ausserhalb»?
- **Ausblick Folge-Workshop:** MaxMSP + Csound in der Tiefe (Blöcke D, E, F).

---

## Vorbereitung & Downloads

- Reaper ist auf allen Workshop-Rechnern vorinstalliert (v7+, inkl. ICST-Plugins)
- Kopfhörer mitbringen (Binaural-Monitoring)
- Vorkonfigurierte Reaper-Session vorab herunterladen

<div class="ws-resources">
  <a class="ws-resource-link ws-resource-link--featured" href="/downloads/workshop-2026/ICST_Ambisonics_Workshop_2026.zip" download>⬇ ICST_Ambisonics_Workshop_2026.zip<strong>Komplettes Workshop-Paket — Reaper-Session, Lua-Scripts, Csound, MaxMSP (6.8 MB)</strong></a>
  <a class="ws-resource-link" href="/downloads/zylia-recording-example/zylia_recording_example.RPP" download>zylia_recording_example.RPP<strong>Vorkonfigurierte Reaper-Session für Zylia ZM-1</strong></a>
  <a class="ws-resource-link" href="/downloads/ICST_Ambisonics_Workshop.docx" download>Workshop-Dokument (.docx)<strong>Vollständiges Workshop-Dokument</strong></a>
  <a class="ws-resource-link" href="/downloads/lua-scripts/icst_ambi_encoding_voice.lua" download>icst_ambi_encoding_voice.lua<strong>Encoding: Stimme auf Az −45°, El +20°</strong></a>
  <a class="ws-resource-link" href="/downloads/lua-scripts/icst_ambi_zug_langsam.lua" download>icst_ambi_zug_langsam.lua<strong>Langsamer Zug (28 s)</strong></a>
  <a class="ws-resource-link" href="/downloads/lua-scripts/icst_ambi_zug_schnell.lua" download>icst_ambi_zug_schnell.lua<strong>Schnellzug (4 s)</strong></a>
  <a class="ws-resource-link" href="/downloads/lua-scripts/icst_ambi_zug_vergleich.lua" download>icst_ambi_zug_vergleich.lua<strong>Zug-Vergleich (langsam + schnell)</strong></a>
  <a class="ws-resource-link" href="/downloads/lua-scripts/icst_ambi_kopter.lua" download>icst_ambi_kopter.lua<strong>Helikopter-Überflug (3D, 18 s)</strong></a>
  <a class="ws-resource-link" href="/downloads/lua-scripts/FuMa_to_AmbiX_FOA.jsfx" download>FuMa_to_AmbiX_FOA.jsfx<strong>FuMa → AmbiX FOA Converter (JSFX)</strong></a>
  <a class="ws-resource-link" href="/downloads/lua-scripts/icst_fuma_to_ambix_foa.lua" download>icst_fuma_to_ambix_foa.lua<strong>FuMa → AmbiX Lua-Installer</strong></a>
  <a class="ws-resource-link" href="/blog/b-format-archive/">ICST B-Format Archive<strong>Archiv mit HOA-Beispieldateien zum Ausprobieren</strong></a>
  <a class="ws-resource-link" href="/icst-ambisonics-plugins/15_best_practices/">Best Practices<strong>Empfehlungen für professionelle Ambisonics-Produktionen</strong></a>
</div>
