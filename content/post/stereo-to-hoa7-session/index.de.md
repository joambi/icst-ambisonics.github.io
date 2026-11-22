---
title: "Von Stereo zu HOA7: Eine Schritt-für-Schritt-Session"
description: "Strukturierter Übergang von einem Stereo-Denken zu einer praktischen HOA7-Ambisonics-Session mit Routing, Bewegungsdesign und Export-Checks."
date: 2026-03-08T14:20:00+01:00
year: 2026
month: 2026-03
weight: 24
tags: ["tutorial", "hoa7", "reaper", "ambisonics", "workflow"]
key_points:
  - "Stereo-Produktionsdenken in einen 7th-Order-Ambisonics-Workflow überführen"
  - "Kontrollierte Quellbewegungen gestalten und HOA7-Export prüfen"
difficulty: "intermediate"
post_kind: "tutorial"
tool: ["REAPER"]
---


**Level:** Intermediate | **Zielgruppe:** Komponist:in, Producer.

## Warum es diesen Guide gibt
Viele Nutzer:innen kennen Stereo-Produktion sehr gut, brauchen aber eine konkrete Brücke zu Higher-Order Ambisonics in einer realen Session.

## Lernziel
Ein Stereo-Arrangement in HOA7-Denken überführen: Objektplatzierung, Bewegung und kontrolliertes Rendering.

## Voraussetzungen
- Grundkenntnisse in Stereo-Mix-Workflows.
- Grundkenntnisse in Reaper-Projektaufbau.
- ICST Plugins sind installiert.

## Schritt 1 - Stereo-Rollen in Raumrollen übersetzen

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Stereo-Rollen im Raum: Lead bleibt vorne, Support wird breiter, Atmosphäre wird eine diffuse Höhenebene." xmlns="http://www.w3.org/2000/svg"><defs><marker id="m1" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="150" y="22" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Stereo</text><line x1="40" y1="110" x2="260" y2="110" stroke="currentColor" stroke-width="2" stroke-opacity=".5"/><circle cx="150" cy="110" r="9" fill="#d9534f" fill-opacity=".85"/><text x="150" y="90" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Lead</text><circle cx="80" cy="110" r="9" fill="#3fa968" fill-opacity=".85"/><text x="80" y="90" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Support</text><circle cx="220" cy="110" r="9" fill="#3fa968" fill-opacity=".85"/><text x="220" y="90" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Support</text><rect x="60" y="140" width="180" height="30" rx="15" fill="#4a8fe0" fill-opacity=".2" stroke="#4a8fe0"/><text x="150" y="160" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Atmosphäre</text><line x1="285" y1="110" x2="380" y2="110" stroke="currentColor" stroke-width="1.6" marker-end="url(#m1)"/><text x="540" y="22" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Raum</text><circle cx="540" cy="115" r="85" fill="none" stroke="currentColor" stroke-opacity=".3"/><circle cx="540" cy="115" r="52" fill="none" stroke="#4a8fe0" stroke-width="2" stroke-dasharray="5 4"/><circle cx="540" cy="115" r="9" fill="none" stroke="currentColor" stroke-width="1.8"/><circle cx="540" cy="102" r="2.5" fill="currentColor"/><circle cx="540" cy="45" r="9" fill="#d9534f" fill-opacity=".85"/><text x="556" y="49" text-anchor="start" font-size="11" font-weight="400" fill="currentColor" fill-opacity="1">Lead</text><circle cx="460" cy="123" r="9" fill="#3fa968" fill-opacity=".85"/><circle cx="620" cy="123" r="9" fill="#3fa968" fill-opacity=".85"/><text x="460" y="149" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="1">Support</text><text x="620" y="149" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="1">Support</text><text x="540" y="227" text-anchor="middle" font-size="11" font-weight="400" fill="#4a8fe0" fill-opacity="1">Atmosphäre: diffus, oben</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Schritt 1: von Stereo-Rollen zu Raumrollen.</figcaption>
</figure>

