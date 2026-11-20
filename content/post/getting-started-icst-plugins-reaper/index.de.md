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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 230" role="img" aria-label="30-Minuten-Plan mit Vorlagen-Abkürzung" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="70" width="126" height="62" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="78.0" y="99.0" text-anchor="middle" font-weight="600">1. Monitoring</text><text x="78.0" y="116.0" text-anchor="middle" font-size="10.5">≈ 5 min</text><line x1="141" y1="101" x2="153" y2="101" stroke="currentColor" stroke-width="1.4" opacity="1" marker-end="url(#ar1)"/><rect x="153" y="70" width="126" height="62" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="216.0" y="99.0" text-anchor="middle" font-weight="600">2. Quelle</text><text x="216.0" y="116.0" text-anchor="middle" font-size="10.5">≈ 5 min</text><line x1="279" y1="101" x2="291" y2="101" stroke="currentColor" stroke-width="1.4" opacity="1" marker-end="url(#ar1)"/><rect x="291" y="70" width="126" height="62" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="354.0" y="99.0" text-anchor="middle" font-weight="600">3. Bewegen</text><text x="354.0" y="116.0" text-anchor="middle" font-size="10.5">≈ 5 min</text><line x1="417" y1="101" x2="429" y2="101" stroke="currentColor" stroke-width="1.4" opacity="1" marker-end="url(#ar1)"/><rect x="429" y="70" width="126" height="62" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="492.0" y="99.0" text-anchor="middle" font-weight="600">4. Binaural</text><text x="492.0" y="116.0" text-anchor="middle" font-size="10.5">≈ 5 min</text><line x1="555" y1="101" x2="567" y2="101" stroke="currentColor" stroke-width="1.4" opacity="1" marker-end="url(#ar1)"/><rect x="567" y="70" width="126" height="62" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="630.0" y="99.0" text-anchor="middle" font-weight="600">5. Rendern</text><text x="630.0" y="116.0" text-anchor="middle" font-size="10.5">≈ 5 min</text><path d="M15,64 L15,52 L279,52 L279,64" fill="none" stroke="#3fa968" stroke-width="2"/><text x="147.0" y="40" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="12">Vorlagen-Abkürzung: schon eingerichtet</text><path d="M291,138 L291,150 L693,150 L693,138" fill="none" stroke="#4a8fe0" stroke-width="2"/><text x="492.0" y="170" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="12">Deine Arbeit in der Session</text><text x="360" y="212" text-anchor="middle" font-size="11">Jeder Schritt endet mit einer kurzen Prüfung. Schlägt sie fehl, erst beheben, dann weiter.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Fünf Schritte zu je etwa fünf Minuten. Eine Projektvorlage deckt die Schritte 1 und 2 ab.</figcaption>
</figure>







Wenn du das Setup überspringen willst, öffne `ICST_AmbiPlugins_MonoEncoder.RPP` (wird mit den Plugins installiert). Sie enthält bereits einen Encoder-Track, den 64-Kanal-`Bformat-Master` und den Decoder, die Schritte 1 und 2 sind damit erledigt. Starte bei Schritt 3 und nutze die Prüfungen aus Schritt 1 und 2 als schnellen Funktionstest. Alle Vorlagen siehst du unter [Spurvorlagen](/de/icst-ambisonics-plugins/05_open_track_templates/).

## Voraussetzungen
- Reaper und die ICST Ambisonics Plugins sind installiert ([Installation](/icst-ambisonics-plugins/02_installation/)).
- Empfohlen: SWS und ReaPack (Erweiterungen für Skripte und Updates in REAPER).
- Audio-Interface mit passender I/O-Konfiguration. Für die erste Session reichen Kopfhörer, ein Lautsprecherarray ist nicht nötig.
- Grundkenntnisse zu Tracks, Bussen und Plugin-Insert-Slots.
- Regel für die ganze Session: **64 Kanäle** auf allen Ambisonics-Tracks und das Routing nach jedem Schritt prüfen. 64 Kanäle reichen bis zur 7. Ordnung; niedrigere Ordnungen nutzen einfach weniger davon (siehe [Welche Ambisonics-Ordnung brauche ich?](/de/post/hoa-ordnung-wahl-praxis/)).

## Schritt 1 - Monitoring-Backbone

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 260" role="img" aria-label="Prüfung mit test all speakers" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><circle cx="190" cy="130" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="190" y="26" text-anchor="middle" font-size="11">vorne</text><rect x="174.0" y="34.0" width="32" height="22" rx="5" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="190.0" y="49.0" text-anchor="middle" font-weight="600" font-size="11">1</text><rect x="234.1" y="58.9" width="32" height="22" rx="5" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="250.1" y="73.9" text-anchor="middle" font-weight="600" font-size="11">2</text><rect x="259.0" y="119.0" width="32" height="22" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="275.0" y="134.0" text-anchor="middle" font-weight="600" font-size="11">3</text><rect x="234.1" y="179.1" width="32" height="22" rx="5" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="250.1" y="194.1" text-anchor="middle" font-weight="600" font-size="11">4</text><rect x="174.0" y="204.0" width="32" height="22" rx="5" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="190.0" y="219.0" text-anchor="middle" font-weight="600" font-size="11">5</text><rect x="113.9" y="179.1" width="32" height="22" rx="5" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="129.9" y="194.1" text-anchor="middle" font-weight="600" font-size="11">6</text><rect x="89.0" y="119.0" width="32" height="22" rx="5" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="105.0" y="134.0" text-anchor="middle" font-weight="600" font-size="11">7</text><rect x="113.9" y="58.9" width="32" height="22" rx="5" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="129.9" y="73.9" text-anchor="middle" font-weight="600" font-size="11">8</text><text x="190" y="246" text-anchor="middle" font-size="11">Nummerierung im Uhrzeigersinn</text><rect x="375" y="50" width="325" height="175" rx="10" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="537" y="86" text-anchor="middle" font-weight="600">test all speakers</text><text x="392" y="124" text-anchor="start" fill="#3fa968" font-size="12">✓ jeder Lautsprecher klingt nacheinander</text><text x="392" y="154" text-anchor="start" fill="#3fa968" font-size="12">✓ in der erwarteten Reihenfolge</text><text x="392" y="184" text-anchor="start" fill="#3fa968" font-size="12">✓ an der erwarteten Position</text><text x="392" y="214" text-anchor="start" fill="#d9534f" font-size="12">✗ Stille oder falsche Reihenfolge → Preset</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Der Lautsprechertest ist der erste Realitätscheck. Hier spielt gerade Lautsprecher 3 (rot).</figcaption>
</figure>







Lege eine neue Session an, setze die Sample Rate und erstelle den Track `Bformat-Master` (64 Kanäle). Setze den Decoder in den Monitoring-Pfad und wähle das Lautsprecher-Preset.

**Prüfung (ca. 5 Minuten):** Nutze im Decoder *test all speakers*. Jeder Lautsprecher sollte nacheinander an der erwarteten Position und in der erwarteten Reihenfolge erklingen. Wenn nicht, korrigiere das Preset, bevor du weitermachst.

- Docs: [Schnellstart](/icst-ambisonics-plugins/04_quick_start/), [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/), [Spurvorlagen](/icst-ambisonics-plugins/05_open_track_templates/)

## Schritt 2 - Quelle hinzufügen
Lege einen Quelltrack mit dem AmbiEncoder an und route den Ausgang auf `Bformat-Master`. Prüfe die Kanalzuordnung im Routing-Fenster.

**Prüfung (ca. 5 Minuten):** Spiele einen Mono-Testklang ab. Steht der Encoder vorne, hörst du ihn vorne, und der Pegelanzeiger von `Bformat-Master` bewegt sich. Kein Signal dort bedeutet: Das Routing ist unterbrochen.

- Docs: [Wie es funktioniert](/icst-ambisonics-plugins/03_how_it_works/), [ICST Encoders](/icst-ambisonics-plugins/10_icst_encoders/)

## Schritt 3 - Quelle im Raum bewegen

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Bewegung aufnehmen" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="70" width="150" height="70" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="90.0" y="103.0" text-anchor="middle" font-weight="600">Write / Touch</text><text x="90.0" y="120.0" text-anchor="middle" font-size="10.5">Automation setzen</text><line x1="165" y1="105" x2="190" y2="105" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#ar3)"/><rect x="190" y="70" width="150" height="70" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="265.0" y="103.0" text-anchor="middle" font-weight="600">Bewegen</text><text x="265.0" y="120.0" text-anchor="middle" font-size="10.5">Quelle in X/Y/Z</text><line x1="340" y1="105" x2="365" y2="105" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#ar3)"/><rect x="365" y="70" width="150" height="70" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="440.0" y="103.0" text-anchor="middle" font-weight="600">Stoppen</text><text x="440.0" y="120.0" text-anchor="middle" font-size="10.5">Regler loslassen</text><line x1="515" y1="105" x2="540" y2="105" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#ar3)"/><rect x="540" y="70" width="150" height="70" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="615.0" y="103.0" text-anchor="middle" font-weight="600">Abspielen</text><text x="615.0" y="120.0" text-anchor="middle" font-size="10.5">Hände weg</text><polyline points="205.0,185.0 207.2,181.2 209.4,177.7 211.6,174.7 213.8,172.3 216.0,170.6 218.2,169.8 220.4,169.8 222.6,170.4 224.8,171.6 227.0,173.0 229.2,174.6 231.4,176.1 233.6,177.2 235.8,177.9 238.0,178.0 240.2,177.6 242.4,176.7 244.6,175.5 246.8,174.1 249.0,172.7 251.2,171.6 253.4,170.9 255.6,170.9 257.8,171.6 260.0,173.2 262.2,175.5 264.4,178.4 266.6,181.9 268.8,185.6 271.0,189.4 273.2,193.0 275.4,196.1 277.6,198.6 279.8,200.3 282.0,201.2 284.2,201.3 286.4,200.7 288.6,199.5 290.8,197.9 293.0,196.2 295.2,194.5 297.4,193.2 299.6,192.2 301.8,191.8 304.0,191.9 306.2,192.6 308.4,193.6 310.6,194.8 312.8,196.1 315.0,197.2 317.2,197.8 319.4,197.9 321.6,197.3 323.8,195.8 326.0,193.7 328.2,190.8 330.4,187.4 332.6,183.7 334.8,180.0" fill="none" stroke="#d9534f" stroke-width="2"/><text x="205" y="214" text-anchor="start" fill="#d9534f" font-size="11">aufgezeichnete Automationskurve</text><path d="M615.0,142 C615.0,262 90.0,262 90.0,142" fill="none" stroke="currentColor" stroke-width="1.3" stroke-dasharray="4 3" opacity=".6" marker-end="url(#ar3)"/><text x="360" y="288" text-anchor="middle" font-size="12">Bewegung wiederholt sich? Dann klappt es</text><text x="360" y="34" text-anchor="middle" font-weight="600">Eine Bewegung in vier Zügen aufnehmen</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Die Bewegung bei laufender Wiedergabe schreiben, stoppen, dann ohne Berührung abspielen.</figcaption>
</figure>







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
