---
title: ICST Kristall Motion Map — Benutzerhandbuch
date: 2026-07-01T00:00:00
weight: 90
draft: false
toc: true
translationKey: kristall-motion-map
description: "Installation und Benutzerhandbuch für JS_ICST_Kristall_Motion_Map.lua — ein eigenständiges REAPER-Skript, das bis zu 64 AmbiEncoder-Quellen durch einen 3D-Kristallgitter-Schritt-Sequenzer mit Echtzeit-GUI, OSC-Ausgabe und benannten Presets bewegt."
---

Niveau: Mittel | Zielgruppe: Komponist, Klangestalter, Raumklangtechniker. | **Version: 0.1.0**

ICST Kristall Motion Map ist ein **eigenständiges REAPER-Lua-Skript** mit grafischer Echtzeit-Oberfläche. Es ordnet bis zu 64 AmbiEncoder-Quellen als Punkte in einem 3D-Kristallgitter an und bewegt sie mit einem Schritt-Sequenzer durch den Raum. Die Bewegung kann live in der isometrischen Vorschau verfolgt, per OSC an einen AmbiEncoder gesendet und mit instanzspezifischen Transformationen, Quantisierung, Glättung und Interaktion gestaltet werden.

---

## 1. Voraussetzungen

- **REAPER** v6 oder neuer (v7 empfohlen)
- **ICST AmbiEncoder_64** auf dem Ziel-Track — siehe [Installation](/icst-ambisonics-plugins/02_installation/)
- **Python 3** mit `python-osc` — nur für die Live-OSC-Vorschaubrücke erforderlich

---

## 2. Installation

### Schritt 1 — Skript herunterladen

`JS_ICST_Kristall_Motion_Map.lua` von der [Downloads-Seite](/icst-ambisonics-plugins/08_downloads/) herunterladen und beliebig auf dem Computer ablegen, z. B. `~/REAPER/Scripts/`.

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

Das Fenster ist in vier Bereiche aufgeteilt:

```
┌─────────────────┬──────────────────────────────────────┐
│  Instanzliste   │     Gitter-Vorschau (3D isometrisch) │
│                 ├──────────────────────────────────────┤
│  [+Add] [-Rem]  │         Parameter-Panel               │
│  [Dup]          │    (scrollbar, pro Instanz)           │
├─────────────────┴──────────────────────────────────────┤
│  Statusleiste Zeile 1: OSC · Preset                    │
│  Statusleiste Zeile 2: Speed · BPM · Fwd/Rev · Pause · Stop │
│  Statusleiste Zeile 3: Pos X Y Z · Move X Y Z         │
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

### OSC

| Steuerelement | Beschreibung |
|---------------|--------------|
| Farbpunkt | Grün = verbunden, rot = getrennt |
| **Host** | IP-Adresse des OSC-Ziels (Standard `127.0.0.1`) |
| **Port** | UDP-Port des OSC-Ziels (Standard `9001`) |
| **Connect / Disconnect** | OSC-Brücke öffnen oder schliessen |

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
| **■ Stop** | Alle Instanzen auf Schritt 0 zurücksetzen und sofort weiterlaufen. |

### BPM-Modus im Detail

BPM **aus**: `Rate = 2` bedeutet 2 Schritte pro Sekunde, unabhängig vom Tempo.

BPM **an**: `Rate = 1` bedeutet 1 Schritt pro Viertelnote. Bei 120 BPM sind das 2 Schritte/Sek; bei 60 BPM ein Schritt/Sek. Eine Instanz mit 64 Schritten und Rate 1 vollendet einen Zyklus in 64 Viertelnoten (16 Takte in 4/4).

---

## 9. Statusleiste — Zeile 3: Globale Position und Bewegung

Zeile 3 enthält sechs **Scrubber-Slider** mit Bereich −2,0 bis +2,0. Horizontal ziehen zum Ändern des Wertes.

### Pos X / Y / Z — Globale Translation

Verschiebt alle Instanzpositionen gleichmässig **nach** allen instanzspezifischen Transformationen. Damit kann das gesamte Kristall im Ambisonics-Raum platziert werden, ohne einzelne Start-Positionen anzufassen.

Beispiel: `Pos X = 0,5` verschiebt alle Quellen um 0,5 Einheiten nach rechts.

### Move X / Y / Z — Globale Bewegungsrichtung

Fügt **allen** Instanzen einen zusätzlichen Schritt-Offset überlagert zu ihrem eigenen Offset X/Y/Z hinzu. Damit treibt das gesamte Kristall in eine gewählte Richtung.

Beispiel: `Move X = 0,01` addiert pro Schritt 0,01 Einheiten entlang X zu jeder Instanz. Kombination `Move X = 0,007` und `Move Y = 0,007` ergibt eine Diagonalbewegung.

{{< notice warning >}}
Pos und Move werden **nicht in Presets gespeichert** — sie sind Steuerungen auf Sitzungsebene für Echtzeit-Performance.
{{< /notice >}}

---

## 10. Eingebaute Presets (Schnellauswahl)

Vier Preset-Schaltflächen in der Statusleiste. Jedes Preset löscht alle aktuellen Instanzen.

| Preset | Was erstellt wird |
|--------|-------------------|
| **Cubic** | 8 Instanzen an den Ecken eines Einheitswürfels |
| **Tetragonal** | Gitter mit gleichem XY-Abstand und anderem Z-Abstand |
| **Hexagonal** | 2D-Hexagonalring entlang Z (entspricht typischen Kuppelaufstellungen) |
| **RandomSwarm** | 20 zufällig in einer Kugel verteilte Instanzen |

---

## 11. Erste Schritte — Schnelleinstieg

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

### Schritt 6 — OSC verbinden

Host und Port in Zeile 1 eingeben, **Connect** klicken. Positionen werden in Echtzeit gesendet.

---

## 12. Fehlerbehebung

**Quellen bewegen sich nicht.** Speed > 0 prüfen und Instanz auf Enabled kontrollieren. Im BPM-Modus muss der REAPER-Transport laufen.

**Alle Instanzen an derselben Position.** Ein Preset anwenden oder manuell unterschiedliche Start-Positionen setzen.

**Positionen driften ausserhalb des Arrays.** Mode auf Pingpong wechseln oder Bounds mit Mirror-Modus aktivieren.

**OSC verbindet sich nicht.** Python-OSC-Brücke (`python-osc`) prüfen. Host-IP und Port kontrollieren.

---

## Siehe auch

- [ICST Ambi Motion Map](/icst-ambisonics-plugins/15_icst_ambi_motion_map/) — schrittbasierte 2D/3D-Bewegungsformen
- [OSC-Referenz](/icst-ambisonics-plugins/13_osc/) — AmbiEncoder-OSC-Format und Koordinatensystem
- [Downloads](/icst-ambisonics-plugins/08_downloads/) — Skript-Downloads
