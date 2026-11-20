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

Ambisonics ist **szenenbasiert**: Die Kanäle sind keine Lautsprechersignale, sondern Komponenten einer räumlichen Klangfeldrepräsentation. Bei **kanalbasiertem** Audio dagegen bedeutet Kanal 1 linker Lautsprecher, Kanal 2 rechter Lautsprecher usw.

In Ambisonics entscheidet der Decoder, wie die Szene zu Lautsprechersignalen oder binauralem Output wird. Darum kann derselbe B-Format-Master für eine Kuppel, ein Oktagon, ein Studio-Array, Kopfhörer oder Stereo gerendert werden.

</div>

---

<div class="fmt-section" id="empfehlung">

## ICST-Empfehlung

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
