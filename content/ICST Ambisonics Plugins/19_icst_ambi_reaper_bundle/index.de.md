---
title: ICST Ambi REAPER Bundle
date: 2026-11-18T00:00:00
weight: 35
draft: false
toc: true
translationKey: ambi-reaper-bundle
description: "Das ICST Ambi REAPER Bundle (ICST_Ambi_Reaper): ein portabler, vorkonfigurierter REAPER-Ordner mit Toolbar, Lua-Skripten, VST3-Plugins und Doku für die ICST Ambisonics Plugins und den Animator Choreographer."
---

Level: Einsteiger | Zielgruppe: Komponist:in, Sounddesigner:in, Studierende, Techniker:in.

Das **ICST Ambi REAPER Bundle** (`ICST_Ambi_Reaper`) ist ein portabler REAPER-Ordner, der für die ICST Ambisonics Plugins bereits eingerichtet ist. Mit einem Klick auf die Toolbar legst du Ambisonics-Spuren (1. bis 7. Ordnung) an, verbindest sie, bewegst Quellen und dekodierst. Er ist der vorkonfigurierte Einstieg in REAPER innerhalb des [ICST Ambisonics EcoSystems](/de/ecosystem/).

{{< notice warning >}}
Evaluationsbeta, Stand v1.1.3. Die macOS-Version ist vollständig. Die Windows-Version ist Beta und noch nicht getestet. REAPER selbst ist aus Lizenzgründen nicht enthalten. Die ICST-eigenen Inhalte stehen unter GPL-3.0-or-later, Komponenten von Dritten behalten ihre Lizenz (siehe unten).
{{< /notice >}}

## Was enthalten ist

- Ein REAPER-Ressourcenordner mit der Toolbar *ICST_Ambi_Automation* und Icons für die ICST-Werkzeuge
- Lua-Skripte für räumliche Arbeitsabläufe: Quick Start, Spuren anlegen, Auto-Route, Bewegung, Marker, Animator
- ICST- und IEM-Plugins als VST3 (AmbiEncoder, AmbiEncoder_64, AmbiDecoder, IEM BinauralDecoder, IEM-Effekte für HOA FX und HOA_Reverb)
- SWS, js_ReaScriptAPI und ReaPack (macOS, Apple Silicon)
- Ein Offline-Handbuch (`Docs/index.html`)
- Die App [Animator Choreographer](/de/post/icst-animator-choreographer/) (`Animator/`)

## Voraussetzungen

| Punkt | macOS | Windows |
|---|---|---|
| Status | Vollständig | Beta, ungetestet |
| System | macOS 12 oder neuer, Apple Silicon empfohlen (auf Intel-Macs fehlen die Erweiterungen in `UserPlugins`) | Windows 10/11 (64 Bit) |
| REAPER | Version 7 (getestet mit 7.85), nicht enthalten | Version 7 (64 Bit), Portable-Installation |
| Plugins | Im Ordner (`Effects/VST3`) | Installer nötig |
| Python 3 | Optional, für Motion Map, [Motion Markers](/de/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) und Kristall Motion Map | Dasselbe, von python.org |
| Plugin-Format | VST3 (nicht AU) | VST3 |

## Download

