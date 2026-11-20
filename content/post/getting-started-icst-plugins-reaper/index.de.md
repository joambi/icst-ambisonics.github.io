---
title: Getting Started mit ICST Ambisonics Plugins in REAPER
description: "Praktischer Einstiegsleitfaden für Komponist:innen, Studierende und Techniker:innen, um mit ICST Ambisonics Plugins in Reaper eine erste funktionierende Session aufzubauen."
date: 2026-03-08T14:10:00+01:00
year: 2026
month: 2026-03
weight: 23
tags: ["tutorial", "reaper", "ambiencoder", "getting-started", "workflow"]
key_points:
  - "Erste funktionierende Spatial-Audio-Session in REAPER in rund 30 Minuten aufbauen"
  - "Strukturierte Checkliste vom Plugin-Install bis zum Binaural-Monitoring"
difficulty: "beginner"
post_kind: "tutorial"
tool: ["REAPER", "AmbiEncoder"]
aliases:
  - /de/post/reaper-setup-20-minuten/
  - /de/post/ambisonics-in-30-minutes/
---

**Level:** Beginner | **Zielgruppe:** Komponist:in, Studierende, Studio-Assistenz.

In rund 30 Minuten baust du eine funktionierende Reaper-Session auf: Quellrouting, AmbiEncoder-Steuerung, B-Format-Bus, Decoder und ein Monitoring-Check.
Das ist der kurze Weg. Die vollständige technische Referenz ist [Schritt-für-Schritt-Setup](/icst-ambisonics-plugins/06_step_by_step_setup/).

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 175" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Signalkette in REAPER: Quellen mit AmbiEncoder speisen den 64-Kanal-Bformat-Master, der zum Decoder für Lautsprecher und zu einem Binaural-Track für Kopfhörer geht." xmlns="http://www.w3.org/2000/svg"><defs><marker id="ah1" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="30" width="150" height="52" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="85.0" y="54.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Quelle 1</text><text x="85.0" y="70.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">+ AmbiEncoder</text><rect x="10" y="100" width="150" height="52" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="85.0" y="124.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Quelle 2</text><text x="85.0" y="140.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">+ AmbiEncoder</text><line x1="162" y1="56" x2="238" y2="86" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah1)"/><line x1="162" y1="126" x2="238" y2="100" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah1)"/><rect x="240" y="63" width="150" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="315.0" y="89.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Bformat-Master</text><text x="315.0" y="105.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">64 Kanäle</text><line x1="392" y1="80" x2="478" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah1)"/><line x1="392" y1="102" x2="478" y2="126" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah1)"/><rect x="480" y="30" width="130" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="545" y="54.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Decoder</text><text x="545" y="70.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Lautsprecher-Preset</text><line x1="612" y1="56" x2="636" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah1)"/><text x="642" y="60" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Lautsprecher</text><rect x="480" y="100" width="130" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="545" y="124.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Binaural-Track</text><text x="545" y="140.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Decoder (binaural)</text><line x1="612" y1="126" x2="636" y2="126" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah1)"/><text x="642" y="130" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Kopfhörer</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Die Session-Struktur aus den Schritten 1 bis 4: Jede Quelle hat einen eigenen AmbiEncoder, alle speisen einen B-Format-Bus, dekodiert wird einmal am Ausgang.</figcaption>
</figure>

## Abkürzung: mit einer Projektvorlage starten
Wenn du das Setup überspringen willst, öffne `ICST_AmbiPlugins_MonoEncoder.RPP` (wird mit den Plugins installiert). Sie enthält bereits einen Encoder-Track, den 64-Kanal-`Bformat-Master` und den Decoder, die Schritte 1 und 2 sind damit erledigt. Starte bei Schritt 3 und nutze die Prüfungen aus Schritt 1 und 2 als schnellen Funktionstest. Alle Vorlagen siehst du unter [Spurvorlagen](/de/icst-ambisonics-plugins/05_open_track_templates/).

