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
Entwurf. Die macOS-Version ist vollständig. Die Windows-Version ist Beta und noch nicht getestet. REAPER selbst ist aus Lizenzgründen nicht enthalten. Die ICST-eigenen Inhalte stehen unter GPL-3.0-or-later, Komponenten von Dritten behalten ihre Lizenz (siehe unten).
{{< /notice >}}

## Was enthalten ist

- Ein REAPER-Ressourcenordner mit der Toolbar *ICST_Ambi_Automation* und Icons für die ICST-Werkzeuge
- Lua-Skripte für räumliche Arbeitsabläufe: Spuren anlegen, Auto-Route, Bewegung, Marker, Animator
- ICST- und IEM-Plugins als VST3 (AmbiEncoder, AmbiEncoder_64, AmbiDecoder, IEM BinauralDecoder)
- SWS, js_ReaScriptAPI und ReaPack (macOS, Apple Silicon)
- Ein Offline-Handbuch (`Docs/index.html`)
- Die App [Animator Choreographer](/de/post/icst-animator-choreographer/) (`Animator/`)

## Voraussetzungen

| Punkt | macOS | Windows |
|---|---|---|
| Status | Vollständig | Beta, ungetestet |
| System | macOS 12 oder neuer, Apple Silicon empfohlen | Windows 10/11 (64 Bit) |
| REAPER | Version 7 (getestet mit 7.85), nicht enthalten | Version 7 (64 Bit), Portable-Installation |
| Plugins | Im Ordner (`Effects/VST3`) | Installer nötig |
| Python 3 | Optional, für Motion Map, [Motion Markers](/de/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) und Kristall Motion Map | Dasselbe, von python.org |
| Plugin-Format | VST3 (nicht AU) | VST3 |

## Download

