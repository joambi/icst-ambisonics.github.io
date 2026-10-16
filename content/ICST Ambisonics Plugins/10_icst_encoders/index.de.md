---
title: ICST Encoders
date: 2025-01-01T00:00:00
weight: 80
draft: false
description: "Leitfaden zu den ICST Encoders für Quellenpositionierung, Bewegung, Gruppierung und OSC-basierte Steuerung in Ambisonics-Sessions."
---

Level: Intermediate | Zielgruppe: Komponist:in, Techniker:in, Studierende, Interactive-Media-User.

Nutze diese Seite, wenn du Quellen im Ambisonics-Feld platzieren, bewegen, gruppieren oder automatisieren willst.

Wenn du vor den Encoder-Einstellungen unsicher bist, was **B-Format**, **ambiX**, **ACN/SN3D** oder **64 Kanäle** bedeuten, lies zuerst die [Ambisonics-Formate-Referenz](/de/learn/ambisonics-formats/).

## Welchen Encoder solltest du verwenden?

Nutze **MonoEncoder**, wenn:

- du jeweils nur eine Quelle positionieren willst
- du den Workflow gerade lernst
- du das klarste Routing pro Quelle willst

Nutze **MultiEncoder**, wenn:

- du viele Quellen in einer Oberfläche steuern willst
- du Quellengruppen brauchst
- du größere Bewegungsstrukturen aufnehmen oder editieren willst
- du OSC-basierte Interaktion mit mehreren Quellen planst

## Was die Encoder machen

Die **ICST Encoders** positionieren und bewegen Klangquellen im Ambisonics-B-Format-Feld.

- **MonoEncoder** arbeitet mit einer einzelnen Mono-Quelle.
- **MultiEncoder** verarbeitet bis zu 64 Quellen auf einer Spur und organisiert sie in bis zu 8 Gruppen.

Ein prägendes Merkmal ist die integrierte **Distanzsimulation**, die Tiefpassfilterung und einen Doppler-ähnlichen Effekt kombiniert, um Tiefenwahrnehmung zu formen.

Durch OSC-Ein- und Ausgang sind die Encoder auch für controllerbasierte und algorithmische Workflows geeignet.

## Übersicht

![ICST AmbiEncoder overview](<CleanShot 2026-03-04 at 14.27.47@2x.png>)

Oben links der **MonoEncoder** (eine Quelle), unten links der **MultiEncoder** mit drei Gruppen, rechts das Fenster **Encoder Settings**.

1. **Einstellungen** (Zahnrad) – öffnet das Fenster Encoder Settings.
2. **Hilfe** (?)
3. **Sources** – Quellenliste mit Position (X/Y/Z, A/E/D), Mute/Solo, Gain und Farbe.
4. **Encoding** – Encoding-Einstellungen.
5. **Radar** – Einstellungen der Radar-Darstellung.
6. **OSC In** – Empfang von OSC-Nachrichten.
7. **OSC Out** – Senden des Encoder-Zustands per OSC.
8. **Distance Scaler** – Distanzsimulation über Tiefpassfilterung und Doppler-ähnliches Verhalten.
9. **Infinite** – Quellen an der Fernfeld-Grenze platzieren.
10. **Master Gain [dB]** – Gesamtpegel des Encoders.
11. **import/export** – Quellkonfigurationen speichern oder laden.
12. **Groups** – Gruppen-Editor mit Position, Stretch, Rotation, Anzahl Punkte und Farbe; Gruppen lassen sich relativ zu ihrem Zentrum verschieben.
13. **Presets** – komplette Encoder-Zustände für reproduzierbare Setups speichern (save) und verwalten (manage…).

**Video: ICST Ambisonics Plugins – 02 – AmbiEncoder**

{{< youtube -U0t8sjeTsw >}}

## Benutzeroberfläche

### Quellen-Fenster

![AmbiEncoder source window](<CleanShot 2026-03-04 at 15.02.00@2x.png>)

In diesem Bereich werden einzelne Quellen über Azimut, Elevation und Distanz angezeigt und gesteuert.

