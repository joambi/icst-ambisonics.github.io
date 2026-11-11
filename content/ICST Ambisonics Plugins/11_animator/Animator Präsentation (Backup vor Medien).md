---
created: 2026-10-14
---
---

# ICST Animator v4.0 im ICST Multi-AmbiEncoder_64

Der Animator steht für die Animations-timeline oder für den Choreographie-Editor.
Im Animator lassen sich 
### Animator Overview

![[CleanShot 2026-10-14 at 12.40.41@2x.png]]
Bild 1: ICST Multi-AmbiEncoder_64 mit vier Gruppen und dem Animator
Jede Gruppe erhält ihre eigene Timeline, in der jeweils zwei Tracks liegen:
- Movement
- Action
Ist die Groupe im ICST Multi-Ambiencoder_64 nicht aktiviert, so erscheint sie "schraffiert".

---
### DEMO:

![[CleanShot 2026-10-14 at 13.41.17-converted.mp4]]
Video 1: Ein Demo des Animator im ICST Multi-AmbiEncoder_64

---

- Was ist und kann der Animator
- Was kann der Animator nicht
- Wie arbeite ich mit dem Animator
- Troubleshooting

---

## Was ist und kann der Animator

- Bewegt und transformiert **Quellgruppen** automatisch auf einer Timeline
- Gekoppelt an den **DAW-Transport** (Play, Stop, Loops)
- **Movement-Clips**: Der Gruppenpunkt bewegt sich entlang einer Bahn
- **Action-Clips**: Die Quellen rotieren, strecken oder wackeln um den Gruppenpunkt
- Beide wirken gleichzeitig: zuerst Movement, dann Action
- Öffnen über den grünen **Animator**-Button; der Play-Button daneben schaltet ON/OFF
- Die Animation läuft auch bei geschlossenem Fenster weiter

---

### Movement: 10 Bewegungstypen

| Typ | Bahn |
|---|---|
| MoveTo (Cartesian) | Gerade von Start zu Ziel |
| MoveTo (Polar) | Bogen (A/E/D), kürzester Weg über ±180° |
| Circle | Kreis um Mittelpunkt, Rotations (auch negativ/Bruchteil) |
| Spiral | Kreis mit Radiusänderung pro Umlauf |
| Spline | Weiche Kurve durch Waypoints (Tension), optional geschlossen |
| Polygon | Gerade Segmente zwischen Waypoints |
| Lissajous | Frequenz X/Y + Phase, optional geschlossen |
| Rose | Rosenkurve mit Anzahl Blätter |
| Helix | Spirale mit Höhenanstieg |
| Random Walk | Rauschbasiertes Wandern, reproduzierbar per Seed |

Rotation um den Hörer = Circle mit Center 0/0/0

---

### Action: Transformationen der Gruppe

| Typ | Wirkung |
|---|---|
| Rotation X / Y / Z | Quellen drehen sich um den Gruppenpunkt |
| Stretch | Ausdehnung der Gruppe ändert sich |
| Jitter | Zufälliges Wackeln (Intensity, Speed) |

**Timing-Typen:** Absolute Target · Relative During Clip · Constant Per Second

- Mehrere Actions pro Clip stapelbar
- **Use Start Value** + Absolute Target = reproduzierbar, auch bei Loops
- ⚠️ Bei Rotation und Stretch **immer Use Start Value** aktivieren, sonst summiert sich der Wert bei jedem Loop, Stop/Play und Pause/Resume
- Jitter: tatsächlicher Maximalversatz ≈ halbe angezeigte Intensity

---

### Timing jedes Clips

- **Speed curve**: Bézier-Editor mit Presets (Linear, Ease In/Out, Slow Start/End)
- **Repetitions**: Bewegung n-mal innerhalb der Clipdauer
- **Palindrome**: vorwärts, dann rückwärts (bei offenen Bahnen nötig)
- **Per repetition / Per direction**: wie die Kurve auf die Zyklen angewendet wird
- Mindestdauer 10 ms (= Sprung)

---

### Animator vs. DAW-Automation

Preferences → *Automation Control*:

1. **Solange eingeschaltet**: Der Animator besitzt die Gruppen immer
2. **Über seine Clips (pro Layer)**: vom ersten bis letzten Clip, Movement und Action getrennt
3. **Über seine Clips (kombiniert)**: wie 2, beide Layer gemeinsam (*Standard*)
4. **Nur während Clips**: Die Automation hat jede Lücke

Übernommen wird nur, was die Timeline tatsächlich mit Clips steuert.

> [!note] Neu ab 3.2.0.9, noch nicht auf ambisonics.ch
> Bis 3.2.0.8 gilt: Aufgezeichnete X/Y/Z-Automation (*Read*) gewinnt immer. Hüllkurven bypassen, wenn der Animator die Gruppe steuern soll.

---

### Kombinationen (Beispiele)

