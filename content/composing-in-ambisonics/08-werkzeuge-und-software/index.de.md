---
title: "Werkzeuge und Software"
description: "Ein Überblick über wichtige Ambisonics-Toolchains für Komposition, Produktion und Forschung."
date: 2026-01-01T00:00:00
weight: 89
translationKey: "composing-tools-software"
---

Wer mit Ambisonics arbeitet, braucht fast immer eine Kombination aus **DAW**, **Encoder-/Decoder-Plugins**, **Monitoring**, **Analyse** und oft auch **szenischen oder binauralen Spezialwerkzeugen**. Die folgende Uebersicht konzentriert sich auf verbreitete Software-Pakete fuer Produktion, Lehre, Forschung und kuenstlerische Praxis.

Die Tabelle ist bewusst als **Orientierung** zu lesen: Manche Tools sind komplette Produktionsumgebungen, andere eher spezialisierte Bausteine fuer Analyse, Mikrofon-Postproduktion, VR oder experimentelle Komposition. Gerade bei maximaler Ordnung, Host-Support und Formatkonventionen lohnt sich immer ein Blick in die jeweilige Dokumentation.

### Ambisonics Software Uebersicht

| Paket / Name | Typ / Fokus | Max. Ordnung (typisch) | Formate / Konventionen | Plattform / Host | Lizenz / Kosten | Typische Use-Cases |
| --- | --- | --- | --- | --- | --- | --- |
| [ICST Ambisonics Plugins](https://ambisonics.ch/icst-ambisonics-plugins/) | HOA-Produktion, Panning, Decoding, OSC | bis 7. Ordnung (HOA) | ambiX (ACN/SN3D), ICST-Spezifika | Reaper, andere Mehrkanal-DAWs | kostenlos (ZHdK-Projekt) | Kunst/Musik, Forschung, Lehre, Dome/Arrays, ICST-Workflows |
| [IEM Plug-in Suite](https://plugins.iem.at) | vollstaendige freie HOA-Suite | bis 7. Ordnung | ambiX (ACN/SN3D) | VST/AU (Reaper, Nuendo, Ardour etc.) | frei, Open Source | Encoder, Decoder, Analyser, Reverb, Granular, AllRAD-Decoder |
| [SPARTA](https://leomccormack.github.io/sparta-site/docs/plugins/overview/) | Analyse, Decoding, DOA, Binaural | typ. bis 7.-10. Ordnung | ambiX | VST/AU, Linux/Win/macOS | frei, Open Source | parametrisches Decoding, Energy-/Velocity-Visualisierung, Forschung |
| [SSA aX Plugins](https://www.ssa-plugins.com) | kommerzielle Ambisonics-Suite | bis 10. Ordnung (aX) | ambiX | VST3/AAX (Reaper, Pro Tools etc.) | kommerziell | Musik, VR/AR, High-Order-Produktionen, binaurales Monitoring |
| [Audio Brewers](https://www.audiobrewers.com/plugins) | kreative Ambisonics- und Immersive-Plugin-Suite | bis 7. Ordnung | ambiX / HOA | AAX/AU/VST3, teils AUv3/iOS | kommerziell, teils Free-Versionen | Decoder, Encoder, Imager, Reverb, EQ, Visualizer, kreative HOA-Bearbeitung |
| [ambix](https://spaes.org/ambix-plug-ins) | Encoder/Decoder, Rotation, Tools | variable Ordnung (praktisch etwa bis 7) | ambiX (ACN/SN3D) | VST/LV2, Standalone (Jack) | frei, Open Source (GPL) | klassische Ambisonics-Chains, B-Format-Post, DIY-Setups |
| [Ambisonic Toolkit (ATK)](https://www.ambisonictoolkit.net) | Soundfield-Kernel-Komposition, FX | typ. bis 3.-7. Ordnung | FuMa und ambiX (je nach Version) | Reaper (JSFX), SuperCollider | frei, Open Source | Fokussierung, Dominance, Mirrors, kreative Schallfeld-Manipulation |
| [Blue Ripple Sound O3A / O7A](https://www.blueripplesound.com/pro_audio) | HOA-Studio- und Upmixing-Toolchain | 3. bis 7. Ordnung | SN3D / HOA-Konventionen | VST2/AAX, Reaper, Pro Tools, Pyramix, Max | teils frei, teils kommerziell | Upmixing, HOA-Studio-Tools, Visualisierung, Dekodierung, Forschung |
| [FLUX:: SPAT Revolution](https://www.flux.audio/project/spat-revolution/) | immersive Produktions- und Render-Umgebung | bis 7. Ordnung (Ultimate), bis 3. Ordnung (Essential) | Ambisonics, HOA, binaural, channel-based, transaural | Standalone + AAX/AU/VST3 Integration | kommerziell | Live- und Studio-Spatial-Audio, IRCAM/FLUX-Workflows, ReaVolution, OSC, grosse Render-Setups |
| [Sound Particles](https://soundparticles.com/products/soundparticles/overview) | immersive 3D-Audio-Workstation und Sound-Design | immersiv, inkl. HOA-/Ambisonics-Workflows | Ambisonics, HOA, binaural, ADM, immersive Formate | Standalone + Plugin-Oekosystem | kommerziell | Film, Games, grosse 3D-Sound-Design-Szenen, Partikel-basierte Raumbewegung |
| [Sound Particles Energy Panner / Space Controller / Density](https://lp.soundparticles.com/energypanner) | Panning, Controller, kreative Spatial-Plugins | FOA bis HOA, je nach Tool | Ambisonics, HOA, binaural, immersive Formate | AAX/AU/VST/VST3, teils iOS/Android | kommerziell | Panning, mobile Bewegungssteuerung, immersive FX, Musik- und Postproduktion |
| [Envelop for Live](https://envelop.us/e4l/) | freie Ableton-Live-Toolchain fuer immersive Produktion | typ. bis HOA, je nach Setup | Ambisonics, binaural, DIY-Multichannel | Ableton Live Suite / Max for Live | frei, Open Source | Live-Performance, Envelop-Spaces, DIY-Arrays, Lehre, zugangsoffene Spatial-Workflows |
| [Xp4L](https://xp4l.com/) | Ableton-zentrierte Spatial-Audio-Suite | flexibel, je nach Zielsystem | Ambisonics, binaural, VBAP, DBAP, weitere Verfahren | Ableton Live + Standalone-Komponenten | kommerziell | Live-Performance, Club-/Installations-Setups, Spatial-Mixing in Ableton |
| [OAT / Pd-basierte Toolchains](https://www.giuseppepisano.com/ambisonics/oat/tut03/) | Education, DIY-Lautsprecher-Setups | meist bis 3.-5. Ordnung | iem_ambi, ambiX | Pure Data, SuperCollider, DIY-Setups | frei, Open Source | guenstige Ambisonics-Setups, Lehre, Experimente mit Raspberry Pi etc. |
| [SoundField by RODE](https://rode.com/en-int/apps/soundfield-by-rode) | A- zu B-Format, Mic-Post, Decoding | 1. Ordnung (mikrofonbezogen) | FuMa / ambiX (Wandlung moeglich) | VST/AU/AAX | kostenlos (fuer Mic-User) | SoundField/RODE-Mikros, Rotation, Decoding, Stereo-/Binaural-Export |
| [dearVR PRO 2 / Dear Reality](https://www.sennheiser.com/en-us/immersive/dear-reality) | binaurales Monitoring, Spatializer, Ambisonics-nahe Immersive-Tools | bis 3. Ordnung | Ambisonics, binaural, immersive Formate | VST/AU/AAX | historisch kommerziell, aktuell weitgehend kostenlos, aber nicht mehr aktiv weiterentwickelt | dearVR, Ambi Micro, Monitoring, Spatial-Mixing, historisch wichtige Immersive-Toolchain |
| [audioCube](https://main.audiocube.app/features) | all-in-one Spatial-Audio-App | nicht als klassische HOA-Ordnung beschrieben; 3D-Spatialisierung mit binauralem Fokus | Spatial Audio, binaural, 3D-Umgebung | Standalone fuer macOS/Windows | Free + Lifetime-Lizenz | experimentelle 3D-Komposition, Bewegung, virtuelle Akustik, zugangsoffene Spatial-Audio-Skizzen |
| [Noise Makers Binauralizer / Ambi Bundle](https://www.noisemakers.fr/) | binaurales und immersive Monitoring / Ambisonics-nahe Tools | vor allem FOA bis kleinere immersive Formate | binaural, Ambi Bundle, Surround/Immersive Formate | VST3/AU/AAX | kommerziell | Monitoring, Downmix, binaurale Kontrolle, immersive Postproduktion |
| [Spatial Audio Designer](https://www.newaudiotechnology.com/en/products/spatial-audio-designer/) | Multi-Format-Renderer und DAW-Spatializer | inkl. Ambisonics-Workflows, je nach Host und Format | binaural, Ambisonics, Atmos, Auro-3D, MPEG-H, Custom Layouts | Plugin fuer DAWs und teils Video-Workstations | kommerziell | Multi-Format-Monitoring, Installationen, Planetarien, Film und Broadcast |
| [MNTN Spatial Audio Production Suite](https://mntncraft.com/) | Produktions-, Live- und Presentations-Suite | flexible Kanal- und Spatial-Setups | binaural, Ambisonics, DBAP | Standalone + DAW-Plugin + virtuelle Audio-Interfaces | kommerziell | physische Venues, Custom Loudspeaker Layouts, Live-Spatial-Mixing |
| [Reaper](https://www.reaper.fm) + Plugins | DAW-Host mit 128-Kanal-Tracks | bis 10. Ordnung (technisch) | beliebig (ueber Plugins) | Windows/macOS, Linux (Wine) | kommerziell, sehr guenstig | zentrale Produktionsplattform fuer HOA mit ICST, IEM, ambix, SSA, ATK etc. |
| [Nuendo](https://www.steinberg.net/nuendo/) / [Pro Tools Ultimate](https://www.avid.com/pro-tools) | DAW mit nativen Ambisonics-Bussen | meist bis 3.-7. Ordnung | ambiX | Nuendo, Pro Tools Ultimate | kommerzielle DAWs | Film/VR-Post, 360-Video, Broadcast mit nativen Ambi-Bussen und Monitoring |
| [Game-Engines + Ambisonics](https://unity.com/de/glossary/ambisonic-audio) | VR/AR-Integration, 360 | typ. bis 3.-4. Ordnung | ambiX | Unity, Unreal | gemischt (Engine + Plugins) | 3D-Audio in VR/AR, Headtracking-Binaural, 360-Video-Engines |

### Schnelle Orientierung

- **Fuer freie HOA-Produktion** sind ICST, IEM, SPARTA, ambix und ATK die wichtigsten Oekosysteme.
- **Fuer kuenstlerische Komposition** sind ICST, IEM, ATK, Audio Brewers und teilweise audioCube besonders interessant, weil sie zwischen praeziser Technik und kreativer Schallfeldbearbeitung vermitteln.
- **Fuer VR, Film und kommerzielle Workflows** spielen SSA, Sound Particles, FLUX:: SPAT, dearVR, Spatial Audio Designer, Nuendo, Pro Tools und Game-Engines eine groessere Rolle.
- **Fuer Lehre, DIY und kleinere Setups** sind OAT, ambix, Blue Ripple, Envelop for Live, audioCube und Reaper-basierte Kombinationen oft besonders attraktiv.
- **Fuer Mikrofon-Workflows** ist SoundField by RODE relevant, wenn FOA-Aufnahmen aus A-Format-Mikrofonen weiterverarbeitet werden sollen.
- **Fuer Upmixing, Spezial-Decoder und experimentelle HOA-Produktionsketten** lohnt sich ein Blick auf Blue Ripple Sound, FLUX:: SPAT, Spatial Audio Designer und Audio Brewers.
- **Wichtig zur Einordnung:** Nicht alle Tools in dieser Tabelle sind klassische Ambisonics-Plugins. Einige, wie audioCube, FLUX:: SPAT, Sound Particles, MNTN oder Spatial Audio Designer, sind breitere immersive Produktionsumgebungen, in denen Ambisonics ein Teil des Workflows ist.

### Weiterfuehrende Quellen

- [ICST Ambisonics](https://ambisonics.ch)
- [ICST Ambisonics Plugins an der ZHdK](https://www.zhdk.ch/forschungsprojekt/icst-ambisonics-plugins-555245)
- [ICST Overview](https://ambisonics.ch/icst-ambisonics-plugins/01_overview/)
- [Ambisonic Audio with REAPER](https://iaspace.zhdk.ch/wiki/ambisonic-audio-with-reaper/)
- [IEM Plug-in Suite](https://plugins.iem.at)
- [SPARTA Overview](https://leomccormack.github.io/sparta-site/docs/plugins/overview/)
- [SSA Plugins](https://www.ssa-plugins.com)
- [Audio Brewers Plugins](https://www.audiobrewers.com/plugins)
- [ambiX plug-ins](https://spaes.org/ambix-plug-ins)
- [Ambisonic Toolkit](https://www.ambisonictoolkit.net)
- [Blue Ripple Sound Pro Audio](https://www.blueripplesound.com/pro_audio)
- [FLUX:: SPAT Revolution](https://www.flux.audio/project/spat-revolution/)
- [Sound Particles](https://soundparticles.com/products/soundparticles/overview)
- [Envelop for Live](https://envelop.us/e4l/)
- [Xp4L](https://xp4l.com/)
- [SoundField by RODE](https://rode.com/en-int/apps/soundfield-by-rode)
- [Dear Reality bei Sennheiser](https://www.sennheiser.com/en-us/immersive/dear-reality)
- [audioCube Features](https://main.audiocube.app/features)
- [Noise Makers Spatial Audio Plugins](https://www.noisemakers.fr/)
- [Spatial Audio Designer](https://www.newaudiotechnology.com/en/products/spatial-audio-designer/)
- [MNTN Spatial Audio Production Suite](https://mntncraft.com/)
- [Unity: Was ist Ambisonic Audio](https://unity.com/de/glossary/ambisonic-audio)