Aktuelle Version: **1.0.0** ([Release-Notizen und alle Dateien auf GitHub](https://github.com/joambi/ICST_Ambi_Reaper/releases/tag/v1.0.0)):

- [`ICST_Ambi_Reaper_1.0.0_macOS.pkg`](https://github.com/joambi/ICST_Ambi_Reaper/releases/download/v1.0.0/ICST_Ambi_Reaper_1.0.0_macOS.pkg): Installer nach `/Applications/ICST_Ambi_Reaper`
- [`ICST_Ambi_Reaper_1.0.0_macOS.zip`](https://github.com/joambi/ICST_Ambi_Reaper/releases/download/v1.0.0/ICST_Ambi_Reaper_1.0.0_macOS.zip): portabel, zum Beispiel für eine externe SSD
- [`ICST_Ambi_Reaper_1.0.0_scripts-only.zip`](https://github.com/joambi/ICST_Ambi_Reaper/releases/download/v1.0.0/ICST_Ambi_Reaper_1.0.0_scripts-only.zip): nur die plattformneutralen Teile (für Windows)

## Installation unter macOS

1. **Ordner kopieren** an einen festen Ort (externe SSD oder `~/Music`). Leerzeichen im Pfad sind erlaubt.
2. **REAPER.app ergänzen.** Liegt `REAPER.app` nicht im Ordner, von [reaper.fm](https://www.reaper.fm) laden (gleiche Hauptversion) und **in den Ordner** neben `reaper.ini` legen.
3. **Einrichtungsskript starten:** Rechtsklick auf `run-me-before-install.command` → *Öffnen*. Es entfernt das macOS-Quarantäne-Flag und setzt den Plugin-Pfad. Nach jedem Verschieben des Ordners erneut ausführen.
4. **REAPER aus dem Ordner starten.** Warnt macOS: Rechtsklick auf die App → *Öffnen*. Kontrolle: *Options → Show REAPER resource path* muss auf `ICST_Ambi_Reaper` zeigen.
5. **Plugins scannen:** *Options → Preferences → Plug-ins → VST*, Pfad endet auf `Effects/VST3`, *Re-scan* klicken.
6. **Toolbar zeigen:** *View → Toolbars → Floating toolbar 1*.

Mit dem `.pkg`-Installer entfallen die Schritte 1 bis 3. Ein unsigniertes PKG öffnest du mit Rechtsklick → *Öffnen*.

{{< notice info >}}
Nicht doppelt installieren: Liegen dieselben Plugins zusätzlich in `/Library/Audio/Plug-Ins/VST3`, lädt REAPER unter Umständen die alte Kopie. Entweder nur den Ordner oder nur die System-Installer benutzen.
{{< /notice >}}

## Installation unter Windows (Beta)

Der Ordner ist ein macOS-Bundle, unter Windows werden deshalb nur die plattformneutralen Teile verwendet:

1. REAPER als **Portable-Installation** einrichten (zum Beispiel `C:\ICST_Ambi_Reaper`), einmal starten und wieder schließen.
2. SWS und ReaPack installieren, danach über ReaPack **js_ReaScriptAPI**.
3. Aus dem *scripts-only*-Zip `Scripts\ICST`, `Data\toolbar_icons`, `Docs`, `OSC`, `ICST_Player_Presets`, `reaper-menu.ini` und `reaper-kb.ini` in diesen Ordner kopieren.
4. Plugins mit ihren Installern einrichten (ICST-Pakete, AmbiEncoder/AmbiDecoder von [ambisonics.ch](/de/icst-ambisonics-plugins/02_installation/), [IEM Plug-in Suite](https://plugins.iem.at)).
5. REAPER starten, VST-Plugins *Re-scan*, *Floating toolbar 1* zeigen.

## Erster Durchlauf (10 Minuten)

1. Neue Spur, mono Audiodatei einfügen. Auf der Spur **Encoder 64** klicken.
2. **Decoder** für Lautsprecher oder **Binaural** für Kopfhörer klicken.
3. Optional: **HOA FX**.
4. **Auto-Route** klicken: die 16-Kanal-Sends Quelle → HOA FX → Decoder/Binaural werden angelegt.
5. Abspielen und die Quelle im Encoder bewegen. Für aufgenommene Bewegungen dienen [Motion Map](/de/icst-ambisonics-plugins/15_icst_ambi_motion_map/), [Motion Markers](/de/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) oder Spat Motion Automation.

## Toolbar und Skripte

Die Skripte fragen nach der Ambisonics-Ordnung (1, 3, 5 oder 7, also 4, 16, 36 oder 64 Kanäle) und färben die Spuren pro Effekt.

| Button | Funktion |
|---|---|
| Quick Start | Legt eine komplette Session an (Quellen, Encoder, optional HOA FX, Decoder, Binaural) und routet sie |
| B-Format Player, Encoder 64, Encoder | Player- und Encoder-Spuren anlegen |
| HOA Master, Mono Sources | Sammelspur `HOA_MASTER`; Mono-Quellspuren auf den AmbiEncoder_64 routen |
| HOA FX | Effektspur mit IEM-Effekten |
| Decoder, Binaural | Lautsprecher-Decoder, IEM BinauralDecoder (bis 7. Ordnung); das Binaural-Skript nutzt dearVR AMBI MICRO nur, wenn dearVR installiert ist |
| Auto-Route | Erkennt Spuren und legt alle Sends an |
| Motion Map GUI, Kristall Motion Map, Spat Motion Automation | Bewegungsformen und Automation |
| [Motion Markers GUI](/de/icst-ambisonics-plugins/14_icst_ambi_motion_markers/), CSV-Import | Bewegung zwischen Markern per OSC, Aufnahme als Automation |
| Animator-Buttons | [Choreographer](/de/post/icst-animator-choreographer/) öffnen, Region-Navigation, Encoder-Spuren, CSV-Export |
| Dokumentation | Öffnet das Offline-Handbuch |

<!-- TODO release: Screenshot der Toolbar ergänzen. -->

## Wenn etwas nicht geht

| Problem | Lösung |
|---|---|
| Plugins erscheinen nicht (macOS) | `run-me-before-install.command` erneut ausführen, REAPER aus dem Ordner starten, *Re-scan* |
| Toolbar leer | *Floating toolbar 1* prüfen; `reaper-menu.ini` und `reaper-kb.ini` müssen im Ressourcenordner liegen |
| Skript meldet fehlende `JS_…`-Funktion | js_ReaScriptAPI installieren (Windows) bzw. `UserPlugins` prüfen (macOS) |
| Motion-Werkzeuge: „python3 not found“ | Python 3 installieren und `python3 -m pip install python-osc` |
| Auto-Route findet eine Spur nicht | Die Spur braucht ein erkennbares Plugin oder „Player“ im Namen |

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
