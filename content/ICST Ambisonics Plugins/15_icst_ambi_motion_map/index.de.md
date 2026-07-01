---
title: ICST Ambi Motion Map — Benutzerhandbuch
date: 2026-06-28T00:00:00
weight: 87
draft: false
toc: true
translationKey: motion-map-user-guide
description: "Schritt-für-Schritt-Anleitung zum AmbiEncoder64 Motion Map GUI v2.0 — Installation, Source-Setup, Bewegungsformen, XYZ-Koordinaten, Scale, Source-Offset, Presets, Zeitkurve, Palindrom-Modus und Live-OSC-Vorschau."
---

Niveau: Einsteiger–Fortgeschrittene | Zielgruppe: Komponist:in, Sound Designer:in, Spatial-Audio-Techniker:in. | **Version: v2.1**

Das Motion Map GUI erzeugt algorithmische Raumbewegungen für bis zu 64 AmbiEncoder-Quellen und schreibt sie mit einem Klick als REAPER-Automation. Diese Anleitung führt Schritt für Schritt durch alle Funktionen — vom ersten Start bis zu fortgeschrittenen Techniken.

> **Download:** [ICST Ambi Motion Map Bundle](/downloads/ICST_Ambi_Motion_Map_Bundle.zip) (GUI-Script + Automation-Writer, beide erforderlich)

---

## 1. Voraussetzungen

Vor dem Start werden folgende Komponenten benötigt:

- **REAPER** v6 oder neuer
- **ICST AmbiEncoder_64** auf dem Ziel-Track (siehe [Installation](/icst-ambisonics-plugins/02_installation/))
- **Python 3** installiert — nur für die Live-OSC-Vorschau erforderlich
- Beide Script-Dateien im **selben Ordner**: `JS_AmbiEncoder64_Motion_Map_GUI.lua` und `JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua`

---

## 2. Installation

### Schritt 1 — Bundle herunterladen

Das [ICST Ambi Motion Map Bundle](/downloads/ICST_Ambi_Motion_Map_Bundle.zip) herunterladen und entpacken. Beide Lua-Dateien in einem gemeinsamen Ordner belassen (z.B. im REAPER-Scripts-Verzeichnis).

### Schritt 2 — Script in REAPER laden

In REAPER: **Actions → Load ReaScript…** → `JS_AmbiEncoder64_Motion_Map_GUI.lua` auswählen. Nur das GUI-Script muss geladen werden — es findet den Writer automatisch.

{{< notice warning >}}
Der Writer `JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua` muss im **selben Ordner** wie das GUI-Script liegen. Die beiden Dateien nicht trennen.
{{< /notice >}}

### Schritt 3 — Aktion zuweisen (optional)

Im **Actions**-Fenster `JS_AmbiEncoder64_Motion_Map_GUI` suchen und einen Tastaturkürzel oder Toolbar-Button zuweisen.

Eine detailliertere Anleitung inkl. Python-OSC-Setup für macOS und Windows bietet die [Motion Map Einrichtungsseite](/icst-ambisonics-plugins/16_motion_map_setup/).

---

## 3. Erster Start

1. In REAPER **genau einen Track auswählen**, der das ICST AmbiEncoder_64 FX enthält.
2. Eine **Time Selection** (Loop-Range) im REAPER-Timeline setzen — sie definiert, wo die Automation geschrieben wird.
3. Das GUI-Script aus dem Actions-Menü (oder per Tastenkürzel) starten. Das Motion Map Fenster öffnet sich.

{{< notice warning >}}
*„Bitte genau einen Track mit ICST AmbiEncoder_64 selektieren"* — kein AmbiEncoder-Track ist ausgewählt. Den richtigen Track selektieren und das GUI neu starten.

*„Bitte zuerst eine Loop/Time Selection setzen"* — eine Loop-Range in der Timeline setzen, bevor auf Write geklickt wird.
{{< /notice >}}

---

## 4. Die Oberfläche auf einen Blick