**Neu in 4.0:** Die Spalte **Blauert** schaltet den Blauert-Filter pro Quelle ein oder aus (Einstellungen siehe [Encoding-Einstellungen](#encoding-einstellungen)).

![Tab Sources mit der neuen Spalte Blauert](ENC-SRC-01-Sources-Blauert.png)

### Encoding-Einstellungen

![AmbiEncoder encoding settings](<CleanShot 2026-03-04 at 15.02.47@2x.png>)

Hier werden zentrale Encoding-Parameter wie Ordnung und Kanalformat gesetzt.

**Neu in 4.0:** Im Tab **Encoding** lassen sich der **Doppler-Effekt** und der **Blauert-Filter** getrennt einschalten (Enable). Der Blauert-Filter hat zwei Modi, **Standard** und **Height Only** (wirkt nur in der Z-Achse), und einen **Intensity Factor** (in %), der die Stärke des Filters bestimmt.

![Tab Encoding: Doppler effect und Blauert filter mit Modus-Auswahl Standard / Height Only](ENC-ENC-01-Doppler-Blauert-Modus.png)

![Blauert filter mit Intensity Factor (1)](ENC-ENC-02-Blauert-Intensity.png)

### Radar

Das Radar zeigt das Feld in Draufsicht und macht Quellenpositionen und Gruppen direkt editierbar.

## Gruppierung und Bewegung

MultiEncoder ist besonders dann sinnvoll, wenn räumliche Bewegung nicht nur individuell, sondern strukturell gedacht wird:

- mehrere Quellen können gruppiert werden
- Gruppen lassen sich relativ zu ihrem Gruppenzentrum bewegen
- größere räumliche Choreografien können aufgenommen und verfeinert werden

Nutze Gruppen, wenn die Szene als zusammenhängendes Objekt funktionieren soll und nicht als Sammlung unabhängiger Einzelquellen.

**Neu in 4.0:**

![Sources und Groups: Blauert pro Quelle (1), Quellenauswahl über Edit… (2), Kontextmenü der Gruppe (3)](ENC-GRP-01-Groups-Edit-Kontextmenue.png)

1. **Blauert** – Blauert-Filter pro Quelle.
2. **Edit…** in der Spalte # Points – öffnet eine Auswahl aller 64 Quellen; angehakte Quellen gehören zur Gruppe.
3. **Kontextmenü der Gruppe** – **Reset Stretch**, **Reset Rotation** und **Apply color to sources** (überträgt die Gruppenfarbe auf ihre Quellen).

## OSC-Integration

- **OSC-Eingang und JavaScript** empfangen externe Steuernachrichten
- **OSC-Ausgang** sendet den Encoder-Zustand an Controller oder externe Anwendungen

**Neu in 4.0: OSC Out an externe Ziele.** Im Tab **OSC Out** sendet *Send Positions for External Usage* die Positionen an beliebig viele Ziele, wahlweise fortlaufend (*Continuous*) im eingestellten Intervall (ms). Unten zeigt der Tab den geschätzten Netzwerkverkehr.

![OSC Out: externe Ziele mit Enable (1), Host (2), Port (3), OSC-Message (4), Type (5) und presets (6)](ENC-OSC-01-OSC-Out-External-Targets.png)

1. **Enable** – Ziel ein- oder ausschalten.
2. **Host** – IP-Adresse des Empfängers.
3. **Port** – Zielport.
4. **OSC-Message** – Nachrichtenformat, z. B. *ICST AmbiPlugins Standard XYZ/AED* mit Name oder Index.
5. **Type** – was gesendet wird: All Sources, All Groups, All Sources & Groups oder Select….
6. **presets…** – Ziel-Konfigurationen speichern und laden.

Mit **Select…** öffnet der Button **…** eine Auswahl einzelner Quellen und Gruppen:

![Auswahl über … (1): einzelne Quellen (2) und Gruppen (3)](ENC-OSC-02-OSC-Out-Select.png)

{{< notice warning >}}
Die Auswahl gilt nach **Position in der Liste**. Werden Quellen oder Gruppen später umsortiert, hinzugefügt oder entfernt, sendet das Ziel unter Umständen andere Daten.
{{< /notice >}}

**Video: ICST Ambisonics Plugins – 03 – OSC Teil 1**

{{< youtube 7_s-jaUQa14 >}}

Für Setup und Syntax:

- [OSC](/icst-ambisonics-plugins/13_osc/)

## Häufige Fehler

- MultiEncoder wird genutzt, obwohl eine einfache MonoEncoder-Spur klarer wäre
- Distanz-Skalierung wird spät im Projekt verändert und bricht die Bewegungskonsistenz
- vergessen wird, dass das Encoder-Routing trotzdem in einen stabilen Bformat Master führen muss
- OSC wird als Pflicht behandelt, obwohl normale REAPER-Automation ausreichen würde
- Quellen werden gruppiert, ohne klare Benennung, was spätere Bearbeitung erschwert

## Nächster Schritt

- [Schritt-für-Schritt-Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)
- [Ambisonics-Formate erklärt](/de/learn/ambisonics-formats/)
- [OSC](/icst-ambisonics-plugins/13_osc/)
- [Best Practices](/icst-ambisonics-plugins/15_best_practices/)
