---
title: "User Guide: 64 Quellen mit open-stage-control und ICST AmbiEncoder_64"
date: 2026-08-19T00:00:00
weight: 121
draft: false
toc: true
description: "User Guide für die Steuerung von 64 Quellen mit open-stage-control und dem ICST AmbiEncoder_64 in REAPER."
---

Niveau: Fortgeschritten | Zielgruppe: Komponierende, Technik, Studierende, Live-Elektronik-Anwender:innen.

{{< figure
  src="ICST-AmbiPlugin_Open-Stage-control.jpeg"
  alt="open-stage-control mit ICST AmbiEncoder_64"
  caption="open-stage-control-Session zur Steuerung von 64 Quellen mit dem ICST AmbiEncoder_64."
>}}

Dieser User Guide beschreibt die aktuelle `XYZ`-Session für `open-stage-control` in Verbindung mit dem `ICST AmbiEncoder_64`.

Download:

- [64-source-points-tablet-xyz.session.json](/icst-ambisonics-plugins/13a_open_stage_control_64_sources/64-source-points-tablet-xyz.session.json)

Die Session steuert kartesisch in `XYZ` und ist für die direkte Arbeit mit dem Plugin-Radar aufgebaut:

- oben = Front
- rechts = Rechts
- `+X` zeigt nach rechts
- `+Y` zeigt nach vorne

Der linke Fader steuert `Z` (Höhe, `-1..1`) statt `Distance`. Pad und Plugin-Radar entsprechen sich in dieser Session daher direkt.

Die Session sendet ICST-kompatibles OSC an den `AmbiEncoder_64`:

- `/icst/ambi/sourceindex/xyz [Index] [X] [Y] [Z]`
- `/icst/ambi/sourceindex/gain [Index] [Gain]`

