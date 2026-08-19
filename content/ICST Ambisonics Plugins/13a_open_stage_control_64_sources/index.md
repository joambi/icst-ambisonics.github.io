---
title: "User Guide: 64 Sources mit open-stage-control und ICST AmbiEncoder_64"
date: 2026-08-19T00:00:00
weight: 121
draft: false
toc: true
description: "User Guide fuer die Steuerung von 64 Quellen mit open-stage-control und dem ICST AmbiEncoder_64 in REAPER."
---

Level: Intermediate | Audience: Composer, technician, student, live-electronics user.

{{< figure
  src="ICST-AmbiPlugin_Open-Stage-control.jpeg"
  alt="open-stage-control mit ICST AmbiEncoder_64"
  caption="open-stage-control-Session zur Steuerung von 64 Quellen mit dem ICST AmbiEncoder_64."
>}}

Dieser User Guide beschreibt die aktuelle `XYZ`-Session fuer `open-stage-control` in Verbindung mit dem `ICST AmbiEncoder_64`.

Download:

- [64-source-points-tablet-xyz.session.json](/icst-ambisonics-plugins/13a_open_stage_control_64_sources/64-source-points-tablet-xyz.session.json)

Die Session steuert kartesisch in `XYZ` und ist fuer die direkte Arbeit mit dem Plugin-Radar aufgebaut:

- oben = Front
- rechts = Rechts
- `+X` zeigt nach rechts
- `+Y` zeigt nach vorne

Der linke Fader steuert `Z` (Hoehe, `-1..1`) statt `Distance`. Pad und Plugin-Radar entsprechen sich in dieser Session daher direkt.

Die Session sendet ICST-kompatibles OSC an den `AmbiEncoder_64`:

- `/icst/ambi/sourceindex/xyz [Index] [X] [Y] [Z]`
- `/icst/ambi/sourceindex/gain [Index] [Gain_dB]`

Der Source-Index ist 1-basiert, Gain ist in dB.

## 1. REAPER und AmbiEncoder_64 vorbereiten

1. Oeffne dein REAPER-Projekt oder lege ein neues an.
2. Lege einen Track an, der den Encoder tragen soll, und fuege `ICST AmbiEncoder_64` als Insert-FX ein.
3. Achte darauf, dass der Track genuegend Kanaele hat (`Track Routing` > `Track channels`), sonst arbeitet der 64er-Encoder nicht vollstaendig.
4. Oeffne das Plugin-Fenster des `AmbiEncoder_64`.
5. Oeffne im Plugin den OSC-Bereich und aktiviere `OSC In` (`Receive`).
6. Notiere dir den dort eingestellten Empfangsport. Der typische Default aus den ICST-Tutorials ist `50001`, massgeblich ist aber immer der Port, der tatsaechlich im Plugin hinterlegt ist.
7. Lass das Plugin-Fenster fuer den ersten Test geoeffnet, damit du sehen kannst, ob sich die Quellen bewegen.

## 2. open-stage-control starten

1. Starte `open-stage-control`. Zuerst oeffnet sich der Launcher.
2. Trage im Launcher bei `send` das OSC-Ziel ein:

   - REAPER auf demselben Rechner: `127.0.0.1:50001`
   - REAPER auf einem anderen Rechner: `IP-des-REAPER-Rechners:50001`
   - Falls noetig: den Port aus Teil 1 verwenden

3. Trage bei `Port` den HTTP-Port fuer die Bedienoberflaeche ein, zum Beispiel `8080`.
4. Klicke auf `Start`. Es oeffnet sich die leere Oberflaeche im Browser oder App-Fenster.
5. Lade die Session ueber `Menu` > `Session` > `Open` und waehle `64-source-points-tablet-xyz.session.json`. Alternativ kannst du die Datei per Drag-and-drop ins Fenster ziehen.

