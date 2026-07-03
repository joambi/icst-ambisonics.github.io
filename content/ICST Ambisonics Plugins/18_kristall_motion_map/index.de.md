---
title: ICST Kristall Motion Map — Benutzerhandbuch
date: 2026-07-01T00:00:00
weight: 90
draft: false
toc: true
translationKey: kristall-motion-map
description: "Installation und Benutzerhandbuch für JS_ICST_Kristall_Motion_Map.lua — ein eigenständiges REAPER-Skript, das bis zu 64 AmbiEncoder-Quellen durch einen 3D-Kristallgitter-Schritt-Sequenzer mit Echtzeit-GUI, OSC-Ausgabe und benannten Presets bewegt."
---

Niveau: Mittel | Zielgruppe: Komponist, Klangestalter, Raumklangtechniker. | **Version: 2.1.5**

ICST Kristall Motion Map ist ein **eigenständiges REAPER-Lua-Skript** mit grafischer Echtzeit-Oberfläche. Es ordnet bis zu 64 AmbiEncoder-Quellen als Punkte in einem 3D-Kristallgitter an und bewegt sie mit einem Schritt-Sequenzer durch den Raum. Die Bewegung kann live in der isometrischen Vorschau verfolgt, per OSC an einen ICST AmbiEncoder_64 gesendet und mit instanzspezifischen Transformationen, Quantisierung, Glättung und Interaktion gestaltet werden.
Dieses Instrument entstand in Zusammenarbeit mit und inspiriert durch Eli Stine, Gast der ICST Studio Residency 2026.

---

## 1. Voraussetzungen

- **REAPER** v6 oder neuer (v7 empfohlen)
- **ICST AmbiEncoder_64** auf dem Ziel-Track — siehe [Installation](/icst-ambisonics-plugins/02_installation/)
- **Python 3** mit `python-osc` — nur für die Live-OSC-Vorschaubrücke erforderlich
  - macOS / Linux: `pip3 install python-osc`
  - Windows: `pip install python-osc` — beim Python-Installer unbedingt **„Add Python to PATH"** aktivieren (sonst findet REAPER Python nicht)

---

## 2. Installation

### Schritt 1 — Bundle herunterladen

**[ICST_Kristall_Motion_Map_Bundle.zip](/downloads/lua-scripts/ICST_Kristall_Motion_Map_Bundle.zip)** herunterladen (auch auf der [Downloads-Seite](/icst-ambisonics-plugins/08_downloads/) verfügbar) und entpacken, z. B. nach `~/REAPER/Scripts/ICST_Kristall_Motion_Map_Bundle/`.

Das Bundle enthält:

- `scripts/JS_ICST_Kristall_Motion_Map.lua` — Hauptskript
- `jsfx/JS_ICST_Kristall_Controller.jsfx` — optionale MIDI/JSFX-Steuereinheit
- `README.md` — Schnellstart-Anleitung

### Schritt 2 — Als ReaScript laden

1. In REAPER: **Actions → Load ReaScript…**
2. `JS_ICST_Kristall_Motion_Map.lua` auswählen und **Open** klicken.
3. REAPER fügt das Skript der Aktionsliste hinzu. Einmal ausführen — das Kristall-Motion-Map-Fenster öffnet sich.

### Schritt 3 — Optional: Launcher-Datei

Wenn das Skript in einem versionierten Ordner liegen soll, kann eine einzeilige Launcher-Datei im REAPER-Scripts-Verzeichnis erstellt werden:

```lua
-- JS_ICST_Kristall_Motion_Map_Launcher.lua
dofile('/Pfad/zu/JS_ICST_Kristall_Motion_Map.lua')
```

Diesen Launcher als ReaScript laden. Zum Neuladen nach einer Skriptänderung das Kristall-Fenster schliessen und die Launcher-Aktion erneut ausführen.

---

## 3. Die Oberfläche auf einen Blick

![ICST Kristall Motion Map in Aktion — Gitter-Vorschau mit 8 kubischen Quellen](/images/kristall-demo.gif)

![ICST Kristall Motion Map — Gesamtansicht mit Instanzliste, Gitter-Vorschau, Parameter-Panel und Statusleiste](/images/kristall-overview.png)

Das Fenster ist in vier Bereiche aufgeteilt:

![Statusleisten-Übersicht — alle 5 Zeilen beschriftet](/images/kristall-status-bar-overview.svg)

