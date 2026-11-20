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

<figure data-gen="g19" style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Signalfluss: Controller senden OSC über das Netzwerk an den ICST AmbiEncoder in REAPER, der seinen Zustand zurückmeldet" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="aro1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="24" width="190" height="50" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="110" y="46" text-anchor="middle" font-weight="600" font-size="13">Tablet</text><text x="110" y="63" text-anchor="middle" font-size="10.5">TouchOSC, Lemur</text><line x1="205" y1="49" x2="275" y2="150" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#aro1)"/><rect x="15" y="86" width="190" height="50" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="110" y="108" text-anchor="middle" font-weight="600" font-size="13">Smartphone</text><text x="110" y="125" text-anchor="middle" font-size="10.5">GyrOSC-Bewegungsdaten</text><line x1="205" y1="111" x2="275" y2="150" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#aro1)"/><rect x="15" y="148" width="190" height="50" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="110" y="170" text-anchor="middle" font-weight="600" font-size="13">Software</text><text x="110" y="187" text-anchor="middle" font-size="10.5">Max/MSP, SuperCollider, Python</text><line x1="205" y1="173" x2="275" y2="150" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#aro1)"/><rect x="15" y="210" width="190" height="50" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="110" y="232" text-anchor="middle" font-weight="600" font-size="13">Zweiter Computer</text><text x="110" y="249" text-anchor="middle" font-size="10.5">gleiches Netzwerk</text><line x1="205" y1="235" x2="275" y2="150" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#aro1)"/><text x="240" y="285" text-anchor="middle" font-size="11">UDP über das Netzwerk</text><rect x="280" y="95" width="170" height="110" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="365" y="125" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="15">REAPER</text><text x="365" y="148" text-anchor="middle" font-size="13">ICST AmbiEncoder</text><text x="365" y="170" text-anchor="middle" font-size="10.5">empfängt OSC-Eingang</text><text x="365" y="187" text-anchor="middle" font-size="10.5">meldet seinen Zustand</text><line x1="450" y1="130" x2="540" y2="130" stroke="currentColor" stroke-width="2" opacity="1" marker-end="url(#aro1)"/><line x1="540" y1="170" x2="450" y2="170" stroke="#3fa968" stroke-width="2" opacity="1" marker-end="url(#aro1)"/><text x="495" y="121" text-anchor="middle" font-size="10.5">Steuerung</text><text x="495" y="190" text-anchor="middle" fill="#3fa968" font-size="10.5">Rückmeldung</text><rect x="545" y="95" width="160" height="110" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="625" y="125" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="13">Monitoring</text><text x="625" y="148" text-anchor="middle" font-size="12">AmbiDecoder</text><text x="625" y="168" text-anchor="middle" font-size="12">oder Binaural</text><text x="495" y="230" text-anchor="middle" font-weight="600" font-size="11">bidirektional</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">OSC ist die Brücke zwischen externer Steuerung und Encoder. Controller bewegen Quellen, der Encoder meldet seinen Zustand zurück.</figcaption>
</figure>



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

<figure data-gen="g19" style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Erster OSC-Test in fünf Schritten und was bei einem Fehler zu prüfen ist" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="aro2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="10" y="45" width="128" height="78" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="74.0" y="68" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="17">1</text><text x="74.0" y="90" text-anchor="middle" font-weight="600" font-size="11.5">Session öffnen</text><text x="74.0" y="106" text-anchor="middle" font-size="10.5">Encoder geladen</text><line x1="138" y1="84" x2="152" y2="84" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#aro2)"/><rect x="152" y="45" width="128" height="78" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="216.0" y="68" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="17">2</text><text x="216.0" y="90" text-anchor="middle" font-weight="600" font-size="11.5">Port prüfen</text><text x="216.0" y="106" text-anchor="middle" font-size="10.5">OSC-Einstellungen</text><line x1="280" y1="84" x2="294" y2="84" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#aro2)"/><rect x="294" y="45" width="128" height="78" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="358.0" y="68" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="17">3</text><text x="358.0" y="90" text-anchor="middle" font-weight="600" font-size="11.5">Nachricht senden</text><text x="358.0" y="106" text-anchor="middle" font-size="10.5">eine einfache OSC</text><line x1="422" y1="84" x2="436" y2="84" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#aro2)"/><rect x="436" y="45" width="128" height="78" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="500.0" y="68" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="17">4</text><text x="500.0" y="90" text-anchor="middle" font-weight="600" font-size="11.5">Eine Quelle bewegen</text><text x="500.0" y="106" text-anchor="middle" font-size="10.5">im Encoder sichtbar</text><line x1="564" y1="84" x2="578" y2="84" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#aro2)"/><rect x="578" y="45" width="128" height="78" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="642.0" y="68" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="17">5</text><text x="642.0" y="90" text-anchor="middle" font-weight="600" font-size="11.5">Hören</text><text x="642.0" y="106" text-anchor="middle" font-size="10.5">Decoder oder Binaural</text><text x="360" y="26" text-anchor="middle" font-weight="600">Erster Test in zwei Minuten</text><line x1="360" y1="123" x2="360" y2="150" stroke="#d9534f" stroke-width="1.6" opacity="1" marker-end="url(#aro2)" stroke-dasharray="4 3"/><rect x="110" y="152" width="500" height="80" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="360" y="174" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="12.5">Bewegt sich nichts, prüfen</text><text x="130" y="196" text-anchor="start" font-size="11.5">• UDP-Port ist offen</text><text x="380" y="196" text-anchor="start" font-size="11.5">• gleiches Netzwerk wie REAPER</text><text x="130" y="216" text-anchor="start" font-size="11.5">• Adresse passt zur Syntax</text><text x="380" y="216" text-anchor="start" font-size="11.5">• Encoder empfängt den Eingang</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Die fünf Schritte der Reihe nach durchgehen. Die Prüfliste hilft, wenn Schritt 4 keine Bewegung zeigt.</figcaption>
</figure>



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

