---
title: "FAQ"
description: "Häufig gestellte Fragen zu den ICST Ambisonics Plugins, Setup, OSC und typischen Problemen."
date: 2026-01-01T00:00:00
weight: 16
draft: false
languageCode: de
---

Antworten auf die häufigsten Fragen zu den ICST Ambisonics Plugins für REAPER und den ICST Ambisonics Tools für Max/MSP.

---

## Installation & Kompatibilität

**Welche REAPER-Version wird benötigt?**
REAPER 6.0 oder höher wird empfohlen. Die Plugins laufen auf macOS (Intel und Apple Silicon) sowie Windows 10/11 (64-Bit). Linux wird offiziell nicht unterstützt.

**Funktionieren die Plugins auf Apple Silicon (M1/M2/M3)?**
Ja — die Plugins werden als universelle Binaries ausgeliefert und laufen nativ auf Apple Silicon ohne Rosetta. Für volle Kompatibilität wird REAPER 6.78 oder neuer empfohlen.

**Wo werden die Plugins installiert?**
Die `.vst3`-Dateien (bzw. `.component` für AU auf macOS) in den systemweiten VST3-Ordner kopieren, danach in REAPER unter Options → Preferences → VST einen Rescan durchführen. Genaue Pfade sind in der [Installationsanleitung](/de/icst-ambisonics-plugins/02_installation/) beschrieben.

**REAPER zeigt die Plugins nach der Installation nicht an — was tun?**
Manuellen VST-Rescan auslösen: Options → Preferences → Plug-ins → VST → Re-scan. Falls die Plugins danach immer noch fehlen: prüfen ob die Plugin-Dateien im richtigen Ordner liegen und nicht von macOS Gatekeeper quarantiniert wurden.

**Auf macOS erscheint "Apple kann diesen Entwickler nicht verifizieren" — was tun?**
Systemeinstellungen → Datenschutz & Sicherheit → nach unten scrollen und bei dem blockierten Plugin auf "Trotzdem öffnen" klicken. Dies ist einmal pro Plugin-Datei erforderlich.

---

## Signalfluss & Einrichtung

**Was ist der Unterschied zwischen AmbiEncoder und MultiEncoder?**
Der AmbiEncoder verarbeitet eine einzelne Mono-Audioquelle und positioniert sie im 3D-Raum. Der MultiEncoder verarbeitet mehrere Quellen gleichzeitig (bis zu 36 in v3.2) und ist die empfohlene Wahl für Produktions-Sessions.

**Ich höre keinen Sound durch den Decoder — woran liegt das?**
Drei Dinge der Reihe nach prüfen: (1) die Kanal-Anzahl des B-Format-Busses muss der gewählten Ordnung entsprechen (z.B. 16 Kanäle für 3rd Order HOA), (2) das Decoder-Preset muss zum Lautsprecher-Layout passen, (3) das REAPER-Ausgangs-Routing muss auf die richtigen Hardware-Ausgänge zeigen. Die [Schritt-für-Schritt-Anleitung](/de/icst-ambisonics-plugins/06_step_by_step_setup/) führt durch jeden Schritt.

**Wie viele Ausgangskanäle braucht 3rd-Order HOA?**
3rd-Order Ambisonics verwendet (3+1)² = 16 B-Format-Kanäle. 7th-Order verwendet 64 Kanäle. Encoder und Decoder müssen auf dieselbe Ordnung eingestellt sein.

**Kann ich den ICST Decoder mit anderen FX in der REAPER-Kette kombinieren?**
Ja. Verarbeitung vor dem Decoder auf dem B-Format-Bus ist problemlos möglich — Gain, Filter, Reverb etc. funktionieren wie erwartet. Vermieden werden sollte nur Processing, das die Kanal-Anzahl nach dem Encoder ändert.

---

## OSC-Steuerung

**Der OSC-Encoder reagiert nicht auf meine Nachrichten — was prüfen?**
Zuerst sicherstellen, dass der richtige UDP-Port in REAPER offen ist (Extensions → OSC/Web). Der Standard-ICST-Listener-Port ist **8000**. Dann den Nachrichtenpfad prüfen — die Syntax ist in der [OSC-Syntax-Referenz](/de/post/osc-syntax-for-the-icst-ambiencoder-plugin/) dokumentiert.

**Was ist die minimale OSC-Nachricht um eine Quelle zu bewegen?**
`/ambi/source/[id]/aed [azimuth] [elevation] [distance]` — Azimuth und Elevation in Grad, Distanz als normalisierter 0–1-Wert. Quell-IDs beginnen bei 1.

**Kann ich OSC aus Ableton Live automatisieren?**
Ja — Max-for-Live-MIDI- oder OSC-Clips senden Steuernachrichten, synchronisiert per LTC. Das [Ableton + REAPER Tutorial](/de/post/ableton_reaper/) dokumentiert einen vollständigen 7th-Order-Workflow.

---

## Binaurales Monitoring

**Kann ich binaurales Monitoring ohne Lautsprecheranlage nutzen?**
Ja. Der AmbiDecoder enthält einen Binaural-Modus auf Basis von HRTFs. Im Decoder-Ausgangsbereich aktivieren und auf einen Stereo-Ausgang routen. Das [DearVR-Integrations-Tutorial](/de/post/getting-started-icst-plugins-reaper/) zeigt die Verwendung eines externen Binaural-Renderers am Decoder-Ausgang.

**Der binaurale Ausgang klingt mono oder zusammengebrochen — warum?**
Meist ein Kanal-Count-Mismatch: der Decoder empfängt weniger HOA-Kanäle als erwartet. Prüfen, ob das B-Format-Bus-Send auf vollständiges Multichannel gesetzt ist (nicht auf Stereo-Summe).

---

## ICST Ambisonics Tools (Max/MSP)

**Welche Max-Version wird benötigt?**
Max 8.0 oder neuer. Das Paket ist über den Max Package Manager verfügbar.

**Was ist der Unterschied zwischen Plugins und Tools?**
Die Plugins laufen in REAPER als VST/AU-Effects und sind für Session-basiertes Multitrack-Arbeiten ausgelegt. Die Tools sind Max/MSP-Externals für Live-Spatialisation, algorithmische Komposition und eigene Patches außerhalb einer DAW.

---

## Updates & Versionen

**Wie aktualisiere ich von v3.1 auf v3.2?**
Die alten Plugin-Dateien durch die neuen von der [GitHub-Releases-Seite](https://github.com/schweizerweb/icst-ambisonics-plugins/releases) ersetzen und REAPER neu scannen lassen. Bestehende Sessions öffnen korrekt — keine Einstellungsmigration nötig. Neue Features sind unter [Was ist neu in v3.2](/de/icst-ambisonics-plugins/00_new/) beschrieben.

**Wo kann ich Bugs melden oder Features anfragen?**
Ein Issue auf dem [GitHub-Repository](https://github.com/schweizerweb/icst-ambisonics-plugins/issues) öffnen — OS-Version, REAPER-Version, Plugin-Version und wenn möglich ein minimales Beispielprojekt angeben.
