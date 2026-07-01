---
title: ICST Kristall Motion Map — Benutzerhandbuch
date: 2026-07-01T00:00:00
weight: 90
draft: false
toc: true
translationKey: kristall-motion-map
description: "Schritt-für-Schritt-Anleitung zu ICST Kristall Motion Map — ein modulares 3D-Kristallgitter-Bewegungssystem für bis zu 64 AmbiEncoder-Quellen in REAPER. Behandelt Instanzen, Transformationen, Quantisierung, Glättung, Interaktion und Presets."
---

Niveau: Fortgeschritten | Zielgruppe: Komponist:in, Sound Designer:in, Spatial-Audio-Techniker:in. | **Version: 0.1.0**

ICST Kristall Motion Map erzeugt **dreidimensionale gitterbasierte Raumbewegung** für bis zu 64 AmbiEncoder-Quellen. Jede Audioquelle ist einem Punkt in einem Kristallgitter zugeordnet; ein Schrittsequenzer bewegt die Quelle durch das Gitter, während Transformationen (Rotation, Skalierung, Begrenzung, Quantisierung) und eine distanzbasierte Interaktions-Engine die Bewegung formen. Ergebnisse können als REAPER-Automation aufgeschrieben oder live per OSC gestreamt werden.
Entstanden nach einer Idee unseres ICST Studio-Gastes Eli Stine 2026

> **Script-Datei:** `JS_ICST_Kristall_Motion_Map.lua` — siehe [Downloads](/icst-ambisonics-plugins/08_downloads/)

---

## 1. Was ist ein Kristallgitter?

Ein Kristallgitter ist ein **sich wiederholendes 3D-Raster** von Positionen, definiert durch eine Einheitszelle — die kleinste sich wiederholende Einheit. Die sieben klassischen Kristallsysteme unterscheiden sich in Achsenlängen und -winkeln:

| System | Achsen | Winkel | Beispielform |
|--------|--------|--------|--------------|
| Kubisch | a = b = c | α = β = γ = 90° | Würfel |
| Tetragonal | a = b ≠ c | α = β = γ = 90° | Gestreckter Würfel |
| Orthorhombisch | a ≠ b ≠ c | α = β = γ = 90° | Quader |
| Hexagonal | a = b ≠ c | α = β = 90°, γ = 120° | Wabensäule |
| Rhomboedrisch | a = b = c | α = β = γ ≠ 90° | Verzerrter Würfel |
| Monoklin | a ≠ b ≠ c | α = γ = 90°, β ≠ 90° | Geneigter Quader |
| Triklin | a ≠ b ≠ c | α ≠ β ≠ γ ≠ 90° | Vollständig verzerrt |

In ICST Kristall Motion repräsentiert jede **Instanz** einen Gitterpunkt. Ihre Position wird berechnet als:

```
Position = Start + aktueller Schritt × Offset
```

Anschliessend werden Transformationen (Rotation, Skalierung, Begrenzung) angewendet.

---

## 2. Voraussetzungen

- **REAPER** v6 oder neuer
- **ICST AmbiEncoder_64** auf dem Zieltrack (siehe [Installation](/icst-ambisonics-plugins/02_installation/))
- `JS_ICST_Kristall_Motion_Map.lua` geladen über *Actions → Load ReaScript*
- **Python 3** — nur für Live-OSC-Vorschau benötigt

{{< notice warning >}}
Das Lua-Modul enthält einen **Host-Adapter** (Abschnitt 3 des Scripts). Vor der Nutzung müssen die sechs Stub-Funktionen (`declareParam`, `getParam`, `setParam`, `drawPoint`, `drawLine`, `getTransportState`) durch REAPER-spezifische Aufrufe ersetzt werden. Ohne Anpassung läuft das Script als reines Logikmodul ohne UI oder Ausgabe.
{{< /notice >}}

---

## 3. Installation

### Schritt 1 — Script herunterladen und ablegen