{{< figure
  src="open-stage-control-setup.png"
  alt="open-stage-control Launcher mit Send-Ziel 127.0.0.1:50001 und Port 8080"
  caption="Beispiel fuer die Launcher-Einstellungen in open-stage-control: OSC-Ziel auf den AmbiEncoder-Port und HTTP-Port fuer die Bedienoberflaeche."
>}}

## 3. Tablet verbinden

1. Verbinde das Tablet mit demselben Netzwerk wie den Rechner, auf dem `open-stage-control` laeuft.
2. Finde die IP-Adresse dieses Rechners heraus.

   - macOS: `Systemeinstellungen` > `Netzwerk`
   - alternativ im Terminal: `ipconfig getifaddr en0`

3. Oeffne auf dem Tablet einen Browser und rufe `http://IP-des-Rechners:8080` auf. Wenn du einen anderen HTTP-Port gesetzt hast, verwende diesen.
4. Die Oberflaeche erscheint im Browser. Fuer Vollbild auf dem iPad: Seite ueber `Teilen > Zum Home-Bildschirm` ablegen und von dort starten.
5. Wichtig: Das Tablet spricht nur mit `open-stage-control`. Das OSC an REAPER schickt der Rechner, auf dem `open-stage-control` laeuft.

## 4. Erster Funktionstest

1. Gehe in der Oberflaeche zum Tab `Select + Focus`.
2. Druecke unten rechts den blauen Button `Alle 64 senden (Sync)`.

   Dieser Button schickt alle Positionen und Gains einmal ans Plugin. Danach zeigen Oberflaeche und Plugin denselben Stand. Dieser Schritt ist nach jedem Start von `open-stage-control` der erste.

3. Tippe im Raster links auf `S1`. Der Button wird orange, rechts steht `Source 1`.
4. Bewege den Punkt im grossen `XY`-Pad.
5. Schau ins Plugin-Fenster des `AmbiEncoder_64`: Quelle 1 muss sich mitbewegen.
6. Bewege danach den `Z`- und den `Gain dB`-Fader und pruefe die Reaktion im Plugin.
7. Wenn das funktioniert, teste einen Bank-Tab wie `S1-8` und bewege dort mehrere Punkte gleichzeitig.

Hinweis zur Darstellung: Das Pad ist in dieser Session eine Draufsicht in `XYZ`. Deshalb entspricht es dem Plugin-Radar direkt.

