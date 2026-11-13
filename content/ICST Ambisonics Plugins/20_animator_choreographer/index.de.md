---
title: Animator Choreographer
date: 2026-11-12T00:00:00
weight: 86
draft: false
toc: true
type: docs
translationKey: animator-choreographer-docs
docs_nav_id: animator-choreographer
docs_nav_label: Animator Choreographer
description: "Desktop-App, die Szenen-XML für den ICST Animator in fünf Schritten erzeugt: Gruppen, Gesten, Beziehungen und REAPER-Regionen als Abschnitte."
---

Niveau: Fortgeschritten | Zielgruppe: Komponist:innen, Sounddesigner:innen | **Arbeitet mit:** [ICST Animator](/de/icst-ambisonics-plugins/11_animator/)

Der **Animator Choreographer** ist eine Desktop-App, mit der du planst, wie sich Gruppen von Quellen über die Zeit im Raum bewegen. Du beschreibst die Choreographie in Hörbegriffen (Richtung, Distanz, Höhe, Geste). Die App erzeugt daraus die Szenen-XML, die der [Animator](/de/icst-ambisonics-plugins/11_animator/) im ICST AmbiEncoder_64 importiert und abspielt.

{{< notice warning >}}
**Evaluationsbeta, nicht signiert.** macOS 15 und neuer: App öffnen, Meldung schliessen, dann **Systemeinstellungen › Datenschutz & Sicherheit › Dennoch öffnen** und mit dem Passwort bestätigen. Bis macOS 14 genügt beim ersten Start Ctrl-Klick › Öffnen. Alternative im Terminal: `xattr -dr com.apple.quarantine "Animator Choreographer.app"`. Windows: SmartScreen › **Weitere Informationen › Trotzdem ausführen**.
{{< /notice >}}

![Der Schritt Form im Animator Choreographer: Abschnitte, Raumgrösse und Encoder links, Draufsicht, Seitenansicht und Zeitleiste rechts](/images/icst-animator-choreographer-form.jpg)

## Wo er im Arbeitsablauf steht

1. Optional die Regionen oder Marker deines REAPER-Projekts als CSV exportieren.
2. Die Choreographie in der App planen, Abschnitte importieren, Gruppen und Gesten anpassen.
3. Die Szene als XML exportieren.
4. Die XML im [Animator](/de/icst-ambisonics-plugins/11_animator/) importieren und abspielen.

## Die fünf Schritte

1. **Form**: Titel, Dauer und Abschnitte des Stücks, auch aus REAPER-Regionen importierbar.
2. **Gruppen**: die Gruppen von Quellen, die sich gemeinsam bewegen.
3. **Gesten**: die Bewegung jeder Gruppe in jedem Abschnitt, in Hörbegriffen.
4. **Beziehungen**: wie die Gruppen zueinander stehen.
5. **Prüfen & Export**: den Plan prüfen und die XML schreiben.

## Voraussetzungen

| Punkt | Details |
|-------|---------|
| System | macOS 11+ (Universal), Windows 10/11 (x64), Linux x86_64 (glibc 2.35+) |
| Plugins | ICST Ambisonics Plugins mit dem Animator (AmbiEncoder_64) in REAPER; geprüft mit 3.2.0.9 |
| Optional | [Ollama](https://ollama.com) für den Entwurf eines Plans aus einer Beschreibung |
| Bezug | [Release auf GitHub](https://github.com/joambi/animator-choreographer/releases/tag/v0.1.0); die macOS-App liegt auch im [ICST Ambi REAPER Bundle](/de/icst-ambisonics-plugins/19_icst_ambi_reaper_bundle/) (Ordner `Animator`, Toolbar-Button *Open Animator*) |
| Lizenz | GPL-3.0 |
| Quellcode | [joambi/animator-choreographer](https://github.com/joambi/animator-choreographer) |

## Download

{{< release "animator-choreographer" >}}

Geprüft mit den ICST Ambisonics Plugins 3.2.0.9, mit 4.0.0 noch nicht. Das macOS-`.pkg` ist noch nicht auf einem Testrechner installiert worden; bis dahin ist das ZIP der sichere Weg. Windows und Linux sind bisher nur in GitHub Actions gebaut, installiert und gestartet worden, nicht an einem Rechner mit REAPER.

## Weiterlesen

Die ausführliche Anleitung mit REAPER-Regionen-Import, Plan aus Textbeschreibung und Beispielen steht im Beitrag [Animator Choreographer – Raumchoreographien planen und für den Animator exportieren](/de/post/icst-animator-choreographer/).
