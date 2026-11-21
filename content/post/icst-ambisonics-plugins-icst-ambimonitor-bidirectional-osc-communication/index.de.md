---
title: MaxMSP & ICST AmbiEncoder – OSC Kommunikation
description: "Zeigt die bidirektionale OSC-Kommunikation zwischen Max/MSP und ICST AmbiEncoder inklusive Winkel- und Bewegungsformaten."
date: 2025-03-16T09:44:58
year: 2025
month: 2025-03
weight: 2
tags: ["maxmsp", "osc", "ambimonitor", "ambiencoder", "bidirectional"]

key_points:
  - "Bidirektionale OSC-Kommunikation zwischen Max/MSP und ICST AmbiEncoder einrichten"
  - "Quellenwinkel im Euler-Format zwischen Max-Patches und REAPER senden und empfangen"
DisableComments: false
difficulty: "advanced"
post_kind: "tutorial"
tool: ["Max", "OSC"]
---

## Bidirektionale OSC-Kommunikation mit MaxMSP

**Für wen:** Level: Advanced | Zielgruppe: Max/MSP- und OSC-Integrator:in.

Generiere Bewegungsdaten in Max und sende sie via OSC zum _ICST AmbiEncoder_ in deiner DAW. Alternativ kannst du eine Bewegungskomposition von deiner DAW zu den _icst.ambisonics-externals_ übertragen.

<figure data-gen="g25" style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Bidirektionales OSC: Max sendet Quellpositionen an den ICST AmbiEncoder in der DAW, der Encoder sendet seine Positionen zurück an Max" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="are5" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="20" y="60" width="230" height="170" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="135" y="86" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="14">MaxMSP</text><text x="135" y="106" text-anchor="middle" font-size="11">erzeugt Bewegungsdaten</text><text x="135" y="124" text-anchor="middle" font-size="11">z.B. ambimonitor, ambicontrol</text><rect x="40" y="140" width="190" height="34" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.6"/><text x="135" y="162" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="11">ambimonitor / ambicontrol</text><rect x="40" y="184" width="190" height="34" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.6"/><text x="135" y="206" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="11">icst.ambisonics-externals</text><rect x="470" y="60" width="230" height="170" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="585" y="86" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="14">REAPER (DAW)</text><text x="585" y="106" text-anchor="middle" font-size="12">ICST AmbiEncoder</text><text x="585" y="124" text-anchor="middle" font-size="11">Positionen und Automation</text><rect x="490" y="140" width="190" height="34" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.6"/><text x="585" y="162" text-anchor="middle" font-weight="600" font-size="12">OSC In</text><rect x="490" y="184" width="190" height="34" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.6"/><text x="585" y="206" text-anchor="middle" font-weight="600" font-size="12">OSC Out</text><line x1="252" y1="135" x2="468" y2="135" stroke="#3fa968" stroke-width="2" opacity="1" marker-end="url(#are5)"/><text x="360" y="124" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="12">Max → DAW</text><text x="360" y="153" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="10">OSC In · port 50001</text><line x1="468" y1="201" x2="252" y2="201" stroke="#4a8fe0" stroke-width="2" opacity="1" marker-end="url(#are5)" stroke-dasharray="6 4"/><text x="360" y="190" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="12">DAW → Max</text><text x="360" y="219" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="10">/icst/ambi/sourceindex/xyz</text><text x="360" y="262" text-anchor="middle" font-size="11">Max sendet an den OSC-In-Port des Encoders</text><text x="360" y="280" text-anchor="middle" font-size="11">und hört auf den OSC Out des Encoders (ICST AmbiPlugins Standard XYZ Index).</text><text x="360" y="36" text-anchor="middle" font-weight="600" font-size="13">Zwei Richtungen, eine Adresse</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Beide Richtungen: Max erzeugt Bewegung und sendet sie an den Encoder; der Encoder meldet seine Positionen zurück, sodass eine Komposition aus der DAW in Max genutzt werden kann.</figcaption>
</figure>

### **Erforderliche Software:**

