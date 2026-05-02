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

<style>
.support-intro {
  border-left: 4px solid #6086b4;
  margin: 0.75rem 0 1.5rem;
  padding: 0.95rem 1.15rem;
}
.support-intro p {
  margin: 0.25rem 0;
}
.support-nav {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin: 1rem 0 1.8rem;
}
.support-nav a {
  border: 1px solid currentColor;
  border-radius: 2px;
  padding: 0.35rem 0.7rem;
  text-decoration: none;
}
.support-checklist {
  display: grid;
  gap: 0.7rem;
  margin: 1rem 0 2rem;
}
.support-checklist__item {
  border-left: 3px solid #6086b4;
  padding: 0.35rem 0 0.35rem 0.8rem;
}
.support-checklist__item strong {
  display: block;
}
.support-steps {
  margin: 1rem 0 1.6rem;
  padding-left: 1.4rem;
}
.support-steps li {
  margin: 0.35rem 0;
}
.support-contact {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 0.8rem;
  margin: 1rem 0 1.5rem;
}
.support-contact__item {
  border-left: 3px solid #6086b4;
  padding: 0.4rem 0 0.4rem 0.8rem;
}
.support-contact__item strong {
  display: block;
}
</style>

<div class="support-intro">
  <p><strong>Für wen:</strong> Komponist:innen, Studierende, Researcher, Studio-Gäste und Techniker:innen.</p>
  <p>Diese Seite bündelt die wichtigsten Support-Schritte für die Arbeit im ICST Kompositionsstudio: Audio-Treiber, Display-Setup, erste Fehlersuche und Kontaktstellen vor Ort.</p>
</div>

<div class="support-nav" aria-label="Support navigation">
  <a href="#schnellstart">Schnellstart</a>
  <a href="#audio-rme-madiface-usb">Audio</a>
  <a href="#video-curved-screen-und-displaylink">Video</a>
  <a href="#erste-fehlersuche">Fehlersuche</a>
  <a href="#support--kontakt">Kontakt</a>
</div>

## Schnellstart

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

### Vor der Session prüfen

<div class="support-checklist">
  <div class="support-checklist__item">
    <strong>1. RME-Treiber installieren</strong>
    MadiFace USB anschließen und prüfen, ob das Interface in macOS oder in der DAW erscheint.
  </div>
  <div class="support-checklist__item">
    <strong>2. DriverKit erlauben</strong>
    Nach der Installation Datenschutz & Sicherheit sowie Login Items & Extensions prüfen.
  </div>
  <div class="support-checklist__item">
    <strong>3. DisplayLink installieren</strong>
    Curved Screen nur mit DisplayLink Manager und korrekter Mission-Control-Einstellung nutzen.
  </div>
  <div class="support-checklist__item">
    <strong>4. Mehrkanal testen</strong>
    DAW-Ausgang, Sample Rate, TotalMix und Speaker Settings vor dem Arbeiten kontrollieren.
  </div>
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

Für den großen Studio-Screen wird DisplayLink benötigt. Installiere den [DisplayLink Manager](https://www.synaptics.com/products/displaylink-graphics/downloads/macos) vor der Session und erlaube die nötigen Bildschirmfreigabe-Rechte in macOS.

<ol class="support-steps">
  <li><a href="https://www.synaptics.com/products/displaylink-graphics/downloads/macos" target="_blank" rel="noopener noreferrer">DisplayLink Manager</a> installieren.</li>
  <li>Systemeinstellungen öffnen.</li>
  <li>Mission Control öffnen.</li>
  <li>Option <strong>Monitore verwenden verschiedene Spaces</strong> deaktivieren.</li>
  <li>Ausloggen und erneut einloggen, damit die Einstellung aktiv wird.</li>
</ol>

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

<div class="support-contact">
  <div class="support-contact__item">
    <strong>Studio-Support</strong>
    Johannes Schütt<br>
    Mobile: +41 79 786 12 49<br>
    Mail: <a href="mailto:johannes.schuett@zhdk.ch">johannes.schuett@zhdk.ch</a>
  </div>
  <div class="support-contact__item">
    <strong>Technischer Service A/V</strong>
    Simon Könz<br>
    Mobile: +41 76 330 11 02<br>
    Mail: <a href="mailto:simon.koenz@zhdk.ch">simon.koenz@zhdk.ch</a>
  </div>
</div>

## Weitere Studio-Seiten

<div class="hero__links">
  <a class="hero__link hero__link--primary" href="/blog/icst-composer-studio-blog/">Studio Hub</a>
  <a class="hero__link" href="/blog/icst-kompositionsstudio-pre-installation/">Pre-Installation</a>
  <a class="hero__link" href="/blog/icst-kompositionsstudio-equipment/">Equipment</a>
  <a class="hero__link" href="/blog/icst-kompositionsstudio-software/">Software</a>
  <a class="hero__link" href="/blog/downloads/">Downloads</a>
</div>