Ordne Stereo-Elemente räumlichen Objekten zu:
- Lead-Elemente -> stabile Front oder gezielte Bewegung.
- Support-Elemente -> breitere Räume.
- Atmosphären -> diffuse oder geschichtete Höhenanteile.

## Schritt 2 - HOA7-Session-Grundstruktur bauen

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 262" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Die 64 Kanäle von HOA7 nach Ordnung 0 bis 7 gruppiert; niedrigere Ordnungen sind in höheren enthalten." xmlns="http://www.w3.org/2000/svg"><rect x="20" y="22" width="21" height="21" rx="3" fill="#8a8a8a" fill-opacity=".85"/><rect x="44" y="22" width="21" height="21" rx="3" fill="#4a8fe0" fill-opacity=".85"/><rect x="68" y="22" width="21" height="21" rx="3" fill="#4a8fe0" fill-opacity=".85"/><rect x="92" y="22" width="21" height="21" rx="3" fill="#4a8fe0" fill-opacity=".85"/><rect x="116" y="22" width="21" height="21" rx="3" fill="#3fa5c4" fill-opacity=".85"/><rect x="140" y="22" width="21" height="21" rx="3" fill="#3fa5c4" fill-opacity=".85"/><rect x="164" y="22" width="21" height="21" rx="3" fill="#3fa5c4" fill-opacity=".85"/><rect x="188" y="22" width="21" height="21" rx="3" fill="#3fa5c4" fill-opacity=".85"/><rect x="20" y="46" width="21" height="21" rx="3" fill="#3fa5c4" fill-opacity=".85"/><rect x="44" y="46" width="21" height="21" rx="3" fill="#3fa98f" fill-opacity=".85"/><rect x="68" y="46" width="21" height="21" rx="3" fill="#3fa98f" fill-opacity=".85"/><rect x="92" y="46" width="21" height="21" rx="3" fill="#3fa98f" fill-opacity=".85"/><rect x="116" y="46" width="21" height="21" rx="3" fill="#3fa98f" fill-opacity=".85"/><rect x="140" y="46" width="21" height="21" rx="3" fill="#3fa98f" fill-opacity=".85"/><rect x="164" y="46" width="21" height="21" rx="3" fill="#3fa98f" fill-opacity=".85"/><rect x="188" y="46" width="21" height="21" rx="3" fill="#3fa98f" fill-opacity=".85"/><rect x="20" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="44" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="68" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="92" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="116" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="140" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="164" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="188" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="20" y="94" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="44" y="94" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="68" y="94" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="92" y="94" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="116" y="94" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="140" y="94" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="164" y="94" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="188" y="94" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="20" y="118" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="44" y="118" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="68" y="118" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="92" y="118" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="116" y="118" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="140" y="118" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="164" y="118" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="188" y="118" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="20" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="44" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="68" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="92" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="116" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="140" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="164" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="188" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="20" y="166" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="44" y="166" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="68" y="166" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="92" y="166" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="116" y="166" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="140" y="166" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="164" y="166" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="188" y="166" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="20" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="44" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="68" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="92" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="116" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="140" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="164" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="188" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><text x="116" y="236" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.8">64 Kanäle, nach Ordnung eingefärbt</text><text x="250" y="30" text-anchor="start" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Ordnungen in HOA7 (Kanäle kumuliert)</text><rect x="250" y="44" width="18" height="18" rx="3" fill="#8a8a8a" fill-opacity=".85"/><text x="280" y="58" text-anchor="start" font-size="13" font-weight="400" fill="currentColor" fill-opacity="1">Ordnung 0</text><text x="420" y="58" text-anchor="start" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">1</text><rect x="250" y="74" width="18" height="18" rx="3" fill="#4a8fe0" fill-opacity=".85"/><text x="280" y="88" text-anchor="start" font-size="13" font-weight="400" fill="currentColor" fill-opacity="1">Ordnung 1</text><text x="420" y="88" text-anchor="start" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">4</text><rect x="250" y="104" width="18" height="18" rx="3" fill="#3fa5c4" fill-opacity=".85"/><text x="280" y="118" text-anchor="start" font-size="13" font-weight="400" fill="currentColor" fill-opacity="1">Ordnung 2</text><text x="420" y="118" text-anchor="start" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">9</text><rect x="250" y="134" width="18" height="18" rx="3" fill="#3fa98f" fill-opacity=".85"/><text x="280" y="148" text-anchor="start" font-size="13" font-weight="400" fill="currentColor" fill-opacity="1">Ordnung 3</text><text x="420" y="148" text-anchor="start" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">16</text><rect x="250" y="164" width="18" height="18" rx="3" fill="#8fb83f" fill-opacity=".85"/><text x="280" y="178" text-anchor="start" font-size="13" font-weight="400" fill="currentColor" fill-opacity="1">Ordnung 5</text><text x="420" y="178" text-anchor="start" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">36</text><rect x="250" y="194" width="18" height="18" rx="3" fill="#d9843f" fill-opacity=".85"/><text x="280" y="208" text-anchor="start" font-size="13" font-weight="400" fill="currentColor" fill-opacity="1">Ordnung 7</text><text x="420" y="208" text-anchor="start" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">64</text><text x="250" y="250" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.8">(order + 1)² = channels</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">HOA7 enthält alle niedrigeren Ordnungen; 64 Kanäle tragen alles von FOA aufwärts.</figcaption>
</figure>