Wenn sich in Schritt 4 nichts bewegt, siehe [7. Fehlersuche](#7-fehlersuche).

## 5. Bedienung im Ueberblick

### Tab `Select + Focus`

1. Quelle waehlen: Im `8x8`-Raster links auf den gewuenschten Button tippen. Die aktive Quelle ist orange markiert.
2. Position setzen: den Punkt im grossen Pad rechts bewegen. Die Session arbeitet kartesisch in `X/Y`.
3. `Z (-1..1)` und `Gain (dB) (-60..+12)` mit den beiden horizontalen Fadern einstellen. Beide Fader haben ein Zahlenfeld fuer praezise Eingaben.
4. Umbenennen: oben rechts ins Textfeld tippen, den Namen eingeben und mit `Bestaetigen` abschliessen. Der Name erscheint sofort auf dem Raster-Button. Ohne eigenen Namen zeigt der Button `S1` bis `S64` an.

### Bank-Tabs `S1-8` bis `S57-64`

1. Oeffne den Tab der gewuenschten Gruppe.
2. Im grossen Multi-XY lassen sich einzelne oder mehrere Punkte gleichzeitig bewegen (`Multitouch`).
3. Jeder Punkt sendet sofort seine `XYZ`-Message.
4. Die Quellen sind gleichmaessig im Pad angeordnet. So siehst du sofort, welcher Punkt welcher Quelle entspricht.

## 6. Speichern

1. Positionen und Namen aendern sich waehrend der Session. Wenn du den Zustand behalten willst, waehle in `open-stage-control` `Menu` > `Session` > `Save` oder `Save As`, am besten unter neuem Namen.
2. Die Einstellungen im `AmbiEncoder_64`, inklusive der zuletzt empfangenen Positionen, speicherst du wie gewohnt im REAPER-Projekt mit `Cmd+S`.

## 7. Fehlersuche

### Es kommt nichts im Plugin an

1. Ist `OSC In` im `AmbiEncoder_64` wirklich aktiviert?
2. Stimmen Host und Port in den `send`-Einstellungen von `open-stage-control` exakt mit dem Plugin ueberein?
3. Blockiert eine Firewall eingehende UDP-Pakete auf dem REAPER-Rechner?
4. Laeuft versehentlich eine zweite Instanz von `open-stage-control` ohne Send-Ziel?

### Das Tablet findet die Oberflaeche nicht

1. Sind Tablet und Rechner im selben Netzwerk?
2. Stimmen IP-Adresse und HTTP-Port in der Browser-Adresse ueberein?
3. Verwende `http://`, nicht `https://`.
4. Erlaube eingehende Verbindungen fuer `open-stage-control` in der Firewall.

### Die falsche Quelle bewegt sich

1. Der Source-Index ist 1-basiert: `S1` in der Oberflaeche entspricht Quelle 1 im Plugin.
2. Pruefe, ob im Raster tatsaechlich die gewuenschte Quelle orange markiert ist.

### Bewegungen ruckeln im Netzwerk

1. Pruefe die WLAN-Qualitaet.
2. Schließe den Rechner bei Bedarf per Kabel an.
3. Nimm andere Geraete mit hohem Traffic aus dem WLAN.

### Plugin und Oberflaeche zeigen unterschiedliche Positionen

1. `open-stage-control` sendet beim Start nichts von selbst. Druecke nach jedem Start einmal `Alle 64 senden (Sync)`.

### Plugin meldet `Unknown OSC message received`

1. Es laeuft eine veraltete Session-Kopie, zum Beispiel aus `~/Downloads`.
2. Verwende nur die Dateien aus diesem Ordner.
3. Nach Dateiaenderungen `open-stage-control` neu starten. Laufende Sessions laden Aenderungen nicht automatisch nach.

### Plugin meldet `Malformed OSC message`

1. Der Source-Index muss als Integer ankommen, nicht als Float.
2. Die Sessions in diesem Ordner werden in den Skripten korrekt als `{type: 'i'}` typisiert.

### Gain-Fader bewegt sich, aber das Plugin springt auf `-88 dB`

1. Dieser Plugin-Build erwartet den Gain als linearen Faktor, nicht in dB.
2. Die Tablet-Sessions rechnen deshalb beim Senden um: Der Fader zeigt dB (`-60..+12`), gesendet wird `10^(dB/20)`.
3. `0 dB` entspricht dem Faktor `1.0`.
4. Bestaetigt am `18.08.2026`.

### Hinweise fuer kuenftige Session-Aenderungen in open-stage-control v1.29

1. Script-Code gehoert in die Widget-Eigenschaft `onValue`, nicht in `script`.
2. Das Shared-State-Objekt heisst `globals`, nicht `global`.
3. `send()` ohne Target-Argument sendet an den Launcher-Default. `send(false, ...)` ist ungueltig.
4. Jedes Widget, auch Panels und Tabs, braucht `"bypass": true`, sonst sendet es seinen Rohwert.
5. Die Konsole unten im `open-stage-control`-Fenster zeigt Skriptfehler an. Dort zuerst nachsehen.

## 8. Diese Session

`64-source-points-tablet-xyz.session.json` steuert in Buehnenkoordinaten (`XYZ`). Das Pad ist eine Draufsicht wie das Plugin-Radar, beide entsprechen sich direkt. Diese Seite beschreibt ausschliesslich diese aktuelle `XYZ`-Version.

## Quellen

- [ICST AmbiEncoder - OSC Syntax](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
- [OSC](/icst-ambisonics-plugins/13_osc/)
- [Motion Map Setup](/icst-ambisonics-plugins/16_motion_map_setup/)
