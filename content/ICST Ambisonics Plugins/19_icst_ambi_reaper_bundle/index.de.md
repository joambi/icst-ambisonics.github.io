---
title: ICST Ambi REAPER Bundle
date: 2026-11-12T00:00:00
weight: 35
draft: false
toc: true
translationKey: ambi-reaper-bundle
description: "Das ICST Ambi REAPER Bundle (ICST_Ambi_Reaper): ein portabler, vorkonfigurierter REAPER-Ordner mit Toolbar, Lua-Skripten, VST3-Plugins und Doku für die ICST Ambisonics Plugins und den Animator Choreographer."
---

Level: Einsteiger | Zielgruppe: Komponist:in, Sounddesigner:in, Studierende, Techniker:in.

Das **ICST Ambi REAPER Bundle** (`ICST_Ambi_Reaper`) ist ein portabler REAPER-Ordner, der für die ICST Ambisonics Plugins bereits eingerichtet ist. Mit einem Klick auf die Toolbar legst du Ambisonics-Spuren (1. bis 7. Ordnung) an, verbindest sie, bewegst Quellen und dekodierst. Er ist der vorkonfigurierte Einstieg in REAPER innerhalb des [ICST Ambisonics EcoSystems](/de/ecosystem/).

{{< notice warning >}}
Entwurf, Stand v1.1.2. Die macOS-Version ist vollständig. Die Windows-Version ist Beta und noch nicht getestet. REAPER selbst ist aus Lizenzgründen nicht enthalten. Die ICST-eigenen Inhalte stehen unter GPL-3.0-or-later, Komponenten von Dritten behalten ihre Lizenz (siehe unten).
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

<!-- HIDDEN bis Test abgeschlossen
## Download

