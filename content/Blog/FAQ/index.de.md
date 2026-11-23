---
title: "FAQ"
description: "Häufig gestellte Fragen zu den ICST Ambisonics Plugins, Setup, OSC und typischen Problemen."
date: 2026-01-01T00:00:00
weight: 16
draft: false
languageCode: de
class: faq
home_hide: true
---

<p class="faq-intro">Antworten auf die häufigsten Fragen zu den ICST Ambisonics Plugins für REAPER und den ICST Ambisonics Tools für Max/MSP.</p>

---

## Installation & Kompatibilität

<details class="faq-item">
<summary class="faq-question">Welche REAPER-Version wird benötigt?</summary>
<div class="faq-answer">

REAPER 6.0 oder höher wird empfohlen. Die Plugins laufen auf macOS (Intel und Apple Silicon) sowie Windows 10/11 (64-Bit). Linux wird offiziell nicht unterstützt.

</div>
</details>

<details class="faq-item">
<summary class="faq-question">Funktionieren die Plugins auf Apple Silicon (M1/M2/M3)?</summary>
<div class="faq-answer">

Ja — die Plugins werden als universelle Binaries ausgeliefert und laufen nativ auf Apple Silicon ohne Rosetta. Für volle Kompatibilität wird REAPER 6.78 oder neuer empfohlen.

</div>
</details>

<details class="faq-item">
<summary class="faq-question">Wo werden die Plugins installiert?</summary>
<div class="faq-answer">

Die `.vst3`-Dateien (bzw. `.component` für AU auf macOS) in den systemweiten VST3-Ordner kopieren, danach in REAPER unter Options → Preferences → VST einen Rescan durchführen. Genaue Pfade sind in der [Installationsanleitung](/de/icst-ambisonics-plugins/02_installation/) beschrieben.

</div>
</details>

<details class="faq-item">
<summary class="faq-question">REAPER zeigt die Plugins nach der Installation nicht an — was tun?</summary>
<div class="faq-answer">

Manuellen VST-Rescan auslösen: Options → Preferences → Plug-ins → VST → Re-scan. Falls die Plugins danach immer noch fehlen: prüfen ob die Plugin-Dateien im richtigen Ordner liegen und nicht von macOS Gatekeeper quarantiniert wurden.

</div>
</details>

<details class="faq-item">
<summary class="faq-question">Auf macOS erscheint "Apple kann diesen Entwickler nicht verifizieren" — was tun?</summary>
<div class="faq-answer">

Systemeinstellungen → Datenschutz & Sicherheit → nach unten scrollen und bei dem blockierten Plugin auf "Trotzdem öffnen" klicken. Dies ist einmal pro Plugin-Datei erforderlich.

</div>
</details>

---

## Signalfluss & Einrichtung

<details class="faq-item">
<summary class="faq-question">Was ist der Unterschied zwischen AmbiEncoder und AmbiEncoder_64?</summary>
<div class="faq-answer">

Der AmbiEncoder verarbeitet eine einzelne Mono-Audioquelle und positioniert sie im 3D-Raum. Der AmbiEncoder_64 verarbeitet mehrere Quellen gleichzeitig (bis zu 64 in v4.0, 36 in v3.2) und ist die empfohlene Wahl für Produktions-Sessions.

</div>
</details>

<details class="faq-item">
<summary class="faq-question">Ich höre keinen Sound durch den Decoder — woran liegt das?</summary>
<div class="faq-answer">

Drei Dinge der Reihe nach prüfen: (1) die Kanal-Anzahl des B-Format-Busses muss der gewählten Ordnung entsprechen (z.B. 16 Kanäle für 3rd Order HOA), (2) das Decoder-Preset muss zum Lautsprecher-Layout passen, (3) das REAPER-Ausgangs-Routing muss auf die richtigen Hardware-Ausgänge zeigen. Die [Schritt-für-Schritt-Anleitung](/de/icst-ambisonics-plugins/06_step_by_step_setup/) führt durch jeden Schritt.

</div>
</details>

<details class="faq-item">
<summary class="faq-question">Wie viele Ausgangskanäle braucht 3rd-Order HOA?</summary>
<div class="faq-answer">

3rd-Order Ambisonics verwendet (3+1)² = 16 B-Format-Kanäle. 7th-Order verwendet 64 Kanäle. Encoder und Decoder müssen auf dieselbe Ordnung eingestellt sein.

</div>
</details>

<details class="faq-item">
<summary class="faq-question">Kann ich den ICST Decoder mit anderen FX in der REAPER-Kette kombinieren?</summary>
<div class="faq-answer">

Ja. Verarbeitung vor dem Decoder auf dem B-Format-Bus ist problemlos möglich — Gain, Filter, Reverb etc. funktionieren wie erwartet. Vermieden werden sollte nur Processing, das die Kanal-Anzahl nach dem Encoder ändert.

</div>
</details>

---

## OSC-Steuerung

<details class="faq-item">
<summary class="faq-question">Der OSC-Encoder reagiert nicht auf meine Nachrichten — was prüfen?</summary>
<div class="faq-answer">

