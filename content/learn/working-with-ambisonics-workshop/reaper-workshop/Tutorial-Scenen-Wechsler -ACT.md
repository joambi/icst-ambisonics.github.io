---
categories:
  - ICST Ambisonics Workshop
---
---


**ICST Ambisonics Workshop 2026**  
Zielgruppe: fortgeschrittene Teilnehmende (Max/REAPER-Grundkenntnisse vorausgesetzt)

---

## Überblick

Das System besteht aus zwei Teilen, die über OSC (UDP Port 50010) kommunizieren:

|Teil|Beschreibung|
|---|---|
|**REAPER**|Zeit-Master – erzeugt Marker-Trigger via OSC|
|**ACT_Circle_Mover_Main** (Max)|Raum-Master – verwaltet Ambisonics-Positionen pro Scene|

Die zentrale Einheit auf der Max-Seite ist der Subpatcher **`p Scene_Mover`** – in diesem Tutorial auch „Scenen_Wechsler" genannt. Er nimmt die OSC-Nachrichten aus REAPER entgegen und steuert den ambimonitor.

---

## 1. ACT_Circle_Mover_Main – Architektur

Der Hauptpatch `ACT_Circle_Mover_Main.maxpat` (bzw. die Standalone-App `.app`) gliedert sich in folgende Subpatcher:

```
ACT_Circle_Mover_Main
├── p Scene_Mover       ← Scenen_Wechsler (diese Sektion)
├── p Ease_mover        ← Interpolation / Easing
├── p Trajectory        ← automatische Trajektorien
├── p Circle_Spiral     ← Kreis- / Spiralbewegung
├── p Circle_random     ← Zufallsbewegung
├── p Circle_Oval       ← Ovalbewegung
├── p Manuell           ← manuelle XYZ-Eingabe
└── p Laurenz           ← (weiterer Modus)
```

OSC-Ausgang: `udpsend 127.0.0.1 50001` … `udpsend 127.0.0.1 50008`  
→ je eine Verbindung zu einem ICST AmbiEncoder-Plugin in der DAW.

---

## 2. Der Scenen_Wechsler (p Scene_Mover)

### 2.1 Was er macht

Der `Scene_Mover`-Subpatcher ist das Herzstück der zeitgesteuerten Raumpositionierung:

- **Speichert** Snapshots der Ambimonitor-Positionen (XYZ aller Quellen) unter einem Scene-Namen
- **Erinnert** sich an die Dauer (Duration in ms) pro Scene
- **Fährt** auf Befehl alle Quellen interpoliert zu den gespeicherten Positionen
- **Empfängt** OSC-Befehle von REAPER auf Port `50010`

### 2.2 Benutzeroberfläche

Im Presentation-Mode zeigt der Hauptpatch folgende Elemente des Scene_Movers:

```
[ 1 ] [ 2 ] [ 3 ]    ← Scene-Buttons (direktes Abrufen)
[ 4 ] [ 5 ] [ 6 ]
[  umenu ▼ ]         ← Dropdown: alle gespeicherten Scenes
[ store Scene_1 ]    ← Speichert aktuelle Ambimonitor-Position als Scene
[ remove_all ]       ← Löscht alle gespeicherten Scenes
[ read ] [ write ]   ← Lädt / speichert snapshots.xml
```

Die `live.line`-Objekte visualisieren die Interpolationsbewegung (Duration).

### 2.3 Snapshot-Format (snapshots.xml)

Scenes werden in `snapshots.xml` gespeichert. Jeder Snapshot enthält die XYZ-Koordinaten aller Quellen (normiert, d. h. Einheitskugel ± Distanz):

xml

```xml
<ambiscore>
  <snapshot index="Scene_1">
    <point>
      <number>1</number>
      <xyz>-0.470573 -0.713237 0.000000</xyz>
    </point>
    <point>
      <number>2</number>
      <xyz>0.418915 -0.728489 0.007626</xyz>
    </point>
    <!-- weitere Quellen … -->
  </snapshot>
</ambiscore>
```

### 2.4 Interne OSC-Verarbeitung

Der `udpreceive 50010` im Scene_Mover routet eingehende Nachrichten:

|OSC-Adresse|Typ|Bedeutung|
|---|---|---|
|`/act/scene/target`|string|Wählt die Scene an (noch kein Start)|
|`/act/scene/setduration`|int (ms)|Setzt die Interpolationsdauer|
|`/act/scene/store`|string|Speichert aktuelle Position als Scene|
|`/act/scene/start`|int float string|Legacy: feuert eine Scene (ohne Dauer)|
|`/act/scene/interval`|int float int float int|Playback-Trigger mit Zeitberechnung|

**Wichtig:** `/act/scene/interval` ist die Haupt-Nachricht beim Playback. Sie enthält:  
`marker1_index marker1_pos marker2_index marker2_pos diff_ms`

Der `diff_ms`-Wert wird direkt als Duration der Scene verwendet.

---

## 3. ACT_Circle_Mover.app – Standalone-Version

### 3.1 Was ist die .app?