Lege pro Stereo-Element einen Mono-Quelltrack an, setze auf jedem einen AmbiEncoder ein und leite alle Encoder-Ausgänge auf einen `Bformat-Master`-Track.

- Stelle **alle** Ambisonics-Tracks auf **64 Kanäle**. HOA7 braucht genau 64 Kanäle (ACN 0-63); ein Track mit weniger Kanälen verliert still die höheren Ordnungen.
- Halte eine klare Kette: `Quelle -> Encoder -> Bformat-Master -> Decoder`. Keine Quelle geht direkt auf den Master.
- Benenne Tracks konsequent (`LEAD`, `PAD_L`, `ATMO`, `Bformat-Master`), damit Routing-Fehler später auffallen.
- Starte mit den [Track-Templates](/de/icst-ambisonics-plugins/05_open_track_templates/), statt das Routing von Hand zu bauen, und ergänze den Decoder mit dem Preset deiner Lautsprecher im Monitoring-Pfad.

## Schritt 3 - Mit statischer Platzierung starten
Gib jeder Quelle eine feste Position und höre, bevor es Automation gibt.

- Prüfe die Kette mit einer Mono-Testquelle an bekannter Position (geradeaus), bevor du den Rest platzierst.
- Lead nah an die Front, Support links und rechts, Atmosphäre höher und breiter. Nutze die Distanz, um Tiefenebenen zu trennen.
- Höre über Lautsprecher und binaural. Ist eine Quelle statisch nicht ortbar, rettet Bewegung sie nicht.
- Speichere ein Plugin-Preset pro Rolle und einen Projekt-Snapshot (zum Beispiel `_static`) als Rückfallebene.

## Schritt 4 - Kontrollierte Bewegung ergänzen
Ergänze Bewegung Element für Element, beginnend mit dem Lead.

- Starte mit kleinen Bewegungen; werde grösser, wenn sie im Monitoring nicht hörbar sind.
- Lass ein Vordergrund-Element sich bewegen, während Support und Atmosphäre ruhen.
- Wähle das Werkzeug nach Aufgabe: [Motion Markers](/de/post/motion-markers-reaper/) für zeitgebundene Bewegung, der [Animator](/de/icst-ambisonics-plugins/11_animator/) für Choreographien, [Gruppenanimation](/de/post/gp-manipulation/) für mehrere Quellen gleichzeitig.
- Prüfe jede Bewegung auch im binauralen Pfad, nicht nur über Lautsprecher.

