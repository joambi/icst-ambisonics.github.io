---
title: OSC
date: 2025-01-01T00:00:00
weight: 120
draft: false
description: "Praktische Einstiegsseite für OSC-Steuerung mit dem ICST AmbiEncoder: was sich steuern lässt, wie der erste Test aussieht und wo Syntax und fortgeschrittene Workflows dokumentiert sind."
---

Level: Intermediate | Zielgruppe: Komponist:in, Techniker:in, Studierende, Interactive-Media-User.

Nutze diese Seite, wenn du den ICST AmbiEncoder von externer Hardware, Sensoren, Skripten oder netzwerkbasierten Controller-Apps aus steuern willst.

OSC (Open Sound Control) erlaubt es externer Hard- und Software, den ICST AmbiEncoder in Echtzeit zu steuern. Quellpositionen, Bewegungsdaten und Parameteränderungen lassen sich direkt in REAPER senden, ohne die Encoder-Oberfläche anzufassen.

## Was OSC hier macht

OSC ist die Brücke zwischen dem Encoder und externen Steuersystemen. Typische Parameter sind:

- Quellenposition in **AED** oder **XYZ**
- Quellenbewegung über die Zeit
- Gruppenbewegung, Skalierung oder Rotation
- Gain- und Mute-Zustände
- bidirektionales Status-Feedback aus dem Encoder

## Typische Anwendungsfälle

- tabletbasierte Steuerung mit **TouchOSC** oder **Lemur**
- Bewegungssteuerung über **GyrOSC** auf iOS
- algorithmische Steuerung aus **Max/MSP**, **SuperCollider** oder Python
- räumliche Encoder-Daten auf FX-Parameter abbilden
- Fernsteuerung von einem zweiten Computer im selben Netzwerk

## Erster Test in zwei Minuten

Für einen schnellen ersten OSC-Test:

1. Öffne eine funktionierende ICST-REAPER-Session mit bereits geladenem Encoder.
2. Öffne die OSC-Einstellungen des Encoders und prüfe den Input-Port.
3. Sende eine einfache OSC-Message aus deinem Controller oder deiner Testumgebung.
4. Bewege eine Quelle und prüfe, ob die Veränderung im Encoder sichtbar wird.
5. Kontrolliere, ob die Bewegung auch im Decoder oder binauralen Monitoring hörbar ist.

Wenn das nicht funktioniert, prüfe:

- der richtige UDP-Port ist geöffnet
- Sender und REAPER befinden sich im selben Netzwerk
- die OSC-Adresse entspricht der unterstützten Syntax
- der Encoder ist das Plugin, das den OSC-Input empfängt

## Hier starten

- [Die 10 wichtigsten OSC-Messages](/post/osc-10-key-messages/)  
  Schneller Praxiseinstieg mit kurzem Setup-Pfad und Debugging-Checkliste.
- [OSC-Syntax-Referenz](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)  
  Vollständige Referenz der unterstützten OSC-Adressen und Parameter.

## Häufige Workflows

- [OSC auf FX-Parameter abbilden](/post/osc-2-fx/)  
  Encoder-OSC-Output nutzen, um Effektparameter wie Halltiefe oder Diffusion zu steuern.
- [MaxMSP & ICST AmbiEncoder — OSC-Kommunikation](/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/)  
  Bidirektionale OSC-Kommunikation zwischen Max/MSP und dem Encoder.
- [GyrOSC — iOS-Bewegungssteuerung](/post/gyrosc/)  
  iOS-Bewegungssensordaten in den Encoder streamen.

## Wann sich OSC lohnt

Nutze OSC, wenn:

- Maussteuerung für Live-Bewegung zu begrenzt ist
- du Bewegungssensoren oder Mobilgeräte anbinden willst
- du reproduzierbare externe Kontrolle aus einer anderen Software-Umgebung brauchst
- du bidirektionales Feedback zwischen REAPER und einem Controller willst

Wenn du nur statische Positionierung oder einfache Automation in REAPER brauchst, reichen die Encoder-Oberfläche und die normalen Automationsspuren oft aus.

## Verwandte Seiten

- [ICST Encoders](/icst-ambisonics-plugins/10_icst_encoders/)
- [Schritt-für-Schritt-Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)
- [Best Practices](/icst-ambisonics-plugins/15_best_practices/)
- [YouTube — OSC Tutorial](https://www.youtube.com/watch?v=7_s-jaUQa14&t=10s)