```
┌─────────────────┬──────────────────────────────────────┐
│  Instanzliste   │     Gitter-Vorschau (3D isometrisch) │
│                 ├──────────────────────────────────────┤
│  [+Add] [-Rem]  │         Parameter-Panel               │
│  [Dup]          │    (scrollbar, pro Instanz)           │
├─────────────────┴──────────────────────────────────────┤
│  Statusleiste Zeile 1: OSC · Preset                    │
│  Statusleiste Zeile 2: Speed · BPM · Fwd/Rev · Pause · Stop │
│  Statusleiste Zeile 3: Offset X Y Z · Move X Y Z      │
│  Statusleiste Zeile 4: Rotate Pt · Yw · Rl            │
└────────────────────────────────────────────────────────┘
```

---

## 4. Instanzliste

Das linke Panel listet alle aktiven Instanzen auf. Jede Zeile zeigt Nummer, Farbpunkt, Name und aktuellen Schrittzähler.

| Steuerelement | Aktion |
|---------------|--------|
| Zeile anklicken | Instanz auswählen; Parameter-Panel aktualisiert sich |
| **+ Add** | Neue Instanz mit Standardeinstellungen erstellen |
| **− Rem** | Ausgewählte Instanz löschen |
| **Dup** | Ausgewählte Instanz duplizieren |
| Taste **A** | Instanz hinzufügen |
| Taste **D** | Ausgewählte Instanz duplizieren |
| Taste **R** | Ausgewählte Instanz auf Schritt 0 zurücksetzen |

{{< notice warning >}}
Das Maximum sind **64 Instanzen**. Darüber hinaus hat das Hinzufügen keine Wirkung.
{{< /notice >}}

---

## 5. Gitter-Vorschau

![Instanzliste (links) und isometrische Gitter-Vorschau mit 8 kubischen Quellen — ausgewählte Instanz hervorgehoben](/images/kristall-instance-preview.png)

Das obere rechte Panel zeigt alle aktivierten Instanzen als farbige Punkte in einer isometrischen 3D-Projektion. Ein Einheitswürfel dient als Orientierungsrahmen.

| Interaktion | Wirkung |
|-------------|---------|
| Punkt ziehen | Instanz in der XY-Ebene verschieben (aktualisiert Start X und Start Y) |
| Shift + ziehen | Instanz entlang der Z-Achse verschieben (aktualisiert Start Z) |
| Hovern | Zeigt Instanzname und Markierungsring |

Zwischen je zwei Instanzen innerhalb von `EDGE_DIST` Welteinheiten werden Kanten gezeichnet — so ist die Gitter-Topologie auf einen Blick erkennbar.

---

## 6. Parameter-Panel

Die rechte Spalte unterhalb der Vorschau zeigt alle Parameter der **ausgewählten Instanz**. Mit dem Mausrad scrollen.

### Identität

| Parameter | Beschreibung |
|-----------|--------------|
| **Name** | Bezeichnung in der Instanzliste |
| **Enabled** | Deaktiviert: Instanz eingefroren, nicht in OSC-Ausgabe |

### Position

| Parameter | Beschreibung |
|-----------|--------------|
| **Start X / Y / Z** | Ursprung der Instanz im Weltkoordinatensystem (in der Vorschau visuell verschiebbar) |
| **Offset X / Y / Z** | Schrittvektor — Bewegung pro Schritt entlang jeder Achse |

Pro Schritt ergibt sich die Rohposition als:

```
Position = Start + currentStep × Offset
```

### Timing

| Parameter | Beschreibung |
|-----------|--------------|
| **Rate** | Schritte pro Sekunde (BPM aus) oder Schritte pro Taktschlag (BPM an) |
| **Steps** | Gesamtschrittanzahl; bestimmt den Umkehrpunkt bei Finite und Pingpong |
| **Mode** | **Infinite** — läuft unendlich; **Finite** — stoppt am letzten Schritt; **Pingpong** — prallt ab |

### Rotation

Dreht um die Start-Position mit einer Euler-Rotationsmatrix. Winkel in Grad.

| Parameter | Beschreibung |
|-----------|--------------|
| **Rot X / Y / Z** | Euler-Winkel in Grad |
| **Order** | Anwendungsreihenfolge: XYZ, XZY, YXZ, YZX, ZXY, ZYX |