1. `JS_ICST_Kristall_Motion_Map.lua` von der [Downloads-Seite](/icst-ambisonics-plugins/08_downloads/) herunterladen.
2. Datei in den REAPER-Scripts-Ordner legen:
   - **macOS:** `~/Library/Application Support/REAPER/Scripts/`
   - **Windows:** `%APPDATA%\REAPER\Scripts\`

### Schritt 2 — Host-Funktionen anpassen

Das Skript im Texteditor öffnen und **ABSCHNITT 3 — HOST ADAPTER STUBS** suchen (ca. Zeilen 80–130). Jeden Stub durch den entsprechenden REAPER-Lua-Aufruf ersetzen:

```lua
-- Beispiel-Adapter für REAPER
local function declareParam(id, label, group, min, max, default)
  -- Hier auf das eigene Slider-/Knob-System mappen
end

local function getTransportState()
  local playing = reaper.GetPlayState() == 1
  local _, bpm  = reaper.GetProjectTimeSignature2(0)
  local time    = reaper.GetPlayPosition()
  return { playing = playing, bpm = bpm, time = time }
end
```

Alle anderen Abschnitte sind reines Lua und müssen nicht angepasst werden.

### Schritt 3 — Script in REAPER laden

1. REAPER öffnen.
2. **Actions → Load ReaScript…** aufrufen.
3. Zum Scripts-Ordner navigieren und `JS_ICST_Kristall_Motion_Map.lua` auswählen.
4. **Open** klicken — REAPER bestätigt: *„Script loaded successfully."*

### Schritt 4 — Modul initialisieren

`init()` einmal beim Start aufrufen (das Wrapper-Script sollte dies übernehmen):

```lua
local KM = dofile(reaper.GetResourcePath() .. "/Scripts/JS_ICST_Kristall_Motion_Map.lua")
KM.init()   -- deklariert alle UI-Parameter und startet ein 2×2×2-Kubisch-Gitter
```

Danach `KM.onUpdate(dt)` jeden Frame aufrufen, wobei `dt` die vergangene Zeit in Sekunden ist.

---

## 4. Grundkonzepte

### Instanzen

Eine **Instanz** ist ein Kristallgitterpunkt — eine sich bewegende Audioquelle. Jede Instanz hat eine eigene Position, einen Offset-Vektor, eine Rate, einen Transform-Stack sowie Interaktionseinstellungen. Bis zu **64 Instanzen** können gleichzeitig laufen.

### Schrittsequenzer

Jede Instanz hat einen internen Schrittzähler. Bei jeder Taktunterteilung (gesteuert durch die **Rate**) wird der Schrittzähler um 1 erhöht. Die Position wird berechnet als:

```
Rohposition = Start + aktueller Schritt × effektiver Offset
```

Drei **Wiederholungsmodi** steuern, was am Ende passiert:

- **Infinite** — der Schrittzähler läuft unbegrenzt (Position driftet vom Ursprung weg).
- **Finite** — stoppt bei `Schrittzahl − 1` und hält die Endposition.
- **Pingpong** — kehrt an beiden Enden die Richtung um (Hin- und Herbewegung).

### Die Transform-Pipeline

Jeden Frame durchläuft die Position jeder Instanz diese Kette:

```
Schrittposition → Rotation → Skalierung → Begrenzung → Räumliche Quantisierung → Glättung → Ausgabe
```

---

## 5. Instanzparameter

### Position

| Parameter | Beschreibung |
|-----------|--------------|
| **Start X / Y / Z** | Weltkoordinaten-Ursprung dieser Instanz |
| **Offset X / Y / Z** | Gittervektor — wie weit sich die Position pro Schritt bewegt |

### Timing

| Parameter | Bereich | Beschreibung |
|-----------|---------|--------------|
| **Rate** | 0.001 – 16 | Schritte pro Taktschlag |
| **Repetition Mode** | Infinite / Finite / Pingpong | Verhalten am Ende der Schrittfolge |
| **Step Count** | 1 – 1024 | Gesamtanzahl der Schritte (Finite und Pingpong) |

### Rotation

Die Rotation dreht um den **Start**-Punkt der Instanz. Winkel in Grad.

| Parameter | Beschreibung |
|-----------|--------------|
| **Rotation X / Y / Z** | Euler-Winkel in Grad |
| **Rotation Order** | Anwendungsreihenfolge: XYZ, XZY, YXZ, YZX, ZXY, ZYX |

### Skalierung

Die Skalierung streckt den Gittervektor relativ zum Start-Punkt.

| Parameter | Bereich | Beschreibung |
|-----------|---------|--------------|
| **Scale X / Y / Z** | 0.001 – 10 | Skalierungsfaktor pro Achse |

### Begrenzung (Bounds)

Begrenzungen klemmen oder falten die Position in einen definierten Bereich.

| Parameter | Beschreibung |
|-----------|--------------|
| **Bounds Enabled** | Begrenzungsverarbeitung ein-/ausschalten |
| **Bound Min/Max X/Y/Z** | Ecken des Begrenzungsrahmens |
| **Bound Mode** | none / clamp / wrap / mirror |

**Begrenzungsmodi erklärt:**

- `clamp` — Position stoppt an der Grenze und bleibt stehen.
- `wrap` — Position springt zur gegenüberliegenden Grenze (Torus-Topologie).
- `mirror` — Position reflektiert an der Grenze (Pingpong pro Achse unabhängig).

---

## 6. Schritt für Schritt: Erste Kristallbewegung

Diese Anleitung erstellt ein einfaches kubisches Gitter mit drei Quellen, die sich entlang der X-Achse bewegen.

### Schritt 1 — Kubisches Preset anwenden

In der Utilities-Gruppe **Preset: Cubic** auslösen (Parameter auf 1 setzen, dann zurück auf 0). Es werden 27 Instanzen in einem 3×3×3-Raster mit Standardeinstellungen erstellt.

### Schritt 2 — Instanz auswählen

**Selected Index** (Utilities-Gruppe) auf `1` setzen. Die Parameter der *Selected Instance* zeigen nun Instanz 1.

### Schritt 3 — Offset anpassen

**Offset X** auf `0.5`, **Offset Y** und **Offset Z** auf `0` setzen. Instanz 1 bewegt sich nun 0,5 Einheiten pro Schritt entlang X.

### Schritt 4 — Wiederholung einstellen

**Repetition Mode** auf `Pingpong` und **Step Count** auf `16` setzen. Die Quelle bewegt sich 8 Schritte nach aussen und kehrt zurück.

### Schritt 5 — Glättung aktivieren

Sicherstellen, dass **Smoothing** eingeschaltet ist und **Glide Time** ca. `0.08` beträgt. Positionen gleiten sanft zwischen den Schritten.

### Schritt 6 — Mit AmbiEncoder_64 verbinden

`KM.getOutputPositions()` in der Update-Schleife aufrufen und jede `{x, y, z}`-Position über OSC oder Automationsparameter der entsprechenden AmbiEncoder-Quelle zuweisen.

### Schritt 7 — Play drücken

REAPER-Transport starten. Die Quellen beginnen sich zu bewegen.

---

## 7. Rotation

Die Rotation wendet eine 3×3-Euler-Rotationsmatrix auf die Position **relativ zum Start-Punkt** an. Die sechs Rotationsordnungen folgen der Standard-Aerospace-Konvention:

| Ordnung | Reihenfolge |
|---------|-------------|
| XYZ | Roll → Pitch → Yaw |
| XZY | Roll → Yaw → Pitch |
| YXZ | Pitch → Roll → Yaw |
| YZX | Pitch → Yaw → Roll |
| ZXY | Yaw → Roll → Pitch |
| ZYX | Yaw → Pitch → Roll (häufigste in der Robotik) |

{{< notice warning >}}
Die Rotationsreihenfolge ist entscheidend. XYZ und ZYX liefern nur dann dasselbe Ergebnis, wenn zwei der drei Winkel null sind.
{{< /notice >}}

**Tipp:** Um eine ganze Gitterebene zu rotieren ohne den Ursprung zu verschieben, Start X/Y/Z auf `0` belassen und die Rotation setzen, bevor ein Offset ungleich null hinzugefügt wird.

---

## 8. Begrenzung (Bounds)

Begrenzungen werden **nach** Rotation und Skalierung angewendet. Die vier Modi:

**Clamp** — die Position stoppt an der Grenze und bleibt stehen:

```
Position = max(BoundMin, min(BoundMax, Position))
```

**Wrap** — die Position springt zur gegenüberliegenden Seite. Erzeugt eine Torus-Topologie — nützlich für kontinuierliche Kreisbewegungen ohne Pingpong:

```
Position = BoundMin + (Position - BoundMin) mod (BoundMax - BoundMin)
```

**Mirror** — die Position reflektiert an jeder Grenze. Jede Achse verhält sich wie Pingpong, unabhängig vom Wiederholungsmodus des Schrittzählers.

**None** — keine Begrenzung; Positionen können beliebig weit gehen.

---

## 9. Quantisierung

### Räumliche Quantisierung

Rastet die berechnete Position auf den nächsten Gitterpunkt ein, **bevor** die Glättung angewendet wird. Das Raster wird pro Achse definiert:

| Parameter | Beschreibung |
|-----------|--------------|
| **Space Quantize** | Ein-/ausschalten |
| **Grid X / Y / Z** | Gitterzellengrösse pro Achse |
| **Round Mode** | nearest / floor / ceil |

`nearest` für symmetrisches Einrasten, `floor` für immer nach unten (nützlich für Lautsprecherarray-Indizierung), `ceil` für immer nach oben.

### Zeitliche Quantisierung

Wenn aktiviert, werden Schrittvorschübe auf **Taktunterteilungen** eingerastet statt kontinuierlich zu akkumulieren. Rate steuert dann, wie viele Taktunterteilungen in einen Schrittzyklus passen:

```
Schrittzauer = (60 / BPM) / Rate    (Sekunden pro Schritt)
```

Zeitliche Quantisierung aktivieren für **rhythmisch gesperrte** Kristallbewegung, die im DAW-Raster synchron bleibt.

---

## 10. Glättung

Die Glättungs-Engine wendet einen **exponentiellen Decay-Lerp** (Einpol-Tiefpassfilter) zwischen der rohen Schrittposition (`targetPos`) und der Ausgabe (`currentPos`) an:

```
alpha      = 1 − exp(−dt / Glide Time)
currentPos = currentPos + alpha × (targetPos − currentPos)
```

| Parameter | Bereich | Beschreibung |
|-----------|---------|--------------|
| **Smoothing** | ein / aus | Filter ein-/ausschalten |
| **Glide Time** | 0 – 2 s | Zeitkonstante (Zeit, 63 % des Ziels zu erreichen) |

Eine Gleitzeit von `0,08 s` erzeugt schnelle aber weiche Sprünge. Werte über `0,5 s` erzeugen langsame Übergänge, die Schrittgrenzen verwischen. Auf `0` setzen für harte diskrete Schritte.

---

## 11. Interaktions-Engine

Die Interaktion ermöglicht es Instanzen, die **Bewegung gegenseitig zu beeinflussen**, basierend auf ihrer 3D-Distanz. Jede Instanz kann als Sender, Empfänger oder beides agieren.

### Funktionsweise

Jeden Frame, bevor Positionen berechnet werden, strahlt jede Sender-Instanz eine Einfluss-Sphäre mit Radius **Interaction Radius** aus. Jeder Empfänger innerhalb dieses Radius akkumuliert einen gewichteten Beitrag zu seinem **Effective Offset** und/oder **Effective Rate**.

### Abfall-Modi (Falloff)

| Modus | Formel | Charakter |
|-------|--------|-----------|
| **Linear** | `w = 1 − dist / radius` | Gleichmässiger, vorhersehbarer Abfall |
| **Inverse Square** | `w = (1 − dist/radius)²` | Starkes Zentrum, schneller Randabfall |
| **Gaussian** | `w = exp(−dist² / 2σ²)` | Weiche Glockenkurve, σ = radius / 3 |

### Interaktionsparameter

| Parameter | Beschreibung |
|-----------|--------------|
| **Interaction** | Ein-/ausschalten für diese Instanz |
| **Send Amount** | Wie stark diese Instanz andere beeinflusst (0 = kein Senden) |
| **Receive Amount** | Wie stark diese Instanz eingehende Einflüsse akzeptiert (0 = taub) |
| **Radius** | Einfluss-Sphäre in Welteinheiten |
| **Affect Offset** | Ob eingehende Einflüsse den Effective Offset-Vektor ändern |
| **Affect Rate** | Ob eingehende Einflüsse die Effective Rate ändern |

{{< notice warning >}}
Die Interaktion wird zwischen **allen** aktiven Instanzen jeden Frame berechnet. Bei 64 Instanzen und grossen Radien kann jede Instanz jede andere beeinflussen. Mit `Send Amount = 0.2` starten und behutsam erhöhen.
{{< /notice >}}

---

## 12. Presets

Vier eingebaute Presets erzeugen vollständige Instanzkonfigurationen. Jedes Preset löscht alle bestehenden Instanzen.

### Kubisches Gitter

Erzeugt ein n×n×n-Raster mit gleichem Abstand auf allen Achsen (a = b = c). Standard: 3×3×3 = 27 Instanzen.

```lua
KM.presetCubic(3, 1.0)    -- 3×3×3-Raster, 1,0-Einheit Abstand
```

### Tetragonales Gitter

Erzeugt ein nx×ny×nz-Raster, bei dem der X-Y-Abstand vom Z-Abstand abweicht (a = b ≠ c). Standard: 3×3×2 = 18 Instanzen.

```lua
KM.presetTetragonal(3, 3, 2, 1.0, 1.6)    -- sa=1,0, sc=1,6
```

`sc > sa` für gestreckte Säulen (wie ein Quarzkristall). `sc < sa` für flache Plättchenstrukturen.

### Hexagonales Gitter

Erzeugt ein 2D-Hexagonalgitter (γ = 120°), entlang der Z-Achse gestapelt. Verwendet axiale Koordinaten für perfekte Hex-Packung.

```lua
KM.presetHexagonal(2, 2, 1.0)    -- 2 Ringe, 2 Lagen, 1,0 Abstand
```

Die resultierende Lautsprecherverteilung spiegelt typische HOA-Kuppellayouts wider.

### Zufälliger Kristall-Schwarm

Verteilt Instanzen zufällig innerhalb einer Sphäre. Rate, Offset-Richtung, Rotation, Gleitzeit und Interaktionseinstellungen werden alle zufällig gewählt.

```lua
KM.presetRandomSwarm(16, 3.0)    -- 16 Instanzen, 3-Einheiten-Streuradius
```

Erneutes Auslösen des Presets erzeugt eine neue Zufallskonfiguration.

---

## 13. Ausgabe und AmbiEncoder-Integration

### getOutputPositions()

Gibt eine flache Tabelle mit `{x, y, z}` für jede aktivierte Instanz zurück. Damit Positionen an einen OSC-Sender weiterleiten:

```lua
local positions = KM.getOutputPositions()
for i, pos in ipairs(positions) do
  -- OSC an AmbiEncoder-Quelle i senden
  sendOSC("/icst/ambi/sourceindex/aed", i-1, pos.x, pos.y, pos.z)