<figure data-gen="g19" style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Aufbau einer OSC-Nachricht für den ICST AmbiEncoder" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="aro3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="360" y="34" text-anchor="middle" font-weight="600" font-size="13">Beispiel: Quelle 1 positionieren</text><rect x="50" y="56" width="110" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="105.0" y="84" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="15">/icst/ambi/</text><text x="105.0" y="122" text-anchor="middle" font-size="11">Namensraum</text><rect x="170" y="56" width="110" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="225.0" y="84" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="15">sourceindex</text><text x="225.0" y="122" text-anchor="middle" font-size="11">per Index</text><rect x="290" y="56" width="60" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="320.0" y="84" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="15">aed</text><text x="320.0" y="122" text-anchor="middle" font-size="11">Koordinaten</text><rect x="360" y="56" width="70" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="395.0" y="84" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="15">1</text><text x="395.0" y="122" text-anchor="middle" font-size="11">Quelle 1</text><rect x="440" y="56" width="70" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="475.0" y="84" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="15">45</text><text x="475.0" y="122" text-anchor="middle" font-size="11">Azimut</text><rect x="520" y="56" width="70" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="555.0" y="84" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="15">10</text><text x="555.0" y="122" text-anchor="middle" font-size="11">Elevation</text><rect x="600" y="56" width="70" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="635.0" y="84" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="15">0.8</text><text x="635.0" y="122" text-anchor="middle" font-size="11">Distanz</text><line x1="50" y1="140" x2="350" y2="140" stroke="currentColor" stroke-width="1.5" opacity="0.5"/><text x="200.0" y="158" text-anchor="middle" font-size="11">Adresse: was gesteuert wird</text><line x1="360" y1="140" x2="670" y2="140" stroke="currentColor" stroke-width="1.5" opacity="0.5"/><text x="515.0" y="158" text-anchor="middle" font-size="11">Argumente: wie</text><text x="360" y="196" text-anchor="middle" font-size="12">Eine Quelle stattdessen per Name ansprechen:</text><text x="360" y="214" text-anchor="middle" font-weight="600" font-size="12">/icst/ambi/source/aed 'S1' 45 10 0.8</text><text x="360" y="236" text-anchor="middle" font-size="11">Kartesische Positionen nutzen xyz:  /icst/ambi/sourceindex/xyz 2 0.2 0.2 0.0</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Die Adresse sagt, was gesteuert wird, die Zahlen danach sagen wie. Quellen lassen sich per Index oder per Name ansprechen.</figcaption>
</figure>



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

<figure data-gen="g19" style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Wann sich OSC lohnt und wann REAPER-Automation reicht" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="aro4" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="20" width="330" height="210" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="180" y="46" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="14">OSC lohnt sich</text><text x="30" y="78" text-anchor="start" font-size="12.5">• Mausbedienung ist für Live-Bewegung zu limitiert</text><text x="30" y="110" text-anchor="start" font-size="12.5">• Bewegungssensoren oder mobile Geräte</text><text x="30" y="142" text-anchor="start" font-size="12.5">• wiederholbare Steuerung aus anderer Software</text><text x="30" y="174" text-anchor="start" font-size="12.5">• Rückmeldung zwischen REAPER und Controller</text><rect x="375" y="20" width="330" height="210" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="540" y="46" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="14">REAPER allein reicht</text><text x="390" y="78" text-anchor="start" font-size="12.5">• statische Quellenplatzierung</text><text x="390" y="110" text-anchor="start" font-size="12.5">• einfache Automationsspuren</text><text x="390" y="142" text-anchor="start" font-size="12.5">• kein externer Controller</text><text x="390" y="174" text-anchor="start" font-size="12.5">• kein Live-Input nötig</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">OSC nutzen, wenn die Bewegung von ausserhalb REAPER kommt oder live sein muss. Statische Platzierung und einfache Automation brauchen kein OSC.</figcaption>
</figure>



Nutze OSC, wenn:

- Maussteuerung für Live-Bewegung zu begrenzt ist
- du Bewegungssensoren oder Mobilgeräte anbinden willst
- du reproduzierbare externe Kontrolle aus einer anderen Software-Umgebung brauchst
- du bidirektionales Feedback zwischen REAPER und einem Controller willst

Wenn du nur statische Positionierung oder einfache Automation in REAPER brauchst, reichen die Encoder-Oberfläche und die normalen Automationsspuren oft aus.

## Verwandte Seiten

- [ICST Encoders](/de/icst-ambisonics-plugins/10_icst_encoders/)
- [Schritt-für-Schritt-Setup](/de/icst-ambisonics-plugins/06_step_by_step_setup/)
- [Best Practices](/de/icst-ambisonics-plugins/17_best_practices/)
**OSC Tutorial Video**

{{< youtube 7_s-jaUQa14 >}}