Aktuelle Version: **1.1.3** mit Motion Map GUI v2.4.5 ([Release-Notizen und alle Dateien auf GitHub](https://github.com/joambi/ICST_Ambi_Reaper/releases/tag/v1.1.3)):

- [`ICST_Ambi_Reaper_1.1.3_macOS.zip`](https://github.com/joambi/ICST_Ambi_Reaper/releases/download/v1.1.3/ICST_Ambi_Reaper_1.1.3_macOS.zip): portabel, zum Beispiel für eine externe SSD
- [`ICST_Ambi_Reaper_1.1.3_scripts-only.zip`](https://github.com/joambi/ICST_Ambi_Reaper/releases/download/v1.1.3/ICST_Ambi_Reaper_1.1.3_scripts-only.zip): nur Skripte, Toolbar, Konfiguration und Doku (für den Aufbau unter Windows)

**Neu in 1.1.3:** Motion Map GUI v2.4.5 (vorher: v2.4.3). Version 2.4.4 bringt einen Preview-Transport mit Geschwindigkeit, Richtung und Play/Stop; Presets speichern diese Einstellungen nicht. Version 2.4.5 schreibt Spuren immer mit Latch (die Option *Track Latch* entfällt, ältere Presets werden dafür ignoriert) und ergänzt einen *Sync*-Button: Die Vorschau folgt Play/Stop von REAPER, und Play/Stop in der GUI starten und stoppen den REAPER-Transport. Stop hält die Animation in der Trajektorien-Vorschau und in der Live-OSC-Vorschau an, und der Speed-Faktor läuft frei und im Tempo (Details im [Motion-Map-Guide](/de/icst-ambisonics-plugins/15_icst_ambi_motion_map/#preview-transport-ab-v244-sync-ab-v245)). Toolbar-Button, Action-ID und Icon bleiben gleich. Alle übrigen Skripte, Konfigurationsdateien und die Dokumentation sind gegenüber 1.1.2 unverändert.

**Getestet:** als 1.1.2 mit REAPER 7.85 auf macOS (Apple Silicon): Auto-Route, Quick Start und Routing mit 64 Kanälen. Die Motion Map GUI v2.4.5 wurde vor der Aufnahme ins Bundle einzeln in REAPER verwendet; der Start über die Toolbar dieses Bundles wurde nicht eigens getestet.

Die Version ist eine Evaluationsbeta (Vorabversion auf GitHub). Rückmeldungen bitte als [Issue auf GitHub](https://github.com/joambi/ICST_Ambi_Reaper/issues).

Die SHA-256-Prüfsummen stehen in den [Release-Notizen](https://github.com/joambi/ICST_Ambi_Reaper/releases/tag/v1.1.3).

## Installation unter macOS

<figure class="reaper-bundle-video" style="margin:0 0 1.5rem 0;">
  <video controls playsinline preload="metadata" poster="/reaper-bundle/install-tutorial-de-poster.jpg" aria-label="Video: Installation und erster Durchlauf des ICST Ambi REAPER Bundles unter macOS" style="max-width:100%;height:auto">
    <source src="/reaper-bundle/install-tutorial-de.mp4" type="video/mp4">
  </video>
  <figcaption>Video: Bundle unter macOS installieren und erster Durchlauf mit Quick Start (ca. 80 Sekunden). Die Schritte stehen darunter auch als Text.</figcaption>
</figure>


Das ZIP ist nicht mit einer Developer-ID signiert. Blockiert macOS die Datei: Meldung schliessen, dann **Systemeinstellungen › Datenschutz & Sicherheit › Dennoch öffnen** und mit dem Passwort bestätigen (ab macOS 15; bis macOS 14 genügt Ctrl-Klick › *Öffnen*).

### Portabler Ordner (ZIP)

![Aufbau des Ordners ICST_Ambi_Reaper](/images/reaper-bundle-anatomy-de.svg)

*Was im Ordner liegt und welche Dateien du selbst ergänzt oder startest.*


1. **Entpacken** und den Ordner `ICST_Ambi_Reaper` an einen festen Ort legen (externe SSD oder `~/Music`). Leerzeichen im Pfad sind erlaubt.
2. **REAPER.app ergänzen:** von [reaper.fm](https://www.reaper.fm/download.php) laden (gleiche Hauptversion) und **in den Ordner** neben `reaper.ini` legen.
3. **Einrichtungsskript:** Doppelklick auf `run-me-before-install.command`, beim ersten Mal über *Dennoch öffnen*. Das Skript entfernt das Quarantäne-Flag und setzt den Plugin-Pfad.
4. **REAPER starten:** ab jetzt immer mit `ICST_Ambi_Reaper starten.command`. Es setzt den Plugin-Pfad bei jedem Start auf den aktuellen Ort, auch auf externen Laufwerken mit anderem Namen.
5. **Plugin-Pfad prüfen:** Fragt REAPER *New portable install detected … scan system VST/CLAP/LV2 paths?*, mit **No** antworten. Hängt REAPER die System-VST3-Ordner trotzdem an und beginnt zu scannen: Scan abbrechen, REAPER beenden und wieder mit `ICST_Ambi_Reaper starten.command` öffnen. Kontrolle: *Options › Preferences › Plug-ins › VST*, der Pfad endet auf `Effects/VST3`. Fehlen Plugins: dort *Re-scan*.
6. **Toolbar:** *ICST_Ambi_Automation* erscheint beim ersten Start fest oben im Hauptfenster. Wurde sie geschlossen: *View › Toolbars › Floating toolbar 1*.

![Einmal einrichten, dann immer mit dem Start-Skript starten](/images/reaper-bundle-setup-flow-de.svg)

*Die Einrichtung geschieht einmal; danach startest du immer mit demselben Skript.*

{{< notice info >}}
Nicht doppelt installieren: Liegen dieselben Plugins zusätzlich in `/Library/Audio/Plug-Ins/VST3`, lädt REAPER unter Umständen die alte Kopie. Entweder die Plugins im Ordner oder die systemweiten aus den ICST-Plugin-Installern benutzen, nicht beides. Lädt REAPER eine alte Kopie, die Plugins aus `/Library/Audio/Plug-Ins/VST3` entfernen.
{{< /notice >}}

## Update einer bestehenden Installation

Ein neues ZIP bringt eigene `reaper.ini` (unter anderem Audiogerät und Fensterpositionen), `reaper-kb.ini`, `reaper-menu.ini`, `reaper-mouse.ini` und `reapack.ini` mit. Wer eigene Einstellungen, Tastenbelegungen oder Menüs behalten will, kopiert diese Dateien vor dem Ersetzen aus dem alten Ordner `ICST_Ambi_Reaper` und legt sie danach zurück.

Welche Dateien du kopierst, hängt vom Ausgangsstand ab:

| Von | Nach | Was tun |
|---|---|---|
| Beliebige Version | 1.1.3, vollständig | Den ganzen Ordner durch das neue ZIP ersetzen (vorher die eigenen Einstellungen kopieren, siehe oben) |
| 1.1.0 oder 1.1.1 | 1.1.2, nur die Korrektur | `Scripts/ICST/Ambi/Ambi_Auto_Route.lua`, `Scripts/ICST/Ambi/Ambi_Quick_Start.lua` und `Scripts/ICST/Ambi/lib/ambi_common.lua` aus `…_scripts-only.zip` in den bestehenden Ordner kopieren |
| 1.1.2 | 1.1.3 | `Scripts/ICST/JS_AmbiEncoder64_Motion_Map_GUI.lua` (Motion Map GUI v2.4.5) aus `…_scripts-only.zip` in den bestehenden Ordner kopieren |

## Installation unter Windows (Beta)

Der Ordner ist ein macOS-Bundle, unter Windows werden deshalb nur die plattformneutralen Teile verwendet:

1. REAPER als **Portable-Installation** einrichten (zum Beispiel `C:\ICST_Ambi_Reaper`), einmal starten und wieder schliessen.
2. SWS und ReaPack installieren, danach über ReaPack **js_ReaScriptAPI**.
3. Aus dem *scripts-only*-Zip `Scripts\ICST`, `Data\toolbar_icons`, `Docs`, `OSC`, `ICST_Player_Presets`, `reaper-menu.ini` und `reaper-kb.ini` in diesen Ordner kopieren. In einer bestehenden Installation überschreiben die beiden ini-Dateien eigene Toolbars und Tastenbelegungen.
4. Plugins mit ihren Installern einrichten (ICST-Pakete, AmbiEncoder/AmbiDecoder von [ambisonics.ch](/de/icst-ambisonics-plugins/02_installation/), [IEM Plug-in Suite](https://plugins.iem.at)).
5. REAPER starten, VST-Plugins *Re-scan*, *Floating toolbar 1* zeigen.

## Erster Durchlauf (10 Minuten)

### Variante A: Quick Start

1. Neues, leeres Projekt (*File › New project*).
2. In der Toolbar ganz links **Quick Start** (Blitz, Button 1) klicken.
3. Der Dialog fragt fünf Werte ab. Vorgabe: `4, n, n, j, j` = 4 Mono-Quellen, keine HOA_FX-Spur, kein HOA_Reverb, Decoder ja, Binaural ja. Mit **OK** bestätigen. Der Dialog merkt sich die zuletzt gewählten Werte.
4. Es entstehen `Src_01` bis `Src_04`, `Ambi_Encoder_64`, `HOA_MASTER`, ein Decoder und eine Binaural-Spur, fertig geroutet mit 64 Kanälen. Mit `j` bei *HOA_FX* kommt eine Effektspur (IEM SceneRotator, MultiEQ) dazu, mit `j` bei *HOA_Reverb* eine Spur mit IEM FdnReverb, parallel zwischen Encoder (bzw. HOA_FX) und `HOA_MASTER`.
5. Auf `Src_01` eine Mono-Audiodatei einfügen, abspielen und die Quelle im AmbiEncoder_64 bewegen. Kopfhörer über die Binaural-Spur, Lautsprecher über den Decoder.

![Signalfluss nach Quick Start](/images/reaper-bundle-routing-de.svg)

*Was Quick Start erzeugt: Quellen in den Encoder, optional über HOA_FX und HOA_Reverb in HOA_MASTER, dann zu Decoder und Binaural.*

In allen Ja/Nein-Feldern gelten `j`, `ja`, `y`, `yes` und `1` als ja (ab 1.1.2; vorher galt nur `j`).

### Variante B: Schritt für Schritt

1. Neue Spur, mono Audiodatei einfügen. Auf der Spur **Encoder 64** klicken.
2. **Decoder** für Lautsprecher oder **Binaural** für Kopfhörer klicken.
3. Optional: **HOA FX**.
4. **Auto-Route** klicken. Der Dialog fragt, ob die Spuren sortiert werden sollen und ob HOA_FX seriell (`s`) oder parallel (`p`) eingebunden wird. Die Sends übernehmen die Kanalzahl der Spuren (64 beim AmbiEncoder_64). Mit Sortieren stehen die Spuren danach in der Reihenfolge Player, Quellen, Encoder, HOA_FX, HOA_Reverb, `HOA_MASTER`, Decoder, Binaural; übrige Spuren folgen am Ende.
5. Abspielen und die Quelle im Encoder bewegen.

Für aufgenommene Bewegungen dienen [Motion Map](/de/icst-ambisonics-plugins/15_icst_ambi_motion_map/), [Motion Markers](/de/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) oder Spat Motion Automation. **Animator** (Button 16) startet den Animator Choreographer.

## Toolbar und Skripte

Die Skripte fragen nach der Ambisonics-Ordnung (1, 3, 5 oder 7, also 4, 16, 36 oder 64 Kanäle) und färben die Spuren pro Effekt.

| Button | Funktion |
|---|---|
| Quick Start (1) | Legt eine komplette Session an (Quellen, Encoder, optional HOA FX und HOA_Reverb, Decoder, Binaural) und routet sie |
| B-Format Player, Encoder 64, Encoder (2–4) | Player- und Encoder-Spuren anlegen |
| HOA Master, Mono Sources (6–7) | Sammelspur `HOA_MASTER`; Mono-Quellspuren auf den AmbiEncoder_64 routen |
| HOA FX (5) | Effektspur mit IEM-Effekten (SceneRotator, MultiEQ, FdnReverb, DualDelay u. a.), Auswahl per Menü |
| Decoder, Binaural (8–9) | Lautsprecher-Decoder, IEM BinauralDecoder (bis 7. Ordnung); das Binaural-Skript nutzt dearVR AMBI MICRO nur, wenn dearVR installiert ist |
| Auto-Route (10) | Erkennt Spuren, legt alle Sends an und sortiert die Spuren auf Wunsch |
| Motion Map GUI, Kristall Motion Map, Spat Motion Automation (11, 12, 15) | Bewegungsformen und Automation |
| [Motion Markers GUI](/de/icst-ambisonics-plugins/14_icst_ambi_motion_markers/), CSV-Import (13–14) | Bewegung zwischen Markern per OSC, Aufnahme als Automation |
| Animator-Buttons (16–20) | [Choreographer](/de/post/icst-animator-choreographer/) öffnen, Region-Navigation, Encoder-Spuren, CSV-Export |
| Dokumentation (21) | Öffnet das Offline-Handbuch |

![Die Toolbar des ICST Ambi REAPER Bundles mit 21 Buttons in Funktionsgruppen](/images/reaper-bundle-toolbar-de.svg)

*Die Toolbar mit ihren 21 Buttons, von links nach rechts nummeriert. Die Nummern entsprechen dem Offline-Handbuch.*

## Wenn etwas nicht geht

| Problem | Lösung |
|---|---|
| Plugins erscheinen nicht (macOS) | REAPER beenden und mit `ICST_Ambi_Reaper starten.command` neu starten; sonst *Re-scan* bzw. *Clear cache and re-scan*. Beim ZIP vorher `run-me-before-install.command` erneut ausführen |
| Toolbar leer | *Floating toolbar 1* prüfen; `reaper-menu.ini` und `reaper-kb.ini` müssen im Ressourcenordner liegen |
| Skript meldet fehlende `JS_…`-Funktion | js_ReaScriptAPI installieren (Windows) bzw. `UserPlugins` prüfen (macOS) |
| Motion-Werkzeuge: „python3 not found“ | Python 3 installieren und `python3 -m pip install python-osc` |
| Auto-Route findet eine Spur nicht | Die Spur braucht ein erkennbares Plugin oder „Player“ im Namen |
| Auto-Route sortiert nicht, Quick Start legt HOA_FX oder HOA_Reverb nicht an | Bis 1.1.1 galt nur `j` als ja, `y` wurde als nein gewertet. Auf 1.1.2 aktualisieren (siehe Update) |

## Lizenz

Die **ICST-eigenen Inhalte** des Bundles (ReaScripts, JSFX, Toolbar-Icons, Konfiguration und Dokumentation) stehen unter der **GNU General Public License, Version 3 oder später (GPL-3.0-or-later)**. Der Lizenztext liegt als Datei `LICENSE` im Ordner.

Die mitgelieferten Binaries (Plugins, Erweiterungen, Animator Choreographer) fallen nicht darunter: Jede Komponente behält ihre eigene Lizenz, und das Bundle fasst sie nur zu einem Download zusammen. Die Übersicht dazu steht in der Datei `THIRD_PARTY_LICENSES.md` im Ordner und in der Tabelle unten.

## Komponenten von Dritten

| Komponente | Lizenz | Hinweis |
|---|---|---|
| [IEM Plug-in Suite](https://plugins.iem.at/) (BinauralDecoder, HOA FX) | GPL3 | Der Binaural-Button nutzt den IEM BinauralDecoder; Breaking Changes ab v1.16.0, Templates vor dem Update prüfen |
| [SWS/S&M Extension](https://www.sws-extension.org) | MIT | Unter Windows manuell installieren; Lizenztext liegt im Ordner `licenses/` |
| [ReaPack](https://reapack.com) | LGPL-3.0 | Unter Windows manuell installieren |
| [js_ReaScriptAPI](https://github.com/juliansader/ReaExtensions) | MIT | Unter Windows manuell installieren |
| Animator Choreographer | GPL-3.0 | Im Ordner `Animator/`; Toolbar-Button 16 startet ihn |

## Siehe auch

- [Quick Start: ICST Ambisonics Plugins in REAPER](/de/icst-ambisonics-plugins/04_quick_start/)
- [Installation](/de/icst-ambisonics-plugins/02_installation/)
- [Downloads](/de/icst-ambisonics-plugins/08_downloads/)
- [ICST Ambi Reaper Online-Handbuch](/icst-ambisonics-plugins/19_icst_ambi_reaper/docs/)
- [ICST Ambisonics EcoSystem](/de/ecosystem/)