end
```

{{< notice warning >}}
Kristall Motion gibt **kartesische XYZ-Koordinaten** aus, keine AED-Werte (Azimut/Elevation/Distanz). Bei Bedarf vor dem OSC-Senden konvertieren. Siehe [OSC-Referenz](/icst-ambisonics-plugins/13_osc/) für die Konvertierungsformel.
{{< /notice >}}

### Automation schreiben

Um Positionen als REAPER-Automation aufzuschreiben, bei jedem Transport-Schritt über `getOutputPositions()` iterieren und REAPER's Envelope-API zum Einfügen von Punkten verwenden. Das [Motion Map](/icst-ambisonics-plugins/15_icst_ambi_motion_map/)-Script zeigt das Referenzmuster mit dem Writer-Script.

---

## 14. Gute Praktiken

**Klein anfangen.** Mit 4–8 Instanzen beginnen statt mit 64. Instanzen schrittweise hinzufügen, sobald die Grundbewegung funktioniert.

**Offset-Skalierung an Raumgrösse anpassen.** Wenn das Lautsprecherarray etwa 2 Einheiten umspannt, Offsets im Bereich ±1 halten. Positionen ausserhalb des Arrays werden weiterhin enkodiert, können aber an räumlicher Auflösung verlieren.

**Begrenzungen nutzen, um einen Schwarm einzufangen.** Begrenzungen mit `mirror`-Modus und einer dem Lautsprecherlayout entsprechenden Box aktivieren, damit alle Quellen immer hörbar bleiben.

**Rotationsordnungen kombinieren.** Zwei Instanzen an derselben Start-Position mit verschiedenen Rotationsordnungen (z.B. XYZ und ZYX) überlagern, um sich kreuzende Bogenverläufe zu erzeugen.

**Rhythmische Sperrung.** **Time Quantize** für alle Instanzen in einem Schwarm aktivieren, um alle Schritte am Projekt-BPM zu sperren. Mit Rate-Werten von 1, 2, 4 oder 8 (ganzzahlige Taktunterteilungen) für rhythmische Raummuster kombinieren.

**Interaktion als Textur, nicht als Chaos.** `Send Amount` ≤ 0,3 für subtile gegenseitige Störung halten. Hohe Sendewerte mit grossen Radien können den gesamten Schwarm an einem Punkt zusammenführen.

**Preset → anpassen → duplizieren.** Ein eingebautes Preset anwenden, eine interessante Instanz auswählen, Parameter anpassen, dann **Duplicate** verwenden, um Variationen zu erstellen.

---

## 15. Fehlerbehebung

### Quellen bewegen sich nach dem Starten nicht

Prüfen, ob `getTransportState()` `playing = true` zurückgibt. Die Update-Schleife (`updateAllInstances`) verlässt sofort, wenn der Transport gestoppt ist.

### Alle Instanzen springen an dieselbe Position

Die Instanzen teilen sich dieselben `startX/Y/Z`- und `offsetX/Y/Z`-Werte. Ein Preset anwenden (z.B. Cubic) oder manuell eindeutige Start-Positionen setzen.

### Positionen driften weit ausserhalb des Lautsprecherarrays

Der Wiederholungsmodus ist **Infinite** mit einem Offset ungleich null. Entweder auf **Finite** oder **Pingpong** wechseln oder **Begrenzungen** mit einem dem Lautsprecherlayout entsprechenden Rahmen aktivieren.

### Glättung erzeugt kein hörbares Gleiten

Prüfen, ob **Glide Time** über null liegt und ob der Schritt tatsächlich vorwärts geht (Rate muss > 0 sein und der Transport muss laufen).

### Interaktion lässt alle Quellen zusammenklumpen

**Send Amount** reduzieren (Versuch: 0,1 – 0,2) und **Interaction Radius** verkleinern, um den Einflussbereich auf unmittelbare Nachbarn zu begrenzen.

### Hexagonales Preset erzeugt zu viele Instanzen

Die Anzahl der Zellen in einem Hexagonalgitter wächst schnell mit `rings`: Ring 0 = 1, Ring 1 = 7, Ring 2 = 19, Ring 3 = 37. `rings ≤ 3` halten oder Lagen reduzieren, um innerhalb von MAX_INSTANCES (64) zu bleiben.

### Die Host-Adapter-Funktionen tun nichts

Das Standard-Script wird mit **Stub-Funktionen** ausgeliefert. Die sechs Funktionen in Abschnitt 3 müssen durch echte Host-Aufrufe ersetzt werden, bevor UI, Transportzustand und Ausgabe funktionieren.

---

## Siehe auch

- [ICST Ambi Motion Map](/icst-ambisonics-plugins/15_icst_ambi_motion_map/) — schrittbasierte 2D/3D-Bewegungsformen mit fertigem REAPER-GUI
- [Motion Map Einrichtung](/icst-ambisonics-plugins/16_motion_map_setup/) — Installationsanleitung für das Motion Map Bundle
- [OSC-Referenz](/icst-ambisonics-plugins/13_osc/) — AmbiEncoder-OSC-Adressformat und Koordinatensystem
- [Downloads](/icst-ambisonics-plugins/08_downloads/) — alle Script-Downloads
