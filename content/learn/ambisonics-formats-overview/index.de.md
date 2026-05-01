---
title: "Ambisonics-Formate im Überblick"
description: "Visuelle Referenz zu Ambisonics-Formaten: A-Format vs. B-Format, FuMa vs. ambiX, FOA vs. HOA, Kanalzahlen und Normierungskonventionen — alles auf einen Blick."
date: 2026-05-01T00:00:00
draft: false
url: /de/ambisonics-101/formats/
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
  font-size: 1.05rem;
  margin-bottom: 1.8rem;
  line-height: 1.7;
}
.fmt-section {
  margin: 2.2rem 0;
}
.fmt-section h2 {
  font-size: 1.2rem;
  font-weight: 700;
  margin-bottom: 0.8rem;
  padding-bottom: 0.3rem;
  border-bottom: 2px solid #e0e0e0;
}
.fmt-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.93rem;
  margin: 0.6rem 0 1.2rem 0;
}
.fmt-table th {
  background: #f5f5f5;
  text-align: left;
  padding: 0.55rem 0.8rem;
  font-weight: 700;
  border-bottom: 2px solid #ccc;
}
.fmt-table td {
  padding: 0.5rem 0.8rem;
  border-bottom: 1px solid #e8e8e8;
  vertical-align: top;
  line-height: 1.5;
}
.fmt-table tr:last-child td { border-bottom: none; }
.fmt-table tr:hover td { background: #fafafa; }
.fmt-badge {
  display: inline-block;
  font-size: 0.78rem;
  font-weight: 700;
  padding: 0.15rem 0.5rem;
  border-radius: 3px;
  margin-left: 0.4rem;
}
.fmt-badge--icst { background: #d4edda; color: #155724; }
.fmt-badge--legacy { background: #fff3cd; color: #856404; }
.fmt-badge--raw { background: #cce5ff; color: #004085; }
.fmt-rule {
  background: #f0f7ff;
  border-left: 4px solid #6086b4;
  padding: 0.8rem 1rem;
  margin: 1rem 0;
  border-radius: 0 4px 4px 0;
  font-size: 0.95rem;
}
.fmt-links {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
  margin: 1.6rem 0 0.4rem 0;
}
.fmt-links a {
  font-size: 0.9rem;
  padding: 0.35rem 0.9rem;
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
      <td>ICST-Studio-Standard, große Lautsprecherarrays, hochwertige Archivierung</td>
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
      <td>✓ Standardmäßig verwenden</td>
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
      <td>Forschung, große Arrays</td>
    </tr>
    <tr>
      <td><strong>5</strong></td>
      <td>HOA-5</td>
      <td>36</td>
      <td>Sehr hoch</td>
      <td>Eigenmike em32, große Dome-Setups</td>
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

**Mehr Details:** [Ambisonics-Formate erklärt](/de/learn/ambisonics-formats/) — die vollständige technische Referenz mit allen Konventionen, ACN-Nummerierung und Archivierungs-Richtlinien.

**Zurück zu:** [Ambisonics 101](/de/ambisonics-101/)
