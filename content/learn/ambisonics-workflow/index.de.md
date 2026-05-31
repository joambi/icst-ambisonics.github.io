---
title: "Wie arbeiten in Ambisonics: Workflow von Aufnahme bis Delivery"
description: "Praxisnaher Workflow-Guide für Ambisonics-Produktionen: Aufnahme, Produktion, Mixing, Delivery und Live-Systeme mit REAPER, ICST Plugins und Max/MSP."
date: 2026-05-15T00:00:00
draft: false
slug: ambisonics-workflow
languageCode: de
tags:
  - ambisonics
  - workflow
  - aufnahme
  - mixing
  - delivery
  - live
  - reaper
---

<style>
/* ══════════════════════════════════════════════════════════
   WORKFLOW PAGE STYLES — Light + Dark Mode
   ══════════════════════════════════════════════════════════ */

.post__content > h1 {
  font-size: clamp(2.8rem, 4.2vw, 4.3rem);
  line-height: 1.08;
  letter-spacing: 0.01em;
  margin-bottom: 1.5rem;
}
.post__content h2 {
  font-size: clamp(2rem, 2.6vw, 2.7rem);
  line-height: 1.18;
}
.post__content h3 {
  font-size: clamp(1.45rem, 1.6vw, 1.8rem);
  line-height: 1.25;
}
.post__content p,
.post__content li,
.post__content td,
.post__content th {
  font-size: 1.55rem;
  line-height: 1.62;
}

