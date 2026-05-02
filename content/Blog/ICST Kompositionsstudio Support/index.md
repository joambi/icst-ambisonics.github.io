---
title: ICST Composition Studio Support
description: "Drivers, display setup, troubleshooting, and contact points for working in the ICST Composition Studio"
date: 2025-06-10T10:00:00
slug: icst-kompositionsstudio-support
aliases:
  - /blog/icst-kompositionsstudio-support/
weight: 1
group: "Studio"
---

**For:** composers, students, researchers, studio guests, and technicians.

This page collects the essential support steps for working in the ICST Composition Studio: audio drivers, display setup, first troubleshooting, and on-site contacts.

<div class="home-cards">
  <section class="home-card">
    <h4>Prepare Audio</h4>
    <p>Install RME MadiFace USB, enable DriverKit, and check multichannel output.</p>
    <div class="home-card__actions">
      <a class="hero__link hero__link--primary" href="https://rme-audio.de/de_madiface-usb.html" target="_blank" rel="noopener noreferrer">MadiFace USB</a>
      <a class="hero__link" href="https://rme-audio.de/rme-treiber-macos.html" target="_blank" rel="noopener noreferrer">RME macOS Driver</a>
    </div>
  </section>

  <section class="home-card">
    <h4>Prepare Screen</h4>
    <p>Install DisplayLink Manager and set up macOS Spaces correctly for the curved screen.</p>
    <div class="home-card__actions">
      <a class="hero__link hero__link--primary" href="https://www.synaptics.com/products/displaylink-graphics/downloads/macos" target="_blank" rel="noopener noreferrer">DisplayLink Manager</a>
      <a class="hero__link" href="/blog/icst-kompositionsstudio-pre-installation/">Pre-Installation</a>
    </div>
  </section>
</div>

## Audio: RME MadiFace USB

Install the appropriate RME driver before your studio session if you want to work from your own laptop.

<details class="home-accordion" open>
  <summary>Install the RME driver</summary>
  <div class="home-accordion__actions">
    <a class="hero__link hero__link--primary" href="https://rme-audio.de/de_madiface-usb.html" target="_blank" rel="noopener noreferrer">MadiFace USB product page</a>
    <a class="hero__link" href="https://rme-audio.de/downloads/madiface_usb_d.pdf" target="_blank" rel="noopener noreferrer">Manual PDF</a>
    <a class="hero__link" href="https://rme-audio.de/rme-treiber-macos.html" target="_blank" rel="noopener noreferrer">RME driver for macOS</a>
    <a class="hero__link" href="https://rme-audio.de/installationsanleitung.html" target="_blank" rel="noopener noreferrer">Installation guide</a>
  </div>
  <p>The MadiFace USB can be used with macOS and Windows. On macOS 11 and newer, the matching USB-series extension or DriverKit component must be installed and allowed in System Settings.</p>
</details>

<details class="home-accordion">
  <summary>Allow DriverKit on macOS</summary>
  <div class="home-accordion__actions">
    <a class="hero__link hero__link--primary" href="https://rme-audio.de/de_login-items-extensions-driverkit-macos-sequoia.html" target="_blank" rel="noopener noreferrer">Login Items & Extensions</a>
    <a class="hero__link" href="https://youtu.be/Ilkwtb2MKrM?t=156" target="_blank" rel="noopener noreferrer">Troubleshooting video from 2:36</a>
  </div>
  <p>If the interface does not appear after installation, check macOS Privacy & Security and Login Items & Extensions. Restart the Mac after allowing the extension.</p>
</details>

<details class="home-accordion">
  <summary>TotalMix and multichannel audio</summary>
  <div class="home-accordion__actions">
    <a class="hero__link hero__link--primary" href="https://rme-audio.de/totalmix-fx.html" target="_blank" rel="noopener noreferrer">RME TotalMix FX</a>
    <a class="hero__link" href="/blog/icst-kompositionsstudio-speaker-settings/">Speaker Settings</a>
    <a class="hero__link" href="/blog/icst-kompositionsstudio-ambisonics-setting/">Ambisonics Setting</a>
  </div>
  <p>For Ambisonics and multichannel workflows, make sure no stereo downmix is active. Check TotalMix before the session and remove or disable unwanted stereo mixes.</p>
</details>

## Video: Curved Screen and DisplayLink

The large studio screen requires DisplayLink. Install DisplayLink Manager before the session and allow the required screen-recording permissions in macOS.

1. Install DisplayLink Manager.
2. Open System Settings.
3. Open Mission Control.
4. Disable **Displays have separate Spaces**.
5. Log out and log in again so the setting becomes active.

## First Troubleshooting

<details class="home-accordion" open>
  <summary>Interface is not detected</summary>
  <p>Check the USB cable, reconnect the MadiFace, check macOS security settings, and restart after allowing DriverKit.</p>
</details>

<details class="home-accordion">
  <summary>No multichannel audio</summary>
  <p>Check the audio device in the DAW, match the sample rate, inspect TotalMix routing, and make sure no stereo downmix is active.</p>
</details>

<details class="home-accordion">
  <summary>Curved screen behaves like multiple displays</summary>
  <p>Disable the Mission Control option for separate Spaces and then log out. Without a new login, the previous display configuration often remains active.</p>
</details>

## Support & Contact

**Studio support**

- Johannes Schütt · Mobile: +41 79 786 12 49 · Mail: [johannes.schuett@zhdk.ch](mailto:johannes.schuett@zhdk.ch)

**Technical service A/V**

- Simon Könz · Mobile: +41 76 330 11 02 · Mail: [simon.koenz@zhdk.ch](mailto:simon.koenz@zhdk.ch)

## Related Studio Pages

<div class="hero__links">
  <a class="hero__link hero__link--primary" href="/blog/icst-composer-studio-blog/">Studio Hub</a>
  <a class="hero__link" href="/blog/icst-kompositionsstudio-pre-installation/">Pre-Installation</a>
  <a class="hero__link" href="/blog/icst-kompositionsstudio-equipment/">Equipment</a>
  <a class="hero__link" href="/blog/icst-kompositionsstudio-software/">Software</a>
  <a class="hero__link" href="/blog/downloads/">Downloads</a>
</div>