![ICST Ambi Motion Map GUI v2.1 — beschriftete Übersicht](/images/ICST%20Motion%20Map%202.1.png)

![ICST Ambi Motion Map in Aktion](/images/ICST%20Motion%20Map%20Gif.gif)

Das Fenster gliedert sich in drei Bereiche:

**Links — Source Grid:** Zeilen für Sources S0–S63. Jede Zeile hat einen Aktivierungs-Toggle, ein Source-Label und **17 Bewegungsform-Zellen** (Line bis Lis, inklusive Lat).

**Rechts oben — Trajectory Preview:** Animierte Leinwand, die den Pfad jeder aktiven Source zeigt. Die horizontale Achse ist **X** (links–rechts), die vertikale **Y** (unten–oben), beide in der aktuellen Scale-Einheit beschriftet. Die ausgewählte Source zeigt ein Koordinaten-Label (z.B. `S0  X:-0.16  Y:-0.04`).

**Rechts unten — Settings:** Steuerelemente für Scale, räumliche Parameter, Timing, Presets und Ausgabe-Optionen.

---

## 5. Sources aktivieren

Beim ersten Start sind alle 64 Sources aktiviert und haben automatisch zugewiesene Formen (Auto-Round-Robin). Es gibt drei Wege, eine Source ein- oder auszuschalten:

- **Klick auf das ✓-Kästchen** in der „On"-Spalte — schaltet die Source ein oder aus.
- **Klick auf das Source-Label** (z.B. S0, S1) — gleicher Effekt, aber größere Klickfläche.
- **Shift+Klick auf ein Source-Label** — aktiviert alle Sources von der aktuell ausgewählten bis zur angeklickten (Bereichsauswahl).

In der unteren Leiste stehen **Schnellauswahl-Buttons**: `All Src`, `None Src`, `S0-7`, `S8-15` für schnelle Mehrfachauswahl.

Der Zähler oben rechts im Settings-Bereich zeigt, wie viele Sources aktiv sind (z.B. `3 / 64 active`).

---

## 6. Bewegungsformen zuweisen

Jede Zeile hat **17 Form-Buttons**. Klick auf einen Button weist diese Bewegungsform der Source zu. Das Zuweisen einer Form aktiviert die Source automatisch.

![Übersicht aller 17 Bewegungsformen und ihrer Trajektorien](/images/motion-shapes-overview.svg)

| Label | Form | Bewegungscharakter |
|-------|------|--------------------|
| **Line** | `line` | Linearer Sweep durch das Feld |
| **Arc+** | `arc_up` | Bogen nach oben mit sanftem Easing |
| **Arc−** | `arc_down` | Bogen nach unten |
| **S** | `s_curve` | S-förmiger Sweep — sinusoidale Y-Bewegung |
| **Step** | `step` | Vier diskrete Positionsschritte |
| **Zig** | `zigzag` | Schnelles X/Y-Zickzack |
| **Circ** | `circle` | Vollkreis in der XY-Ebene |
| **Spir** | `spiral` | Expandierende Spirale von innen nach außen |
| **Four** | `fourier_xyz` | Komplexe 3D-Bahn aus summierten Harmonischen |
| **Lat** | `lattice` | Wiederholte XYZ-Offset-Struktur mit optionalem Gleiten und Begrenzung |
| **Hrt** | `heart_curve` | Herzförmige parametrische Kurve |
| **Card** | `cardioid` | Kardioid — eintropfige Herzkurve |
| **R8** | `rose8` | Rosenkurve mit 8 Blättern |
| **Bern** | `bernoulli` | Lemniskate von Bernoulli — Acht-Variante |
| **Ast** | `astroid` | Astroid — 4-spitzige Sternkurve |
| **Epi** | `epicycloid` | Epizykloide — komplexe Schleifenbahn |
| **Lis** | `lissajous` | Lissajous-Figur — X und Y auf verschiedenen Frequenzen |

