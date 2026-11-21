---
date: 2025-02-02T04:14:54-08:00
draft: false
title: Installation
description: "Installationsanleitung für die ICST Ambisonics Plugins unter macOS und Windows, inklusive REAPER-Abhängigkeiten, Zielpfaden und ersten Troubleshooting-Schritten."
params:
  author: Johannes Schuett
weight: 30
tags:
---

Level: Beginner | Zielgruppe: Komponist:in, Techniker:in, Studierende, Studio-User.

Nutze diese Seite, wenn du vor Templates oder manuellem REAPER-Setup zuerst eine saubere Plugin-Installation brauchst.

> **Abkürzung:** Wenn du REAPER nicht selbst einrichten möchtest, nimm das [ICST Ambi REAPER Bundle](/de/icst-ambisonics-plugins/19_icst_ambi_reaper_bundle/): ein portabler, vorkonfigurierter REAPER-Ordner mit Toolbar, Skripten und Plugins.

## Bevor du startest

Für eine verlässliche Installation solltest du Folgendes bereit haben:

- eine aktuelle Version von **REAPER**
- die **SWS / S&M Extension**
- **ReaPack**
- Zugriff auf das aktuelle Release-Paket der ICST Plugins

Empfohlener nächster Schritt nach der Installation:

- [Schnellstart](/de/icst-ambisonics-plugins/04_quick_start/) für die erste funktionierende Session
- [Schritt-für-Schritt-Setup](/de/icst-ambisonics-plugins/06_step_by_step_setup/) wenn du das Routing manuell aufbauen willst

## Installation unter macOS

1. Lade **REAPER** für Apple Silicon oder Intel von [reaper.fm](https://www.reaper.fm/) herunter.
2. Installiere REAPER und öffne es einmal.
3. Schliesse REAPER wieder.
4. Installiere die **SWS / S&M Extension** von <https://www.sws-extension.org/>.
5. Installiere **ReaPack** von <https://reapack.com/>.
6. Folge der ReaPack-Installationsanleitung: <https://reapack.com/user-guide#installation>
7. Lade das aktuelle Release der ICST Ambisonics Plugins von <https://github.com/schweizerweb/icst-ambisonics-plugins/releases> herunter.
8. Starte den macOS-Installer.

![installer](installer.gif)

## Installation unter Windows

1. Lade **REAPER** für Windows von [reaper.fm](https://www.reaper.fm/) herunter.
2. Installiere REAPER und öffne es einmal.
3. Schliesse REAPER wieder.
4. Installiere die **SWS / S&M Extension** von <https://www.sws-extension.org/>.
5. Installiere **ReaPack** von <https://reapack.com/>.
6. Folge der ReaPack-Installationsanleitung: <https://reapack.com/user-guide#installation>
7. Lade das aktuelle Release der ICST Ambisonics Plugins von <https://github.com/schweizerweb/icst-ambisonics-plugins/releases> herunter.
8. Lade `ICST_AmbiPlugins_Windows_4.0.0.exe` (oder den neuesten Installer) herunter und starte ihn. Die „Full installation“ richtet die VST3- und LV2-Plugins sowie die REAPER-Projekt- und Track-Templates ein. Folge den Schritten unten.

> **Hinweis:** Die Screenshots zeigen den Windows-Installer in Version 4.0.0 (der Installer selbst ist englisch). Neuere Versionen können im Wortlaut leicht abweichen.

<style>
.win-shots { display:flex; flex-wrap:wrap; gap:1.2rem; align-items:flex-start; margin:1.2rem 0 }
.win-shots p { margin:0; width:320px; max-width:100% }
.win-shots em { display:block; font-size:1.3rem; opacity:.85; margin-top:.4rem }
.win-shots img { width:320px; max-width:100%; height:auto; border-radius:6px }
</style>

<div class="win-shots">

![SmartScreen: Der Computer wurde durch Windows geschützt](01_win.jpg)
*1. SmartScreen warnt vor einem unbekannten Herausgeber: „Trotzdem ausführen“ anklicken. Wird nur „Weitere Informationen“ angezeigt, zuerst diese anklicken.*

![Benutzerkontensteuerung](02_win.jpg)
*2. Die Benutzerkontensteuerung mit „Ja“ bestätigen.*

![Installer-Infoseite](03_win.jpg)
*3. Hinweise lesen und „Next“ anklicken.*

![Zielordner Common Files](04_win.jpg)
*4. Zielordner (Common Files) beibehalten und „Next“ anklicken.*

![Komponenten auswählen](05_win.jpg)
*5. „Full installation“ wählen (LV2, VST3, REAPER-Projekt- und Track-Templates) und „Next“ anklicken.*

![Bereit zur Installation](06_win.jpg)
*6. Zusammenfassung prüfen und „Install“ anklicken.*

![Installation läuft](07_win.jpg)
*7. Warten, bis die Installation abgeschlossen ist.*

</div>

## Installierte Dateien und Ordner

Typische Zielpfade der Installation:

- `/Library/Audio/Plugins/VST3`
- `/Library/Audio/Plugins/Components`
- `/Library/Audio/Plugins/LV2` (experimentell)
- `Users/Shared/AmbiPluginsTemp/ProjectTemplates`
- `Users/Shared/AmbiPluginsTemplatesTemp/TrackTemplates`

Enthaltene Vorlagen sind typischerweise:

- `ICST_AmbiPlugins_MonoEncoder.RPP`
- `ICST_AmbiPlugins_MultiEncoder.RPP`
- `ICST_AmbiPlugins`
- `ICST_AmbiPlugins_3rdParty`

## Wenn die Plugins nicht erscheinen

Prüfe zuerst diese Punkte:

- REAPER wurde nach der Installation neu gestartet.
- Die **SWS**-Extension ist korrekt installiert.
- **ReaPack** ist korrekt installiert.
- Die Plugin-Dateien liegen in den erwarteten VST3-, AU- oder LV2-Verzeichnissen.
- Die ICST Plugins erscheinen nach einem Rescan im **FX Browser** von REAPER.

Wenn die Vorlagen fehlen, prüfe zusätzlich die oben genannten gemeinsamen Template-Ordner.

## Weiterführende Referenzen

- Projekt-Wiki: <https://github.com/schweizerweb/icst-ambisonics-plugins/wiki>
**Installationsvideo: ICST Ambisonics Plugins – 01 – How to Install**

{{< youtube 2GXb5tbqW1Y >}}

## Nächster Schritt

- [Schnellstart](/de/icst-ambisonics-plugins/04_quick_start/)
- [Schritt-für-Schritt-Setup](/de/icst-ambisonics-plugins/06_step_by_step_setup/)
