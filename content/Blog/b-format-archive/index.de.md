---
title: "ICST B-Format Archiv"
description: "B-Format-Referenzdateien im ambiX-Format (ACN/SN3D) zum Testen von Ambisonics-Dekodern, Binauralrenderern und Signalketten."
date: 2026-01-01T00:00:00
draft: false
languageCode: de
tags:
  - b-format
  - test-files
  - ambisonics
---

Eine kuratierte Sammlung von Ambisonics-B-Format-Referenzdateien zum Testen von Dekodern, Binauralrenderern und räumlichen Audio-Pipelines. Alle Dateien verwenden die **ambiX**-Konvention: ACN-Kanalreihenfolge, SN3D-Normierung.

Wenn du zuerst den Format-Hintergrund brauchst, lies [Ambisonics-Formate erklärt](/de/learn/ambisonics-formats/) zu A-Format vs. B-Format, FuMa vs. ambiX, FOA/HOA, ACN/SN3D und Kanalzahlen.

---

## Audiodateien

{{< bformat_archive_table >}}

---

## Format-Referenz

Alle Dateien in diesem Archiv folgen dem **ambiX**-Standard:

- **Kanalreihenfolge:** ACN (Ambisonic Channel Number) — Kanäle sortiert nach Grad und Ordnungsindex
- **Normierung:** SN3D (Schmidt Semi-Normierung)
- **Kodierung:** B-Format, kein lautsprecherdecodiertes Audio

Zur Verwendung: Datei in REAPER importieren, Spur auf die korrekte Kanalanzahl setzen und durch einen ICST AmbiDecoder für die passende Ordnung routen. Die [Schritt-für-Schritt-Anleitung](/de/icst-ambisonics-plugins/06_step_by_step_setup/) führt durch den Prozess.

Verwandte Referenz: [Ambisonics-Formate erklärt](/de/learn/ambisonics-formats/).
