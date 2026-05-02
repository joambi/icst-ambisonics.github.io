---
title: ICST Kompositionsstudio Support
description: "Treiber, Display-Setup, Fehlersuche und Kontaktstellen für die Arbeit im ICST Kompositionsstudio"
date: 2025-06-10T10:00:00
slug: icst-kompositionsstudio-support
aliases:
  - /blog/icst-kompositionsstudio-support/
weight: 1
group: "Studio"
languageCode: de
---

**Für wen:** Komponist:innen, Studierende, Researcher, Studio-Gäste und Techniker:innen.

Diese Seite bündelt die wichtigsten Support-Schritte für die Arbeit im ICST Kompositionsstudio: Audio-Treiber, Display-Setup, erste Fehlersuche und Kontaktstellen vor Ort.

<div class="home-cards">
  <section class="home-card">
    <h4>Audio vorbereiten</h4>
    <p>RME MadiFace USB installieren, DriverKit aktivieren und Mehrkanal-Ausgabe prüfen.</p>
    <div class="home-card__actions">
      <a class="hero__link hero__link--primary" href="https://rme-audio.de/de_madiface-usb.html" target="_blank" rel="noopener noreferrer">MadiFace USB</a>
      <a class="hero__link" href="https://rme-audio.de/rme-treiber-macos.html" target="_blank" rel="noopener noreferrer">RME macOS Driver</a>
    </div>
  </section>

  <section class="home-card">
    <h4>Screen vorbereiten</h4>
    <p>DisplayLink Manager installieren und macOS Spaces für den Curved Screen korrekt einstellen.</p>
    <div class="home-card__actions">
      <a class="hero__link hero__link--primary" href="https://www.synaptics.com/products/displaylink-graphics/downloads/macos" target="_blank" rel="noopener noreferrer">DisplayLink Manager</a>
      <a class="hero__link" href="/blog/icst-kompositionsstudio-pre-installation/">Pre-Installation</a>
    </div>
  </section>
</div>

## Audio: RME MadiFace USB

Installiere den passenden RME-Treiber vor deinem Studiotermin, wenn du mit dem eigenen Laptop arbeiten möchtest.

<details class="home-accordion" open>
  <summary>RME-Treiber installieren</summary>
  <div class="home-accordion__actions">
    <a class="hero__link hero__link--primary" href="https://rme-audio.de/de_madiface-usb.html" target="_blank" rel="noopener noreferrer">Produktseite MadiFace USB</a>
    <a class="hero__link" href="https://rme-audio.de/downloads/madiface_usb_d.pdf" target="_blank" rel="noopener noreferrer">Handbuch PDF</a>
    <a class="hero__link" href="https://rme-audio.de/rme-treiber-macos.html" target="_blank" rel="noopener noreferrer">RME-Treiber für macOS</a>
    <a class="hero__link" href="https://rme-audio.de/installationsanleitung.html" target="_blank" rel="noopener noreferrer">Installationsanleitung</a>
  </div>
  <p>Das MadiFace USB ist mit macOS und Windows nutzbar. Unter macOS 11 und neuer muss die passende USB-Series-Erweiterung beziehungsweise DriverKit-Komponente installiert und in den Systemeinstellungen erlaubt werden.</p>
</details>

<details class="home-accordion">
  <summary>macOS DriverKit erlauben</summary>
  <div class="home-accordion__actions">
    <a class="hero__link hero__link--primary" href="https://rme-audio.de/de_login-items-extensions-driverkit-macos-sequoia.html" target="_blank" rel="noopener noreferrer">Login Items & Extensions</a>
    <a class="hero__link" href="https://youtu.be/Ilkwtb2MKrM?t=156" target="_blank" rel="noopener noreferrer">Troubleshooting-Video ab 2:36</a>
  </div>
  <p>Wenn das Interface nach der Installation nicht erscheint, prüfe in macOS die Bereiche Datenschutz & Sicherheit sowie Login Items & Extensions. Starte den Mac nach dem Freigeben der Erweiterung neu.</p>
</details>

<details class="home-accordion">
  <summary>TotalMix und Mehrkanal</summary>
  <div class="home-accordion__actions">
    <a class="hero__link hero__link--primary" href="https://rme-audio.de/totalmix-fx.html" target="_blank" rel="noopener noreferrer">RME TotalMix FX</a>
    <a class="hero__link" href="/blog/icst-kompositionsstudio-speaker-settings/">Speaker Settings</a>
    <a class="hero__link" href="/blog/icst-kompositionsstudio-ambisonics-setting/">Ambisonics Setting</a>
  </div>
  <p>Für Ambisonics- und Mehrkanal-Workflows sollte kein Stereo-Downmix aktiv sein. Prüfe TotalMix vor der Session und lösche beziehungsweise deaktiviere unerwünschte Stereo-Mixes.</p>
</details>

## Video: Curved Screen und DisplayLink

Für den großen Studio-Screen wird DisplayLink benötigt. Installiere den DisplayLink Manager vor der Session und erlaube die nötigen Bildschirmfreigabe-Rechte in macOS.

1. DisplayLink Manager installieren.
2. Systemeinstellungen öffnen.
3. Mission Control öffnen.
4. Option **Monitore verwenden verschiedene Spaces** deaktivieren.
5. Ausloggen und erneut einloggen, damit die Einstellung aktiv wird.

## Erste Fehlersuche

<details class="home-accordion" open>
  <summary>Interface wird nicht erkannt</summary>
  <p>USB-Kabel prüfen, MadiFace neu verbinden, macOS-Sicherheitseinstellungen kontrollieren und nach DriverKit-Freigabe neu starten.</p>
</details>

<details class="home-accordion">
  <summary>Kein Mehrkanal-Audio</summary>
  <p>Audio-Gerät in der DAW prüfen, Sample Rate abgleichen, TotalMix-Routing kontrollieren und sicherstellen, dass kein Stereo-Downmix aktiv ist.</p>
</details>

<details class="home-accordion">
  <summary>Curved Screen verhält sich wie mehrere Displays</summary>
  <p>Die Mission-Control-Option für getrennte Spaces deaktivieren und danach ausloggen. Ohne neuen Login bleibt die alte Display-Konfiguration oft aktiv.</p>
</details>

## Support & Kontakt

**Studio-Support**

- Johannes Schütt · Mobile: +41 79 786 12 49 · Mail: [johannes.schuett@zhdk.ch](mailto:johannes.schuett@zhdk.ch)
- Peter Färber · Mobile: +41 79 444 06 16 · Mail: [peter.faerber@zhdk.ch](mailto:peter.faerber@zhdk.ch)

**Technischer Service A/V**

- Simon Könz · Mobile: +41 76 330 11 02 · Mail: [simon.koenz@zhdk.ch](mailto:simon.koenz@zhdk.ch)

## Weitere Studio-Seiten

<div class="hero__links">
  <a class="hero__link hero__link--primary" href="/blog/icst-composer-studio-blog/">Studio Hub</a>
  <a class="hero__link" href="/blog/icst-kompositionsstudio-pre-installation/">Pre-Installation</a>
  <a class="hero__link" href="/blog/icst-kompositionsstudio-equipment/">Equipment</a>
  <a class="hero__link" href="/blog/icst-kompositionsstudio-software/">Software</a>
  <a class="hero__link" href="/blog/downloads/">Downloads</a>
</div>