`ACT_Circle_Mover_Main.app` ist die **kompilierte Standalone-Version** desselben Patches. Sie läuft ohne Max-Entwicklungsumgebung – nur das Bundle muss vorhanden sein.

Vorteil: kein Max-Lizenz-Login nötig, direkt doppelklicken und starten.

### 3.2 Starten

1. `ACT_Circle_Mover_Main.app` doppelklicken
2. macOS fragt ggf. nach Netzwerkzugang → **Erlauben** (für UDP Port 50010)
3. Die App öffnet sich im Presentation-Mode (keine Patcher-Ansicht)
4. In der Max Console (Menü: `Window → Max Console`) sollte erscheinen:

```
   udpreceiver binding to port 50010
```

### 3.3 Presentation-View der App

Die App zeigt denselben Presentation-Mode wie der Patch. Sichtbar sind u. a.:

- **ambimonitor** – interaktive 3D-Ansicht der Klangquellen
- **Scene-Buttons 1–6** – direktes Abrufen gespeicherter Scenes
- **Ease_mover**-Toggle – schaltet Interpolation ein/aus
- **Distance**-Regler – skaliert die Distanz aller Quellen
- **Interpolation-Mode**-Menu – Easing-Kurve (linear, ease-in, ease-out …)
- **AmbiEncoder-Send-Buttons** (OFF/sending) – ein pro ICST AmbiEncoder-Port

### 3.4 Unterschied .maxpat vs. .app

||.maxpat|.app|
|---|---|---|
|Patcher bearbeitbar|ja|nein|
|Max-Installation nötig|ja|nein (Runtime enthalten)|
|Max Console sichtbar|ja|ja (Window-Menü)|
|snapshots.xml-Pfad|neben .maxpat|im App-Bundle (oder Arbeitsverzeichnis)|

> **Tipp:** Die snapshots.xml liegt beim Start der .app im Arbeitsverzeichnis (oft `~/Documents`). Mit dem `write`-Button kann sie explizit gespeichert werden.

---

## 4. REAPER-Seite

### 4.1 Die Scripts

|Script|Funktion|Wann starten|
|---|---|---|
|`ICST_Trigger_Scenes.lua`|Dauerhaft laufend – feuert Scenes beim Playback & Marker-Klick|Einmalig via Actions starten, läuft dann im Loop|
|`ICST_Store_Current_Marker_Scene.lua`|Einmalig – speichert eine Scene in Max|Pro Scene einmal ausführen|

### 4.2 OSC-Nachrichten, die REAPER sendet

**`ICST_Trigger_Scenes.lua` sendet:**

```
/act/scene/target  Scene_1          ← wählt Scene an
/act/scene/interval  0 0.931 1 5.112 4181   ← feuert mit Dauer
/act/scene/start  0 0.931 Scene_1   ← Legacy / Klick-Modus
```

**`ICST_Store_Current_Marker_Scene.lua` sendet:**

```
/act/scene/target  Scene_1          ← wählt Scene an
/act/scene/setduration  4181        ← setzt Dauer in ms
/act/scene/store  Scene_1           ← speichert Snapshot
```

### 4.3 Marker-Namen

|REAPER-Marker|wird zu|Scene in Max|
|---|---|---|
|`Scene_1`|→|`Scene_1`|
|`1`|→ (auto)|`Scene_1`|
|`Intro`|→|`Intro`|
|`Mein Raum`|→|`Mein_Raum` (Leerzeichen → Underscore)|

### 4.4 Transport-Verhalten von ICST_Trigger_Scenes.lua

Das Script erkennt zwei Modi:

**Playback läuft:**  
→ prüft in jedem `defer`-Loop, ob der Playhead einen Marker überquert hat  
→ sendet `target` + `interval`-Nachricht (mit `diff_ms`)  
→ 0.25 s Cooldown verhindert Doppeltrigger

**Playback gestoppt:**  
→ prüft ob der Edit-Cursor auf einem Marker steht (Toleranz: ±0.02 s)  
→ sendet `target` + `start`-Nachricht (ohne Dauer-Berechnung)  
→ ideal für manuelles Durchklicken im Probe-Modus

---

## 5. Gesamtworkflow

### 5.1 Setup (einmalig)

```
1. ACT_Circle_Mover_Main.app (oder .maxpat) starten
   → Console zeigt: udpreceiver binding to port 50010

2. In REAPER:
   Actions → Show action list → ReaScript → Load
   → ICST_Trigger_Scenes.lua laden
   → ICST_Store_Current_Marker_Scene.lua laden
```

### 5.2 Scenes vorbereiten (Workflow A – Speichern)

```
Für jede Scene:

1. Im ambimonitor der App/Patch die Klangquellen positionieren

2. In REAPER einen Marker setzen:
   Shift+M → Name eingeben: Scene_1, Scene_2 … (oder 1, 2 …)

3. Edit-Cursor auf den Marker stellen

4. ICST_Store_Current_Marker_Scene.lua ausführen
   → REAPER-Console zeigt:
      ACT explicit store -> Max: marker 0 at 0.931s as Scene_1 duration=4181ms

5. In Max Console erscheint:
      REAPER_MARKER_TARGET: Scene_1
      REAPER_MARKER_SETDURATION: 4181
      REAPER_MARKER_STORE: Scene_1

6. Schritt 1–5 für jede weitere Scene wiederholen
```