### Skalierung

Skaliert den Offset-Vektor relativ zur Start-Position.

| Parameter | Beschreibung |
|-----------|--------------|
| **Scale X / Y / Z** | Skalierungsfaktor pro Achse |

### Grenzen (Bounds)

Begrenzt die Position auf eine Box, nach Rotation und Skalierung.

| Parameter | Beschreibung |
|-----------|--------------|
| **Bounds On** | Grenzenverarbeitung aktivieren |
| **Mode** | **None**, **Clamp** (stoppt am Rand), **Wrap** (springt auf die Gegenseite), **Mirror** (reflektiert) |
| **Min / Max X / Y / Z** | Eckpunkte der Begrenzungsbox |

### Quantisierung

| Parameter | Beschreibung |
|-----------|--------------|
| **Space Q.** | Endposition auf ein Raster einrasten (vor Glättung) |
| **Time Q.** | Schrittfortschritt auf Taktunterteilungen quantisieren |
| **Grid X / Y / Z** | Rasterzellgrösse pro Achse (Space Q.) |

### Glättung

Exponentieller Übergang zwischen der schrittweisen Zielposition und der Ausgabe:

```
alpha      = 1 − exp(−dt / glideTime)
currentPos = currentPos + alpha × (targetPos − currentPos)
```

| Parameter | Beschreibung |
|-----------|--------------|
| **Smoothing** | Filter aktivieren/deaktivieren |
| **Glide Time** | Zeitkonstante in Sekunden — 0.08 s ist knackig, 0.5 s ist langsam |

### Interaktion

![Parameter-Panel (untere Bereiche) — Bounds, Quantize, Smoothing und Interaction sichtbar](/images/kristall-param-panel.png)

Instanzen können die Geschwindigkeit und Richtung benachbarter Instanzen beeinflussen.

| Parameter | Beschreibung |
|-----------|--------------|
| **Interaction** | Für diese Instanz aktivieren |
| **Send Amount** | Wie stark diese Instanz andere beeinflusst |
| **Receive Amount** | Wie stark diese Instanz eingehende Einflüsse aufnimmt |
| **Radius** | Einflusssphäre in Welteinheiten |
| **Falloff Mode** | Linear / Inverse Square / Gaussian |
| **Affect Offset** | Eingehender Einfluss modifiziert die Schrittrichtung |
| **Affect Rate** | Eingehender Einfluss modifiziert die Schrittrate |

---

## 7. Statusleiste — Zeile 1: OSC und Presets

![Statusleiste — alle vier Steuerzeilen und die acht Preset-Buttons am unteren Rand](/images/kristall-status-bar.png)

### OSC

| Steuerelement | Beschreibung |
|---------------|--------------|
| Farbpunkt | Grün = verbunden, rot = getrennt |
| **Host** | IP-Adresse des OSC-Ziels (Standard `127.0.0.1`) |
| **Port** | UDP-Port des OSC-Ziels (Standard `9001`) |
| **Connect / Disconnect** | OSC-Brücke öffnen oder schliessen |
| **in: PORT** | Erscheint nach dem Verbinden — UDP-Port für eingehende OSC-Nachrichten (immer `Ausgangsport + 1`, z. B. `9002` bei Ausgangsport `9001`) |

Felder anklicken zum Bearbeiten, **Enter** zum Bestätigen.

### Presets

| Steuerelement | Beschreibung |
|---------------|--------------|
| Namensfeld | Preset-Name eintippen |
| **▼** | Gespeicherte Presets als Dropdown öffnen |
| **Save** | Alle aktuellen Instanzen unter dem Preset-Namen speichern |
| **Reset** | Alle Instanzen löschen und Standard-Preset laden |

Presets werden im REAPER ExtState gespeichert (projektunabhängig, sitzungsübergreifend persistent).

---

## 8. Statusleiste — Zeile 2: Wiedergabe-Steuerung

| Steuerelement | Beschreibung |
|---------------|--------------|
| **Speed ×N.NN** | Globaler Raten-Multiplikator — skaliert alle Instanzraten gleichmässig. Klicken zum Eintippen, Enter bestätigt. |
| **BPM** | BPM-Sync umschalten. Aus = Schritte/Sekunde. An = Schritte/Taktschlag (folgt REAPER-Tempo). |
| **\> Fwd / < Rev** | Globale Richtung für alle Instanzen. |
| **‖ Pause** | Alle Bewegungen einfrieren. Nochmals klicken = weiter. |
| **■ Stop** | Alle Instanzen auf Schritt 0 zurücksetzen und sofort **pausieren** (Wiedergabe startet nicht automatisch). Über **‖ Pause** oder Neustart fortsetzen. |