Wenn mehrere Sources dieselbe Form verwenden, verteilt der **Src offset**-Schieberegler (siehe §7) sie entlang der Trajektorie — sonst bewegen sie sich alle überlagert am gleichen Punkt.

### Lattice-Form

`Lat` ist eine kristallartige Wiederholungsbewegung. Statt eine einzelne kontinuierliche geometrische Kurve zu zeichnen, startet sie am aktuellen XYZ-Zentrum und addiert im Zeitverlauf immer wieder den XYZ-Spread-Vektor.

- **Startpunkt:** `X center`, `Y center`, `Z center`
- **Wiederholter Offset:** `X spread`, `Y spread`, `Z spread`
- **Rate / T:** wie viele Lattice-Updates innerhalb einer Time Selection passieren
- **Slide:** glättet den Übergang zwischen den Gitterpunkten, sodass die Bewegung gleitet statt hart zu springen
- **Bound X/Y/Z:** optionale Wrap-Grenzen um das Zentrum pro Achse; `0` deaktiviert die Begrenzung

Diese Form eignet sich für kristalline Bewegung, stufenartige Tiefenbewegung, wiederholte Raumgitter und andere strukturierte Offsets, die sich vom Ursprung aus fortpflanzen.

### Schnellzuweisung (PRESETS-Leiste unter dem Grid)

| Button | Effekt |
|--------|--------|
| **Auto** | Weist alle 17 Formen im Round-Robin auf alle 64 Sources zu |
| **Random** | Weist jeder Source eine zufällige Form zu |
| **All Line** | Setzt alle aktiven Sources auf Line |
| **All Circle** | Setzt alle aktiven Sources auf Circle |
| **All Step** | Setzt alle aktiven Sources auf Step |
| **S0-7 Arc** | Weist Arc+ den Sources 0–7 zu |
| **S8-15 Circ** | Weist Circle den Sources 8–15 zu |
| **Clear All** | Entfernt alle Formzuweisungen und deaktiviert alle Sources |

---

## 7. Räumliche Parameter

### Koordinatensystem

Das GUI arbeitet im **kartesischen XYZ-Raum** (Einheitskugel −1..+1). Der Scale-Wert setzt einen Anzeige-Multiplikator, damit in Metern gedacht werden kann. Die REAPER-Automation wird immer in der nativen Einheitskugel geschrieben — Scale ändert nie das, was aufgezeichnet wird, nur wie Werte angezeigt werden und wie die OSC-Distanz gesendet wird.

- **X** = links–rechts (−1 = links, 0 = Mitte, +1 = rechts)
- **Y** = unten–oben (−1 = unter dem Hörer, 0 = Horizont, +1 = darüber)
- **Z** = Distanz (0 = nah, 1 = fern)

### Steuerelemente

Alle Schieberegler sind ziehbar. **Shift** während des Ziehens halten für Feineinstellung. Klick auf das **Wertefeld** rechts ermöglicht direkte Zahleneingabe.

| Parameter | Standard | Beschreibung |
|-----------|----------|--------------|
| **Scale (m)** | 1 | Raumgröße in Metern. Angezeigte Koordinaten sind in Scale-Einheiten (z.B. Scale 10 → Bereich −10..+10 m). REAPER-Automation und OSC arbeiten intern mit der Einheitskugel. Beliebigen Wert 1–1000 eingeben. |
| **Steps/sec** | 12 | Automationspunkte pro Sekunde. Höher = flüssiger, aber mehr Envelope-Daten. |
| **Motion amount** | 1.00 | Globaler Amplituden-Multiplikator. 1.0 = voller Bereich; 0.5 = halbe Amplitude; Werte über 1.0 dehnen über den definierten Spread hinaus und werden an der Kugelgrenze geclampt. |
| **X center** | 0.00 | Links–rechts-Zentrum des Bewegungsfeldes (−Scale..+Scale). |
| **X spread** | 2.00 | Gesamter links–rechts-Bereich (0..2×Scale). **2.0 bei Scale 1 = voller −1..+1-Sweep** — der maximale Bereich, der in REAPER geschrieben werden kann. |
| **Src offset** | 0.00 | Zeitlicher Versatz zwischen Sources entlang der Trajektorie. `0` = alle Sources am gleichen Punkt; `1` = Sources gleichmäßig über den gesamten Pfad verteilt. Damit lassen sich Sources mit gleicher Bewegungsform trennen. |
| **Y center** | 0.00 | Vertikal-Zentrum (−Scale = unten, 0 = Horizont, +Scale = oben). |
| **Y spread** | 0.56 | Gesamter Vertikalbereich. |
| **Z center** | 0.75 | Distanz-Zentrum (0 = nah, Scale = fern). |
| **Z spread** | 0.35 | Distanz-Variationsbereich. |

