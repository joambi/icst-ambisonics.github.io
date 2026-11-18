---
title: ICST AmbiEncoder – Spiral Walk Script
description: "Dokumentiert das Spiral Walk ReaScript mit Installation, GUI-Parametern und Envelope-Generierung für Spiralen."
date: 2025-07-17T14:31:00
year: 2025
month: 2025-07
weight: 8
tags: ["ambiencoder", "automation", "lua", "reaper"]
key_points:
  - "Spiral-Walk-ReaScript installieren und Spiralbewegungs-Envelopes in REAPER erzeugen"
  - "GUI-Parameter und LFO-Logik des Spiral-Algorithmus verstehen"
difficulty: "advanced"
post_kind: "tutorial"
tool: ["AmbiEncoder", "Lua"]
---

## ICST AmbiEncoder_64 Spiral Walk - Dokumentation

**Level:** Advanced | **Zielgruppe:** ReaScript-User, Technical Artist.

### 🔍 **Funktion**

Dieses ReaScript generiert Spiralbewegungen (z.B. expandierende Spiralen) für die X-, Y- und optional Z-Koordinaten des VST3 "ICST AmbiEncoder_64" in REAPER. Es erlaubt dir, Bewegungsverläufe auf Basis von Startpositionen deiner Punkte zu erzeugen und automatisch als Envelope einzufügen. Das Ganze erfolgt grafisch via ReaImGui mit einstellbaren Parametern und Preset-Speicher.

<figure data-gen="g23" style="margin:1.8rem 0">
<svg viewBox="0 0 720 312" role="img" aria-label="Spiral Walk: eine wachsende Spirale ab der Startposition jedes Punkts wird als X/Y/Z-Envelopes geschrieben" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ard4" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><circle cx="135" cy="150" r="100" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><polyline points="140.0,150.0 140.6,149.3 141.0,148.5 141.4,147.6 141.6,146.6 141.6,145.5 141.5,144.3 141.2,143.1 140.6,141.9 139.9,140.8 139.0,139.7 137.9,138.7 136.6,137.8 135.1,137.1 133.5,136.6 131.8,136.3 130.0,136.2 128.1,136.4 126.2,136.8 124.3,137.5 122.4,138.5 120.6,139.7 118.9,141.2 117.5,143.0 116.1,145.0 115.1,147.2 114.3,149.6 113.8,152.1 113.6,154.8 113.7,157.5 114.2,160.2 115.1,163.0 116.3,165.7 117.9,168.2 119.9,170.6 122.2,172.8 124.8,174.7 127.6,176.4 130.8,177.7 134.1,178.6 137.6,179.1 141.1,179.2 144.8,178.8 148.4,178.0 152.0,176.7 155.4,174.9 158.7,172.7 161.7,170.0 164.5,167.0 166.9,163.6 168.8,159.8 170.4,155.8 171.4,151.6 171.9,147.2 171.9,142.6 171.4,138.1 170.2,133.6 168.5,129.1 166.2,124.9 163.4,120.9 160.1,117.2 156.3,113.9 152.1,111.1 147.5,108.7 142.6,107.0 137.4,105.8 132.0,105.2 126.6,105.3 121.1,106.0 115.7,107.4 110.4,109.5 105.4,112.3 100.7,115.7 96.3,119.7 92.4,124.2 89.1,129.2 86.4,134.7 84.3,140.5 82.9,146.6 82.3,152.9 82.4,159.3 83.3,165.7 85.0,172.0 87.5,178.2 90.8,184.0 94.7,189.5 99.3,194.5 104.6,199.0 110.4,202.8 116.7,205.9 123.5,208.3 130.5,209.9 137.7,210.6 145.0,210.4 152.4,209.4 159.6,207.4 166.6,204.6 173.2,200.9 179.5,196.4 185.2,191.1 190.3,185.1 194.6,178.5 198.2,171.4 200.9,163.8 202.6,155.9 203.5,147.7 203.3,139.4 202.1,131.2 199.9,123.0 196.8,115.2 192.6,107.7 187.6,100.6 181.7,94.2 175.0,88.5 167.6,83.6 159.7,79.6 151.2,76.6 142.3,74.6 133.3,73.7 124.0,73.8 114.8,75.1 105.8,77.5 97.0,81.0 88.7,85.5 80.9,91.1 73.8,97.6 67.4,105.0 62.0,113.1 57.5,121.9 54.1,131.2 51.9,141.0 50.8,151.0 50.9,161.2 52.3,171.3 54.8,181.3 58.6,190.9 63.6,200.1 69.7,208.7 76.8,216.6 84.8,223.6 93.7,229.6 103.3,234.5 113.5,238.3 124.2,240.8 135.1,242.1 146.2,242.0 157.3,240.6 168.2,237.8 178.7,233.8 188.8,228.4 198.2,221.9 206.8,214.2 214.5,205.5 221.1,195.9 226.5,185.4 230.7,174.4 233.5,162.8 234.9,151.0" fill="none" stroke="#4a8fe0" stroke-width="2.2"/><circle cx="135" cy="150" r="5" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="135" y="172" text-anchor="middle" font-size="10"></text><line x1="135" y1="150" x2="105" y2="210" stroke="#d9534f" stroke-width="1.2" opacity="1"/><text x="135" y="272" text-anchor="middle" fill="#d9534f" font-size="10">Startposition (von jedem Punkt gelesen)</text><text x="135" y="28" text-anchor="middle" font-size="11">Draufsicht</text><text x="135" y="290" text-anchor="middle" font-size="10">Mindestradius 0.1</text><rect x="340" y="24" width="360" height="50" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="520" y="46" text-anchor="middle" font-weight="600" font-size="13">Zeitauswahl in REAPER</text><text x="520" y="63" text-anchor="middle" font-size="11">auf der Spur mit AmbiEncoder_64</text><line x1="520" y1="76" x2="520" y2="100" stroke="currentColor" stroke-width="1.8" opacity="1" marker-end="url(#ard4)"/><rect x="340" y="102" width="360" height="92" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="520" y="126" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="13">Spiral Walk (ReaImGui-GUI)</text><text x="520" y="146" text-anchor="middle" font-size="11">Schritte · Radiuslimit · Spread · Geschwindigkeit</text><text x="520" y="162" text-anchor="middle" font-size="11">Z-Achse ein / aus und skaliert</text><text x="520" y="178" text-anchor="middle" font-size="11">Presets (speichern, laden, löschen)</text><line x1="520" y1="196" x2="520" y2="220" stroke="currentColor" stroke-width="1.8" opacity="1" marker-end="url(#ard4)"/><rect x="340" y="222" width="360" height="56" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="520" y="246" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="13">X / Y (/ Z) Envelopes</text><text x="520" y="264" text-anchor="middle" font-size="11">des ICST AmbiEncoder_64</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Spiral Walk startet an der aktuellen Position jedes Punkts und schreibt die Spirale als X-, Y- (und optional Z-)Envelopes über die Zeitauswahl.</figcaption>
</figure>

