---
title: Szenen-Rotation – Das gesamte B-Format-Feld drehen
description: "Wie du eine Ambisonics-Szene als Ganzes rotierst: IEM SceneRotator und SPARTA Rotator im REAPER-Workflow, OSC-Adressen, REAPER-Automations-Envelopes und drei typische Anwendungsfälle – Livekorrektur, Nachbearbeitung und kompositorische Rotation."
date: 2026-03-21T18:30:00+01:00
year: 2026
month: 2026-03
weight: 39
tags: ["rotation", "scenerotator", "sparta", "iem", "osc", "automation", "b-format", "transform", "live", "workflow"]
key_points:
  - "Szenen-Rotation dreht das gesamte B-Format-Feld – alle Quellen rotieren gleichzeitig"
  - "IEM SceneRotator unterstützt Euler-Winkel (Yaw/Pitch/Roll) und Quaternionen – beide via OSC steuerbar"
  - "REAPER-Automation-Envelopes erlauben kompositorische Rotation als parametrische Kurve"
difficulty: "intermediate"
---

Level: Intermediate | **Audience:** Komponist:in, Live-Techniker:in, Recording-Techniker:in.

---

Ambisonics hat gegenüber kanalbasierten Formaten einen entscheidenden Vorteil: Das B-Format-Feld ist rotationsinvariant. Eine gespeicherte Ambisonics-Szene lässt sich jederzeit nachträglich drehen – ohne Qualitätsverlust, ohne neue Encoder-Durchläufe, ohne die Quellen einzeln anzufassen. Dieser Artikel zeigt, wie diese Rotation in der Praxis funktioniert.

---

## Szenen-Rotation vs. Objekt-Rotation

Es gibt zwei grundlegend verschiedene Arten, räumliche Positionen in Ambisonics zu bewegen:

**Objekt-Rotation** (ICST AmbiEncoder / AmbiAnimator): Einzelne Quellen werden an andere Positionen bewegt. Azimut, Elevation und Distanz einer Quelle ändern sich. Alle anderen Quellen bleiben wo sie sind.

**Szenen-Rotation** (IEM SceneRotator / SPARTA Rotator): Das gesamte B-Format-Feld wird als Einheit gedreht. Alle Quellen in der Szene rotieren gleichzeitig – inklusive aufgenommener Ambisonics-Felder, die keine einzelnen Objekte mehr haben. Das ist der Werkzeugtyp, der in diesem Artikel behandelt wird.

| | Objekt-Rotation | Szenen-Rotation |
|---|---|---|
| Eingabe | Einzelne Quellen mit Positions-Parametern | B-Format-Masterbus |
| Granularität | Pro Quelle | Gesamtes Feld |
| Plugin | ICST AmbiEncoder / Animator | IEM SceneRotator, SPARTA Rotator |
| Typischer Einsatz | Kompositorische Bewegung | Orientierungskorrektur, Live-Headtracking |

---

## IEM SceneRotator

Das Plugin aus der IEM Plug-in Suite ist die empfohlene Lösung im ICST-Workflow, weil es SN3D/ACN-kompatibel ist und nahtlos mit den anderen IEM-Plugins zusammenarbeitet.

### Platzierung in der Signal-Chain

```
[Quellen] → [ICST AmbiEncoder] → [B-Format Bus] → [IEM SceneRotator] → [ICST AmbiDecoder / BinauralDecoder]
```

Der SceneRotator sitzt **auf dem B-Format-Master-Bus**, nach den Encodern und vor dem Decoder. Er bekommt das vollständige Multikanal-Signal und gibt es rotiert weiter.

### Parameter

**Euler-Winkel-Modus (Standard):**

| Parameter | Bereich | Bedeutung |
|---|---|---|
| Yaw | –180° bis +180° | Horizontale Rotation (Kompass-Drehung) |
| Pitch | –180° bis +180° | Vertikale Kippung (nach vorne / hinten kippen) |
| Roll | –180° bis +180° | Längsachsen-Drehung (um die Vorne-hinten-Achse rollen) |
| Rotationsreihenfolge | Yaw→Pitch→Roll oder Roll→Pitch→Yaw | Bestimmt die Reihenfolge der Winkelanwendung |

**Quaternionen-Modus (alternativ):**
Vier Parameter (qw, qx, qy, qz) statt Euler-Winkeln. Vorteil: kein Gimbal Lock, stabiler bei kontinuierlichen Rotationen. Für Head-Tracking mit Geräten, die Quaternionen ausgeben (z.B. MrHeadTracker), direkter verwendbar.

**Normalisierung:**
`useSN3D`: SN3D = 1 (Standard im ICST-Workflow). N3D = 0 nur wenn die gesamte Session auf N3D normiert ist.

### Ordnungs-Erkennung

Der IEM SceneRotator erkennt die Kanalzahl des Busses automatisch (`orderSetting = 0 = Auto`) und passt die Rotationsmatrix entsprechend an. Das Plugin rechnet korrekt für jede Ordnung von FOA bis HOA7.

---

## SPARTA Rotator

Teil der SPARTA Spatial Audio Suite. Einsatz sinnvoll wenn du SPARTA-Plugins bereits in der Session verwendest oder SOFA-basiertes Head-Tracking brauchst.

- Unterstützt Yaw/Pitch/Roll und Quaternionen
- OSC-Empfang für Head-Tracking via externem Gerät
- Kann Rotationsachsen invertieren – nützlich wenn das Tracking-Gerät eine andere Vorzeichenkonvention hat
- Bis 10th Order

---