### Lattice-Steuerung

Diese Parameter erscheinen unter den Haupt-XYZ-Einstellungen und wirken nur auf Sources mit der Form **Lat**:

| Parameter | Standard | Beschreibung |
|-----------|----------|--------------|
| **Rate / T** | 8.0 | Anzahl der Lattice-Updates über eine komplette Time Selection. `8` bedeutet, dass der Offset über die gewählte Dauer achtmal addiert wird. |
| **Slide** | 1.0 | Glättungsfaktor zwischen Lattice-Positionen. `0` erzeugt harte Sprünge; `1` interpoliert vollständig zwischen den Schritten; Zwischenwerte mischen beides. |
| **Bound X / Y / Z** | 0.00 | Optionale Wrap-Grenzen pro Achse um den Mittelpunkt. `0` deaktiviert die Begrenzung; positive Werte halten die wiederholte Transformation in einem endlichen Bereich. |

### Quantize-Steuerung

Quantisierung kann auf **jede** Bewegungsform angewendet werden, nicht nur auf Lattice. Sie verwandelt kontinuierliche Bewegung in zeitlich, räumlich oder doppelt gestufte Bewegung.

| Parameter | Standard | Beschreibung |
|-----------|----------|--------------|
| **Time / T** | 0.0 | Anzahl zeitlicher Rasterpunkte über eine Time Selection. `0` deaktiviert die Zeit-Quantisierung. Beispiel: `16` aktualisiert die Kurve an 16 gleichmäßig verteilten Zeitpunkten. |
| **Q X / Q Y / Q Z** | 0.00 | Räumliche Rundungsstufe pro Achse im normierten Raum. `0` deaktiviert die Rundung; `0.1` rundet die jeweilige Achse auf 0.1-Schritte. |

Das ist nützlich, wenn sich eine beliebige Form wie ein räumlicher Sequencer verhalten soll: Die Trajektorie wird in diskreten Zeiten abgetastet und/oder auf diskrete Positionen gerundet.

### Reset-Button

**⟲ Reset** (neben Write) stellt alle räumlichen und Timing-Parameter auf ihre Standardwerte zurück, während Formzuweisungen und Presets erhalten bleiben.

### Scale und OSC-Distanz

Wenn die OSC-Vorschau aktiv ist, wird der gesendete Distanzwert als Einheitskugel-Radius × Scale berechnet. Bei Scale 10 sendet eine Source am Rand der Kugel ~10 m an den AmbiEncoder.

---

## 8. Zeitkurve — Bewegungsrhythmus gestalten

Der Bereich **Time Curve** steuert, wie die Animation zeitlich verläuft. Drei Modi:

![Zeitkurven-Vergleich — Linear, Exp, Log](/images/time-curve-comparison.svg)

| Modus | Verhalten |
|-------|-----------|
| **Linear** | Gleichmäßige Geschwindigkeit — konstantes Tempo (Standard). |
| **Exp** | Langsamer Start, schnelles Ende — die Bewegung beschleunigt. |
| **Log** | Schneller Start, langsames Ende — die Bewegung verlangsamt sich. |

