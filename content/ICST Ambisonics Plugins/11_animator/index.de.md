---
title: ICST Animator
date: 2026-10-15T00:00:00
weight: 85
draft: false
toc: true
type: docs
description: "Tutorial und Referenz zum ICST Animator: Quellengruppen im Multi-AmbiEncoder_64 auf einer Timeline bewegen, drehen und transformieren."
---

Niveau: Fortgeschritten | Zielgruppe: Komponierende, Technik, Studierende, Interactive-Media-Anwender:innen. | **Version: ICST Ambisonics Plugins 4.0**

<!-- TODO Release: Download-Link einsetzen -->
<p><button type="button" disabled aria-disabled="true" style="display:inline-block;padding:.6em 1.4em;border:0;border-radius:6px;background:#2e8b57;color:#fff;font-weight:600;font-size:1em;opacity:.55;cursor:not-allowed;">Download Animator &nbsp;·&nbsp; Coming soon</button></p>

![Multi-AmbiEncoder_64 mit vier Gruppen und der Animator-Timeline](AT-BAS-05-Animator-Overview.png)

Der **Animator** ist die Choreografie-Timeline des **Multi-AmbiEncoder_64**: Er bewegt, dreht und verformt ganze Quellengruppen automatisch über die Zeit, synchron zum DAW-Transport.

{{< video name="AT-DEM-V01-Load-Demo" caption="Demo: die vier Beispielszenen aus File → Load Demo." >}}