> **Zeitlogik:** Die Duration einer Scene ist immer der Abstand zum nächsten Marker.  
> Scene_1 bei 0:00.931, Scene_2 bei 0:05.112 → Scene_1 bekommt **4181 ms**.  
> Der letzte Marker erhält keine neue Duration (kein folgender Marker).

### 5.3 Performance (Workflow B – Playback)

```
1. ICST_Trigger_Scenes.lua starten (falls noch nicht aktiv)

2. Playback in REAPER starten

3. Beim Überfahren eines Markers:
   → Max wählt die passende Scene
   → fährt Quellen über Duration ms zur gespeicherten Position
   → sendet neue OSC-Positionen an ICST AmbiEncoder (Ports 50001–50008)
```

### 5.4 Schnelltest (Workflow C – Marker-Klick)

```
1. ICST_Trigger_Scenes.lua muss laufen

2. REAPER-Playback gestoppt lassen

3. Edit-Cursor auf einen Marker klicken

4. Scene feuert sofort in Max (ohne Interpolations-Dauer)
```

---

## 6. Detailwissen: Was passiert intern bei einem Scene-Wechsel

```
REAPER
  └── ICST_Trigger_Scenes.lua
       ├── /act/scene/target  "Scene_2"
       │     → Scene_Mover wählt Scene_2 im umenu an
       │
       └── /act/scene/interval  0 0.931 1 5.112 4181
             → diff_ms = 4181
             → Scene_Mover: sprintf store Scene_2 → ambimonitor recall
             → Duration = 4181 ms → live.line interpoliert
             → s scene  →  alle aktiven Encoder-Subpatcher
             → pack i x y z  →  prepend /icst/ambi/sourceindex/xyz
             → udpsend 127.0.0.1 50001 … 50008
```

Der ambimonitor interpoliert dabei nicht selbst – die `live.line`-Objekte im `Ease_mover`-Subpatcher übernehmen das Easing zwischen alten und neuen XYZ-Werten.

---

## 7. Troubleshooting

### Max empfängt nichts

- App / Patch neu öffnen (UDP-Receiver muss sich neu binden)
- `ICST_Trigger_Scenes.lua` wirklich gestartet? → REAPER Console prüfen
- Port 50010 blockiert? → `sudo lsof -i :50010` im Terminal

### Duration ist 0 oder fehlt

- Hat der Marker keinen Nachfolger? → nur der letzte Marker hat dieses Problem
- Cursor wirklich auf dem richtigen Marker? → Zoom in REAPER erhöhen
- Marker-Reihenfolge: REAPER sortiert nach Position, nicht nach Eingabe

### Falsche Scene wird gefeuert

- Marker-Name exakt prüfen (Gross-/Kleinschreibung zählt)
- Im umenu des Scene_Movers nachschauen: welche Scenes sind gespeichert?
- `remove_all` + alle Scenes neu abspeichern

### App öffnet, aber ambimonitor ist leer

- `read`-Button klicken → `snapshots.xml` aus dem richtigen Verzeichnis laden
- Pfad: meist neben der `.app`-Datei oder im Arbeitsverzeichnis

### REAPER Console zeigt `LuaSocket not available`

- LuaSocket nicht installiert → Script fällt auf Python-Fallback zurück
- Python muss vorhanden sein: `/opt/homebrew/bin/python3` oder `/usr/local/bin/python3`
- Installation: `brew install lua` oder LuaRocks

---

## 8. Kurzreferenz OSC-Nachrichten

```
Port: 50010 (UDP, localhost)

Eingehend in Max (von REAPER):
  /act/scene/target       s   Scene_Name
  /act/scene/setduration  i   4181
  /act/scene/store        s   Scene_Name
  /act/scene/start        i f s   marker_idx  pos  name
  /act/scene/interval     i f i f i   m1_idx m1_pos m2_idx m2_pos diff_ms

Ausgehend aus Max (zu ICST AmbiEncoder):
  /icst/ambi/sourceindex/xyz  i f f f   source_idx  x  y  z
  → Ports 50001 – 50008 (je ein AmbiEncoder-Plugin)
```

---

## 9. Empfohlener Workshop-Ablauf (Zusammenfassung)

```
Phase 1 – Vorbereitung
  [Max]   App starten, Console prüfen
  [REAPER] Marker setzen (Scene_1, Scene_2, …)
  [Max]   Für jede Scene: Positionen einstellen
  [REAPER] Für jede Scene: ICST_Store_Current_Marker_Scene.lua ausführen

Phase 2 – Probe
  [REAPER] ICST_Trigger_Scenes.lua starten
  [REAPER] Marker anklicken → Scene springt sofort

Phase 3 – Performance
  [REAPER] Playback starten
  [Max]   Interpolierte Übergänge laufen automatisch
```

---

_ICST Ambisonics Workshop 2026 · ACT_Circle_Mover v9.1.4_