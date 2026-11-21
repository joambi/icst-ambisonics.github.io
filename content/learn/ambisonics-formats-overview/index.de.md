---
title: "Ambisonics-Formate erklärt: A-Format, B-Format, FuMa, ambiX, FOA und HOA"
description: "Praxisnahe Referenz zu Ambisonics-Formaten: A-Format, B-Format, FuMa, ambiX, ACN, SN3D, N3D, FOA, HOA, Kanalzahlen und ICST-Empfehlung — in Tabellen auf einen Blick."
date: 2026-05-01T00:00:00
draft: false
url: /de/learn/ambisonics-formats/
aliases:
  - /de/ambisonics-101/formats/
languageCode: de
tags:
  - ambisonics
  - b-format
  - ambix
  - hoa
  - formate
---

<style>
.fmt-intro {
  font-size: 1.55rem;
  margin-bottom: 2.2rem;
  line-height: 1.7;
}
.fmt-section {
  margin: 2.2rem 0;
}
.fmt-section h2 {
  font-size: 2.1rem;
  font-weight: 700;
  margin-bottom: 1.2rem;
  padding-bottom: 0.5rem;
  border-bottom: 2px solid #e0e0e0;
}
.fmt-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 1.45rem;
  margin: 1rem 0 1.8rem 0;
}
.fmt-table th {
  background: #f5f5f5;
  text-align: left;
  padding: 0.9rem 1.2rem;
  font-weight: 700;
  border-bottom: 2px solid #ccc;
}
.fmt-table td {
  padding: 0.9rem 1.2rem;
  border-bottom: 1px solid #e8e8e8;
  vertical-align: top;
  line-height: 1.55;
}
.fmt-table tr:last-child td { border-bottom: none; }
.fmt-table tr:hover td { background: #fafafa; }
.fmt-badge {
  display: inline-block;
  font-size: 1.15rem;
  font-weight: 700;
  padding: 0.2rem 0.7rem;
  border-radius: 3px;
  margin-left: 0.4rem;
}
.fmt-badge--icst { background: #d4edda; color: #155724; }
.fmt-badge--legacy { background: #fff3cd; color: #856404; }
.fmt-badge--raw { background: #cce5ff; color: #004085; }
.fmt-rule {
  background: #f0f7ff;
  border-left: 4px solid #6086b4;
  padding: 1.2rem 1.6rem;
  margin: 1.4rem 0;
  border-radius: 0 4px 4px 0;
  font-size: 1.5rem;
  line-height: 1.6;
}
.fmt-links {
  display: flex;
  gap: 1.2rem;
  flex-wrap: wrap;
  margin: 1.6rem 0 0.4rem 0;
}
.fmt-links a {
  font-size: 1.4rem;
  padding: 0.6rem 1.4rem;
  border: 1px solid #6086b4;
  border-radius: 4px;
  color: #6086b4;
  text-decoration: none;
}
.fmt-links a:hover { background: #6086b4; color: #fff; }

/* ── Dark mode ── */
html.theme--dark .fmt-section h2 {
  border-bottom-color: #3a3a3a;
}
html.theme--dark .fmt-table th {
  background: #1e1e1e;
  border-bottom-color: #3a3a3a;
}
html.theme--dark .fmt-table td {
  border-bottom-color: #2e2e2e;
}
html.theme--dark .fmt-table tr:hover td {
  background: #1a1a1a;
}
html.theme--dark .fmt-rule {
  background: rgba(96, 134, 180, 0.12);
  border-left-color: #6086b4;
  color: inherit;
}
html.theme--dark .fmt-badge--icst {
  background: #0d2b18;
  color: #6fcf97;
}
html.theme--dark .fmt-badge--legacy {
  background: #2e2200;
  color: #f0c040;
}
html.theme--dark .fmt-badge--raw {
  background: #001f3d;
  color: #7ec8e3;
}
html.theme--dark .fmt-links a {
  border-color: #6086b4;
  color: #8aadd4;
}
html.theme--dark .fmt-links a:hover {
  background: #6086b4;
  color: #fff;
}
.fmt-fig{margin:1.8rem 0}
.fmt-fig svg{width:100%;height:auto;max-width:720px;display:block}
.fmt-fig figcaption{font-size:1.3rem;opacity:.8;margin-top:.6rem}
</style>

<p class="fmt-intro">
Ambisonics verwendet das Wort <em>Format</em> gleichzeitig für verschiedene Dinge: das Rohsignal des Mikrofons, die Kodierungskonvention, die Kanalreihenfolge und die Normierung. Diese Seite stellt alles nebeneinander.
</p>

<div class="fmt-links">
  <a href="#uebersicht">Alle Formate</a>
  <a href="#a-vs-b">A vs. B-Format</a>
  <a href="#fuma-vs-ambix">FuMa vs. ambiX</a>
  <a href="#ordnungen">Ordnungen & Kanäle</a>
  <a href="#normierung">Normierung</a>
  <a href="#empfehlung">ICST-Empfehlung</a>
</div>

---

<div class="fmt-section" id="warum">

<div class="learn-box" style="border:1px solid var(--border-color,#8886);border-left:4px solid #4a8fe0;border-radius:8px;padding:.4rem 1.4rem;margin:1.6rem 0">

**Das lernst du**

- A-Format und B-Format unterscheiden
- Den Unterschied zwischen FuMa und ambiX (ACN/SN3D) kennen
- Kanalzahlen je Ordnung lesen
- Das passende Format für dein Projekt wählen

</div>

## Warum "Format" verwirrend ist

In Ambisonics bezeichnet **Format** mehrere unterschiedliche Dinge:

- das Rohsignal eines Mikrofons
- das interne räumliche Signal in einer DAW
- die Kanalreihenfolge in einer Datei
- die Normierung der Kugelflächenfunktionen
- die Ambisonics-Ordnung, die die Kanalzahl bestimmt

Darum ist die Frage "Ist das B-Format?" oft nicht genau genug. Praktischer ist:

> Ist das eine ambiX-B-Format-Datei mit ACN-Kanalreihenfolge und SN3D-Normierung, und welche Ordnung verwendet sie?

</div>

---

<div class="fmt-section" id="uebersicht">

## Alle Formate auf einen Blick

<table class="fmt-table">
  <thead>
    <tr>
      <th>Format</th>
      <th>Was es ist</th>
      <th>Kanäle</th>
      <th>Wo man es antrifft</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>A-Format</strong> <span class="fmt-badge fmt-badge--raw">Rohsignal</span></td>
      <td>Rohe Kapselsignale eines tetraedrischen Mikrofons — vor der räumlichen Kodierung</td>
      <td>4</td>
      <td>Direkt vom Mikrofon (Zoom H3-VR, Ambeo, Rode NT-SF1, …). Muss vor der DAW-Verwendung konvertiert werden.</td>
    </tr>
    <tr>
      <td><strong>B-Format FOA</strong></td>
      <td>Ambisonics-Szene erster Ordnung — 4 Kugelflächenfunktionen</td>
      <td>4</td>
      <td>Einfache Aufnahmen, ältere Archive, Einsteiger-Setups</td>
    </tr>
    <tr>
      <td><strong>B-Format HOA-3</strong></td>
      <td>Ambisonics dritter Ordnung — feinere räumliche Auflösung</td>
      <td>16</td>
      <td>Zylia ZM-1 Mikrofonausgabe, mittlere Produktionen</td>
    </tr>
    <tr>
      <td><strong>B-Format HOA-7</strong></td>
      <td>Ambisonics siebter Ordnung — maximale räumliche Auflösung</td>
      <td>64</td>
      <td>ICST-Studio-Standard, grosse Lautsprecherarrays, hochwertige Archivierung</td>
    </tr>
    <tr>
      <td><strong>FuMa</strong> <span class="fmt-badge fmt-badge--legacy">Legacy</span></td>
      <td>Ältere Kanalreihenfolge und Normierungskonvention (W, X, Y, Z / MaxN)</td>
      <td>4–36</td>
      <td>Ältere Plugins, historische Archive, manche First-Order-Workflows</td>
    </tr>
    <tr>
      <td><strong>ambiX</strong> <span class="fmt-badge fmt-badge--icst">ICST-Standard</span></td>
      <td>Moderne Konvention: ACN-Kanalreihenfolge + SN3D-Normierung</td>
      <td>4–64</td>
      <td>Alle aktuellen ICST-, IEM-, SPARTA- und modernen HOA-Werkzeuge</td>
    </tr>
  </tbody>
</table>

</div>

---

<div class="fmt-section" id="a-vs-b">

## A-Format vs. B-Format

<figure class="fmt-fig">
<svg viewBox="0 0 720 210" role="img" aria-label="A-Format: vier Kapselsignale werden in die B-Format-Kanäle W, X, Y, Z umgerechnet" xmlns="http://www.w3.org/2000/svg"><defs><marker id="ah1" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="90" y="22" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">A-Format (4 Kapseln)</text><circle cx="50" cy="62" r="26" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="50" y="67" text-anchor="middle" font-size="14" fill="currentColor">LF</text><circle cx="130" cy="62" r="26" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="130" y="67" text-anchor="middle" font-size="14" fill="currentColor">RF</text><circle cx="50" cy="132" r="26" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="50" y="137" text-anchor="middle" font-size="14" fill="currentColor">LB</text><circle cx="130" cy="132" r="26" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="130" y="137" text-anchor="middle" font-size="14" fill="currentColor">RB</text><line x1="150" y1="110" x2="250" y2="110" stroke="currentColor" stroke-width="1.5" marker-end="url(#ah1)"/><rect x="255" y="70" width="170" height="80" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="340.0" y="111.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">A→B-Umrechnung</text><text x="340.0" y="126.0" text-anchor="middle" font-size="12" fill="currentColor" fill-opacity=".75">Matrix + Filter</text><line x1="430" y1="110" x2="520" y2="110" stroke="currentColor" stroke-width="1.5" marker-end="url(#ah1)"/><text x="615" y="22" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">B-Format (FOA)</text><rect x="530" y="36" width="170" height="34" rx="8" stroke="#8a8a8a" fill="#8a8a8a" fill-opacity=".18" stroke-width="1.5"/><text x="615.0" y="58.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">W</text><rect x="530" y="76" width="170" height="34" rx="8" stroke="#d9534f" fill="#d9534f" fill-opacity=".18" stroke-width="1.5"/><text x="615.0" y="98.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">X</text><rect x="530" y="116" width="170" height="34" rx="8" stroke="#3fa968" fill="#3fa968" fill-opacity=".18" stroke-width="1.5"/><text x="615.0" y="138.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">Y</text><rect x="530" y="156" width="170" height="34" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".18" stroke-width="1.5"/><text x="615.0" y="178.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">Z</text></svg>
<figcaption>Von den Mikrofonkapseln zur B-Format-Szene: Die A→B-Umrechnung ist für jedes Mikrofon spezifisch.</figcaption>
</figure>

<table class="fmt-table">
  <thead>
    <tr>
      <th></th>
      <th>A-Format</th>
      <th>B-Format</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Was es enthält</strong></td>
      <td>Rohe Kapselsignale (mikrofonspezifisch)</td>
      <td>Räumliche Klangfeldrepräsentation (Kugelflächenfunktionen)</td>
    </tr>
    <tr>
      <td><strong>Kanäle (1. Ordnung)</strong></td>
      <td>4</td>
      <td>4 (FOA) bis 64 (HOA-7)</td>
    </tr>
    <tr>
      <td><strong>Zwischen Tools übertragbar?</strong></td>
      <td>Nein — an das Mikrofonmodell gebunden</td>
      <td>Ja — Standard-Austauschformat</td>
    </tr>
    <tr>
      <td><strong>Direkt decodierbar?</strong></td>
      <td>Nein — muss zuerst in B-Format konvertiert werden</td>
      <td>Ja — wird direkt dem Decoder oder Binaural-Renderer zugeführt</td>
    </tr>
    <tr>
      <td><strong>Typische Quelle</strong></td>
      <td>Ambisonics-Mikrofonausgang</td>
      <td>DAW-B-Format-Bus, Archivdatei, Encoder-Ausgang</td>
    </tr>
  </tbody>
</table>

<div class="fmt-rule">
  <strong>Praktische Regel:</strong> A-Format kommt vom Mikrofon und muss zuerst konvertiert werden. B-Format ist die räumliche Szene, die du routest, decodierst, archivierst und renderst.
</div>

</div>

---

<div class="fmt-section" id="fuma-vs-ambix">

## FuMa vs. ambiX

<figure class="fmt-fig">
<svg viewBox="0 0 720 230" role="img" aria-label="Kanalreihenfolge von Ambisonics erster Ordnung: FuMa W X Y Z gegenüber ambiX ACN W Y Z X, gleiche Komponenten mit Linien verbunden" xmlns="http://www.w3.org/2000/svg"><text x="10" y="55" font-size="14" font-weight="600" fill="currentColor">FuMa</text><text x="10" y="73" font-size="11" fill="currentColor" fill-opacity=".75">W X Y Z</text><text x="10" y="175" font-size="14" font-weight="600" fill="currentColor">ambiX</text><text x="10" y="193" font-size="11" fill="currentColor" fill-opacity=".75">ACN / SN3D</text><text x="10" y="22" font-size="12" fill="currentColor" fill-opacity=".8">Kanalposition (0 – 3)</text><text x="240" y="22" text-anchor="middle" font-size="12" fill="currentColor" fill-opacity=".8">0</text><rect x="190" y="34" width="100" height="44" rx="8" stroke="#8a8a8a" fill="#8a8a8a" fill-opacity=".18" stroke-width="1.5"/><text x="240.0" y="57.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">W</text><rect x="190" y="152" width="100" height="44" rx="8" stroke="#8a8a8a" fill="#8a8a8a" fill-opacity=".18" stroke-width="1.5"/><text x="240.0" y="179.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">W</text><text x="365" y="22" text-anchor="middle" font-size="12" fill="currentColor" fill-opacity=".8">1</text><rect x="315" y="34" width="100" height="44" rx="8" stroke="#d9534f" fill="#d9534f" fill-opacity=".18" stroke-width="1.5"/><text x="365.0" y="61.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">X</text><rect x="315" y="152" width="100" height="44" rx="8" stroke="#3fa968" fill="#3fa968" fill-opacity=".18" stroke-width="1.5"/><text x="365.0" y="179.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">Y</text><text x="490" y="22" text-anchor="middle" font-size="12" fill="currentColor" fill-opacity=".8">2</text><rect x="440" y="34" width="100" height="44" rx="8" stroke="#3fa968" fill="#3fa968" fill-opacity=".18" stroke-width="1.5"/><text x="490.0" y="61.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">Y</text><rect x="440" y="152" width="100" height="44" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".18" stroke-width="1.5"/><text x="490.0" y="179.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">Z</text><text x="615" y="22" text-anchor="middle" font-size="12" fill="currentColor" fill-opacity=".8">3</text><rect x="565" y="34" width="100" height="44" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".18" stroke-width="1.5"/><text x="615.0" y="61.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">Z</text><rect x="565" y="152" width="100" height="44" rx="8" stroke="#d9534f" fill="#d9534f" fill-opacity=".18" stroke-width="1.5"/><text x="615.0" y="179.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">X</text><line x1="240" y1="80" x2="240" y2="150" stroke="#8a8a8a" stroke-width="2" stroke-dasharray="0"/><text x="250" y="120" font-size="11" fill="currentColor" fill-opacity=".8">W ist 3 dB leiser</text><line x1="365" y1="80" x2="615" y2="150" stroke="#d9534f" stroke-width="2" stroke-dasharray="5 3"/><line x1="490" y1="80" x2="365" y2="150" stroke="#3fa968" stroke-width="2" stroke-dasharray="5 3"/><line x1="615" y1="80" x2="490" y2="150" stroke="#4a8fe0" stroke-width="2" stroke-dasharray="5 3"/><text x="360" y="222" text-anchor="middle" font-size="12" fill="currentColor" fill-opacity=".8">Gleiche Komponenten, andere Reihenfolge. In ambiX ist der W-Kanal nicht um 3 dB abgesenkt.</text></svg>
<figcaption>Kanalreihenfolge bei erster Ordnung: dieselben vier Komponenten in anderer Reihenfolge.</figcaption>
</figure>

<table class="fmt-table">
  <thead>
    <tr>
      <th></th>
      <th>FuMa <span class="fmt-badge fmt-badge--legacy">Legacy</span></th>
      <th>ambiX <span class="fmt-badge fmt-badge--icst">ICST-Standard</span></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Kanalreihenfolge</strong></td>
      <td>FuMa (W, X, Y, Z, …)</td>
      <td>ACN (0, 1, 2, 3, …)</td>
    </tr>
    <tr>
      <td><strong>Normierung</strong></td>
      <td>MaxN</td>
      <td>SN3D</td>
    </tr>
    <tr>
      <td><strong>Unterstützte Ordnungen</strong></td>
      <td>Hauptsächlich 1. Ordnung (einige Tools bis 3.)</td>
      <td>Alle Ordnungen bis HOA-7 und darüber hinaus</td>
    </tr>
    <tr>
      <td><strong>Wo man es findet</strong></td>
      <td>Ältere Plugins (z. B. klassische ATK-Versionen, Legacy-Archive)</td>
      <td>ICST, IEM, SPARTA, REAPER, moderne Export-Pipelines</td>
    </tr>
    <tr>
      <td><strong>Dateiformat</strong></td>
      <td>WAV (Standard-Mehrkanal)</td>
      <td>WAV oder RF64 (für Dateien > 4 GB)</td>
    </tr>
    <tr>
      <td><strong>ICST-Empfehlung</strong></td>
      <td>Nur wenn ein Tool es ausdrücklich verlangt</td>
      <td>✓ Standardmässig verwenden</td>
    </tr>
  </tbody>
</table>

<div class="fmt-rule">
  <strong>Im Zweifel:</strong> <code>ACN / SN3D</code> wählen — das ist ambiX, und genau das erwarten alle aktuellen ICST-Tools.
</div>

</div>

---

<div class="fmt-section" id="ordnungen">

## Ordnungen & Kanalzahlen

<figure data-gen="g20" style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Kanalzahlen der Ordnungen 1 bis 7 mit ihren ACN-Indexbereichen" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arx1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="360" y="24" text-anchor="middle" font-weight="600">Jede Ordnung enthält alle niedrigeren</text><text x="100" y="61" text-anchor="end" font-weight="600" fill="#4a8fe0" font-size="13">N = 1</text><rect x="120" y="44" width="35.0" height="26" rx="4" fill="#4a8fe0" fill-opacity=".3" stroke="#4a8fe0"/><text x="163.0" y="62" text-anchor="start" font-size="11.5">4 ch · ACN 0–3</text><text x="100" y="97" text-anchor="end" font-weight="600" fill="#4a8fe0" font-size="13">N = 2</text><rect x="120" y="80" width="78.8" height="26" rx="4" fill="#4a8fe0" fill-opacity=".3" stroke="#4a8fe0"/><text x="206.75" y="98" text-anchor="start" font-size="11.5">9 ch · ACN 0–8</text><text x="100" y="133" text-anchor="end" font-weight="600" fill="#3fa968" font-size="13">N = 3</text><rect x="120" y="116" width="140.0" height="26" rx="4" fill="#3fa968" fill-opacity=".3" stroke="#3fa968"/><text x="268.0" y="134" text-anchor="start" font-size="11.5">16 ch · ACN 0–15</text><text x="100" y="169" text-anchor="end" font-weight="600" fill="#d9a441" font-size="13">N = 5</text><rect x="120" y="152" width="315.0" height="26" rx="4" fill="#d9a441" fill-opacity=".3" stroke="#d9a441"/><text x="443.0" y="170" text-anchor="start" font-size="11.5">36 ch · ACN 0–35</text><text x="100" y="205" text-anchor="end" font-weight="600" fill="#d9534f" font-size="13">N = 7</text><rect x="120" y="188" width="560.0" height="26" rx="4" fill="#d9534f" fill-opacity=".3" stroke="#d9534f"/><text x="688.0" y="206" text-anchor="start" font-size="11.5">64 ch · ACN 0–63</text><text x="360" y="236" text-anchor="middle" font-size="11">Niedrigere Ordnungen sind die ersten Kanäle höherer Ordnungen.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Mit ACN-Nummerierung ist eine niedrigere Ordnung einfach der Anfang einer höheren. Die Ordnung reduzieren heisst Kanäle weglassen.</figcaption>
</figure>



Die Kanalzahl eines B-Format-Signals ergibt sich aus der Ambisonics-Ordnung:

**Kanäle = (Ordnung + 1)²**

<table class="fmt-table">
  <thead>
    <tr>
      <th>Ordnung</th>
      <th>Name</th>
      <th>Kanäle</th>
      <th>Räumliche Auflösung</th>
      <th>Typischer Einsatz</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>1</strong></td>
      <td>FOA</td>
      <td>4</td>
      <td>Grundlegend</td>
      <td>Einsteigeraufnahmen, einfache Setups, die meisten Ambisonics-Mikrofone</td>
    </tr>
    <tr>
      <td><strong>2</strong></td>
      <td>HOA-2</td>
      <td>9</td>
      <td>Mittel</td>
      <td>Mittlere Kompositionen, ältere HOA-Tools</td>
    </tr>
    <tr>
      <td><strong>3</strong></td>
      <td>HOA-3</td>
      <td>16</td>
      <td>Gut</td>
      <td>Zylia ZM-1 Ausgabe, Standard-HOA-Produktionen</td>
    </tr>
    <tr>
      <td><strong>4</strong></td>
      <td>HOA-4</td>
      <td>25</td>
      <td>Hoch</td>
      <td>Forschung, grosse Arrays</td>
    </tr>
    <tr>
      <td><strong>5</strong></td>
      <td>HOA-5</td>
      <td>36</td>
      <td>Sehr hoch</td>
      <td>Eigenmike em32, grosse Dome-Setups</td>
    </tr>
    <tr>
      <td><strong>6</strong></td>
      <td>HOA-6</td>
      <td>49</td>
      <td>Sehr hoch</td>
      <td>Spezialisierte Forschungsanwendungen</td>
    </tr>
    <tr>
      <td><strong>7</strong></td>
      <td>HOA-7</td>
      <td>64</td>
      <td>Maximum</td>
      <td><strong>ICST-Studio-Standard</strong> — 64-Kanal-B-Format-Bus in REAPER</td>
    </tr>
  </tbody>
</table>

<div class="fmt-rule">
  In REAPER verwendet der ICST-Workflow einen <strong>64-Kanal-B-Format-Bus</strong>. So gehen keine HOA-Kanäle unbemerkt verloren, unabhängig davon, mit welcher Ordnung du arbeitest.
</div>

</div>

---

<div class="fmt-section" id="normierung">

## Normierungskonventionen

<figure data-gen="g20" style="margin:1.8rem 0">
<svg viewBox="0 0 720 260" role="img" aria-label="Gain-Faktor zwischen SN3D- und N3D-Normierung je Ordnung" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arx2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="360" y="24" text-anchor="middle" font-weight="600">Gleiches Signal, unterschiedliche Skalierung je Ordnung n</text><line x1="100" y1="210" x2="680" y2="210" stroke="currentColor" stroke-width="1.2" opacity="1"/><rect x="150" y="162.0" width="40" height="48.0" fill="#4a8fe0" fill-opacity=".3" stroke="#4a8fe0"/><rect x="196" y="162.0" width="40" height="48.0" fill="#d9a441" fill-opacity=".3" stroke="#d9a441"/><text x="170" y="156" text-anchor="middle" fill="#4a8fe0" font-size="11">1</text><text x="216" y="156.0" text-anchor="middle" fill="#d9a441" font-size="11">1.00</text><text x="193" y="228" text-anchor="middle" font-weight="600" font-size="12">n = 0</text><rect x="280" y="162.0" width="40" height="48.0" fill="#4a8fe0" fill-opacity=".3" stroke="#4a8fe0"/><rect x="326" y="126.9" width="40" height="83.1" fill="#d9a441" fill-opacity=".3" stroke="#d9a441"/><text x="300" y="156" text-anchor="middle" fill="#4a8fe0" font-size="11">1</text><text x="346" y="120.86156123669389" text-anchor="middle" fill="#d9a441" font-size="11">1.73</text><text x="323" y="228" text-anchor="middle" font-weight="600" font-size="12">n = 1</text><rect x="410" y="162.0" width="40" height="48.0" fill="#4a8fe0" fill-opacity=".3" stroke="#4a8fe0"/><rect x="456" y="102.7" width="40" height="107.3" fill="#d9a441" fill-opacity=".3" stroke="#d9a441"/><text x="430" y="156" text-anchor="middle" fill="#4a8fe0" font-size="11">1</text><text x="476" y="96.66873708001009" text-anchor="middle" fill="#d9a441" font-size="11">2.24</text><text x="453" y="228" text-anchor="middle" font-weight="600" font-size="12">n = 2</text><rect x="540" y="162.0" width="40" height="48.0" fill="#4a8fe0" fill-opacity=".3" stroke="#4a8fe0"/><rect x="586" y="83.0" width="40" height="127.0" fill="#d9a441" fill-opacity=".3" stroke="#d9a441"/><text x="560" y="156" text-anchor="middle" fill="#4a8fe0" font-size="11">1</text><text x="606" y="77.00393706889965" text-anchor="middle" fill="#d9a441" font-size="11">2.65</text><text x="583" y="228" text-anchor="middle" font-weight="600" font-size="12">n = 3</text><rect x="490" y="34" width="170" height="40" rx="6" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1" opacity="0.4"/><rect x="502" y="45" width="14" height="14" fill="#4a8fe0" fill-opacity=".3" stroke="#4a8fe0"/><text x="522" y="57" text-anchor="start" font-size="12">SN3D</text><rect x="572" y="45" width="14" height="14" fill="#d9a441" fill-opacity=".3" stroke="#d9a441"/><text x="592" y="57" text-anchor="start" font-size="12">N3D</text><text x="360" y="248" text-anchor="middle" font-weight="600" font-size="12">N3D = SN3D × √(2n+1)</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">SN3D hält alle Ordnungen auf demselben Referenzpegel. N3D skaliert die Ordnung n um √(2n+1) hoch. Ohne Umrechnung gemischt verschiebt das die Balance zwischen den Ordnungen.</figcaption>
</figure>



Die Normierung legt fest, wie die Amplitude jeder Kugelflächenfunktion skaliert wird. Eine falsche Konvention zwischen Encoder und Decoder erzeugt ein fehlerhaftes räumliches Rendering — selbst wenn die Kanalreihenfolge stimmt.

<table class="fmt-table">
  <thead>
    <tr>
      <th>Konvention</th>
      <th>Vollständiger Name</th>
      <th>Verwendet in</th>
      <th>Hinweise</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>SN3D</strong> <span class="fmt-badge fmt-badge--icst">ICST-Standard</span></td>
      <td>Schmidt Semi-Normalised 3D</td>
      <td>ambiX, ICST, IEM, SPARTA, die meisten modernen HOA-Tools</td>
      <td>De-facto-Standard für Produktion und Austausch. Diesen verwenden.</td>
    </tr>
    <tr>
      <td><strong>N3D</strong></td>
      <td>Full 3D Normalised</td>
      <td>Einige Forschungstools, mathematische Kontexte</td>
      <td>Unterscheidet sich von SN3D durch einen konstanten Faktor pro Ordnung. Häufig in wissenschaftlicher Literatur.</td>
    </tr>
    <tr>
      <td><strong>MaxN</strong> <span class="fmt-badge fmt-badge--legacy">Legacy</span></td>
      <td>Maximum Normalised</td>
      <td>FuMa-Konvention</td>
      <td>Normiert jede Komponente auf ihren Spitzenwert. In älteren Systemen und Archiven verwendet.</td>
    </tr>
  </tbody>
</table>

</div>

---

<div class="fmt-section" id="szene">

## Szenenbasiert vs. kanalbasiert

<figure data-gen="g20" style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Kanalbasiertes gegenüber szenenbasiertem Audio" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arx3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="180" y="22" text-anchor="middle" font-weight="600" font-size="14">Kanalbasiert</text><text x="540" y="22" text-anchor="middle" font-weight="600" font-size="14">Szenenbasiert (Ambisonics)</text><line x1="360" y1="36" x2="360" y2="285" stroke="currentColor" stroke-width="1" opacity="0.25" stroke-dasharray="4 4"/><rect x="20" y="50" width="60" height="30" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="50" y="70" text-anchor="middle" font-size="11.5">Ch 1</text><rect x="20" y="90" width="60" height="30" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="50" y="110" text-anchor="middle" font-size="11.5">Ch 2</text><rect x="20" y="130" width="60" height="30" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="50" y="150" text-anchor="middle" font-size="11.5">Ch 3</text><rect x="120" y="70" width="70" height="70" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.5"/><text x="155" y="100" text-anchor="middle" font-size="11.5">Mix</text><text x="155" y="116" text-anchor="middle" font-size="10">für ein Layout</text><line x1="80" y1="65" x2="120" y2="85" stroke="currentColor" stroke-width="1.1" opacity="0.7"/><line x1="80" y1="105" x2="120" y2="95" stroke="currentColor" stroke-width="1.1" opacity="0.7"/><line x1="80" y1="145" x2="120" y2="105" stroke="currentColor" stroke-width="1.1" opacity="0.7"/><line x1="190" y1="105" x2="230" y2="150" stroke="currentColor" stroke-width="1.5" opacity="1" marker-end="url(#arx3)"/><circle cx="250" cy="170" r="7" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="290" cy="150" r="7" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="330" cy="170" r="7" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="260" cy="215" r="7" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="320" cy="215" r="7" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><text x="290" y="250" text-anchor="middle" font-size="11.5">5 feste Lautsprecher</text><text x="290" y="268" text-anchor="middle" font-size="10.5">Kanal 1 heisst: dieser Lautsprecher.</text><rect x="385" y="40" width="80" height="26" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="425" y="58" text-anchor="middle" font-size="11">Quelle 1</text><line x1="465" y1="53" x2="495" y2="97" stroke="currentColor" stroke-width="1" opacity="0.7"/><rect x="385" y="74" width="80" height="26" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="425" y="92" text-anchor="middle" font-size="11">Quelle 2</text><line x1="465" y1="87" x2="495" y2="97" stroke="currentColor" stroke-width="1" opacity="0.7"/><rect x="385" y="108" width="80" height="26" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="425" y="126" text-anchor="middle" font-size="11">Quelle 3</text><line x1="465" y1="121" x2="495" y2="97" stroke="currentColor" stroke-width="1" opacity="0.7"/><rect x="495" y="75" width="80" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="535" y="93" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="12">B-Format</text><text x="535" y="109" text-anchor="middle" font-size="10">Szene</text><line x1="535" y1="119" x2="535" y2="142" stroke="currentColor" stroke-width="1.2" opacity="0.5"/><line x1="535" y1="128" x2="605" y2="164" stroke="currentColor" stroke-width="1.2" opacity="0.8" marker-end="url(#arx3)"/><rect x="605" y="150" width="100" height="28" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="655" y="168" text-anchor="middle" font-size="11">Dom</text><line x1="535" y1="128" x2="605" y2="202" stroke="currentColor" stroke-width="1.2" opacity="0.8" marker-end="url(#arx3)"/><rect x="605" y="188" width="100" height="28" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="655" y="206" text-anchor="middle" font-size="11">Studio-Array</text><line x1="535" y1="128" x2="605" y2="240" stroke="currentColor" stroke-width="1.2" opacity="0.8" marker-end="url(#arx3)"/><rect x="605" y="226" width="100" height="28" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="655" y="244" text-anchor="middle" font-size="11">Kopfhörer</text><text x="535" y="278" text-anchor="middle" font-size="10.5">Eine Szene, für jedes System dekodiert.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Ein Kanal ist im kanalbasierten Audio ein Lautsprechersignal. In Ambisonics ist er eine Komponente des Schallfelds, und der Decoder entscheidet, wie die Szene jedes System erreicht.</figcaption>
</figure>



Ambisonics ist **szenenbasiert**: Die Kanäle sind keine Lautsprechersignale, sondern Komponenten einer räumlichen Klangfeldrepräsentation. Bei **kanalbasiertem** Audio dagegen bedeutet Kanal 1 linker Lautsprecher, Kanal 2 rechter Lautsprecher usw.

In Ambisonics entscheidet der Decoder, wie die Szene zu Lautsprechersignalen oder binauralem Output wird. Darum kann derselbe B-Format-Master für eine Kuppel, ein Oktagon, ein Studio-Array, Kopfhörer oder Stereo gerendert werden.

</div>

---

<div class="fmt-section" id="empfehlung">

## ICST-Empfehlung

<figure data-gen="g20" style="margin:1.8rem 0">
<svg viewBox="0 0 720 290" role="img" aria-label="ICST-Empfehlung: ein B-Format-Bus, nur beim Monitoring oder finalen Render dekodieren" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arx4" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="100" width="220" height="60" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="125" y="125" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="13">64-Kanal-B-Format-Bus</text><text x="125" y="145" text-anchor="middle" font-size="11">ambiX · ACN · SN3D</text><line x1="235" y1="130" x2="300" y2="46" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#arx4)"/><rect x="305" y="24" width="170" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="390" y="51" text-anchor="middle" font-weight="600" font-size="12">Lautsprecher-Decoding</text><line x1="235" y1="130" x2="300" y2="104" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#arx4)"/><rect x="305" y="82" width="170" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="390" y="109" text-anchor="middle" font-weight="600" font-size="12">Binaural-Monitor</text><line x1="235" y1="130" x2="300" y2="162" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#arx4)"/><rect x="305" y="140" width="170" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="390" y="167" text-anchor="middle" font-weight="600" font-size="12">Archiv-Export</text><line x1="235" y1="130" x2="300" y2="220" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#arx4)"/><rect x="305" y="198" width="170" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="390" y="225" text-anchor="middle" font-weight="600" font-size="12">Render für andere Systeme</text><text x="560" y="40" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="13">Dekodierung</text><line x1="520" y1="48" x2="490" y2="48" stroke="#3fa968" stroke-width="1.4" opacity="1" marker-end="url(#arx4)"/><text x="560" y="56" text-anchor="middle" font-size="11">passiert hier</text><text x="360" y="282" text-anchor="middle" font-size="11">Die Session offen halten: derselbe B-Format-Master speist jeden Ausgang.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Im ambiX-B-Format-Bus bleiben und erst am Ende dekodieren. Der Master bleibt für jedes künftige System offen.</figcaption>
</figure>



<div class="fmt-rule">
  <strong>Für alle neuen Ambisonics-Arbeiten:</strong><br>
  <strong>ambiX verwenden — ACN-Kanalreihenfolge + SN3D-Normierung</strong>.<br><br>
  In REAPER: über einen <strong>64-Kanal-B-Format-Bus</strong> routen.<br>
  Nur beim Monitoring oder beim finalen Rendering decodieren.
</div>

Das hält die Session offen: derselbe B-Format-Master kann für Lautsprecherdecoding, Binaural-Monitoring, Archivexport und späteres Rendering für jedes Wiedergabesystem verwendet werden.

</div>

---

<div class="fmt-section" id="checkliste">

## Checkliste: Welches Format soll ich verwenden?

**ambiX B-Format, ACN/SN3D**, wenn du eine neue Produktion beginnst, mit ICST, IEM, SPARTA oder anderen modernen HOA-Tools arbeitest, einen Archivmaster exportierst oder verlässlichen Austausch zwischen DAWs und Plugins brauchst.

**A-Format** nur für rohe Mikrofonaufnahmen, bei denen die herstellerspezifische A-zu-B-Konvertierung noch aussteht.

**FuMa** nur, wenn ein älteres Tool oder Archiv es verlangt oder du historisches First-Order-Material konvertierst.

Immer dokumentieren: Ordnung, Kanalzahl, Kanalreihenfolge, Normierung, Sample Rate und Bit Depth sowie den Decoder oder Renderer fürs Monitoring.

</div>

---

## Verwandte Seiten

- [Ambisonics 101](/de/ambisonics-101/)
- [ICST B-Format-Archiv](/de/blog/b-format-archive/)
- [ICST Encoders](/de/icst-ambisonics-plugins/10_icst_encoders/)
- [ICST Decoder](/de/icst-ambisonics-plugins/08_icst_decoder/)
- [B-Format in REAPER rendern](/de/icst-ambisonics-plugins/12_render_bformat/)
- [Welche Ambisonics-Ordnung brauche ich?](/de/post/hoa-ordnung-wahl-praxis/)
- [Erste Session in REAPER](/de/post/getting-started-icst-plugins-reaper/)
- [Glossar](/de/ambisonics-101/glossary/)