Aktuelle Version: **1.1.2** ([Release-Notizen und alle Dateien auf GitHub](https://github.com/joambi/ICST_Ambi_Reaper/releases/tag/v1.1.2)):

- [`ICST_Ambi_Reaper_1.1.2_macOS.pkg`](https://github.com/joambi/ICST_Ambi_Reaper/releases/download/v1.1.2/ICST_Ambi_Reaper_1.1.2_macOS.pkg): Installer nach `/Applications/ICST_Ambi_Reaper`
- [`ICST_Ambi_Reaper_1.1.2_macOS.zip`](https://github.com/joambi/ICST_Ambi_Reaper/releases/download/v1.1.2/ICST_Ambi_Reaper_1.1.2_macOS.zip): portabel, zum Beispiel für eine externe SSD
- [`ICST_Ambi_Reaper_1.1.2_scripts-only.zip`](https://github.com/joambi/ICST_Ambi_Reaper/releases/download/v1.1.2/ICST_Ambi_Reaper_1.1.2_scripts-only.zip): nur Skripte, Toolbar, Konfiguration und Doku (für den Aufbau unter Windows)

-->

## Installation unter macOS

PKG und ZIP haben denselben Inhalt. Beide sind nicht mit einer Developer-ID signiert. Blockiert macOS eine Datei: Meldung schliessen, dann **Systemeinstellungen › Datenschutz & Sicherheit › Dennoch öffnen** und mit dem Passwort bestätigen (ab macOS 15; bis macOS 14 genügt Ctrl-Klick › *Öffnen*).

### Installer (PKG)

1. **PKG öffnen:** Doppelklick auf `ICST_Ambi_Reaper_<Version>_macOS.pkg`, bei Bedarf über *Dennoch öffnen*.
2. **Installer durchlaufen:** *Fortfahren*, Lizenz *Akzeptieren*, *Installieren*, mit dem Passwort bestätigen. Der Installer legt `/Applications/ICST_Ambi_Reaper` an und setzt den Plugin-Pfad. `run-me-before-install.command` ist nicht nötig.
3. **REAPER.app ergänzen:** Von [reaper.fm](https://www.reaper.fm/download.php) die macOS-Version laden und `REAPER.app` in den Ordner *Programme › ICST_Ambi_Reaper* ziehen, neben `reaper.ini`. Eine vorhandene `/Applications/REAPER.app` bleibt unberührt.
4. **REAPER starten:** immer mit `ICST_Ambi_Reaper starten.command` im Ordner. Das Skript setzt den Plugin-Pfad und startet `REAPER.app` aus dem Ordner.
5. **Plugin-Pfad prüfen:** Fragt REAPER *New portable install detected … scan system VST/CLAP/LV2 paths?*, mit **No** antworten. Hängt REAPER die System-VST3-Ordner trotzdem an und beginnt zu scannen: Scan abbrechen, REAPER beenden und wieder mit `ICST_Ambi_Reaper starten.command` öffnen. Kontrolle: *Options › Preferences › Plug-ins › VST*, der Pfad endet auf `Effects/VST3`.
6. **Toolbar:** *ICST_Ambi_Automation* erscheint beim ersten Start fest oben im Hauptfenster. Wurde sie geschlossen: *View › Toolbars › Floating toolbar 1*.

### Portabler Ordner (ZIP)

1. **Entpacken** und den Ordner `ICST_Ambi_Reaper` an einen festen Ort legen (externe SSD oder `~/Music`). Leerzeichen im Pfad sind erlaubt.
2. **REAPER.app ergänzen:** von [reaper.fm](https://www.reaper.fm/download.php) laden (gleiche Hauptversion) und **in den Ordner** neben `reaper.ini` legen.
3. **Einrichtungsskript:** Doppelklick auf `run-me-before-install.command`, beim ersten Mal über *Dennoch öffnen*. Das Skript entfernt das Quarantäne-Flag und setzt den Plugin-Pfad.
4. **REAPER starten:** ab jetzt immer mit `ICST_Ambi_Reaper starten.command`. Es setzt den Plugin-Pfad bei jedem Start auf den aktuellen Ort, auch auf externen Laufwerken mit anderem Namen.
5. **Plugin-Pfad und Toolbar prüfen** wie beim PKG (Schritte 5 und 6). Fehlen Plugins: *Options › Preferences › Plug-ins › VST › Re-scan*.

{{< notice info >}}
Nicht doppelt installieren: Liegen dieselben Plugins zusätzlich in `/Library/Audio/Plug-Ins/VST3`, lädt REAPER unter Umständen die alte Kopie. Entweder nur den Ordner oder nur die System-Installer benutzen.
{{< /notice >}}

## Update einer bestehenden Installation

Das PKG überschreibt in `/Applications/ICST_Ambi_Reaper` die Dateien `reaper.ini` (unter anderem Audiogerät und Fensterpositionen), `reaper-kb.ini`, `reaper-menu.ini`, `reaper-mouse.ini` und `reapack.ini`. Wer eigene Einstellungen, Tastenbelegungen oder Menüs behalten will, kopiert diese Dateien vor der Installation an einen anderen Ort und legt sie danach zurück. Plugin-Liste und übrige Einstellungsdateien bleiben erhalten.

Wer von 1.1.0 oder 1.1.1 kommt und nur die Korrektur aus 1.1.2 braucht, kopiert aus `…_scripts-only.zip` die Dateien `Scripts/ICST/Ambi/Ambi_Auto_Route.lua`, `Scripts/ICST/Ambi/Ambi_Quick_Start.lua` und `Scripts/ICST/Ambi/lib/ambi_common.lua` in den bestehenden Ordner.

## Installation unter Windows (Beta)

Der Ordner ist ein macOS-Bundle, unter Windows werden deshalb nur die plattformneutralen Teile verwendet:

1. REAPER als **Portable-Installation** einrichten (zum Beispiel `C:\ICST_Ambi_Reaper`), einmal starten und wieder schließen.
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
| Quick Start | Legt eine komplette Session an (Quellen, Encoder, optional HOA FX und HOA_Reverb, Decoder, Binaural) und routet sie |
| B-Format Player, Encoder 64, Encoder | Player- und Encoder-Spuren anlegen |
| HOA Master, Mono Sources | Sammelspur `HOA_MASTER`; Mono-Quellspuren auf den AmbiEncoder_64 routen |
| HOA FX | Effektspur mit IEM-Effekten (SceneRotator, MultiEQ, FdnReverb, DualDelay u. a.), Auswahl per Menü |
| Decoder, Binaural | Lautsprecher-Decoder, IEM BinauralDecoder (bis 7. Ordnung); das Binaural-Skript nutzt dearVR AMBI MICRO nur, wenn dearVR installiert ist |
| Auto-Route | Erkennt Spuren, legt alle Sends an und sortiert die Spuren auf Wunsch |
| Motion Map GUI, Kristall Motion Map, Spat Motion Automation | Bewegungsformen und Automation |
| [Motion Markers GUI](/de/icst-ambisonics-plugins/14_icst_ambi_motion_markers/), CSV-Import | Bewegung zwischen Markern per OSC, Aufnahme als Automation |
| Animator-Buttons | [Choreographer](/de/post/icst-animator-choreographer/) öffnen, Region-Navigation, Encoder-Spuren, CSV-Export |
| Dokumentation | Öffnet das Offline-Handbuch |

![Die Toolbar des ICST Ambi REAPER Bundles mit 21 Buttons, von links nach rechts nummeriert 1 bis 21](/images/reaper-toolbar-numbered.png)

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

## Siehe auch

- [Quick Start: ICST Ambisonics Plugins in REAPER](/de/icst-ambisonics-plugins/04_quick_start/)
- [Installation](/de/icst-ambisonics-plugins/02_installation/)
- [Downloads](/de/icst-ambisonics-plugins/08_downloads/)
- [ICST Ambisonics EcoSystem](/de/ecosystem/)
