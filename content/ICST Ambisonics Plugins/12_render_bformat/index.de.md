---
weight: 150
title: B-Format in REAPER rendern
date: 2026-03-18T12:15:00+01:00
description: "Kompakter REAPER-Leitfaden zum korrekten Rendern des Bformat Master, zur passenden Kanalzahl und zur Dokumentation der Export-Metadaten."
docs_nav_group: "Plugins"
---

Level: Beginner | Zielgruppe: Komponist:in, Techniker:in, Studierende, Studio-User.

Nutze diese Seite, wenn du den kürzesten verlässlichen Weg zu einem sauberen Ambisonics-Export aus REAPER brauchst. Das Ziel ist einfach: den **Bformat Master** rendern, nicht den Decoder-Ausgang.

Wenn du ambiX, ACN/SN3D, FOA/HOA oder die Bedeutung der Kanalzahl klären willst, halte [Ambisonics-Formate erklärt](/de/learn/ambisonics-formats/) neben dieser Anleitung offen.

## Was du am Ende erreicht hast

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Eine B-Format-Datei, viele Wiedergabesysteme" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="100" width="150" height="56" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="90.0" y="132.0" text-anchor="middle" font-weight="600">Bformat Master</text><rect x="215" y="100" width="150" height="56" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="290.0" y="126.0" text-anchor="middle" font-weight="600">WAV-Datei</text><text x="290.0" y="143.0" text-anchor="middle" font-size="10.5">64 Ch · ambiX</text><line x1="165" y1="128" x2="213" y2="128" stroke="currentColor" stroke-width="1.8" opacity="1" marker-end="url(#ar1)"/><rect x="470" y="30" width="230" height="52" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="585.0" y="54.0" text-anchor="middle" font-weight="600">Lautsprecher-Decoder</text><text x="585.0" y="71.0" text-anchor="middle" font-size="10.5">beliebiges Array</text><line x1="365" y1="128" x2="468" y2="56" stroke="#4a8fe0" stroke-width="1.4" opacity="0.8" marker-end="url(#ar1)"/><rect x="470" y="96" width="230" height="52" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="585.0" y="120.0" text-anchor="middle" font-weight="600">Binaural-Decoder</text><text x="585.0" y="137.0" text-anchor="middle" font-size="10.5">Kopfhörer</text><line x1="365" y1="128" x2="468" y2="122" stroke="#4a8fe0" stroke-width="1.4" opacity="0.8" marker-end="url(#ar1)"/><rect x="470" y="162" width="230" height="52" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="585.0" y="186.0" text-anchor="middle" font-weight="600">Anderes Studio / System</text><text x="585.0" y="203.0" text-anchor="middle" font-size="10.5">Archiv, Kolleg:innen</text><line x1="365" y1="128" x2="468" y2="188" stroke="#4a8fe0" stroke-width="1.4" opacity="0.8" marker-end="url(#ar1)"/><text x="90" y="84" text-anchor="middle" font-size="11">hier gerendert</text><text x="290" y="84" text-anchor="middle" fill="#d9a441" font-size="11">einmal</text><text x="360" y="236" text-anchor="middle" font-weight="600" font-size="12">Das B-Format bleibt neutral, bis der Decoder gewählt wird.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Ein Render vom Bformat Master wird später für das jeweils verfügbare System dekodiert. Ein Render des Decoder-Ausgangs würde ein Lautsprecher-Layout für immer festlegen.</figcaption>
</figure>




Am Ende hast du:

- einen korrekten B-Format-Export vom **Bformat Master**
- die passende Kanalzahl für deine HOA-Ordnung
- eine wiederverwendbare Metanotiz für Übergabe und spätere Verifikation

## REAPER-Tutorial: B-Format korrekt rendern

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Render-Ablauf in REAPER" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="40" width="150" height="70" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="90.0" y="73.0" text-anchor="middle" font-weight="600">Solo</text><text x="90.0" y="90.0" text-anchor="middle" font-size="10.5">Bformat Master</text><rect x="205" y="20" width="300" height="230" rx="10" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="355" y="44" text-anchor="middle" font-weight="600">Datei → Rendern</text><text x="222" y="86" text-anchor="start" font-size="12">Quelle</text><rect x="360" y="68" width="135" height="28" rx="5" fill="none" fill-opacity="0" stroke="#4a8fe0" stroke-width="1.2" opacity="1"/><text x="427" y="87" text-anchor="middle" font-weight="600" font-size="12">Stems (ausgewählt)</text><text x="222" y="128" text-anchor="start" font-size="12">Sample Rate</text><rect x="360" y="110" width="135" height="28" rx="5" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.2" opacity="1"/><text x="427" y="129" text-anchor="middle" font-size="12">48000 Hz</text><text x="222" y="170" text-anchor="start" font-size="12">Format</text><rect x="360" y="152" width="135" height="28" rx="5" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.2" opacity="1"/><text x="427" y="171" text-anchor="middle" font-size="12">Multi-WAV / RF64</text><text x="222" y="212" text-anchor="start" font-size="12">Kanäle</text><rect x="360" y="194" width="135" height="28" rx="5" fill="none" fill-opacity="0" stroke="#4a8fe0" stroke-width="1.2" opacity="1"/><text x="427" y="213" text-anchor="middle" font-weight="600" font-size="12">(N+1)²  z.B. 64</text><rect x="545" y="40" width="150" height="70" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="620.0" y="73.0" text-anchor="middle" font-weight="600">Test-Render</text><text x="620.0" y="90.0" text-anchor="middle" font-size="10.5">re-importieren + prüfen</text><line x1="165" y1="75" x2="203" y2="75" stroke="currentColor" stroke-width="1.8" opacity="1" marker-end="url(#ar2)"/><line x1="505" y1="75" x2="543" y2="75" stroke="currentColor" stroke-width="1.8" opacity="1" marker-end="url(#ar2)"/><text x="355" y="278" text-anchor="middle" font-size="12">Kanalzahl muss zur HOA-Ordnung passen: 4 · 9 · 16 · 25 · 36 · 49 · 64</text><text x="620" y="140" text-anchor="middle" font-size="24">↩</text><text x="620" y="162" text-anchor="middle" font-size="11">dann voller Render</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Drei Schritte: Master auf Solo, Render-Dialog einstellen, eine kurze Testdatei prüfen, bevor exportiert wird.</figcaption>
</figure>




Nutze diese kurze REAPER-Sequenz für einen sauberen Ambisonics-Export:

1. Den Track **Bformat Master** auf **Solo** setzen.
2. **Datei -> Rendern** öffnen.
3. **Quelle: Stems (ausgewählte Tracks)** oder den entsprechenden spurbezogenen Render-Modus wählen.
4. **Bformat Master** als Render-Ziel auswählen.
5. **Sample Rate** auf `48000` setzen.
6. Als Format **Multichannel WAV / RF64** wählen.
7. Die **Kanalanzahl** passend zur HOA-Ordnung setzen:
   - `4` Kanäle für FOA / 1. Ordnung
   - `9` Kanäle für 2. Ordnung
   - `16` Kanäle für 3. Ordnung
   - bis `64` Kanäle für 7. Ordnung
8. Zuerst eine kurze Testdatei rendern, danach wieder in REAPER importieren und über Decoder oder binauralen Pfad kontrollieren.

## Kanalzahl-Kurzreferenz

| HOA-Ordnung | Kanäle |
|---|---:|
| 1. Ordnung / FOA | 4 |
| 2. Ordnung | 9 |
| 3. Ordnung | 16 |
| 4. Ordnung | 25 |
| 5. Ordnung | 36 |
| 6. Ordnung | 49 |
| 7. Ordnung | 64 |

## Meta-Text in REAPER

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 190" role="img" aria-label="Aufbau des Dateinamens" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="70" y="50" width="192" height="56" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="166.0" y="87" text-anchor="middle" font-size="22" font-family="monospace" font-weight="600">scene01</text><line x1="166.0" y1="106" x2="166.0" y2="128" stroke="#4a8fe0" stroke-width="1.5" opacity="1" marker-end="url(#ar3)"/><text x="166.0" y="148" text-anchor="middle" fill="#4a8fe0" font-size="12">Szene</text><rect x="278" y="50" width="92" height="56" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="324.0" y="87" text-anchor="middle" font-size="22" font-family="monospace" font-weight="600">O7</text><line x1="324.0" y1="106" x2="324.0" y2="128" stroke="#3fa968" stroke-width="1.5" opacity="1" marker-end="url(#ar3)"/><text x="324.0" y="148" text-anchor="middle" fill="#3fa968" font-size="12">Ordnung</text><rect x="386" y="50" width="162" height="56" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="467.0" y="87" text-anchor="middle" font-size="22" font-family="monospace" font-weight="600">take01</text><line x1="467.0" y1="106" x2="467.0" y2="128" stroke="#d9a441" stroke-width="1.5" opacity="1" marker-end="url(#ar3)"/><text x="467.0" y="148" text-anchor="middle" fill="#d9a441" font-size="12">Take</text><rect x="564" y="50" width="92" height="56" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="610.0" y="87" text-anchor="middle" font-size="22" font-family="monospace" font-weight="600">.wav</text><line x1="610.0" y1="106" x2="610.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1" marker-end="url(#ar3)"/><text x="610.0" y="148" text-anchor="middle" font-size="12">Format</text><text x="360" y="24" text-anchor="middle" font-weight="600">Der Dateiname dokumentiert Ordnung und Take</text><text x="360" y="176" text-anchor="middle" font-size="11">Beispiel: scene01_O7_take01.wav = Szene 01, 7. Ordnung, Take 01</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Ordnung und Take gehören in den Dateinamen, damit die Kanalstruktur klar ist, bevor die Datei geöffnet wird.</figcaption>
</figure>




Halte eine kurze Exportnotiz in **Project Settings -> Notes** oder in einer Session-Textdatei neben dem Render fest. Das erleichtert Übergabe und spätere Verifikation deutlich.

Vorgeschlagener Meta-Text:

```text
Render: B-format master
Format: ambiX (ACN / SN3D)
Sample rate: 48000 Hz
Channels: 64
HOA order: 7th
Source track: BFORMAT_MASTER
Decoder preset used for monitoring: [speaker preset name]
Binaural check: yes / no
Filename: scene01_O7_take01.wav
Notes: rendered from B-format master, not decoder output
```

## Häufige Fehler

- Den **Decoder-Ausgang** statt des **Bformat Master** rendern
- Falsche Kanalzahl für die gewählte HOA-Ordnung
- Nicht dokumentieren, ob über Lautsprecher, Kopfhörer oder beides kontrolliert wurde
- Eine Datei ohne klare Ordnung und Take-Information im Dateinamen abgeben

## Verwandte Seiten

- [Schritt-für-Schritt-Setup](/de/icst-ambisonics-plugins/06_step_by_step_setup/)
- [Ambisonics-Formate erklärt](/de/learn/ambisonics-formats/)
- [Best Practices](/de/icst-ambisonics-plugins/17_best_practices/)
- [ICST Decoder](/de/icst-ambisonics-plugins/08_icst_decoder/)