### BPM-Modus im Detail

BPM **aus**: `Rate = 2` bedeutet 2 Schritte pro Sekunde, unabhängig vom Tempo.

BPM **an**: `Rate = 1` bedeutet 1 Schritt pro Viertelnote. Bei 120 BPM sind das 2 Schritte/Sek; bei 60 BPM ein Schritt/Sek. Eine Instanz mit 64 Schritten und Rate 1 vollendet einen Zyklus in 64 Viertelnoten (16 Takte in 4/4).

---

## 9. Statusleiste — Zeile 3: Globaler Offset und Bewegung

Zeile 3 enthält sechs **Scrubber-Slider** mit Bereich −2,0 bis +2,0. Horizontal ziehen zum Ändern des Wertes.

### Offset X / Y / Z — Globale Translation

Verschiebt alle Instanzpositionen gleichmässig **nach** allen instanzspezifischen Transformationen. Damit kann das gesamte Kristall im Ambisonics-Raum platziert werden, ohne einzelne Start-Positionen anzufassen.

Beispiel: `Offset X = 0,5` verschiebt alle Quellen um 0,5 Einheiten nach rechts.

### Move X / Y / Z — Globale Bewegungsrichtung

Fügt **allen** Instanzen einen zusätzlichen Schritt-Offset überlagert zu ihrem eigenen Offset X/Y/Z hinzu. Damit treibt das gesamte Kristall in eine gewählte Richtung.

Beispiel: `Move X = 0,01` addiert pro Schritt 0,01 Einheiten entlang X zu jeder Instanz. Kombination `Move X = 0,007` und `Move Y = 0,007` ergibt eine Diagonalbewegung.

{{< notice warning >}}
Offset und Move werden **nicht in Presets gespeichert** — sie sind Steuerungen auf Sitzungsebene für Echtzeit-Performance.
{{< /notice >}}

---

## 10. Statusleiste — Zeile 4: Globale Rotation und Zoom

Zeile 4 enthält drei **Rotations-Scrubber** und einen **Zoom-Scrubber**, die alle nach instanzspezifischen Transformationen und dem globalen Offset angewendet werden.

### Rotation (Pt / Yw / Rl)

Dreht den gesamten Kristall um den Weltursprung. Winkel in Grad, Bereich −180 bis +180.

| Slider | Achse | Wirkung |
|--------|-------|---------|
| **Pt** (Pitch) | X | Kippt das Kristall vorwärts / rückwärts |
| **Yw** (Yaw) | Y | Dreht das Kristall links / rechts |
| **Rl** (Roll) | Z | Rollt das Kristall im / gegen Uhrzeigersinn |

### Zoom (×)

Skaliert die gesamte Kristallfigur gleichmässig um den Ursprung — nach der Rotation, vor der Translation. Bereich 0,0–2,0, Neutralpunkt bei 1,0.

| Wert | Wirkung |
|------|---------|
| 0,0 | Alle Quellen kollabieren zum Ursprung |
| 1,0 | Keine Änderung (neutral) |
| 2,0 | Figur doppelt so gross |

Der Zoom wirkt in Echtzeit auf die Gittervorschau und den Live-OSC-Ausgang. Den `×`-Scrubber horizontal ziehen oder anklicken und einen Wert eintippen.

Alle Slider horizontal ziehen oder anklicken und einen Wert eintippen, dann **Enter** bestätigen.

{{< notice warning >}}
Rotation und Zoom wirken auf die **effektive Endposition** jeder Instanz. Die Gittervorschau aktualisiert sich in Echtzeit, auch wenn die Wiedergabe pausiert ist.
{{< /notice >}}

![Rotationsachsen — Pt kippt vorwärts/rückwärts, Yw dreht links/rechts, Rl rollt CW/CCW](/images/kristall-rotation-axes.svg)

