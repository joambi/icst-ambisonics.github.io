---
date: 2025-01-27T14:32:00
title: Spurvorlagen
weight: 50
description: "Übersicht der ICST-Spurvorlagen in REAPER — Inhalt, Verwendungszweck und Anleitung zum Einfügen in eine bestehende Session."
docs_nav_group: "Einstieg"
---

Level: Beginner | Zielgruppe: Komponist:in, Techniker:in, Studierende, Studio-User.

Nutze diese Seite, wenn du die passende ICST-Projekt- oder Spurvorlage auswählen willst, statt jeden Routing-Block manuell aufzubauen.

Die ICST Ambisonics Plugins installieren zwei Arten von REAPER-Vorlagen: **Projektvorlagen** für den Start einer vollständigen Session und **Spurvorlagen** zum Einfügen vorkonfigurierter Tracks in eine bestehende Session.

## Projektvorlagen vs. Spurvorlagen

**Projektvorlagen** (`.RPP`-Dateien) liefern eine vollständige, leere Session mit der gesamten Signalkette: Encoder, B-Format-Master und Decoder. Geeignet für den Start von Null.

**Spurvorlagen** ermöglichen es, einen vorkonfigurierten Encoder-Block — mit korrekter Kanalzahl und Routing — in ein bestehendes Projekt einzufügen. Geeignet für das Erweitern einer laufenden Session oder den Aufbau eigener Layouts.

## Verfügbare Projektvorlagen

Zwei Projektvorlagen werden nach `Users/Shared/AmbiPluginsTemp/ProjectTemplates` installiert:

| Vorlage | Inhalt | Wann verwenden |
|---|---|---|
| `ICST_AmbiPlugins_MonoEncoder.RPP` | Einzelne Monoquelle, Encoder, B-Format-Master, Decoder | Erste Sessions, minimale Setups oder Test einer einzelnen bewegten Quelle |
| `ICST_AmbiPlugins_MultiEncoder.RPP` | AmbiEncoder_64 mit 16 Monoquellen als Child-Tracks, B-Format-Master, Decoder | Für die meisten Produktionen — hier beginnen bei Multi-Source-Sessions |

## Verfügbare Spurvorlagen

Zwei Gruppen von Spurvorlagen werden nach `Users/Shared/AmbiPluginsTemplatesTemp/TrackTemplates` installiert:

**ICST AmbiPlugins** — Kern-Encoder-Blöcke:

- `ICST_AmbiEncoder_Multi_8src` — AmbiEncoder_64 mit 8 vorgerouteten Monoquellen. Häufigster Ausgangspunkt zum Hinzufügen einer neuen Quellengruppe zu einer bestehenden Session.
- AmbiEncoder-Vorlage — Einzelquellen-Track mit vorgeladenem Encoder und 64-Kanal-Ausgang.

**ICST AmbiPlugins 3rdParty** — Integrationen mit Drittanbieter-Plugins wie IEM- und SPARTA-Werkzeuge. Sinnvoll, wenn ICST-Encoder mit externer Bearbeitung im selben Signalpfad kombiniert werden.

![tracktemplate.png](tracktemplate.png)

## Spurvorlagen einfügen

1. Mit der rechten Maustaste in den leeren Spurbereich in **REAPER** klicken.
2. **Spur aus Vorlage einfügen** wählen.
3. Zur gewünschten Vorlagengruppe (**ICST AmbiPlugins** oder **ICST AmbiPlugins 3rdParty**) navigieren und die Vorlage auswählen.

<video autoplay muted loop playsinline preload="metadata" aria-label="Track_template" style="width:100%;height:auto;border-radius:6px" src="/icst-ambisonics-plugins/05_open_track_templates/Track_templates.mp4"></video>

Nach dem Einfügen das Routing zwischen den neuen Spuren und dem bestehenden B-Format-Master prüfen, bevor Audio hinzugefügt wird.

## Verwandte Seiten

- [Schnellstart](/de/icst-ambisonics-plugins/04_quick_start/)
- [Schritt-für-Schritt-Setup](/de/icst-ambisonics-plugins/06_step_by_step_setup/)
- [Best Practices](/de/icst-ambisonics-plugins/17_best_practices/)