## Schritt 5 - Übertragung prüfen

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 240" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Der HOA7-Bus wird auf Mono, Stereo, Binaural und dem Lautsprecher-Array geprüft." xmlns="http://www.w3.org/2000/svg"><defs><marker id="m3" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="70" width="170" height="60" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="95.0" y="98.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">HOA7-Bus</text><text x="95.0" y="114.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">64 Kanäle</text><line x1="182" y1="100" x2="438" y2="38" stroke="currentColor" stroke-width="1.6" marker-end="url(#m3)"/><rect x="440" y="14" width="260" height="44" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="570.0" y="34.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Mono</text><text x="570.0" y="50.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Summen-Check</text><line x1="182" y1="100" x2="438" y2="88" stroke="currentColor" stroke-width="1.6" marker-end="url(#m3)"/><rect x="440" y="64" width="260" height="44" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="570.0" y="84.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Stereo</text><text x="570.0" y="100.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Downmix-Check</text><line x1="182" y1="100" x2="438" y2="138" stroke="currentColor" stroke-width="1.6" marker-end="url(#m3)"/><rect x="440" y="114" width="260" height="44" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="570.0" y="134.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Binaural</text><text x="570.0" y="150.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Kopfhörer</text><line x1="182" y1="100" x2="438" y2="188" stroke="currentColor" stroke-width="1.6" marker-end="url(#m3)"/><rect x="440" y="164" width="260" height="44" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="570.0" y="184.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Lautsprecher-Array</text><text x="570.0" y="200.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Decoder-Preset</text><text x="360" y="230" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.85">Denselben Bus vor dem Export auf jedem Ziel prüfen.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Schritt 5: ein Bus, vier Prüfungen.</figcaption>
</figure>

Prüfe, ob die Session auch funktioniert, wenn das räumliche Format nicht verfügbar ist.

- Falte das B-Format auf Mono und Stereo: Die wichtigen Quellen müssen hörbar und ausgewogen bleiben (achte auf Phasenauslöschungen).
- Vergleiche Lautsprecher- und Binaural-Monitoring; beide sollten dieselbe Geschichte erzählen.
- Mache nach dem Laden eines Presets oder dem Wiederöffnen des Projekts einen 30-Sekunden-Signalcheck und prüfe, ob das Decoder-Preset zu den realen Lautsprechern passt.

## Schritt 6 - Export und Dokumentation
Rendere den **Bformat-Master**, nicht den Decoder-Ausgang.

1. Setze `Bformat-Master` auf Solo, öffne **File -> Render**, wähle 48 kHz und Multichannel-WAV mit **64 Kanälen**.
2. Rendere zuerst eine kurze Testdatei, importiere sie wieder und spiele sie über Decoder oder Binaural-Pfad ab.
3. Schreibe eine Notiz in **Project Settings -> Notes**: ambiX (ACN/SN3D), 48000 Hz, 64 Kanäle, 7. Ordnung, verwendetes Decoder-Preset.

Details: [B-Format rendern](/de/icst-ambisonics-plugins/12_render_bformat/) und [B-Format-Master exportieren](/de/post/b-format-export-reaper/).

## Typische Stolperfallen
- Zu früh zu viel Bewegung.
- Gain-Staging auf Higher-Order-Bussen wird ignoriert.
- Fehlende Dokumentation von Routing und OSC-Zuordnungen.
- Ein Track mit weniger als 64 Kanälen im Signalweg.
- Decoder-Preset, das nicht zu den realen Lautsprechern passt.

## Weiterführend
- [Welche Ambisonics-Ordnung brauche ich?](/de/post/hoa-ordnung-wahl-praxis/): prüfen, ob HOA7 für dein Projekt wirklich nötig ist
- [ICST MultiEncoder: Gruppenanimation](/de/post/gp-manipulation/): mehrere Quellen gemeinsam bewegen
- [ICST Animator](/de/icst-ambisonics-plugins/11_animator/): Bewegungen auf einer Timeline gestalten statt von Hand
- [ICST AmbiDecoder: Multi-Decoder-Modus](/de/post/multi-decoder-mode/): für grössere oder gemischte Lautsprecher-Setups
- [Ambisonics-Workflow](/de/learn/ambisonics-workflow/): der ganze Weg von der Aufnahme bis zur Abgabe
- Später: [OSC und Steuerung](/de/reference/osc-and-control/)