## REAPER-Automation: Rotation als kompositorische Kurve

Rotation lässt sich in REAPER wie jeder andere Parameter automatisieren. Das ermöglicht kompositorische Rotation als Envelope – eine langsam rotierende Szene, eine abrupte Orientierungsänderung als dramatisches Mittel, oder eine oszillierende Pendelbewegung.

**Envelope anlegen:**

1. SceneRotator auf dem B-Format-Bus als FX einrichten
2. Auf dem Track-Panel den Automations-Button (Trim/Read) klicken → *Write* wählen
3. Im Arrange View unten am Track den Yaw-Envelope aufklappen (FX-Parameter → SceneRotator → Yaw)
4. Envelope-Punkte manuell setzen oder im *Write*-Modus live aufnehmen
5. Envelope-Modus auf *Read* zurückschalten für die Wiedergabe

**Envelope-Typen für Rotation:**

- *Langsame Gesamtrotation*: Linearer Yaw-Envelope von 0° auf 360° über die Stücklänge – die Szene dreht sich kontinuierlich
- *Schnelle Umorientierung*: Stufenförmiger Envelope (Hold-Punkt) – Szene springt schlagartig auf neuen Winkel
- *Pendeln*: Sinusförmige LFO-Kurve auf dem Yaw – Szene schwingt zwischen zwei Richtungen

---

## OSC-Steuerung

Der IEM SceneRotator empfängt OSC-Nachrichten auf einem konfigurierbaren Port. Setup:

1. Plugin öffnen → OSC-Status-Anzeige (unten links, neben IEM-Logo) anklicken
2. Empfangs-Port einstellen (z.B. 9000) → *OPEN* klicken
3. Grüne Statuskreise bestätigen die Verbindung

**OSC-Adressen:**

```
# Einzelne Euler-Winkel
/SceneRotator/yaw   45.0
/SceneRotator/pitch -15.0
/SceneRotator/roll   0.0

# Alle drei gleichzeitig
/SceneRotator/ypr   45.0 -15.0 0.0

# Quaternionen
/SceneRotator/quaternions  0.707 0.0 0.707 0.0
```

OSC-Sender: Max/MSP, Pure Data, GyrOSC (iPhone), MrHeadTracker, oder jede andere OSC-fähige Umgebung.

---

## Drei typische Anwendungsfälle

### 1. Live-Korrektur der Szenen-Orientierung

Ein Ambisonics-Mikrofon wurde mit der Frontseite nicht exakt in Richtung der Hauptquelle gehalten. Das aufgenommene Feld ist um 30° nach rechts verdreht. Mit dem SceneRotator: Yaw = –30° statisch setzen. Die gesamte Szene ist korrigiert.

In Live-Situations: Wenn das Mikrofon live platziert wird und die Orientierung nicht immer identisch ist, kann eine OSC-Steuerung die Orientierung in Echtzeit anpassen.

### 2. Head-Tracking im Binaural-Monitoring

Im Binaural-Workflow (IEM BinauralDecoder oder SPARTA AmbiBIN) lässt sich die Szene live drehen, um die Kopfbewegung des Hörers zu kompensieren – die Szene bleibt stationär, der Hörer bewegt sich darin. Signal-Chain für Head-Tracking:

```
[GyrOSC / MrHeadTracker] → [OSC → /SceneRotator/ypr] → [IEM SceneRotator] → [IEM BinauralDecoder] → Kopfhörer
```

GyrOSC auf dem iPhone sendet Yaw/Pitch/Roll direkt als OSC. Der SceneRotator dreht die Szene entsprechend gegenläufig. Das Ergebnis: stabile räumliche Szene trotz Kopfbewegung.

### 3. Kompositorische Rotation als Gestaltungsmittel

Die permanente Rotation einer Ambisonics-Szene als kompositorisches Element – ähnlich wie ein Kamerafahrt in Film. Mögliche Gesten:

- *Orbiting*: Langsame Yaw-Rotation über mehrere Minuten – der Hörer steht still, die Klangwelt dreht sich
- *Auskippen*: Pitch-Envelope von 0° auf 90° – die Szene kippt aus der horizontalen in die vertikale Ebene
- *Spinning*: Schnelle Yaw-Rotation als rhythmisches Element (z.B. auf Schlag synchronisiert via REAPER-Envelope)

---

## Rotation und Encoder-Objekte: Kombination

In einer Produktion mit gemischten Quellen (aufgenommene Ambisonics-Felder + Encoder-Objekte) kann ein SceneRotator den aufgenommenen Teil der Szene unabhängig von den Encoder-Objekten rotieren:

```
[Aufnahme-Track B-Format]  → [SceneRotator] ──┐
                                               ├── [Summierungsbus] → [AmbiDecoder]
[Encoder-Tracks]           ────────────────────┘
```

So dreht sich nur der aufgenommene Raumklang, während die komponierten Objekte an ihren Positionen bleiben – oder umgekehrt.

---

## Weiterführende Seiten

- [Ambisonics-Mikrofon aufnehmen – A-Format, B-Format und die ICST-Integration](/post/ambisonics-mikrofon-a-format-b-format/)
- [Binaural Monitoring im ICST-Workflow](/post/binaural-monitoring-icst-workflow/)
- [GyrOSC & ICST AmbiPlugins](/post/gyrosc-icst-ambi/)
- [ICST AmbiEncoder – OSC Syntax](/post/icst-ambiencoder-osc-syntax/)
- [Warum der Decoder klingt wie er klingt – Methodischer Kontext](/post/decoder-methodischer-kontext/)