> **Getestet mit** REAPER v7.74 – v7.82, macOS arm64. Einzelne GIFs zeigen noch ältere Builds. Neu in dieser Version: siehe [Versionshinweise](#versionshinweise).

## Schnellstart: die erste Bewegung

Voraussetzung: Im Multi-AmbiEncoder_64 ist mindestens **eine Gruppe** mit Quellen angelegt. Im AmbiEncoder Solo gibt es keinen Animator.

1. **Animator öffnen:** im AmbiEncoder oben rechts auf den grünen **Animator**-Button klicken. Animator **OFF** lassen.
2. **Clip anlegen:** in der Werkzeugleiste **Add Movement Clip** (vier Pfeile) klicken. Der Clip erscheint auf der Movement-Spur von Group 1.
3. **Ziel setzen:** die Gruppe im Radar des AmbiEncoder an die Zielposition schieben, dann den Clip doppelklicken und unter den Target-Reglern auf **Apply** klicken. Mit **Apply** unten rechts bestätigen.
4. **Start setzen:** die Gruppe im Radar zurück an den Ausgangspunkt schieben.
5. **Abspielen:** Animator **ON** (Play-Button neben dem Animator-Button) und in der DAW **Play** drücken.

Die Gruppe fährt vom Ausgangspunkt zum Ziel:

{{< video name="AT-MOV-V01-MoveTo" >}}

{{< notice warning >}}
Solange der Animator **ON** ist, lassen sich Gruppen im Radar nicht von Hand verschieben. Zum Positionieren immer zuerst OFF schalten.
{{< /notice >}}

## Grundkonzept

Jede Gruppe hat einen **Gruppenpunkt** (im Radar G1, G2, …) und ihre **Quellen** rund um diesen Punkt. Der Animator arbeitet auf zwei Ebenen:

| Spur | Was sich bewegt | Beispiele |
|---|---|---|
| **Movement** | der **Gruppenpunkt**; alle Quellen fahren mit | Gerade, Bogen, Kreis, Spirale, Spline |
| **Action** | die **Quellen um den Gruppenpunkt**; der Gruppenpunkt bleibt stehen | Rotation X/Y/Z, Stretch, Jitter |

<svg viewBox="0 0 720 240" width="100%" style="max-width:720px;color:inherit" role="img" aria-label="Movement verschiebt den Gruppenpunkt, Action dreht die Quellen um den Gruppenpunkt">
  <defs>
    <marker id="anim-ah-m" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="8" markerHeight="8" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#e64980"/></marker>
    <marker id="anim-ah-a" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#339af0"/></marker>
  </defs>
  <g stroke="currentColor" stroke-width="1" opacity=".35" stroke-dasharray="2 3">
    <line x1="130" y1="135" x2="92" y2="104"/><line x1="130" y1="135" x2="168" y2="104"/><line x1="130" y1="135" x2="130" y2="182"/>
  </g>
  <g fill="none" stroke="currentColor" stroke-width="2">
    <circle cx="92" cy="104" r="7"/><circle cx="168" cy="104" r="7"/><circle cx="130" cy="182" r="7"/>
  </g>
  <circle cx="130" cy="135" r="10" fill="currentColor"/>
  <text x="130" y="139.5" text-anchor="middle" font-size="12" font-weight="700" font-family="sans-serif" fill="#fff" style="mix-blend-mode:difference">G</text>
  <path d="M152 134 C 270 50, 440 50, 532 116" fill="none" stroke="#e64980" stroke-width="2.5" marker-end="url(#anim-ah-m)"/>
  <circle cx="590" cy="135" r="52" fill="none" stroke="currentColor" stroke-width="1" opacity=".35" stroke-dasharray="3 4"/>
  <path d="M634.2 81.6 A 70 70 0 0 1 659.6 128.9" fill="none" stroke="#339af0" stroke-width="2.5" marker-end="url(#anim-ah-a)"/>
  <path d="M545.8 188.4 A 70 70 0 0 1 520.4 141.1" fill="none" stroke="#339af0" stroke-width="2.5" marker-end="url(#anim-ah-a)"/>
  <g fill="none" stroke="currentColor" stroke-width="2">
    <circle cx="555" cy="96" r="7"/><circle cx="634" cy="112" r="7"/><circle cx="582" cy="186" r="7"/>
  </g>
  <circle cx="590" cy="135" r="10" fill="currentColor"/>
  <text x="590" y="139.5" text-anchor="middle" font-size="12" font-weight="700" font-family="sans-serif" fill="#fff" style="mix-blend-mode:difference">G</text>
  <g font-family="sans-serif" font-size="14" fill="currentColor" text-anchor="middle">
    <text x="130" y="225">Gruppenpunkt G + Quellen</text>
    <text x="345" y="28" fill="#e64980" font-weight="600">Movement: Gruppenpunkt wandert</text>
    <text x="345" y="48" font-size="12" opacity=".75">die Quellen fahren mit</text>
    <text x="590" y="225" fill="#339af0" font-weight="600">Action: Quellen kreisen um G</text>
  </g>
</svg>

- Beide Spuren wirken **gleichzeitig**; pro Update-Schritt wird zuerst das Movement, dann die Action angewendet.
- Die Wiedergabe ist an den **DAW-Transport** gekoppelt: Play startet, Pause/Stop hält an, Loops werden verfolgt.
- Die Animation läuft auch bei **geschlossenem** Animator-Fenster weiter.
- Eine Rotation **um den Hörer** ist keine Action, sondern ein **Circle-Movement mit Center 0/0/0**

## Oberfläche

![Animator öffnen: Animator-Button (1) und Fenster (2), Gruppenpunkt (3), Movement-Spur (4), Spuren ohne Gruppe (5)](AT-BAS-03-Animator-oeffnen-Annotiert.png)

1. **Animator-Button** im AmbiEncoder öffnet das Fenster; der Play-Button links daneben schaltet ON/OFF.
2. **Animator-Fenster** mit Menüs und Werkzeugleiste.
3. **Gruppenpunkt** G1 im Radar.
4. **Movement- und Action-Spur** der Gruppe.
5. Spuren ohne zugehörige Gruppe sind schraffiert und als *(No Source)* markiert.

### Werkzeugleiste

| Symbol | Funktion |
|---|---|
| Vier Richtungspfeile | Add Movement Clip |
| Blitz | Add Action Clip |
| Papierkorb | Delete Selected Clips |
| Lupe − / + | Zoom Out / Zoom In |
| Rahmen | Reset Zoom |
| Pfeil an Linie | Toggle Auto-follow |
| Play-Button (rechts) | Animator ON / OFF |

{{< video name="AT-UI-07-Werkzeugleiste" autoplay="true" caption="Werkzeugleiste des Animators" >}}

<details>
<summary><strong>Menüs, Kürzel und Preferences</strong></summary>

**File:** Add Timeline (⌘N), Remove Timeline (eine Gruppe: Spur und Clips werden entfernt, die Gruppe im AmbiEncoder bleibt erhalten; oder alle ungültigen Spuren), Import, Export (einzelne Gruppe oder All Groups), Load Demo, Preferences.

**Edit:** Undo / Redo (⌘Z / ⌘Y; der Eintrag nennt den Schritt), Cut ⌘X, Copy ⌘C, Paste ⌘V, Duplicate ⌘D, Delete, Select All ⌘A, Deselect All (Esc). Unter Windows Ctrl statt ⌘.

**View:** Zoom (⌘= / ⌘−), Reset Zoom, Auto-follow. **Playback:** Toggle ON/OFF.

**File → Preferences:**

- **Time Unit:** Seconds (Standard) oder Milliseconds. Im Sekundenmodus bis zu drei Nachkommastellen; Komma und Punkt werden als Dezimaltrenner akzeptiert.
- **Automation Control:** siehe [Animator und DAW-Automation](#animator-und-daw-automation).

![Preferences mit Time Unit](AT-UI-08-Preferences-Time-Unit.png)

</details>

### Clips in der Timeline

- **Klick** wählt, **Doppelklick** öffnet den Clip-Editor; wiederholte Klicks an derselben Stelle wählen nacheinander die überlappenden Clips.
- **Ziehen** verschiebt, Ziehen an den Kanten kürzt oder verlängert; Kanten **rasten** an benachbarten Clips ein.
- Überlappungen auf einer Spur werden **rot** markiert.
- **M** schaltet Clips stumm; ein stummer Clip behält alle Daten.
- Rechteckauswahl mit ⌘-Ziehen; Copy/Paste auch zwischen Gruppen; **Undo/Redo** für alle Änderungen.

![Muted-Checkbox im Clip-Editor und stummgeschalteter Clip in der Timeline](AT-CLP-01-Muted-Annotiert.png)

## Movement-Clips

Doppelklick auf einen Movement-Clip öffnet **Edit Movement Clip** mit drei Bereichen: **Clip Properties** (Name, Zeit, Farbe, Muted, Timing), **Preview** (Live-Vorschau) und **Movement Properties** (Typ und Positionen).

![Bewegungstyp wählen (1), Live-Vorschau (2), Apply (3)](AT-MOV-N08-Movement-Typ-Auswahl.png)

1. **Movement Type:** einen der zehn Bewegungstypen wählen.
2. **Preview:** zeigt die Bahn des gewählten Typs; Punkte lassen sich hier ziehen.
3. **Apply:** übernimmt die Änderungen in den Clip und schliesst den Dialog.

{{< video name="AT-MOV-V01-Movement-Types-Tour" muted="true" caption="Rundgang durch alle Bewegungstypen im Editor." >}}

### Bewegungstypen und ihre Parameter

<!-- TODO prüfen: Parametermatrix gegen v4.0-Dialog abgleichen -->

| Typ | Bahn | Positionen | Typ-Parameter |
|---|---|---|---|
| **MoveTo (Cartesian)** | Gerade von Start zu Ziel | Start, Target | – |
| **MoveTo (Polar)** | Bogen bei konstanter Distanz, kürzester Weg über ±180° | Start, Target (A/E/D) | – |
| **Circle** | Kreis um einen Mittelpunkt | Start, Center | Rotations |
| **Spiral** | Kreis mit Radiusänderung pro Umlauf | Start, Center | Rotations, Radius change |
| **Helix** | Spirale mit Höhenanstieg | Start, Center | Rotations, Radius change, Height rise |
| **Spline** | Weiche Kurve durch Waypoints | Waypoints | Tension, Closed path |
| **Polygon** | Gerade Segmente zwischen Waypoints | Waypoints | Closed path |
| **Lissajous** | Lissajous-Figur um einen Mittelpunkt | Center | Frequency X/Y, Phase, Closed path |
| **Rose** | Rosenkurve um einen Mittelpunkt | Center | Petals, Phase |
| **Random Walk** | Weiches, rauschbasiertes Wandern | Center | Wander cycles, Seed |

Bei allen Typen mit Mittelpunkt definieren die **Target**-Felder den Mittelpunkt (Center).

**Parameter im Detail:**

- **Duration** bestimmt die Geschwindigkeit; Minimum 10 ms (wirkt wie ein Sprung). Kürzere Werte lehnt der Dialog mit „End time must be at least 10ms after start time“ ab.
- **Rotations:** Anzahl Umläufe, Bruchwerte erlaubt (1.2 = ein Umlauf + 72°); negativ = Gegenrichtung.
- **Radius change / rotation:** Radiusänderung pro Umlauf; 0.0 ergibt einen Kreis.
- **Height rise:** gesamter vertikaler Weg über den Clip.
- **Tension:** 0 = am rundesten, 1 = gerade Linien. **Closed path:** schliesst die Bahn.
- **Seed:** gleicher Seed = gleiche Bahn.

### Positionen setzen

- Werte eintippen, Punkte in der **Vorschau ziehen** oder die aktuelle Gruppenposition mit **Apply** unter den Reglern übernehmen.
- **Use Defined Start Position:** Der Clip startet an der definierten Startposition statt an der aktuellen Gruppenposition.
- **Show Polar Coordinates (AED):** zeigt alle Positionsfelder als Azimut/Elevation/Distanz.
- **Real-world scale:** Der Vorschaukreis wird zur Szenengrenze (Distance-Scaler des Projekts); ohne Häkchen zoomt die Vorschau auf den Clip.

![Edit Movement Clip mit AED-Feldern und Tooltip zu Real-world scale](AT-MOV-N10-AED-Anzeige.png)

1. **Show Polar Coordinates (AED)** – Positionsfelder als Azimut, Elevation und Distanz.
2. **Use Defined Start Position** – Start an der definierten statt an der aktuellen Position.
3. **Apply (Start)** – übernimmt die aktuelle Gruppenposition als Start.
4. **Apply (Target)** – übernimmt die aktuelle Gruppenposition als Ziel.
5. **Real-world scale** – Vorschaukreis = Szenengrenze.
6. **Apply** – übernimmt die Änderungen und schliesst den Dialog.

### Circle und Spiral

{{< video name="AT-MOV-P01-Circle-Playback" autoplay="true" caption="Circle-Clip in der Wiedergabe" >}}

{{< video name="AT-MOV-P02-Spiral-Playback" autoplay="true" caption="Spiral-Clip in der Wiedergabe" >}}

Bei **Radius change = 0** sind Spiral und Circle identisch; positive und negative Werte ergeben eine sichtbare Spirale:

{{< video name="AT-MOV-B03-Spiral-RadiusChange-minus2.0" autoplay="true" caption="Spiral mit Radius change −2.0" >}}

### Spline und Polygon: Waypoints

{{< video name="AT-MOV-V03-Spline-Waypoints-Stretch" caption="Spline mit Waypoints, kombiniert mit einer Stretch-Action." >}}

<details>
<summary><strong>Waypoints bearbeiten</strong></summary>

- X/Y/Z pro Zeile in der Tabelle eintragen, mit **Add / Remove** ergänzen oder löschen.
- Waypoints in der Vorschau **ziehen**; **⌘/Ctrl-Klick** hängt einen Waypoint an.
- **Doppelklick** auf die Bahn fügt einen Waypoint ein, Doppelklick auf einen Waypoint entfernt ihn.
- **Break** beginnt eine neue, getrennte Teilbahn; die Gruppe springt dorthin.
- **Closed path** verbindet den letzten Waypoint jeder Teilbahn mit dem ersten.

</details>

<!-- TODO Medien: je ein kurzes Video für Polygon, Lissajous, Rose, Helix, Random Walk, MoveTo (Polar) -->

### Übergänge zwischen Clips

Ist bei Clip 2 **Use Defined Start Position** aktiv, springt die Gruppe beim Start von Clip 2 an dessen Startposition. Für einen nahtlosen Übergang die Startposition von Clip 2 auf das Ziel von Clip 1 setzen **oder** Use Defined Start Position bei Clip 2 ausschalten.

## Timing: Speed curve, Repetitions, Palindrome

Jeder Clip, Movement wie Action, hat dieselben Timing-Optionen:

| Option | Wirkung |
|---|---|
| **Speed curve** | Bézier-Kurve für den Verlauf über die Clipdauer; Presets Linear, Ease In, Ease Out, Ease In-Out, Slow Start, Slow End |
| **Repetitions** | Bewegung n-mal, gestaucht in die bestehende Clipdauer (unabhängig von Rotations) |
| **Palindrome** | jede Wiederholung vorwärts, dann rückwärts; bei offenen Bahnen (MoveTo, Spline/Polygon offen, Random Walk) fest eingeschaltet |
| **Per repetition** | jeder Zyklus folgt der Kurve identisch |
| **Per direction** | Hin- und Rückweg folgen je der Kurve |

![Speed curve mit Presets](AT-CLP-06-Speed-Curve.png)

{{< video name="AT-MOV-V02-Spiral-Palindrome-Speed-Curve" caption="Spiral mit Palindrome und Speed curve (Rotations 1.8, Radius change 0.4)." >}}

Die **(i)**-Buttons in den Dialogen erklären jede Option kurz.

## Action-Clips

Ein Action-Clip transformiert die Quellen einer Gruppe um den Gruppenpunkt. Mehrere Actions lassen sich in einem Clip über **Add** stapeln; ein solcher Clip zeigt in der Timeline zwei Blitze.

**Add** öffnet den Dialog **Add New Action**, **Remove** entfernt die gewählte Action aus der Liste:

| Feld | Bedeutung |
|---|---|
| **Action Type** | Rotation X/Y/Z, Stretch oder Jitter |
| **Timing Type** | wie **Value** gelesen wird (siehe [Timing-Typen](#timing-typen)) |
| **Value** | Zielwert, Gesamtänderung oder Rate |
| **Use Start Value** / **Start Value** | fester Startwinkel bzw. Startfaktor |

| Typ | Wirkung | Video |
|---|---|---|
| **Rotation X / Y / Z** | Quellen drehen sich um die Achse durch den Gruppenpunkt | [X](#rotation-x) · [Y](#rotation-y) · [Z](#rotation-z) |
| **Stretch** | Ausdehnung der Gruppe wächst oder schrumpft; der angezeigte Wert (m/s) skaliert mit den Distanz-Einstellungen des Projekts | [Stretch](#stretch) |
| **Jitter** | zufälliges Wackeln (Intensity = Amplitude, Speed = Zyklen/s) | [Jitter](#jitter) |

### Timing-Typen

| Typ | Bedeutung |
|---|---|
| **Absolute Target** | Rotation/Stretch *auf* den angegebenen Wert |
| **Relative During Clip** | Gesamtänderung über die Clipdauer (z. B. 90° über 4 s) |
| **Constant Per Second** | konstante Rate (z. B. 30 °/s); negativ = Gegenrichtung |

{{< notice warning >}}
**Bei Rotation und Stretch immer *Use Start Value* setzen.** Ohne Startwert baut die Transformation auf dem aktuellen Zustand auf und summiert sich bei jedem Loop, Stop/Play und Pause/Resume. Mit Startwert (z. B. 0°) ist das Ergebnis jedes Mal gleich.
{{< /notice >}}

Bei Rotationen ist der Startwinkel absolut: Die Quellen springen beim Clipstart auf diesen Winkel, und alle Achsen des Clips werden absolut (Achsen ohne Startwinkel beginnen bei 0). Jitter hat weder Timing-Typ noch Startwert; der tatsächliche Maximalversatz beträgt etwa **die Hälfte** der angezeigten Intensity.

### Rotation X

{{< video name="AT-ACT-V01-Rotation-X" >}}

### Rotation Y

{{< video name="AT-ACT-V02-Rotation-Y" >}}

### Rotation Z

{{< video name="AT-ACT-V03-Rotation-Z" >}}

### Stretch

{{< video name="AT-ACT-V04-Stretch-Grow-Shrink" >}}

### Jitter

{{< video name="AT-ACT-V05-Jitter" >}}

## Rezepte

<!-- TODO prüfen: alle Werte im Plugin testen und ggf. anpassen; pro Rezept ein kurzes Video -->

Vorschläge für typische Kombinationen als Ausgangspunkt. Die Werte lassen sich frei anpassen. Tipp: Actions mit kleinen Werten beginnen (z. B. 10 °/s) und schrittweise steigern.

### Quellen in einer stehenden Gruppe drehen

| Spur | Einstellung |
|---|---|
| Action | **Rotation Z**, Constant Per Second 30 °/s, Use Start Value 0° |

Der Gruppenpunkt bleibt stehen, die Quellen kreisen um ihn. Ein negativer Wert kehrt die Richtung um.

### Kreis um den Hörer mit drehenden Quellen

| Spur | Einstellung |
|---|---|
| Movement | **Circle**, Center 0/0/0, Use Defined Start Position aus, Rotations 1, Duration 10 s |
| Action | **Rotation Z**, Constant Per Second 45 °/s, Use Start Value 0° |

Gruppe vorher mit etwas Abstand zum Ursprung platzieren. Die Gruppe umkreist den Hörer, die Quellen drehen sich zusätzlich um den Gruppenpunkt.

### Von A über B nach C ohne Sprung

| Clip | Einstellung |
|---|---|
| 1 | **MoveTo**, Target = A |
| 2 | **MoveTo**, Target = B, Use Defined Start Position aus |
| 3 | **MoveTo**, Target = C, Use Defined Start Position aus |

Clips direkt hintereinander legen (Snap). Jeder Clip startet dort, wo der vorherige endet.

### Pendel

| Spur | Einstellung |
|---|---|
| Movement | **MoveTo (Cartesian)**, Use Defined Start Position an, Start X −0.5, Target X +0.5, Duration 8 s, Repetitions 2, Palindrome, Speed curve *Ease In-Out*, Per direction |

Die Gruppe schwingt zwischen links und rechts und bremst an beiden Wendepunkten weich ab.

### Aufsteigende Spirale

| Spur | Einstellung |
|---|---|
| Movement | **Helix**, Center 0/0/0, Rotations 3, Radius change 0, Height rise 0.8, Duration 20 s, Speed curve *Slow Start* |

Gruppe vorher mit Abstand zum Ursprung platzieren; dieser Abstand ist der Radius der Spirale.

### Schwebende Wolke

| Spur | Einstellung |
|---|---|
| Movement | **Random Walk**, Center = aktuelle Gruppenposition, Wander cycles 2, Seed 1, Duration 30 s |
| Action | **Jitter**, Intensity 0.3, Speed 0.5 + **Stretch**, Absolute Target 1.5, Use Start Value 1.0 |

### Figur entlang Waypoints

| Spur | Einstellung |
|---|---|
| Movement | **Spline**, 4–6 Waypoints, Tension 0.5, Closed path |
| Action | **Stretch**, Relative During Clip, Use Start Value 1.0 |

Siehe das Video unter [Spline und Polygon](#spline-und-polygon-waypoints).

### Zum Hören: Rotation X neben einem Movement-Clip

Ein Action-Clip mit *Rotate X to −360°, starting from 0°* läuft neben einem Movement-Clip: Die Quellen kreisen um den Gruppenpunkt, das Encoder-Radar zeigt Front- und Draufsicht. Das Video hat Ton; mit Kopfhörern ist die Bewegung binaural hörbar.

{{< video name="AT-ACT-V01-Rotation-X-Absolute" caption="Rotation X (absolut, Startwert 0°) kombiniert mit einem Movement-Clip – mit Kopfhörern anhören." >}}

## Animator und DAW-Automation

Die Gruppenpositionen (X/Y/Z) sind normale Host-Parameter. **File → Preferences → Automation Control** legt fest, wer sie steuert:

| Modus | Der Animator steuert … |
|---|---|
| **Solange eingeschaltet** | immer, solange er ON ist |
| **Über seine Clips (pro Layer)** | vom ersten bis zum letzten Clip, Movement und Action getrennt |
| **Über seine Clips (kombiniert)** | wie oben, beide Layer gemeinsam (*Standard*) |
| **Nur während Clips** | nur während Clips; in jeder Lücke übernimmt die DAW-Automation |

Übernommen wird nur, was die Timeline tatsächlich mit Clips steuert. Der Animator selbst hat keinen automatisierbaren ON/OFF-Parameter.

## Szenen speichern und laden

Alle Timelines liegen automatisch im **Plugin-State**: DAW-Projekt speichern genügt. Szenen-Dateien dienen als Sicherung und zum Austausch zwischen Projekten.

- **File → Export → All Groups:** alle Timelines in einer XML-Datei, inkl. Distance-Scaler (empfohlen).
- **File → Export → Gruppe:** die Timeline einer Gruppe.
- **File → Load Demo:** ersetzt alle Timelines durch vier Beispielszenen.

<details>
<summary><strong>Import-Optionen</strong></summary>

**File → Import** öffnet nach der Dateiauswahl einen Dialog mit einer Zeile pro Gruppe der Datei:

| Aktion | Wirkung |
|---|---|
| **Ignore** | Gruppe wird nicht importiert |
| **Replace** | Timeline der Zielgruppe (oder New Group) wird ersetzt, Original-Timing bleibt |
| **Insert at Cursor** | Clips werden eingefügt, der früheste beginnt an der Cursor-Position |

Bei abweichendem Distance-Scaler fragt ein Dialog: **Rescale** (Positionen, Waypoints, Radius change, Height rise umrechnen) oder **Keep Original**. Rotationen und Stretch werden nie skaliert.

</details>

## Fehlerbehebung

| Problem | Lösung |
|---|---|
| Animator lässt sich nicht öffnen | AmbiEncoder **Multi** verwenden, nicht Solo |
| Clip zeigt keine Bewegung | Animator ON? DAW spielt? Start ≠ Ziel? Clip gemutet? |
| Action zeigt keine Wirkung | Mindestens eine Action im Clip? Timing-Typ und Value gesetzt? |
| Gruppe springt bei Clip 2 | Start von Clip 2 = Ziel von Clip 1 oder Use Defined Start Position aus |
| Änderung wirkt nicht | Transport stoppen und neu starten, sonst Projekt speichern und neu laden |
| Wiederholung springt zurück | Bei offenen Bahnen Palindrome verwenden |
| Loop läuft nicht identisch | *Use Start Value* bei Rotation/Stretch setzen |
| Animator „tut nichts“ | X/Y/Z-Automation und *Automation Control* prüfen |
| Gruppe lässt sich nicht verschieben | Animator OFF schalten |
| Polar-Bewegung nimmt unerwarteten Weg | Polar wählt immer den kürzesten Bogen; für Umrundungen Circle verwenden |

## Einschränkungen (v4.0)

<!-- TODO prüfen: gegen v4.0 abgleichen -->

- Clip-Änderungen während der Wiedergabe greifen teils erst beim nächsten Play-Start.
- Bewegungen können bis zu einem Audio-Block vor dem Ziel enden.
- **Circle** mit Startpunkt ober- oder unterhalb des Mittelpunkts wird in die Horizontale abgeflacht.
- Nicht samplegenau (Update pro Audio-Block) und nicht temposynchron (Zeiten in s/ms, nicht in Takten).
- Animator-Werte und ON/OFF erscheinen nicht als Host-Parameter.
- Gruppennamen aus dem AmbiEncoder werden nicht übernommen (generisch „Group N“).
- Die Undo-Historie wird beim Schliessen des Animator-Fensters gelöscht.

Die CPU-Last ist gering: im 12-minütigen Dauertest 0,11–0,18 % FX-CPU, kurzzeitig bis 0,28 % (Apple M2 Pro, REAPER 7.74, VST3).

## Begriffe

| Begriff | Bedeutung |
|---|---|
| **Gruppenpunkt** | Bezugspunkt einer Gruppe (G1, G2, …); Movement bewegt ihn, Action dreht und streckt um ihn |
| **Movement / Action** | die zwei Spuren (Layer) jeder Gruppen-Timeline |
| **Clip** | Baustein auf einer Spur mit Start, Dauer und Parametern |
| **Distance-Scaler** | Raumgrösse des Projekts im AmbiEncoder; Grundlage für Real-world scale und Rescale |
| **Use Start Value** | fester Startwinkel bzw. -faktor einer Action; macht Loops reproduzierbar |

## Versionshinweise

<!-- TODO Release: Neuerungen von 4.0 gegenüber 3.2.0.9 ergänzen -->

**4.0:** Der Animator ist Teil des neuen Releases ICST Ambisonics Plugins v4.0.

**3.2.0.9:** Automation Control, Slot-Bindung der Timelines an ihre Gruppe, Lissajous mit *Closed path*, Komma als Dezimaltrenner.

**3.2.0.8:** sechs neue Bewegungstypen (Spline, Polygon, Lissajous, Rose, Helix, Random Walk), Speed curve, Repetitions und Palindrome, Live-Vorschau, Undo/Redo, Clip-Muting, Jitter, absolute Rotation, zusätzlicher ON/OFF-Button im AmbiEncoder.

**3.2.0.7:** Zeitanzeige in s/ms, Clip-Snap, Überlappungsmarkierung, Load Demo, Rescale beim Import, korrekter Neustart bei DAW-Loops.

Der frühere dialogbasierte Animator wurde mit 3.2.0.5 entfernt; dessen Konfigurationen werden nicht mehr gelesen.

## Weiterführende Seiten

- [ICST Encoders](/icst-ambisonics-plugins/10_icst_encoders/)
- [OSC](/icst-ambisonics-plugins/13_osc/)
- [Best Practices](/icst-ambisonics-plugins/17_best_practices/)