DOWNLOAD ICST LuaScripts:
(Copy to /Reaper/Scripts)

- [ICST Spiral Walk.lua](https://e.pcloud.link/publink/show?code=XZmro6ZLP1Wyf6A0xL5fdX1tbfVjyhpaE7X)

---

### ⚖️ **Features**

- Startposition der Punkte wird dynamisch ausgelesen
- Spiralbewegung mit Schrittzahl, Radiuslimit, Spread, Geschwindigkeit
- Z-Achse kann ein-/ausgeschaltet und skaliert werden
- GUI mit ReaImGui
- Presetverwaltung (Save, Load, Delete)
- Speicherort für Presets auswählbar (JSON-Datei)

---

### 🔧 **Installation & Setup**

1. **Voraussetzungen:**
    - REAPER installiert
    - VST3-Plugin [**ICST AmbiEncoder_64**](https://ambisonics.ch/icst-ambisonics-plugins/02_installation/) muss auf Track geladen sein
    - ReaImGui Extension (https://github.com/cfillion/reaimgui) installiert
2. **Script-Speicherung:**
    - Kopiere das Script in einen beliebigen Ordner z.B. `Scripts/ICST_AMBI/`
    - Speichere die Datei z.B. als `ICST AmbiEncoder_64 Spiral Walk.lua`
3. **Einbindung in REAPER:**
    - REAPER > Actions > Show Action List
    - "Load ReaScript" > wähle die `.lua`-Datei aus
    - Mit [Add] zum Action List hinzufügen
4. **Verwendung:**
    - Selektiere einen Track mit geladenem `ICST AmbiEncoder_64`
    - Wähle im Arrange-Fenster eine Zeit-Selection
    - Starte das Script
    - Stelle Parameter im GUI ein (z.B. Schritte, Radius, Spread)
    - Klicke auf "Spiral Walk ausführen"
5. **Preset-Verwaltung:**
    - Preset-Namen eingeben > Speichern
    - Preset auswählen > Laden oder Löschen
    - Speicherort für JSON-Datei im GUI änderbar

---
### 📊 **Analyse & Technik**

- Parameter-Mapping basiert auf Screenshot-Anordnung: jeder Punkt nutzt 3 Parameter (X, Y, Z)
- Die Spiralbewegung wird mathematisch generiert (∅ Radius + Spread, θ Winkel)
- Normierte Werte werden auf 0-1 skaliert und in Envelopes geschrieben
- Z-Werte werden konstant gehalten oder skaliert wiederholt

---
### ❓ Tipps & Hinweise

- Achte darauf, dass du im richtigen Zeitbereich arbeitest (Reaper Timeline Selection)
- Die Spiralbewegung basiert auf Startposition jedes Punktes
- Der Skalierungsfaktor für Z hat keinen Einfluss, wenn Z deaktiviert ist
- Min Radius < 0.1 ist nicht erlaubt (Verhinderung unphysikalischer Spiralen)

<p class="ai-credit" style="font-size:.85em;opacity:.7"><em>Diagramme und Erklärvideos mit Hilfe von Claude (Anthropic) erstellt. <a href="/de/about/#about-this-site">→</a></em></p>
