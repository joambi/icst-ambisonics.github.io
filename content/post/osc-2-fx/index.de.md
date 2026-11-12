---
title: ICST AmbiEncoder – OSC zu FX Mapping
description: "Beispiel, wie der AmbiEncoder OSC an FX-Plugin-Parameter (z. B. IEM FdnReverb) sendet, um Reverb-Regler mit räumlichen Quellen zu verknüpfen."
date: 2025-05-16T09:44:58
year: 2025
month: 2025-05
weight: 3
tags: ["osc", "fx", "ambiencoder", "reaper", "automation"]

key_points:
  - "ICST-AmbiEncoder-OSC-Messages auf IEM FdnReverb und andere FX-Parameter mappen"
  - "Raumposition und Hall synchron aus einem OSC-Stream steuern"
DisableComments: false
difficulty: "advanced"
post_kind: "tutorial"
tool: ["OSC", "REAPER"]
---

--
## ICST AmbiEncoder sendet OSC zu FX-Plugins-Parameter

**Für wen:** Level: Advanced | Zielgruppe: Techniker:in, Sound Engineer.

### Integration des ICST AmbiEncoder mit IEM FdnReverb via OSC

Dieses Beispiel zeigt eine einfache Synchronisierung zwischen **ICST AmbiEncoder** und **IEM Ambisonics Plugins**, wobei **FdnReverb** verwendet wird, um distanzabhängige Reverb anzuwenden. Die **OSC-Schnittstelle der IEM Plugins** macht diesen Prozess einfach.

### OSC <--> OSC Kommunikation

**FdnReverb** (von IEM) ist ein CPU-effizienter Reverb für B-Format. Das Ziel ist es, **den Reverb zu erhöhen, wenn die Quelle sich während der Raumalisierung weiter entfernt**.

<video autoplay muted loop playsinline preload="metadata" poster="FX-Reverb_osc-poster.jpg" aria-label="OSC to FX-Reverb" style="max-width:100%;height:auto"><source src="FX-Reverb_osc.mp4" type="video/mp4"></video>

#### 1. Richte die DAW ein (Reaper)

- Erstelle drei Spuren:
    - **ICST Decoder** → Stereo
    - **ICST Encoder (Mono/Panner)**
    - **IEM FdnReverb** → Reverb-Verarbeitung

#### 2. Konfiguriere OSC-Kommunikation

1. Öffne die **ICST AmbiEncoder**-Einstellungen und navigiere zum **OSC-Fenster**.
2. Aktiviere **OSC Send** für externe Verwendung.
3. Füge den **Dry/Wet-Parameter** aus **IEM FdnReverb** hinzu.
4. **OSC-Eingabe für IEM FdnReverb:**
    `/FdnReverb/dryWet {d}`
5. Aktiviere in **IEM FdnReverb** den **OSC Listener** (z.B. Port: 9001).
6. Klicke auf **IEM OSC**, stelle die Portnummer ein und drücke **Connect** (sollte grün werden, wenn aktiv).
7. Das Verschieben des **Panners** im ICST AmbiEncoder passt nun dynamisch den **Dry/Wet**-Parameter in FdnReverb an.

Mit zunehmender Entfernung wird auch die Reverb-Intensität zunehmen. Experimentiere mit anderen Reverb-Parametern für zusätzliche Effekte.

----