## Voraussetzungen
- Reaper und die ICST Ambisonics Plugins sind installiert ([Installation](/icst-ambisonics-plugins/02_installation/)).
- Empfohlen: SWS und ReaPack (Erweiterungen für Skripte und Updates in REAPER).
- Audio-Interface mit passender I/O-Konfiguration. Für die erste Session reichen Kopfhörer, ein Lautsprecherarray ist nicht nötig.
- Grundkenntnisse zu Tracks, Bussen und Plugin-Insert-Slots.
- Regel für die ganze Session: **64 Kanäle** auf allen Ambisonics-Tracks und das Routing nach jedem Schritt prüfen. 64 Kanäle reichen bis zur 7. Ordnung; niedrigere Ordnungen nutzen einfach weniger davon (siehe [Welche Ambisonics-Ordnung brauche ich?](/de/post/hoa-ordnung-wahl-praxis/)).

## Schritt 1 - Monitoring-Backbone
Lege eine neue Session an, setze die Sample Rate und erstelle den Track `Bformat-Master` (64 Kanäle). Setze den Decoder in den Monitoring-Pfad und wähle das Lautsprecher-Preset.

**Prüfung (ca. 5 Minuten):** Nutze im Decoder *test all speakers*. Jeder Lautsprecher sollte nacheinander an der erwarteten Position und in der erwarteten Reihenfolge erklingen. Wenn nicht, korrigiere das Preset, bevor du weitermachst.

- Docs: [Schnellstart](/icst-ambisonics-plugins/04_quick_start/), [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/), [Spurvorlagen](/icst-ambisonics-plugins/05_open_track_templates/)

## Schritt 2 - Quelle hinzufügen
Lege einen Quelltrack mit dem AmbiEncoder an und route den Ausgang auf `Bformat-Master`. Prüfe die Kanalzuordnung im Routing-Fenster.

**Prüfung (ca. 5 Minuten):** Spiele einen Mono-Testklang ab. Steht der Encoder vorne, hörst du ihn vorne, und der Pegelanzeiger von `Bformat-Master` bewegt sich. Kein Signal dort bedeutet: Das Routing ist unterbrochen.

- Docs: [Wie es funktioniert](/icst-ambisonics-plugins/03_how_it_works/), [ICST Encoders](/icst-ambisonics-plugins/10_icst_encoders/)

## Schritt 3 - Quelle im Raum bewegen
Bewege die Quelle in X/Y/Z, beobachte sie in der Radar-Ansicht und speichere ein Preset. Nimm dann eine kurze Bewegung auf: Stelle die Positionsparameter des Encoders auf *Write*- oder *Touch*-Automation, bewege die Quelle bei laufender Wiedergabe und stoppe.

**Prüfung (ca. 5 Minuten):** Spiele die Stelle erneut ab, ohne etwas zu berühren. Die Quelle sollte deine Bewegung wiederholen. Für Marker und skriptgesteuerte Bewegung siehe [ICST Ambi Motion Markers](/de/icst-ambisonics-plugins/14_icst_ambi_motion_markers/).

## Schritt 4 - Binaural-Kontrolle
Setze parallel einen binauralen Pfad fürs Kopfhörer-Monitoring auf und mache einen kurzen Pegel- und Hörtest.

Nutze einen binauralen Decoder wie den kostenlosen IEM BinauralDecoder oder den SPARTA-Binauraldecoder. Er sitzt auf einem eigenen Track, der von `Bformat-Master` gespeist wird, parallel zum Lautsprecher-Decoder. Lass nie beide Pfade gleichzeitig hörbar laufen. Details: [Binaurales Monitoring im ICST-Workflow](/de/post/binaural-monitoring-icst-workflow/).

**Prüfung (ca. 5 Minuten):** Mit Kopfhörern sollte eine Quelle, die vorne steht, auch vorne klingen, und beim Bewegen nach links auch links.

## Schritt 5 - Rendern
Rendere aus `Bformat-Master` als Multichannel und prüfe die Ausgangskanäle. Die genauen Render-Einstellungen stehen auf [B-Format in REAPER rendern](/de/icst-ambisonics-plugins/12_render_bformat/).

**Prüfung (ca. 5 Minuten):** Die Datei hat die Kanalzahl deiner Ordnung (64 im obigen Setup). Importiere sie auf einen neuen Track und spiele sie über den Decoder ab.