Der **n**-Schieberegler (Exponent) legt die Stärke der Kurve fest. Bei `n = 1` erzeugen alle drei Modi identische Ergebnisse. Typische Werte: `2.0–3.0`.

**Anwendungsfälle:** Exp eignet sich für Sources, die abrupt „ankommen" sollen; Log ergibt einen ausholenden Einstieg, der sich setzt. Kombiniert mit Palindrome entstehen symmetrische Beschleunigungsprofile.

---

## 9. Palindrom-Modus

Wenn **Palindrome** aktiviert ist, spielt die Bewegung innerhalb derselben Time Selection vorwärts und dann rückwärts: die Form läuft 0 → 1 → 0 statt 0 → 1.

Das bedeutet:
- Die Source kehrt am Ende an ihre Ausgangsposition zurück.
- Ideal für oszillierende Bewegungen ohne harten Sprung.
- Funktioniert mit allen Bewegungsformen.
- Kombiniert mit **Exp** oder **Log** entstehen asymmetrische Vorwärts-/Rückwärtsgeschwindigkeiten.

---

## 10. Ausgabe-Optionen

| Option | Beschreibung |
|--------|--------------|
| **Clear existing** | Löscht vorhandene Envelope-Punkte in der Time Selection vor dem Schreiben. Deaktivieren, um Bewegung auf vorhandene Automation zu schichten. |
| **Track Latch** | Setzt den Track nach dem Schreiben in den Latch-Automationsmodus, damit Live-Parameterbewegungen beim nächsten Playback aufgezeichnet werden. |
| **Overwrite region** | Wenn eine Region mit demselben Namen bereits existiert, wird sie zur aktuellen Time Selection verschoben statt einer neuen erstellt. |
| **Use Z motion** | Aktiviert die Distanz-(Z)-Variation. Deaktivieren, um Sources auf einer fixen Distanz zu halten, während X und Y sich weiterhin bewegen. |

### Regionsname

Legt den Namen der REAPER-Render-Region fest. Standard: `BFormat_TS`. Regionen sinnvoll benennen — sie erscheinen im REAPER-Projekt und in Render-Exporten.

---

## 11. Preset-System

Die **Preset**-Leiste oben im Settings-Bereich ermöglicht das Speichern, Laden und Löschen vollständiger Parametersets.

Ein Preset speichert: alle Formzuweisungen, welche Sources aktiviert sind, Scale, alle XYZ-Parameter (Center und Spread für X, Y, Z), Src offset, Steps/sec, Motion amount, alle Lattice-Parameter, alle Quantize-Parameter, Zeitkurven-Modus und Exponent, Palindrome, Use Z motion sowie alle Ausgabe-Optionen.

### Preset speichern

1. Einen Namen im **Preset**-Textfeld eingeben (z.B. `Kreis_Weit`).
2. **Save** klicken.

### Preset laden

- Auf einen **Preset-Chip** (die Buttons unter dem Textfeld) klicken — sofortiges Laden.
- Oder Namen eintippen und **Load** klicken.

### Preset löschen

Namen eintippen (oder Chip klicken) und **Delete** klicken.

### Viele Presets navigieren

Mit den **◄ ►**-Pfeilen durch mehr als 6 gespeicherte Presets blättern. Presets bleiben über REAPER-Sessions hinaus erhalten (via REAPER ExtState gespeichert).

---

## 12. Live-OSC-Vorschau

Der OSC-Preview-Bereich sendet Live-Positionsdaten an den AmbiEncoder, während die Animation im GUI läuft — so kann die Bewegung gehört werden, bevor sie als Automation festgeschrieben wird.

### Einrichtung Schritt für Schritt

1. In **REAPER Preferences → Control/OSC/web** die Option *„Allow binding of REAPER action and FX parameters to OSC"* aktivieren und den Port notieren (Standard: `9001`).
2. Im GUI **Host** auf `127.0.0.1` und **Port** entsprechend setzen.
3. **Connect** klicken. Der Status-Punkt wird grün, wenn der Python-Helfer läuft.
4. **Live Preview (sends AED to AmbiEncoder)** aktivieren.