- Circle um Ursprung + Rotation Z: Die Gruppe umkreist den Hörer, die Quellen drehen sich
- Rotation Z allein (z. B. 30 °/s): Gruppenpunkt bleibt stehen, die Quellen kreisen um ihn
- Zwei MoveTo-Clips hintereinander: Position A, dann B (Start Clip 2 = Ziel Clip 1)
- MoveTo + Stretch: Die Gruppe fährt zum Ziel und dehnt sich
- Spline/Lissajous + Jitter: kontrollierte Bahn mit organischer Textur
- Rotation X + Rotation Z in einem Clip

---

## Was kann der Animator nicht

- Nicht tempo-synchron (ms/s statt Takte), nicht sample-genau
- Animator-Werte erscheinen nicht als DAW-Automation; ON/OFF ist kein Host-Parameter
- Gruppennamen aus dem Encoder werden nicht übernommen
- Rotation/Stretch ohne Startwert driften bei Loops
- Clip-Änderungen während der Wiedergabe greifen teils erst beim nächsten Play-Start
- Bewegungen enden bis zu einem Audio-Block vor dem Ziel
- **Circle** mit Startpunkt ober-/unterhalb des Mittelpunkts wird in die Horizontale abgeflacht
- **Lissajous** kehrt nicht unbedingt zum Start zurück (ab 3.2.0.9: *Closed path*)
- Bei Animator ON keine manuelle Positionierung im Radar
- Undo-Historie wird beim Schliessen des Fensters gelöscht
- CPU-Last vernachlässigbar (< 0,3 %)

> [!todo] Stand ambisonics.ch = 3.2.0.8, Vault-Analyse = 3.2.0.9 – mit v4.0 abgleichen

---

## Wie arbeite ich mit dem Animator

1. Gruppen und Quellen im Encoder einrichten
2. Animator öffnen, **OFF** lassen, Clips anlegen
3. Gruppe im Radar positionieren → Clip doppelklicken → **Apply** übernimmt die Position
4. Oder Punkte direkt in der **Live-Vorschau** ziehen
5. Animator **ON**, DAW Play
6. Einzelne Clips kurz testen, dann kombinieren
7. **File → Export → All Groups** und DAW-Projekt speichern

Tipp: Movements zuerst mit kurzer Dauer testen, Actions mit kleinen Werten (z. B. 10 °/s) beginnen.

---

### Schnellstart: Gruppe zu einer Position bewegen

1. Animator **OFF**, Gruppenspur wählen, Playhead auf Startzeit
2. **Add Movement Clip** → Clip mit 1000 ms Standarddauer
3. Gruppe im Radar an die **Zielposition** schieben
4. Doppelklick auf den Clip → **Apply unter Target** übernimmt die Position
5. Mit **Apply** (unten rechts) bestätigen
6. Gruppe an die Ausgangsposition schieben, Animator **ON**, DAW Play

→ Die Gruppe fährt zum Ziel und bleibt dort stehen.

---

### Timeline und Szenen

- Clips ziehen, kürzen, verlängern; **Snap** an anderen Clips; Überlappungen **rot**
- **M** schaltet Clips stumm; **Undo/Redo** (⌘Z / ⌘Y)
- Cut/Copy/Paste/Duplicate, auch zwischen Gruppen
- **Load Demo**: vier Beispielszenen
- Timelines liegen automatisch im **Plugin-State** des Projekts
- **Import** pro Gruppe: Ignore · Replace · Insert at Cursor; bei anderem Distance-Scaler **Rescale** oder **Keep Original**

---

## Troubleshooting

| Problem | Lösung |
|---|---|
| Animator öffnet nicht | AmbiEncoder **Multi** verwenden, nicht Solo |
| Clip zeigt keine Bewegung | Animator ON? DAW spielt? Start ≠ Ziel? Clip gemutet? |
| Action-Clip ohne Wirkung | Mindestens eine Action im Clip? Timing-Typ und Value gesetzt? |
| Polar-Bewegung nimmt unerwarteten Weg | Polar wählt immer den kürzesten Bogen; für Gerade Cartesian, für Umrundung Circle |
| Gruppe springt bei Clip 2 | Start von Clip 2 = Ziel von Clip 1 setzen |
| Änderung wirkt nicht | Transport stoppen/neu starten, sonst Projekt neu laden |
| Wiederholung springt zurück | Bei offenen Bahnen **Palindrome** aktivieren |
| Loop läuft nicht identisch | Use Start Value setzen (oranger Eckmarker) |
| Animator „tut nichts“ | X/Y/Z-Automation bypassen bzw. Modus unter *Automation Control* prüfen |
| „1,5“ wird zu 15 | Punkt statt Komma tippen (ab 3.2.0.9 behoben) |
| Gruppe gelöscht, Timelines verrutscht | Gruppenstruktur zuerst festlegen, vorher *Export All Groups* (ab 3.2.0.9 Slot-Bindung) |

---
©ICST 2026
