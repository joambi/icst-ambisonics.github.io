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
post_kind: "tutorial"
tool: ["REAPER", "OSC"]
---

Level: Intermediate | **Audience:** Komponist:in, Live-Techniker:in, Recording-Techniker:in.

---

Ambisonics hat gegenüber kanalbasierten Formaten einen entscheidenden Vorteil: Das B-Format-Feld ist rotationsinvariant. Eine gespeicherte Ambisonics-Szene lässt sich jederzeit nachträglich drehen – ohne Qualitätsverlust, ohne neue Encoder-Durchläufe, ohne die Quellen einzeln anzufassen. Dieser Artikel zeigt, wie diese Rotation in der Praxis funktioniert.

---

## Szenen-Rotation vs. Objekt-Rotation

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Links: eine Quelle wandert an eine neue Position. Rechts: die ganze Szene dreht sich um die Hörposition." xmlns="http://www.w3.org/2000/svg"><defs><marker id="mr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="180" y="22" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Objekt-Rotation</text><circle cx="180" cy="132" r="72" fill="none" stroke="currentColor" stroke-opacity=".35" stroke-width="1.5"/><circle cx="180" cy="132" r="4" fill="currentColor"/><text x="540" y="22" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Szenen-Rotation</text><circle cx="540" cy="132" r="72" fill="none" stroke="currentColor" stroke-opacity=".35" stroke-width="1.5"/><circle cx="540" cy="132" r="4" fill="currentColor"/><circle cx="180.0" cy="86.0" r="9" fill="#3fa968" fill-opacity=".85"/><circle cx="140.2" cy="155.0" r="9" fill="#3fa968" fill-opacity=".85"/><circle cx="217.7" cy="158.4" r="9" fill="none" stroke="#d9534f" stroke-width="1.5" stroke-dasharray="3 3"/><circle cx="221.7" cy="112.6" r="9" fill="#d9534f" fill-opacity=".9"/><path d="M230.6 151.6 A56 56 0 0 0 234.6 126.9" fill="none" stroke="currentColor" stroke-width="1.6" marker-end="url(#mr)"/><circle cx="540.0" cy="86.0" r="9" fill="none" stroke="#3fa968" stroke-width="1.5" stroke-dasharray="3 3"/><circle cx="577.7" cy="105.6" r="9" fill="#3fa968" fill-opacity=".85"/><circle cx="577.7" cy="158.4" r="9" fill="none" stroke="#d9534f" stroke-width="1.5" stroke-dasharray="3 3"/><circle cx="540.0" cy="178.0" r="9" fill="#d9534f" fill-opacity=".85"/><circle cx="500.2" cy="155.0" r="9" fill="none" stroke="#3fa968" stroke-width="1.5" stroke-dasharray="3 3"/><circle cx="498.3" cy="112.6" r="9" fill="#3fa968" fill-opacity=".85"/><path d="M462.1 87.0 A90 90 0 0 1 585.0 54.1" fill="none" stroke="currentColor" stroke-width="1.6" marker-end="url(#mr)"/><text x="180" y="238" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">AmbiEncoder / Animator: eine Quelle bewegt sich</text><text x="540" y="238" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">SceneRotator auf dem B-Format-Bus: das ganze Feld dreht sich</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Objekt-Rotation bewegt eine Quelle; Szenen-Rotation dreht alles auf einmal.</figcaption>
</figure>




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

- [Ambisonics-Mikrofon aufnehmen – A-Format, B-Format und die ICST-Integration](/de/post/ambisonics-mikrofon-a-format-b-format/)
- [Binaural Monitoring im ICST-Workflow](/de/post/binaural-monitoring-icst-workflow/)
- [GyrOSC & ICST AmbiPlugins](/de/post/gyrosc/)
- [ICST AmbiEncoder – OSC Syntax](/de/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
- [Warum der Decoder klingt wie er klingt – Methodischer Kontext](/de/post/decoder-methodological-context/)