Das GUI sendet nun konvertierte OSC-Positionsmeldungen mit ~30 Hz für jede aktivierte Source über die Adresse:

```
/icst/ambi/sourceindex/aed <int index> <float azimuth> <float elevation> <float distance>
```

Beispiel — Source 3, 45° Azimut, −15° Elevation, 2,5 m Distanz:

```
/icst/ambi/sourceindex/aed 3 45.0 -15.0 2.5
```

Die OSC-Distanz wird in physikalischen Metern gesendet (Einheitskugel-Radius × Scale).

**Disconnect** klicken, um das OSC-Senden zu beenden.

{{< notice warning >}}
Die Live-Vorschau erfordert Python 3 als `python3` im System-PATH. Wenn der Status-Punkt rot bleibt, im Terminal `python3 --version` ausführen.
{{< /notice >}}

---

## 13. Automation schreiben

Wenn Sources eingerichtet und die Parameter in der Vorschau korrekt aussehen:

1. Sicherstellen, dass der richtige REAPER-Track ausgewählt ist.
2. Prüfen, dass die Time Selection den gewünschten Bereich abdeckt.
3. **▶ Write Automation + Region** klicken.

Das Script löscht vorhandene Envelope-Punkte (wenn Clear existing aktiv), schreibt XYZ-Automation für jede aktivierte Source direkt in der Einheitskugel (−1..+1) — unabhängig vom Scale-Anzeige-Wert — setzt den Track auf Latch-Modus (wenn Track Latch aktiv) und erstellt oder aktualisiert eine Render-Region.

Eine Statusmeldung am unteren Rand des GUIs bestätigt den Abschluss.

---

## 14. Trajektorien-Vorschau

Die Vorschauleinwand zeigt alle aktiven Sources gleichzeitig. Die horizontale Achse ist **X** (links–rechts), die vertikale **Y** (unten–oben), beide in der aktuellen Scale-Einheit beschriftet.

- Jede Source erhält eine eigene Farbe. Die **ausgewählte Source** hat einen pulsierenden Halo und ein Koordinaten-Label (z.B. `S0  X:-0.16  Y:-0.04` bei Scale 1, oder `S0  X:-1.6  Y:-0.4` bei Scale 10).
- Nicht ausgewählte Sources zeigen kleinere Punkte bei 80 % Deckkraft.
- Alle Punkte animieren gleichzeitig — die vollständige räumliche Szene ist live sichtbar.
- Pfade zeigen die vollständige Trajektorie jeder Source.

Auf ein Source-Label im Grid klicken, um es auszuwählen und seine Koordinaten in der Vorschau zu sehen.

---

## 15. Empfehlungen für die Praxis