Der Source-Index ist 1-basiert. Der Gain-Fader zeigt dB an; gesendet wird ein linearer Faktor (siehe [7. Fehlersuche](#7-fehlersuche)).

## 1. REAPER und AmbiEncoder_64 vorbereiten

1. Öffne dein REAPER-Projekt oder lege ein neues an.
2. Lege einen Track an, der den Encoder tragen soll, und füge `ICST AmbiEncoder_64` als Insert-FX ein.
3. Achte darauf, dass der Track genügend Kanäle hat (`Track Routing` > `Track channels`), sonst arbeitet der 64er-Encoder nicht vollständig.
4. Öffne das Plugin-Fenster des `AmbiEncoder_64`.
5. Öffne im Plugin den OSC-Bereich und aktiviere `OSC In` (`Receive`).
6. Notiere dir den dort eingestellten Empfangsport. Der typische Default aus den ICST-Tutorials ist `50001`, massgeblich ist aber immer der Port, der tatsächlich im Plugin hinterlegt ist.
7. Lass das Plugin-Fenster für den ersten Test geöffnet, damit du sehen kannst, ob sich die Quellen bewegen.

## 2. open-stage-control starten

1. Starte `open-stage-control`. Zuerst öffnet sich der Launcher.
2. Trage im Launcher bei `send` das OSC-Ziel ein:

   - REAPER auf demselben Rechner: `127.0.0.1:50001`
   - REAPER auf einem anderen Rechner: `IP-des-REAPER-Rechners:50001`
   - Falls nötig: den Port aus Teil 1 verwenden

3. Trage bei `Port` den HTTP-Port für die Bedienoberfläche ein, zum Beispiel `8080`.
4. Klicke auf `Start`. Es öffnet sich die leere Oberfläche im Browser oder App-Fenster.
5. Lade die Session über `Menu` > `Session` > `Open` und wähle `64-source-points-tablet-xyz.session.json`. Alternativ kannst du die Datei per Drag-and-drop ins Fenster ziehen.

{{< figure
  src="open-stage-control-setup.png"
  alt="open-stage-control-Launcher mit Send-Ziel 127.0.0.1:50001 und Port 8080"
  caption="Beispiel für die Launcher-Einstellungen in open-stage-control: OSC-Ziel auf den AmbiEncoder-Port und HTTP-Port für die Bedienoberfläche."
>}}

## 3. Tablet verbinden

1. Verbinde das Tablet mit demselben Netzwerk wie den Rechner, auf dem `open-stage-control` läuft.
2. Finde die IP-Adresse dieses Rechners heraus.

   - macOS: `Systemeinstellungen` > `Netzwerk`
   - alternativ im Terminal: `ipconfig getifaddr en0`

3. Öffne auf dem Tablet einen Browser und rufe `http://IP-des-Rechners:8080` auf. Wenn du einen anderen HTTP-Port gesetzt hast, verwende diesen.
4. Die Oberfläche erscheint im Browser. Für Vollbild auf dem iPad: Seite über `Teilen` > `Zum Home-Bildschirm` ablegen und von dort starten.
5. Wichtig: Das Tablet spricht nur mit `open-stage-control`. Das OSC an REAPER schickt der Rechner, auf dem `open-stage-control` läuft.

## 4. Erster Funktionstest

1. Gehe in der Oberfläche zum Tab `Select + Focus`.
2. Drücke unten rechts den blauen Button `Alle 64 senden (Sync)`.

   Dieser Button schickt alle Positionen und Gains einmal ans Plugin. Danach zeigen Oberfläche und Plugin denselben Stand. Dieser Schritt ist nach jedem Start von `open-stage-control` der erste.

3. Tippe im Raster links auf `S1`. Der Button wird orange, rechts steht `Source 1`.
4. Bewege den Punkt im grossen `XY`-Pad.
5. Schau ins Plugin-Fenster des `AmbiEncoder_64`: Quelle 1 muss sich mitbewegen.
6. Bewege danach den `Z`- und den `Gain dB`-Fader und prüfe die Reaktion im Plugin.
7. Wenn das funktioniert, teste einen Bank-Tab wie `S1-8` und bewege dort mehrere Punkte gleichzeitig.

Hinweis zur Darstellung: Das Pad ist in dieser Session eine Draufsicht in `XYZ`. Deshalb entspricht es dem Plugin-Radar direkt.

Wenn sich in Schritt 4 nichts bewegt, siehe [7. Fehlersuche](#7-fehlersuche).

## 5. Bedienung im Überblick

### Tab `Select + Focus`

1. Quelle wählen: Im `8x8`-Raster links auf den gewünschten Button tippen. Die aktive Quelle ist orange markiert.
2. Position setzen: den Punkt im grossen Pad rechts bewegen. Die Session arbeitet kartesisch in `X/Y`.
3. `Z (-1..1)` und `Gain (dB) (-60..+12)` mit den beiden horizontalen Fadern einstellen. Beide Fader haben ein Zahlenfeld für präzise Eingaben.
4. Umbenennen: oben rechts ins Textfeld tippen, den Namen eingeben und bestätigen. Der Name erscheint sofort auf dem Raster-Button. Ohne eigenen Namen zeigt der Button `S1` bis `S64` an.

### Bank-Tabs `S1-8` bis `S57-64`

1. Öffne den Tab der gewünschten Gruppe.
2. Im grossen Multi-XY lassen sich einzelne oder mehrere Punkte gleichzeitig bewegen (`Multitouch`).
3. Jeder Punkt sendet sofort seine `XYZ`-Message.
4. Die Quellen sind gleichmässig im Pad angeordnet. So siehst du sofort, welcher Punkt welcher Quelle entspricht.

## 6. Speichern

1. Positionen und Namen ändern sich während der Session. Wenn du den Zustand behalten willst, wähle in `open-stage-control` `Menu` > `Session` > `Save` oder `Save As`, am besten unter neuem Namen.
2. Die Einstellungen im `AmbiEncoder_64`, inklusive der zuletzt empfangenen Positionen, speicherst du wie gewohnt im REAPER-Projekt mit `Cmd+S`.

## 7. Fehlersuche

### Es kommt nichts im Plugin an

1. Ist `OSC In` im `AmbiEncoder_64` wirklich aktiviert?
2. Stimmen Host und Port in den `send`-Einstellungen von `open-stage-control` exakt mit dem Plugin überein?
3. Blockiert eine Firewall eingehende UDP-Pakete auf dem REAPER-Rechner?
4. Läuft versehentlich eine zweite Instanz von `open-stage-control` ohne Send-Ziel?

### Das Tablet findet die Oberfläche nicht

1. Sind Tablet und Rechner im selben Netzwerk?
2. Stimmen IP-Adresse und HTTP-Port in der Browser-Adresse überein?
3. Verwende `http://`, nicht `https://`.
4. Erlaube eingehende Verbindungen für `open-stage-control` in der Firewall.

### Die falsche Quelle bewegt sich

1. Der Source-Index ist 1-basiert: `S1` in der Oberfläche entspricht Quelle 1 im Plugin.
2. Prüfe, ob im Raster tatsächlich die gewünschte Quelle orange markiert ist.

### Bewegungen ruckeln im Netzwerk

1. Prüfe die WLAN-Qualität.
2. Schliesse den Rechner bei Bedarf per Kabel an.
3. Nimm andere Geräte mit hohem Traffic aus dem WLAN.

### Plugin und Oberfläche zeigen unterschiedliche Positionen

1. `open-stage-control` sendet beim Start nichts von selbst. Drücke nach jedem Start einmal `Alle 64 senden (Sync)`.

### Plugin meldet `Unknown OSC message received`

1. Es läuft eine veraltete Session-Kopie, zum Beispiel aus `~/Downloads`.
2. Verwende nur die aktuelle Session-Datei von dieser Seite.
3. Nach Dateiänderungen `open-stage-control` neu starten. Laufende Sessions laden Änderungen nicht automatisch nach.

### Plugin meldet `Malformed OSC message`

1. Der Source-Index muss als Integer ankommen, nicht als Float.
2. Die Session typisiert ihn in den Skripten korrekt als `{type: 'i'}`.

### Gain-Fader bewegt sich, aber das Plugin springt auf `-88 dB`

1. Dieser Plugin-Build erwartet den Gain als linearen Faktor, nicht in dB.
2. Die Session rechnet deshalb beim Senden um: Der Fader zeigt dB (`-60..+12`), gesendet wird `10^(dB/20)`.
3. `0 dB` entspricht dem Faktor `1.0`.
4. Bestätigt am `18.08.2026`.

### Hinweise für künftige Session-Änderungen in open-stage-control v1.29

1. Script-Code gehört in die Widget-Eigenschaft `onValue`, nicht in `script`.
2. Das Shared-State-Objekt heisst `globals`, nicht `global`.
3. `send()` ohne Target-Argument sendet an den Launcher-Default. `send(false, ...)` ist ungültig.
4. Jedes Widget, auch Panels und Tabs, braucht `"bypass": true`, sonst sendet es seinen Rohwert.
5. Die Konsole unten im `open-stage-control`-Fenster zeigt Skriptfehler an. Dort zuerst nachsehen.

## 8. Diese Session

`64-source-points-tablet-xyz.session.json` steuert in Bühnenkoordinaten (`XYZ`). Das Pad ist eine Draufsicht wie das Plugin-Radar, beide entsprechen sich direkt. Diese Seite beschreibt ausschliesslich diese aktuelle `XYZ`-Version.

## Quellen

- [ICST AmbiEncoder – OSC-Syntax](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
- [OSC](/de/icst-ambisonics-plugins/13_osc/)
- [Motion Map Setup](/de/icst-ambisonics-plugins/16_motion_map_setup/)