- **MaxMSP v.8.0+** → [cycling74.com](https://cycling74.com)
- **ICST Ambisonics Tools v3** → [cycling74.com](https://cycling74.com)
- **ICST Ambisonics Plugins (VST3/AU)** → [ICST AmbiPlugins](https://github.com/schweizerweb/icst-ambisonics-plugins/releases)
- **Reaper (DAW)** → [reaper.fm](https://reaper.fm/download.php)

### **Setup-Anleitung:**

#### 1. OSC im ICST AmbiEncoder konfigurieren

- Öffne den _ICST AmbiEncoder_ in einem FX-Slot und navigiere zu **Encoder Settings**.
- Unter **OSC In** aktiviere den OSC-Eingangs-Port (z.B. `50001`).
   <img src="/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/osc-port.png" alt="OSC-IN" style="display:block;width:100%;max-width:520px;height:auto;margin:.8rem 0;border-radius:6px">
- Klicke auf **OSC Out** und aktiviere den OSC-Ausgangs-Port.
    - Nutzt **ICST AmbiPlugins Standard XYZ Index**.
- Der Max-Demo-Patch hört auf:
    `'/icst/ambi/sourceindex/xyz'`

   <img src="/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/osc-out.png" alt="OSC-OUT" style="display:block;width:100%;max-width:520px;height:auto;margin:.8rem 0;border-radius:6px">

#### 2. Öffne MaxMSP und lade den Patch

- Finde den _OSC communication with ICST plugins in DAW_ Patch.

Siehe die Demo-GIFs:
- <video autoplay muted loop playsinline preload="metadata" poster="/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/Max_Reaper-poster.jpg" aria-label="Max_Reaper" style="width:100%;max-width:720px;height:auto;border-radius:6px"><source src="/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/Max_Reaper.mp4" type="video/mp4"></video>

Nächstes GIF: Wie es funktioniert:
<video autoplay muted loop playsinline preload="metadata" poster="/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/max_osc_to_AmbiPlugins-poster.jpg" aria-label="Max-AmbiEnc" style="width:100%;max-width:720px;height:auto;border-radius:6px"><source src="/post/icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication/max_osc_to_AmbiPlugins.mp4" type="video/mp4"></video>

---

## Absendung absoluter Winkel (Euler-Koordinaten)

<figure data-gen="g25" style="margin:1.8rem 0">
<svg viewBox="0 0 720 170" role="img" aria-label="Aufbau einer absoluten Euler-OSC-Nachricht: Adresse, Quellindex, Yaw, Pitch und Roll" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arf6" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="40" y="24" width="330" height="40" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.6"/><text x="205" y="50" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="13">/icst/ambi/sourceindex/euler</text><rect x="396" y="24" width="60" height="40" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="426" y="50" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="14">1</text><text x="426" y="86" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="11">Index</text><text x="426" y="102" text-anchor="middle" font-size="10">Quelle 1</text><rect x="468" y="24" width="60" height="40" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="498" y="50" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="14">30</text><text x="498" y="86" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="11">Yaw</text><text x="498" y="102" text-anchor="middle" font-size="10">Azimut</text><rect x="540" y="24" width="60" height="40" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="570" y="50" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="14">15</text><text x="570" y="86" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="11">Pitch</text><text x="570" y="102" text-anchor="middle" font-size="10">Elevation</text><rect x="612" y="24" width="60" height="40" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="642" y="50" text-anchor="middle" font-family="ui-monospace,Menlo,Consolas,monospace" font-size="14">5</text><text x="642" y="86" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="11">Roll</text><text x="642" y="102" text-anchor="middle" font-size="10">Vorwärtsachse</text><text x="205" y="86" text-anchor="middle" font-weight="600" font-size="11">Adresse</text><text x="205" y="102" text-anchor="middle" font-size="10">per Index (per Name: /source/euler)</text><text x="360" y="142" text-anchor="middle" font-size="11">Beispiel: /icst/ambi/sourceindex/euler 1 30 15 5</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Absolute Winkel im Euler-Format: zuerst der Quellindex, danach Yaw (Azimut), Pitch (Elevation) und Roll.</figcaption>
</figure>




Um **absolute Winkel** mit **Euler-Koordinaten** von MaxMSP zum ICST AmbiEncoder zu senden, verwende das folgende OSC-Nachrichtenformat:

```
/icst/ambi/source/euler [ChannelName] [Yaw] [Pitch] [Roll]
/icst/ambi/source/euler 'S1' 30 15 5
```

Für **Index-basierte Adressierung**:

```
/icst/ambi/sourceindex/euler [ChannelIndex] [Yaw] [Pitch] [Roll]
/icst/ambi/sourceindex/euler 1 30 15 5
```

**Hinweis:**

- `Yaw` (Azimuth): Horizontale Rotation
- `Pitch` (Elevation): Vertikale Neigung
- `Roll`: Rotation um die Vorwärtsachse

----