- **Voller links–rechts-Sweep:** X center = 0, X spread = 2×Scale (z.B. `2.00` bei Scale 1, `20.00` bei Scale 10). So wird der volle −1..+1-Bereich in die REAPER-Automation geschrieben.
- **Überlappende Sources trennen:** Wenn zwei Sources dieselbe Form haben und ihre Pfade sich überlagern, **Src offset** auf 0.3–0.5 erhöhen, um sie entlang der Trajektorie zu verteilen.
- **Scale als Raumgröße:** Scale auf den tatsächlichen Raumradius setzen (z.B. 8 für einen 8-m-Raum). Die OSC-Vorschau sendet dann Distanzen in Metern — die REAPER-Automation bleibt unverändert.
- Mit **Auto** + 3–4 aktiven Sources starten, um die verfügbaren Formen kennenzulernen.
- **Steps/sec 6–8** für breite Sweeps; **20–30** für detaillierte Bewegungen.
- **Motion amount** zunächst auf 1.0 — höhere Werte können an der Kugelgrenze geclampt werden.
- **Clear existing deaktiviert**: Circle auf bestehende Linien-Automation schichten.
- **Palindrome + Log**: schnell nach außen, sanft zurück — gut für reverbartige räumliche Ausklänge.
- Vor dem Experimentieren immer ein Preset speichern.
- Render-Regionen nach Szenen benennen: `Intro_BFormat`, `Strophe_BFormat`, `Outro_BFormat`.
- **Lattice als räumliches Arpeggio:** Rate/T = 8–16, Slide = 0 → harte Sprünge zwischen Positionen wie ein räumlicher Sequencer.
- **Lattice mit Bounds:** Bound X = 1.0, Bound Y = 0.5 → Sources bleiben in der Vorderhalbkugel, propagieren aber trotzdem weiter.
- **Quantize für rhythmische Bewegung:** Time/T = 16 auf einer Circle-Form → 16 diskrete Positionen statt glattem Orbit — synchron zum Takt wenn Steps/sec zum Tempo passt.
- **Lat + Quantize kombinieren:** Lattice definiert *wohin* die Sources springen; Quantize definiert *wann* — zusammen entstehen strukturierte, gitterbasierte Raumsequenzen.

---

## 16. Fehlerbehebung

### Sources bewegen sich nach dem Schreiben nicht

Prüfen, ob mindestens eine Source ein ✓ in der „On"-Spalte und eine zugewiesene Form hat. Die Statusleiste zeigt, was geschrieben wurde.

### Sources überlagern sich alle am gleichen Punkt

**Src offset** über 0 erhöhen (z.B. 0.5), damit Sources mit gleicher Bewegungsform zeitlich entlang des Pfades verteilt werden.

### Automation entspricht nicht der Vorschau

Parameter-Änderungen nach der Vorschau, aber vor dem Schreiben beeinflussen die geschriebene Automation. Die Einstellungen vor dem Schreiben prüfen.

### OSC-Vorschau — Punkt bleibt rot

- Python 3 prüfen: `python3 --version` im Terminal.
- Port muss mit den REAPER-OSC-Einstellungen übereinstimmen.
- Disconnect → Connect neu klicken.

### Writer-Script nicht gefunden

Beide Lua-Dateien müssen im selben Verzeichnis liegen. Bei Verschiebung erneut über Actions → Load ReaScript laden.

### Steps/sec zu niedrig für kurze Regionen

Eine 0,1-Sekunden-Time-Selection bei 12 Steps/sec ergibt nur 1 Automationspunkt. Steps/sec erhöhen oder Time Selection verlängern.

### Lattice-Sources gleiten statt zu springen

**Slide auf 0 setzen.** Bei Slide = 1 wird zwischen den Gitterpunkten interpoliert; bei Slide = 0 springt die Source sofort.

### Lattice-Sources verlassen das Lautsprecherarray

**Bound X / Y / Z aktivieren.** Den gewünschten Normalisierungsradius eintragen (z.B. `0.8` hält Sources innerhalb von 80 % der Kugel). Bei Bound = 0 akkumuliert sich der Offset unbegrenzt.

### Quantize zeigt keine sichtbare Wirkung

**Time/T muss größer als 0 sein.** Der Standardwert `0` deaktiviert die Zeit-Quantisierung. Auf die gewünschte Schrittanzahl setzen (z.B. `16`) und sicherstellen, dass Steps/sec hoch genug ist, damit jedes Zeitfenster mindestens einen Automationspunkt enthält.

---

## Siehe auch

- [ICST Ambi Motion Markers](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) — für musikalisch getaktete, cue-basierte Bewegungen
- [ICST AmbiEncoder_64](/icst-ambisonics-plugins/01_icst_ambi_encoder/) — das Encoder-Plugin
- [Installation](/icst-ambisonics-plugins/02_installation/) — Plugin-Einrichtung
- [Motion Map Einrichtung](/icst-ambisonics-plugins/16_motion_map_setup/) — Python-OSC-Setup für macOS und Windows