Zuerst sicherstellen, dass der richtige UDP-Port in REAPER offen ist (Extensions → OSC/Web). Der Standard-ICST-Listener-Port ist **8000**. Dann den Nachrichtenpfad prüfen — die Syntax ist in der [OSC-Syntax-Referenz](/de/post/osc-syntax-for-the-icst-ambiencoder-plugin/) dokumentiert.

</div>
</details>

<details class="faq-item">
<summary class="faq-question">Was ist die minimale OSC-Nachricht um eine Quelle zu bewegen?</summary>
<div class="faq-answer">

`/ambi/source/[id]/aed [azimuth] [elevation] [distance]` — Azimuth und Elevation in Grad, Distanz als normalisierter 0–1-Wert. Quell-IDs beginnen bei 1.

</div>
</details>

<details class="faq-item">
<summary class="faq-question">Kann ich OSC aus Ableton Live automatisieren?</summary>
<div class="faq-answer">

Ja — Max-for-Live-MIDI- oder OSC-Clips senden Steuernachrichten, synchronisiert per LTC. Das [Ableton + REAPER Tutorial](/de/post/ableton_reaper/) dokumentiert einen vollständigen 7th-Order-Workflow.

</div>
</details>

---

## Binaurales Monitoring

<details class="faq-item">
<summary class="faq-question">Kann ich binaurales Monitoring ohne Lautsprecheranlage nutzen?</summary>
<div class="faq-answer">

Ja, mit einem externen Binaural-Decoder. Die ICST-Plugins enthalten bewusst keinen: Der AmbiDecoder dekodiert nur auf Lautsprecher. Einen freien Binaural-Decoder wie den IEM BinauralDecoder oder SPARTA AmbiBIN anstelle des Lautsprecher-Decoders auf den B-Format-Master-Bus legen, auf dieselbe Ordnung wie die Encoder einstellen (ACN/SN3D) und den Ausgang auf ein Stereopaar routen. Aufbau, Signalkette und häufige Fehler: [Binaurales Monitoring im ICST-Workflow](/de/post/binaural-monitoring-icst-workflow/).

</div>
</details>

<details class="faq-item">
<summary class="faq-question">Der binaurale Ausgang klingt mono oder zusammengebrochen — warum?</summary>
<div class="faq-answer">

Fast immer erhält der Decoder nur zwei Kanäle: Eine Spur oder ein Bus in der Kette steht noch auf REAPERs Standard von 2 Kanälen, oder das Signal läuft vor dem Decoder über einen Stereo-Bus. Dann kommen nur W und Y an, und das Raumbild bricht zusammen. Prüfen, ob jede Spur von den Encodern bis zum Decoder die volle Kanalzahl von (Ordnung + 1)² führt, von 4 Kanälen bei 1. Ordnung bis 64 bei 7. Ordnung, und ob der Decoder auf ACN/SN3D eingestellt ist. Klingt es nicht mono, sondern verschwommen, führt der Bus weniger Kanäle, als die Encoder erzeugen, oder der Decoder ist auf eine niedrigere Ordnung eingestellt als die Encoder: Die Ortung klingt dann wie 1. Ordnung, obwohl HOA-Material anliegt.

</div>
</details>

---

## ICST Ambisonics Tools (Max/MSP)

<details class="faq-item">
<summary class="faq-question">Welche Max-Version wird benötigt?</summary>
<div class="faq-answer">

Max 8.0 oder neuer. Das Paket ist über den Max Package Manager verfügbar.

</div>
</details>

<details class="faq-item">
<summary class="faq-question">Was ist der Unterschied zwischen Plugins und Tools?</summary>
<div class="faq-answer">

Die Plugins laufen in REAPER als VST/AU-Effects und sind für Session-basiertes Multitrack-Arbeiten ausgelegt. Die Tools sind Max/MSP-Externals für Live-Spatialisation, algorithmische Komposition und eigene Patches ausserhalb einer DAW.

</div>
</details>

---

## Updates & Versionen

<details class="faq-item">
<summary class="faq-question">Wie aktualisiere ich auf v4.0?</summary>
<div class="faq-answer">

Den Installer für das eigene System (macOS .pkg, Windows .exe, Linux .deb) vom [GitHub-Release 4.0.0](https://github.com/schweizerweb/icst-ambisonics-plugins/releases/tag/4.0.0) laden, über die bestehende Installation ausführen und die Plugins in REAPER neu scannen lassen. Mit v3.x gespeicherte Sessions öffnen in v4.0 ohne Umwandlung. Umgekehrt nicht verlässlich: Eine mit v4.0 gespeicherte Session zeigt in einer älteren Version die Warnung «Outdated AmbiEncoder version». Vor dem Wechsel wichtige Projekte sichern. Sessions aus v2.x und früher sind mit v3 und später nicht kompatibel. Neuerungen: [Was ist neu](/de/icst-ambisonics-plugins/00_new/).

</div>
</details>

<details class="faq-item">
<summary class="faq-question">Wo kann ich Bugs melden oder Features anfragen?</summary>
<div class="faq-answer">

Ein Issue auf dem [GitHub-Repository](https://github.com/schweizerweb/icst-ambisonics-plugins/issues) öffnen — OS-Version, REAPER-Version, Plugin-Version und wenn möglich ein minimales Beispielprojekt angeben.

</div>
</details>