/* ── Hero ──────────────────────────────────────────────── */
.wf-hero {
  background: linear-gradient(135deg, #1a2a1a 0%, #2c4a2e 100%);
  border-radius: 10px;
  padding: 2.1rem 2.25rem 1.95rem;
  color: #fff;
  margin-bottom: 2rem;
}
.wf-hero__title {
  font-size: 2.25rem;
  font-weight: 800;
  letter-spacing: 0.02em;
  margin: 0 0 0.3rem 0;
}
.wf-hero__subtitle {
  font-size: 1.45rem;
  opacity: 0.75;
  margin: 0 0 1.2rem 0;
}
.wf-badges {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin-bottom: 1rem;
}
.wf-badge {
  background: rgba(255,255,255,0.15);
  border: 1px solid rgba(255,255,255,0.25);
  border-radius: 20px;
  padding: 0.32rem 0.95rem;
  font-size: 1.3rem;
  color: #fff;
  white-space: nowrap;
}
.wf-badge--green {
  background: #3a8a45;
  border-color: #3a8a45;
}
.wf-meta {
  display: flex;
  flex-wrap: wrap;
  gap: 1.5rem;
  margin-top: 1rem;
  font-size: 1.38rem;
  opacity: 0.85;
}
.wf-meta span { white-space: nowrap; }
.wf-meta a {
  color: inherit;
  text-decoration-color: rgba(255,255,255,0.45);
  text-underline-offset: 0.18em;
}

/* ── Chain / Phasen ─────────────────────────────────────── */
.wf-chain {
  display: flex;
  flex-wrap: wrap;
  gap: 0;
  margin: 1.5rem 0 2rem;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 1px 4px rgba(0,0,0,0.1);
}
.wf-chain__step {
  flex: 1 1 120px;
  background: #f0f6f0;
  border-right: 1px solid #d0e8d0;
  padding: 1rem 1.1rem 0.9rem;
  text-align: center;
}
.wf-chain__step:last-child { border-right: none; }
.wf-chain__step--active {
  background: #2c4a2e;
  color: #fff;
}
.theme--dark .wf-chain__step { background: #1a2d1a; border-right-color: #2a4030; }
.theme--dark .wf-chain__step--active { background: #2c5a30; }
.wf-chain__icon { font-size: 1.8rem; display: block; margin-bottom: 0.3rem; }
.wf-chain__label { font-size: 1.25rem; font-weight: 700; display: block; }
.wf-chain__sub { font-size: 1.1rem; opacity: 0.7; display: block; }

/* ── Section headers ────────────────────────────────────── */
.wf-section {
  border-top: 3px solid #3a8a45;
  margin: 2.5rem 0 1.2rem;
  padding-top: 1rem;
}
.wf-section__head {
  display: flex;
  align-items: baseline;
  flex-wrap: wrap;
  gap: 0.7rem;
  margin-bottom: 0.4rem;
}
.wf-section__num {
  background: #3a8a45;
  color: #fff;
  border-radius: 4px;
  padding: 0.1rem 0.55rem;
  font-size: 1.12rem;
  font-weight: 700;
  letter-spacing: 0.05em;
}
.wf-section__title {
  font-size: 1.9rem;
  font-weight: 700;
  color: #1a2a1a;
  margin: 0;
}
.theme--dark .wf-section__title { color: #c0e8c0; }
.wf-section__meta {
  font-size: 1.35rem;
  color: #666;
  margin: 0.2rem 0 1rem;
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
}
.theme--dark .wf-section__meta { color: #7a9a7a; }
.wf-section__meta span::before { content: "· "; }
.wf-section__meta span:first-child::before { content: ""; }

/* ── Key Box ────────────────────────────────────────────── */
.wf-key {
  background: #f0f6f0;
  border-left: 4px solid #3a8a45;
  border-radius: 0 8px 8px 0;
  padding: 1.1rem 1.5rem;
  margin: 1.2rem 0;
}
.theme--dark .wf-key { background: #1a2d1a; }
.wf-key__title {
  font-weight: 700;
  font-size: 1.4rem;
  color: #1a5a25;
  margin: 0 0 0.6rem;
}
.theme--dark .wf-key__title { color: #7dd3a8; }
.wf-key p, .wf-key li { font-size: 1.5rem; margin-bottom: 0.35rem; line-height: 1.5; }

/* ── Warning Box ────────────────────────────────────────── */
.wf-warn {
  background: #fff8e6;
  border: 1px solid #f0c040;
  border-left: 4px solid #f0c040;
  border-radius: 0 8px 8px 0;
  padding: 0.9rem 1.2rem;
  margin: 1.2rem 0;
}
.theme--dark .wf-warn { background: #231f0e; border-color: #a07c10; border-left-color: #f0c040; }
.wf-warn__title { font-weight: 700; font-size: 1.4rem; color: #7a5800; margin: 0 0 0.5rem; }
.theme--dark .wf-warn__title { color: #f0c040; }
.wf-warn p, .wf-warn li { font-size: 1.45rem; margin-bottom: 0.35rem; line-height: 1.5; }

/* ── Steps ──────────────────────────────────────────────── */
.wf-steps {
  counter-reset: wf-step;
  list-style: none;
  padding: 0;
  margin: 1rem 0;
}
.wf-steps li {
  counter-increment: wf-step;
  display: flex;
  gap: 1rem;
  align-items: flex-start;
  padding: 0.65rem 0;
  border-bottom: 1px solid #e8f0e8;
  font-size: 1.52rem;
  line-height: 1.55;
}
.theme--dark .wf-steps li { border-bottom-color: #2a3d2a; }
.wf-steps li:last-child { border-bottom: none; }
.wf-steps li::before {
  content: counter(wf-step);
  background: #3a8a45;
  color: #fff;
  border-radius: 50%;
  width: 2rem;
  height: 2rem;
  min-width: 2rem;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.1rem;
  font-weight: 700;
  margin-top: 0.1rem;
}

/* ── Decision Table ─────────────────────────────────────── */
.wf-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 1.45rem;
  margin: 1.2rem 0 1.8rem;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 1px 4px rgba(0,0,0,0.08);
}
.wf-table th {
  background: #2c4a2e;
  color: #fff;
  padding: 0.7rem 1rem;
  text-align: left;
  font-weight: 600;
}
.wf-table td {
  padding: 0.65rem 1rem;
  border-bottom: 1px solid #e0ede0;
  vertical-align: top;
}
.theme--dark .wf-table td { border-bottom-color: #2a3d2a; }
.wf-table tr:last-child td { border-bottom: none; }
.wf-table tr:nth-child(even) td { background: #f7fbf7; }
.theme--dark .wf-table tr:nth-child(even) td { background: #1a2d1a; }

/* ── Checklist ──────────────────────────────────────────── */
.wf-checklist {
  columns: 2;
  column-gap: 2rem;
  list-style: none;
  padding: 0;
  margin: 1rem 0;
}
@media (max-width: 640px) { .wf-checklist { columns: 1; } }
.wf-checklist li {
  font-size: 1.45rem;
  padding: 0.32rem 0 0.32rem 2rem;
  position: relative;
  break-inside: avoid;
}
.wf-checklist li::before {
  content: "☐";
  position: absolute;
  left: 0;
  color: #3a8a45;
  font-size: 1.3rem;
}

/* ── Resources ──────────────────────────────────────────── */
.wf-resources {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
  gap: 0.8rem;
  margin: 1rem 0;
}
.wf-resource-link {
  display: block;
  background: #f0f6f0;
  border: 1px solid #c0ddc0;
  border-radius: 7px;
  padding: 0.7rem 1rem;
  text-decoration: none;
  font-size: 1.35rem;
  color: #1a4a25;
  transition: background 0.15s;
}
.wf-resource-link:hover { background: #ddf0dd; text-decoration: none; }
.wf-resource-link strong { display: block; font-size: 1.15rem; color: #6a8a6a; font-weight: 400; }
.theme--dark .wf-resource-link { background: #1a2d1a; border-color: #2a4a2a; color: #7ec8a0; }
.theme--dark .wf-resource-link:hover { background: #1e3d1e; }
.theme--dark .wf-resource-link strong { color: #5a8a6a; }
</style>

<div class="wf-hero">
  <p class="wf-hero__title">Wie arbeiten in Ambisonics</p>
  <p class="wf-hero__subtitle">Workflow-Guide · Aufnahme · Produktion · Delivery · Live · ICST / ZHdK</p>
  <div class="wf-badges">
    <span class="wf-badge wf-badge--green">Advanced</span>
    <span class="wf-badge">REAPER + ICST Plugins</span>
    <span class="wf-badge">Max/MSP optional</span>
    <span class="wf-badge">Csound optional</span>
  </div>
  <div class="wf-meta">
    <span>🎛️ <a href="/de/icst-ambisonics-plugins/15_best_practices/">Voraussetzung: Best Practices</a></span>
    <span>📐 <a href="/de/learn/ambisonics-formats/">Ambisonics-Formate</a></span>
    <span>🔧 <a href="/de/icst-ambisonics-plugins/">ICST Plugin-Dokumentation</a></span>
  </div>
</div>

Diese Seite beschreibt den **vollständigen Ambisonics-Workflow** — von der ersten Mikrofon-Platzierung bis zum fertigen Delivery oder Live-System. Sie ist kein Einsteiger-Tutorial, sondern eine **Referenz für Praktizierende**: kompakt, entscheidungsorientiert und direkt auf das ICST-Ökosystem ausgerichtet.

<div class="wf-chain">
  <div class="wf-chain__step">
    <span class="wf-chain__icon">🎙</span>
    <span class="wf-chain__label">Aufnahme</span>
    <span class="wf-chain__sub">A-Format → B-Format</span>
  </div>
  <div class="wf-chain__step">
    <span class="wf-chain__icon">🎛</span>
    <span class="wf-chain__label">Produktion</span>
    <span class="wf-chain__sub">REAPER · Encoding · Mixing</span>
  </div>
  <div class="wf-chain__step">
    <span class="wf-chain__icon">📦</span>
    <span class="wf-chain__label">Delivery</span>
    <span class="wf-chain__sub">Export · Formate · Render</span>
  </div>
  <div class="wf-chain__step">
    <span class="wf-chain__icon">🔊</span>
    <span class="wf-chain__label">Live</span>
    <span class="wf-chain__sub">System-Design · Echtzeit</span>
  </div>
</div>

---

<div class="wf-section">
<div class="wf-section__head">
  <span class="wf-section__num">01</span>
  <h2 class="wf-section__title">Aufnahme</h2>
</div>
<div class="wf-section__meta">
  <span>Mikrofon-Auswahl</span><span>A-to-B-Konversion</span><span>Fieldrecording</span><span>Qualitätskontrolle</span>
</div>
</div>

### Mikrofon-Auswahl

Ambisonics-Mikrofone nehmen im **A-Format** auf — das sind die Rohsignale der Kapseln, noch kein Schallfeld-Format. Die Konversion in **B-Format (ambiX)** erfolgt danach, entweder direkt im Mikrofon oder per Software.

<table class="wf-table">
<thead><tr><th>Mikrofon</th><th>Ordnung</th><th>Stärken</th><th>Typischer Einsatz</th></tr></thead>
<tbody>
<tr><td>Zoom H3-VR</td><td>1st / 4 ch</td><td>Kompakt, günstiger Einstieg, interner B-Format-Output</td><td>Fieldrecording, Lehre</td></tr>
<tr><td>Sennheiser Ambeo VR</td><td>1st / 4 ch</td><td>Robust, weit verbreitet, guter Klang</td><td>Fieldrecording, Studio</td></tr>
<tr><td>Rode NT-SF1</td><td>1st / 4 ch</td><td>Günstiger Einstieg, solide Qualität</td><td>Fieldrecording, Produktion</td></tr>
<tr><td>DPA d:mension</td><td>1st / 4 ch</td><td>Sehr linearer Klang, wenig Färbung</td><td>Musikaufnahmen, Studio</td></tr>
<tr><td>Zylia ZM-1</td><td>3rd / 19 ch</td><td>Höhere Auflösung, gute Richtungstreue</td><td>Forschung, HOA-Produktion</td></tr>
<tr><td>EigenMike em32</td><td>4th / 32 ch</td><td>Referenz-HOA, maximale Auflösung</td><td>Studio, wissenschaftliche Aufnahmen</td></tr>
</tbody>
</table>

**Faustregel:** Für FOA-Produktionen und Lehre genügen 1st-Order-Mikrofone. Für HOA-Produktionen ab 3rd Order ist ein Zylia ZM-1 oder EigenMike sinnvoll.

### A-to-B-Konversion

<div class="wf-warn">
<p class="wf-warn__title">⚠ A-Format ist kein Ambisonics</p>
<p>A-Format-Dateien klingen räumlich inkohärent, wenn sie direkt als B-Format geladen werden. Die Konversion muss vor jedem weiteren Schritt erfolgen.</p>
</div>

Die Konversionsmatrix kompensiert Kapselabstand, Frequenzgang und Phasenfehler des jeweiligen Mikrofons. Hersteller-spezifische Matri­zen sind wichtig — nicht alle A-to-B-Tools passen zu allen Mikrofonen.

<ul class="wf-steps">
<li>A-Format-Rohdatei in REAPER importieren (4 / 19 / 32 Kanäle je nach Mikrofon)</li>
<li>Herstellerspezifisches A-to-B-Plugin einbinden: Sennheiser Ambeo Orbiter, SoundField Ambisonic Toolkit oder ICST JS-Plugin</li>
<li>Kanalzuordnung prüfen: W (Druck) auf Kanal 1, dann X, Y, Z gemäss ACN-Ordering</li>
<li>Kurzes Testsegment binaural abhören — stabile Richtung und kohärente Tiefe bestätigen</li>
<li>Ergebnis als ambiX WAV exportieren und Metadaten notieren (Mikrofon, Ort, Take-Nr.)</li>
</ul>

### Fieldrecording-Workflow

<table class="wf-table">
<thead><tr><th>Phase</th><th>Massnahme</th></tr></thead>
<tbody>
<tr><td>Vor der Aufnahme</td><td>Akustische Kartierung: Reflexionen, Störquellen, begehbare Hörzonen. Pegelcheck mit Testtönen.</td></tr>
<tr><td>Aufstellung</td><td>Mikrofonhöhe ca. 1.5 m für natürliche Hörperspektive. Keine nahebei Reflexionsflächen ohne Absicht.</td></tr>
<tr><td>Pegel</td><td>Zielpegel ca. −18 dBFS, 12 dB Headroom. Alle Rohkanäle separat monitoren.</td></tr>
<tr><td>Monitoring</td><td>Binaural über Kopfhörer während der Aufnahme. Räumliche Kohärenz und Windgeräusche prüfen.</td></tr>
<tr><td>Dokumentation</td><td>Direkt nach jeder Take: Ort, Mikrofonposition, Wetterbedingungen, Uhrzeit, Besonderheiten.</td></tr>
</tbody>
</table>

### Typische Probleme und Lösungen

<table class="wf-table">
<thead><tr><th>Problem</th><th>Ursache</th><th>Lösung</th></tr></thead>
<tbody>
<tr><td>Kanalvertauschung, instabile Richtung</td><td>Falsches ACN-Ordering</td><td>W/X/Y/Z-Zuordnung vor Ort mit Impuls testen</td></tr>
<tr><td>Kammfilter, räumliche Artefakte</td><td>Falsche oder fehlende A-to-B-Konversion</td><td>Spektrum prüfen, herstellerspezifische Matrix verwenden</td></tr>
<tr><td>Clipping auf einzelner Kapsel</td><td>Überlastung eines Kanals</td><td>Alle Rohkanäle separat metern</td></tr>
<tr><td>Windgeräusche, LF-Rumpeln</td><td>Fehlendes Windschutz-Setup</td><td>Doppelwindschutz, LF-Roll-off unter 80 Hz</td></tr>
</tbody>
</table>

---

<div class="wf-section">
<div class="wf-section__head">
  <span class="wf-section__num">02</span>
  <h2 class="wf-section__title">Produktion & Mixing</h2>
</div>
<div class="wf-section__meta">
  <span>Session-Setup</span><span>Routing</span><span>Encoding</span><span>Spatial Mixing</span><span>Monitoring</span>
</div>
</div>

### Session-Architektur in REAPER

Eine saubere Ambisonics-Session hat eine klare Hierarchie:

```
Quell-Tracks (Mono / Stereo / A-Format)
   └→ ICST AmbiEncoder (Encoding + Panning)
        └→ HOA-Bus (B-Format, N Kanäle)
             ├→ Decoder-Track → Lautsprecher-Output
             └→ B-Format-Master → Export
```

<div class="wf-key">
<p class="wf-key__title">Grundregel: Signalfluss nie am HOA-Bus vorbei</p>
<p>Kein direkter Source-to-Master-Pfad. Jede Quelle läuft durch den AmbiEncoder — sonst klingt der Binaural-Render anders als das Lautsprecher-Setup.</p>
</div>

### Routing Schritt für Schritt

<ul class="wf-steps">
<li>HOA-Bus anlegen: Kanalzahl gemäss gewünschter Ordnung (4 / 9 / 16 / 25 / 36 Kanäle)</li>
<li>ICST AmbiEncoder auf jeden Quell-Track: Azimut, Elevation, Breite einstellen</li>
<li>Encoder-Output auf HOA-Bus routen — nie direkt auf Master</li>
<li>ICST AmbiDecoder am Ende der Kette: Lautsprecherlayout-Preset laden</li>
<li>Separaten Binaural-Branch aufbauen: AmbiHeadphone auf eigenem Monitoring-Track</li>
<li>B-Format-Master als separaten Render-Track (ohne Decoder) vorbereiten</li>
</ul>

### Spatial Mixing — Räumliche Parameter

| Parameter | Tool | Wofür |
|---|---|---|
| **Azimut / Elevation** | AmbiEncoder GUI oder Automation | Grundposition und Bewegung |
| **Breite (Spread)** | AmbiEncoder → Width | Punktquelle vs. diffuse Wolke |
| **Tiefe / Distanz** | Pegel + Pre-Fader-Reverb im HOA-Domain | Near/Far-Illusion |
| **Rotation** | AmbiTransformer oder OSC | Szenen-Rotation, Kompass-Ausrichtung |
| **FX im HOA-Domain** | FX-Plugins nach dem Encoder, vor dem Decoder | Raumklang, der die gesamte Szene färbt |

### Raumklang und FX

Halleffekte und Raumklang **nach dem Encoder und vor dem Decoder** platzieren — nicht auf einzelnen Quell-Tracks. So bleibt der Raumklang formatunabhängig und wird mit dem B-Format-Master korrekt exportiert.

Typische Kette für einen HOA-Reverb:

```
Quell-Track → AmbiEncoder → [HOA FX: SN3D-konformer Reverb] → HOA-Bus → Decoder
```

### Monitoring

<div class="wf-warn">
<p class="wf-warn__title">⚠ Binaural und Lautsprecher nie gleichzeitig</p>
<p>Laufen Binaural-Decoder und Lautsprecher-Decoder parallel, phasieren sie sich gegenseitig aus. Monitoring-Branches als exklusive Sends aufbauen.</p>
</div>

- **Binaural:** AmbiHeadphone auf dediziertem Monitor-Track, Solo-Routing.
- **Lautsprecher:** ICST AmbiDecoder mit dem Preset des aktuellen Raums.
- **Preset-Wechsel:** Nur den Decoder austauschen — der HOA-Bus bleibt unverändert.

### HOA-Ordnung wählen

| Ordnung | Kanäle | Empfehlung |
|---:|---:|---|
| 1st | 4 | Binaural-Produktion, Lehre, FOA-Aufnahmen |
| 3rd | 16 | Standard für HOA-Produktionen und mittlere Arrays |
| 5th | 36 | Grosse Arrays, hohe Richtungsauflösung |
| 7th | 64 | Wissenschaftliche Referenz, max. Auflösung |

---

<div class="wf-section">
<div class="wf-section__head">
  <span class="wf-section__num">03</span>
  <h2 class="wf-section__title">Delivery & Export</h2>
</div>
<div class="wf-section__meta">
  <span>B-Format-Master</span><span>Formate</span><span>Binaural Render</span><span>Plattformen</span>
</div>
</div>

### Goldene Regel: Immer vom B-Format-Master rendern

<div class="wf-key">
<p class="wf-key__title">Nicht vom Decoder-Output rendern</p>
<p>Der Decoder-Output ist lautsprecherspezifisch — er passt nur zu einem bestimmten Array. Der B-Format-Master ist format- und raumunabhängig und bleibt für alle zukünftigen Decoder verwendbar.</p>
</div>

### Export-Workflow

<ul class="wf-steps">
<li>B-Format-Master-Track solo schalten und alle anderen Outputs deaktivieren</li>
<li>Kurze Test-Datei (ca. 10 s) rendern und re-importieren</li>
<li>Test-Datei über Binaural-Pfad abhören — räumliche Kohärenz bestätigen</li>
<li>Vollständigen Render starten: WAV / RF64 bei grossen Multichannel-Dateien</li>
<li>Metadaten in den Project Notes dokumentieren</li>
</ul>

**Empfohlener Meta-Text für REAPER Project Notes:**

```text
Render: B-Format Master | Format: ambiX (ACN/SN3D) | SR: 48000 Hz | Bit: 32-bit float | Channels: 16 | HOA: 3rd | Monitoring: Binaural ✓ / Array ✓
```

### Format-Entscheidungen

<table class="wf-table">
<thead><tr><th>Situation</th><th>Format</th><th>Begründung</th></tr></thead>
<tbody>
<tr><td>Neues Archiv-Master</td><td>ambiX (ACN/SN3D), multichannel WAV/RF64</td><td>Standardkonvention, maximale Kompatibilität mit allen HOA-Tools</td></tr>
<tr><td>Binaural-Delivery (Streaming, Preview)</td><td>2-Kanal WAV, 48 kHz / 24-bit</td><td>Universell abspielbar, HRTF-Auswahl dokumentieren</td></tr>
<tr><td>Lautsprecher-Stems für Aufführung</td><td>N-Kanal WAV, Kanalzahl = Array-Grösse</td><td>Decoder-Preset und Lautsprecher-Layout mitliefern</td></tr>
<tr><td>Älteres Legacy-System (FuMa)</td><td>FuMa (W/X/Y/Z, MaxN-Normalisierung)</td><td>Nur wenn Tool explizit FuMa erfordert</td></tr>
<tr><td>YouTube 360 / VR-Plattform</td><td>Binaural-Stereo + Spatial Metadata</td><td>Spatial Media Metadata Tool (Google) nach Plattform-Anforderung prüfen</td></tr>
</tbody>
</table>

### Kanalzahl nach HOA-Ordnung

| Ordnung | Kanäle | Formel |
|---:|---:|---|
| 1st (FOA) | 4 | `(1+1)²` |
| 2nd | 9 | `(2+1)²` |
| 3rd | 16 | `(3+1)²` |
| 5th | 36 | `(5+1)²` |
| 7th | 64 | `(7+1)²` |

### Export-Checkliste

<ul class="wf-checklist">
<li>B-Format-Master-Track als Source bestätigt</li>
<li>Kanalzahl zur HOA-Ordnung passend</li>
<li>Sample Rate: 48 kHz</li>
<li>Bit Depth: 32-bit float (Master) oder 24-bit (Delivery)</li>
<li>Format: ambiX (ACN/SN3D) dokumentiert</li>
<li>Dateiname enthält Ordnung und Format</li>
<li>Test-Render vor dem vollständigen Export</li>
<li>Re-Import und Binaural-Check bestanden</li>
<li>Project Notes aktualisiert</li>
<li>B-Format-Archiv-Kopie gesichert</li>
</ul>

---

<div class="wf-section">
<div class="wf-section__head">
  <span class="wf-section__num">04</span>
  <h2 class="wf-section__title">Live-Performance & Installation</h2>
</div>
<div class="wf-section__meta">
  <span>System-Design</span><span>Echtzeit-Decoding</span><span>Max/MSP</span><span>OSC</span><span>Robustheit</span>
</div>
</div>

### Kernfrage: Wo wird decodiert?

Die wichtigste Entscheidung bei Live-HOA-Systemen ist die **Decoder-Platzierung**:

<table class="wf-table">
<thead><tr><th>Setup</th><th>Vorteile</th><th>Risiken</th></tr></thead>
<tbody>
<tr><td>Laptop on Stage (Performer decodiert)</td><td>Direkte Kontrolle, flexible Raumreaktionen</td><td>Single point of failure, Latenzbudget begrenzt</td></tr>
<tr><td>FOH-System decodiert</td><td>Trennung von Performance und Regie, bewährte Infrastruktur</td><td>Kommunikation kritisch, B-Format-Streaming nötig</td></tr>
<tr><td>Dedizierter Render-Rechner</td><td>Stabilste Lösung, Performer unabhängig</td><td>Synchronisation, Netzwerk-Setup</td></tr>
</tbody>
</table>

### System-Design nach Kontext

<table class="wf-table">
<thead><tr><th>Kontext</th><th>Prioritäten</th><th>Empfohlene Tools</th></tr></thead>
<tbody>
<tr><td>Konzert / Bühne</td><td>Latenz · Robustheit · FOH-Kompatibilität</td><td>REAPER + ICST Decoder · Backup-Binaural-Mix</td></tr>
<tr><td>Club / Electronic</td><td>Echtzeit-Panning · Beat-Sync · Interaktion</td><td>Max/MSP + OSC + Ableton Link</td></tr>
<tr><td>Galerie / Installation</td><td>Dauerbetrieb · Sensorik · mehrere Zonen</td><td>Max/MSP + Binaural-Stationen</td></tr>
<tr><td>Hybrid Studio/Live</td><td>Produktion + Performance kombinieren</td><td>REAPER als Recorder · Max als Spatializer</td></tr>
</tbody>
</table>

### Max/MSP für Live-HOA

<ul class="wf-steps">
<li>Externals laden: <code>ambiencode~</code>, <code>ambidecode~</code>, <code>ambipanning~</code> aus den ICST Max-Tools</li>
<li>Generatives Panning: <code>drunk</code>, <code>noise~</code> oder <code>cycle~</code> auf Azimut- und Elevation-Eingänge</li>
<li>OSC-Routing: Raumparameter über Netzwerk (Tablet, Sensor, externe Software) steuern</li>
<li>Lautsprecher-Preset in <code>ambidecode~</code> laden und Testton durch alle Positionen schicken</li>
<li>Dauerbetrieb testen: Patch muss stundenlang ohne Speicherleck oder Absturz laufen</li>
<li>Backup-Patch bereithalten: bei Array-Ausfall auf Binaural-Stereo switchen</li>
</ul>

### OSC-Steuerung

OSC-Nachrichten an den ICST AmbiEncoder ermöglichen Echtzeit-Positionierung von aussen — über Tablet, Sensor, andere Software oder ein zweites Gerät.

Wichtige Vorbereitung:
- OSC-Port und Message-Namespace im REAPER-Template dokumentieren.
- Latenz testen: OSC over UDP ist unbestätigt, kritische Nachrichten ggf. bestätigt senden.
- Fallback: Automations-Lanes in REAPER als Backup wenn OSC ausfällt.

→ Vollständige OSC-Syntax: [OSC Syntax für den ICST AmbiEncoder](/de/icst-ambisonics-plugins/osc-syntax/)

### Irregular Arrays und AllRADecoder

Bei unregelmässigen Lautsprecher-Layouts (nicht sphärisch, asymmetrisch) bietet der **AllRADecoder** aus der [IEM Plugin Suite](https://plugins.iem.at/) eine flexiblere Lösung als der ICST-Decoder. Workflow:

- Lautsprecherpositionen in AllRADecoder eingeben und Decoder-Matrix berechnen.
- Matrix als Preset exportieren und im Live-Patch laden.
- Immer mit dem realen Setup einmessen, nicht nur simulieren.

---

## Schnell-Referenz: Entscheidungsbaum

<table class="wf-table">
<thead><tr><th>Situation</th><th>Entscheidung</th></tr></thead>
<tbody>
<tr><td>Neue Produktion, welches Format?</td><td>ambiX (ACN/SN3D) · Ordnung je nach Endformat und Mikrofon</td></tr>
<tr><td>Datei öffnen, unbekanntes Format?</td><td>Kanalzahl prüfen → Formel (N+1)² → Ordering-Tag in Header lesen</td></tr>
<tr><td>Export vorbereiten?</td><td>B-Format-Master-Track solo · Test-Render · Re-Import · Binaural-Check</td></tr>
<tr><td>FuMa-Datei weiterverwenden?</td><td>Erst mit ambiX-Konverter umwandeln, dann in Session integrieren</td></tr>
<tr><td>Live-Setup, Array fällt aus?</td><td>Auf Binaural-Stereo-Backup switchen — vorher einrichten</td></tr>
<tr><td>Monitoring klingt komisch?</td><td>Prüfen: Binaural- und Lautsprecher-Decoder parallel aktiv?</td></tr>
</tbody>
</table>

---

## Weiterführende Ressourcen

<div class="wf-resources">
  <a class="wf-resource-link" href="/de/icst-ambisonics-plugins/15_best_practices/">Best Practices<strong>Setup-Regeln, Routing, Monitoring, Export</strong></a>
  <a class="wf-resource-link" href="/de/learn/ambisonics-formats/">Ambisonics-Formate<strong>A-Format · B-Format · ambiX · FuMa · ACN/SN3D</strong></a>
  <a class="wf-resource-link" href="/de/icst-ambisonics-plugins/12_render_bformat/">B-Format rendern<strong>Export-Guide für REAPER</strong></a>
  <a class="wf-resource-link" href="/de/learn/working-with-ambisonics-workshop/">Advanced Workshop<strong>4-Stunden Workshop: Audit · Aufnahme · Komposition</strong></a>
  <a class="wf-resource-link" href="/de/icst-ambisonics-plugins/">ICST Plugins Docs<strong>Plugin-Dokumentation für REAPER und Max/MSP</strong></a>
  <a class="wf-resource-link" href="https://plugins.iem.at/">IEM Plugin Suite<strong>AllRADecoder · BinauralDecoder · weitere HOA-Tools</strong></a>
  <a class="wf-resource-link" href="https://cabbageaudio.com/">Cabbage Audio<strong>Csound als VST3/AU für algorithmische HOA-Komposition</strong></a>
  <a class="wf-resource-link" href="https://www.openairlib.net/">OpenAIR / SOFA-HRTF<strong>HRTF-Dateien für binaurale Renderer</strong></a>
</div>