## Häufige Startfehler

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 200" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Dieselbe Signalkette mit vier typischen Fehlerstellen: Quelle nicht geroutet, Track ohne 64 Kanäle, falsches Decoder-Preset, Binaural-Track von falscher Quelle gespeist." xmlns="http://www.w3.org/2000/svg"><defs><marker id="ah2" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="30" width="150" height="52" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="85.0" y="54.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Quelle 1</text><text x="85.0" y="70.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">+ AmbiEncoder</text><rect x="10" y="100" width="150" height="52" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="85.0" y="124.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Quelle 2</text><text x="85.0" y="140.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">+ AmbiEncoder</text><line x1="162" y1="56" x2="238" y2="86" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah2)"/><line x1="162" y1="126" x2="238" y2="100" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah2)"/><rect x="240" y="63" width="150" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="315.0" y="89.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Bformat-Master</text><text x="315.0" y="105.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">64 Kanäle</text><line x1="392" y1="80" x2="478" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah2)"/><line x1="392" y1="102" x2="478" y2="126" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah2)"/><rect x="480" y="30" width="130" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="545" y="54.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Decoder</text><text x="545" y="70.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Lautsprecher-Preset</text><line x1="612" y1="56" x2="636" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah2)"/><text x="642" y="60" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Lautsprecher</text><rect x="480" y="100" width="130" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="545" y="124.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Binaural-Track</text><text x="545" y="140.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Decoder (binaural)</text><line x1="612" y1="126" x2="636" y2="126" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah2)"/><text x="642" y="130" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Kopfhörer</text><circle cx="200" cy="55" r="11" fill="#d9534f"/><text x="200" y="60" text-anchor="middle" font-size="13" font-weight="700" fill="#fff" fill-opacity="1">1</text><circle cx="395" cy="60" r="11" fill="#d9534f"/><text x="395" y="65" text-anchor="middle" font-size="13" font-weight="700" fill="#fff" fill-opacity="1">2</text><circle cx="616" cy="28" r="11" fill="#d9534f"/><text x="616" y="33" text-anchor="middle" font-size="13" font-weight="700" fill="#fff" fill-opacity="1">3</text><circle cx="616" cy="98" r="11" fill="#d9534f"/><text x="616" y="103" text-anchor="middle" font-size="13" font-weight="700" fill="#fff" fill-opacity="1">4</text><text x="360" y="185" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.85">1 Quelle nicht geroutet  ·  2 Track hat nicht 64 Kanäle  ·  3 falsches Decoder-Preset  ·  4 Binaural von falscher Quelle</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Wo die erste Session meistens bricht.</figcaption>
</figure>

- Quelle nicht auf `Bformat-Master` geroutet; die Kette `Source -> Bformat-Master -> Decoder` ist unterbrochen. *Lösung:* Track-Routing und Kanalzuordnung prüfen (Schritt 2).
- Nicht-64-Kanal-Track im Signalpfad. *Lösung:* Jeden Ambisonics-Track auf 64 Kanäle stellen.
- Falsches Decoder-Preset für das Lautsprecher-Setup. *Lösung:* Passendes Preset laden und *test all speakers* ausführen (Schritt 1).
- Binaural-Track von falscher Quelle gespeist. *Lösung:* Nur von `Bformat-Master` speisen (Schritt 4).
- OSC-Port-Mismatch bei externer Steuerung. *Lösung:* Ports in REAPER, Controller und Plugin vergleichen; siehe [OSC und Steuerung](/de/reference/osc-and-control/).
- Gar kein Ton. *Lösung:* Mute/Solo-Status, Decoder-Ausgangsrouting auf dein Interface, dann den Master-Send von `Bformat-Master` prüfen.

## Nächste Schritte
- [Von Stereo zu HOA7: Schritt-für-Schritt-Session](/de/post/stereo-to-hoa7-session/): ein komplettes Projekt vom Start bis zum Render
- [Welche Ambisonics-Ordnung brauche ich?](/de/post/hoa-ordnung-wahl-praxis/)
- [Best Practices](/de/icst-ambisonics-plugins/17_best_practices/)
- [Ambisonics-Workflow](/de/learn/ambisonics-workflow/): von der Idee zum B-Format-Master, mit Checkliste
- Später: [OSC und Steuerung](/de/reference/osc-and-control/) und [Ableton-Live-Integration](/de/post/ableton_reaper/)