Pt/Yw/Rl können auch extern gesteuert werden — siehe [§11 Externe Steuerung](#11-externe-steuerung--osc-eingang-und-midi).

---

## 11. Externe Steuerung — OSC-Eingang und MIDI

### OSC-Eingang

Wenn die OSC-Brücke verbunden ist (Connect geklickt, Status-Punkt grün), **empfängt** das Kristall gleichzeitig OSC-Nachrichten auf **`Ausgangsport + 1`** (z. B. Port `9002` bei Ausgangsport `9001`). Der Empfangsport wird als **in: PORT** neben dem Connect-Button angezeigt.

![OSC/MIDI Signalfluss — zwei Eingangspfade konvergieren zur globalen Rotation](/images/kristall-osc-signal-flow.svg)

Folgende Nachrichten können von TouchOSC, Max/MSP, OSSIA, SuperCollider oder jedem OSC-fähigen Tool gesendet werden:

| OSC-Adresse | Argumente | Wirkung |
|-------------|-----------|---------|
| `/kristall/pitch` | `<float Grad>` | Globalen Pitch setzen (−180…+180) |
| `/kristall/yaw` | `<float Grad>` | Globalen Yaw setzen (−180…+180) |
| `/kristall/roll` | `<float Grad>` | Globalen Roll setzen (−180…+180) |
| `/kristall/rotate` | `<float pitch> <float yaw> <float roll>` | Alle drei gleichzeitig setzen |

Die Werte werden sofort übernommen und überschreiben die Slider. Werte ausserhalb von −180…+180 werden automatisch begrenzt.

**Beispiel** — Kristall mit TouchOSC drehen:
1. Im Kristall-GUI verbinden (Ausgangsport `9001`, Ziel `127.0.0.1`).
2. In TouchOSC OSC-Ziel auf `127.0.0.1:9002` setzen.
3. Einen Fader auf `/kristall/yaw`, Bereich −180 bis +180, zuweisen.
4. Fader bewegen → Kristall dreht sich in Echtzeit.

### MIDI über JSFX-Controller-Brücke

Falls ein **Kristall Controller** JSFX auf einem Track vorhanden ist, liest das Skript dessen Parameter automatisch:

| JSFX-Slider | Parameter-Index | Bereich | Wirkung |
|-------------|-----------------|---------|---------|
| slider6 | 5 | −180…+180° | Globaler Pitch |
| slider7 | 6 | −180…+180° | Globaler Yaw |
| slider8 | 7 | −180…+180° | Globaler Roll |

MIDI-CCs über REAPER's MIDI-Learn-Dialog oder den FX-Parameter-Lane auf diese Slider mappen. Ein CC-Sweep von 0 bis 127 entspricht linear −180° bis +180°. Die Slider werden jeden Frame ausgelesen, solange das JSFX auf einem Track geladen ist.

{{< notice warning >}}
JSFX-Pitch/Yaw/Roll werden nur übernommen, wenn **mindestens einer der drei** ungleich null ist. Wenn alle drei 0 sind oder das JSFX diese Slider nicht enthält, bleiben die Slider-Werte der Oberfläche erhalten.
{{< /notice >}}

---

## 12. Eingebaute Presets (Schnellauswahl)

![Preset-Layouts — Top-Ansicht aller 8 Preset-Muster](/images/kristall-preset-layouts.svg)

Acht Preset-Schaltflächen am unteren Fensterrand. Jedes Preset löscht alle aktuellen Instanzen und platziert neue. Buttons 1–4 (türkis) sind abstrakte Bewegungslayouts, Buttons 5–8 (bernstein) sind kristallografische Einheitszellenformen.

| # | Preset | Was erstellt wird |
|---|--------|-------------------|
| 1 | **Cubic** | 8 Instanzen an den Ecken eines Einheitswürfels |
| 2 | **Tetragonal** | Gitter mit gleichem XY-Abstand und anderem Z-Abstand |
| 3 | **Hexagonal** | 2D-Hexagonalring entlang Z (entspricht typischen Kuppelaufstellungen) |
| 4 | **Rnd.Swarm** | 20 zufällig in einer Kugel verteilte Instanzen |
| 5 | **Orthorhombic** | Einheitszelle mit drei ungleichen orthogonalen Achsen (α=β=γ=90°) |
| 6 | **Rhombohedral** | Einheitszelle mit gleichen Achsen und gleichen nicht-orthogonalen Winkeln (α=β=γ≠90°) |
| 7 | **Monoclinic** | Einheitszelle mit einer geneigten Achse (α=γ=90°, β≠90°) |
| 8 | **Triclinic** | Einheitszelle ohne gleiche Achsen und ohne rechte Winkel — maximale Asymmetrie |

---

## 13. Erste Schritte — Schnelleinstieg

### Schritt 1 — Preset anwenden

**Cubic** in der Statusleiste klicken. Acht Instanzen erscheinen in der Gittervorschau.

### Schritt 2 — Bewegung beobachten

Speed auf `×1,00` belassen, BPM aus. Die Schrittzähler in der Instanzliste zählen hoch.

### Schritt 3 — Richtung einstellen

Instanz 1 auswählen. **Offset X = 0,02**, **Offset Y = 0,01**, **Offset Z = 0** setzen. Diese Instanz bewegt sich nun diagonal in der XY-Ebene.

### Schritt 4 — Pingpong-Modus

**Mode = Pingpong**, **Steps = 64**. Die Quelle läuft 64 Schritte aus und prallt zurück.

### Schritt 5 — Globalen Drift hinzufügen

Den **Move X**-Slider in Zeile 3 auf ca. `0,008` ziehen. Das gesamte Kristall driftet nun nach rechts, während die einzelnen Instanzen weiterhin pendeln.

### Schritt 6 — Kristall drehen

Den **Yw**-Slider (Yaw) in Zeile 4 ziehen, um das gesamte Kristall um die Hochachse zu drehen. **Pt** und **Rl** für zusammengesetzte Orientierungen kombinieren. Die Gittervorschau aktualisiert sich in Echtzeit.

### Schritt 7 — OSC verbinden

Host und Port in Zeile 1 eingeben, **Connect** klicken. Positionen werden in Echtzeit gesendet. Nach dem Verbinden erscheint **in: 9002** — dieser Port empfängt externe Rotationssteuerung (siehe [§11](#11-externe-steuerung--osc-eingang-und-midi)).

---

## 14. Fehlerbehebung

**Quellen bewegen sich nicht.** Speed > 0 prüfen und Instanz auf Enabled kontrollieren. Im BPM-Modus muss der REAPER-Transport laufen.

**Alle Instanzen an derselben Position.** Ein Preset anwenden oder manuell unterschiedliche Start-Positionen setzen.

**Positionen driften ausserhalb des Arrays.** Mode auf Pingpong wechseln oder Bounds mit Mirror-Modus aktivieren.

**Move-Slider ändert zu grosse Schritte.** Langsam ziehen — der Slider deckt den gesamten Bereich −2 bis +2 ab. Für Feinsteuerung Slider anklicken, Wert eintippen, Enter bestätigen.

**OSC verbindet sich nicht.** Python-OSC-Brücke (`python-osc`) prüfen. Host-IP und Port kontrollieren. Bei Erfolg wird der Status-Punkt grün.

**OSC verbindet sich nicht (Windows).** Drei Punkte prüfen: (1) Python muss im System-PATH stehen — Python neu installieren und **„Add Python to PATH"** ankreuzen falls es fehlt. (2) Die Windows-Firewall zeigt beim ersten Start einen Dialog — **„Zugriff erlauben"** klicken. (3) Status-Punkt ist grün, aber keine Bewegung: Host-IP auf `127.0.0.1` prüfen falls AmbiEncoder lokal läuft.

**OSC-Eingang (Rotation) hat keine Wirkung.** Die OSC-Brücke muss zuerst verbunden sein. Sicherstellen, dass der Controller an `Ausgangsport + 1` sendet (Standard: `9002`, nicht `9001`). Mit einem UDP-Monitor (z. B. Protokol) prüfen ob Pakete ankommen.

**Stop-Button pausiert nicht, sondern startet die Wiedergabe.** Dieser Fehler bestand in v0.1.0 und ist ab v0.2.0 behoben. Auf das neueste Skript aktualisieren (v2.1.5).

---

## Siehe auch

- [ICST Ambi Motion Map](/icst-ambisonics-plugins/15_icst_ambi_motion_map/) — schrittbasierte 2D/3D-Bewegungsformen
- [OSC-Referenz](/icst-ambisonics-plugins/13_osc/) — AmbiEncoder-OSC-Format und Koordinatensystem
- [Downloads](/icst-ambisonics-plugins/08_downloads/) — Skript-Downloads
