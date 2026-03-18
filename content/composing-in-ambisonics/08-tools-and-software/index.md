---
title: "Tools and Software"
description: "An overview of important Ambisonics toolchains for composition, production, and research."
date: 2026-01-01T00:00:00
weight: 89
draft: false
translationKey: "composing-tools-software"
---

Working in Ambisonics almost always means combining a **DAW**, **encoder/decoder plugins**, **monitoring**, **analysis**, and often **binaural or scene-based specialist tools**. The following overview focuses on widely used software packages for production, teaching, research, and artistic practice.

The table is intended as **orientation**: some tools are complete production environments, others are more specialized building blocks for analysis, microphone post-processing, VR, or experimental composition. For maximum order, host support, and format conventions, it is always worth checking the current documentation.

### Ambisonics Software Overview

| Package / Name | Type / Focus | Max. Order (typical) | Formats / Conventions | Platform / Host | License / Cost | Typical Use Cases |
| --- | --- | --- | --- | --- | --- | --- |
| [ICST Ambisonics Plugins](https://ambisonics.ch/icst-ambisonics-plugins/) | HOA production, panning, decoding, OSC | up to 7th order (HOA) | ambiX (ACN/SN3D), ICST specifics | REAPER, other multichannel DAWs | free (ZHdK project) | art/music, research, teaching, dome/arrays, ICST workflows |
| [IEM Plug-in Suite](https://plugins.iem.at) | complete free HOA suite | up to 7th order | ambiX (ACN/SN3D) | VST/AU (REAPER, Nuendo, Ardour etc.) | free, open source | encoder, decoder, analyser, reverb, granular, AllRAD decoder |
| [SPARTA](https://leomccormack.github.io/sparta-site/docs/plugins/overview/) | analysis, decoding, DOA, binaural | typically up to 7–10th order | ambiX | VST/AU, Linux/Win/macOS | free, open source | parametric decoding, energy/velocity visualization, research |
| [SSA aX Plugins](https://www.ssa-plugins.com) | commercial Ambisonics suite | up to 10th order (aX) | ambiX | VST3/AAX (REAPER, Pro Tools etc.) | commercial | music, VR/AR, high-order productions, binaural monitoring |
| [Audio Brewers](https://www.audiobrewers.com/plugins) | creative Ambisonics and immersive plugin suite | up to 7th order | ambiX / HOA | AAX/AU/VST3, some AUv3/iOS | commercial, some free versions | decoder, encoder, imager, reverb, EQ, visualizer, creative HOA processing |
| [ambix](https://spaes.org/ambix-plug-ins) | encoder/decoder, rotation, tools | variable order (practically up to ~7) | ambiX (ACN/SN3D) | VST/LV2, standalone (Jack) | free, open source (GPL) | classic Ambisonics chains, B-format post, DIY setups |
| [Ambisonic Toolkit (ATK)](https://www.ambisonictoolkit.net) | soundfield kernel composition, FX | typically 3rd–7th order | FuMa and ambiX (depending on version) | REAPER (JSFX), SuperCollider | free, open source | focusing, dominance, mirrors, creative soundfield manipulation |
| [Blue Ripple Sound O3A / O7A](https://www.blueripplesound.com/pro_audio) | HOA studio and upmixing toolchain | 3rd to 7th order | SN3D / HOA conventions | VST2/AAX, REAPER, Pro Tools, Pyramix, Max | partly free, partly commercial | upmixing, HOA studio tools, visualization, decoding, research |
| [FLUX:: SPAT Revolution](https://www.flux.audio/project/spat-revolution/) | immersive production and render environment | up to 7th order (Ultimate), up to 3rd order (Essential) | Ambisonics, HOA, binaural, channel-based, transaural | Standalone + AAX/AU/VST3 integration | commercial | live and studio spatial audio, IRCAM/FLUX workflows, OSC, large render setups |
| [Sound Particles](https://soundparticles.com/products/soundparticles/overview) | immersive 3D audio workstation and sound design | immersive, incl. HOA/Ambisonics workflows | Ambisonics, HOA, binaural, ADM, immersive formats | Standalone + plugin ecosystem | commercial | film, games, large 3D sound design scenes, particle-based spatial movement |
| [Sound Particles Energy Panner / Space Controller / Density](https://lp.soundparticles.com/energypanner) | panning, controller, creative spatial plugins | FOA to HOA, depending on tool | Ambisonics, HOA, binaural, immersive formats | AAX/AU/VST/VST3, some iOS/Android | commercial | panning, mobile movement control, immersive FX, music and post-production |
| [Envelop for Live](https://envelop.us/e4l/) | free Ableton Live toolchain for immersive production | typically up to HOA, depending on setup | Ambisonics, binaural, DIY multichannel | Ableton Live Suite / Max for Live | free, open source | live performance, Envelop spaces, DIY arrays, teaching, accessible spatial workflows |
| [Xp4L](https://xp4l.com/) | Ableton-centred spatial audio suite | flexible, depending on target system | Ambisonics, binaural, VBAP, DBAP, other methods | Ableton Live + standalone components | commercial | live performance, club/installation setups, spatial mixing in Ableton |
| [OAT / Pd-based toolchains](https://www.giuseppepisano.com/ambisonics/oat/tut03/) | education, DIY loudspeaker setups | typically up to 3rd–5th order | iem_ambi, ambiX | Pure Data, SuperCollider, DIY setups | free, open source | affordable Ambisonics setups, teaching, Raspberry Pi experiments |
| [SoundField by RODE](https://rode.com/en-int/apps/soundfield-by-rode) | A- to B-format, mic post, decoding | 1st order (microphone-focused) | FuMa / ambiX (conversion possible) | VST/AU/AAX | free (for mic users) | SoundField/RODE mics, rotation, decoding, stereo/binaural export |
| [dearVR PRO 2 / Dear Reality](https://www.sennheiser.com/en-us/immersive/dear-reality) | binaural monitoring, spatializer, immersive tools | up to 3rd order | Ambisonics, binaural, immersive formats | VST/AU/AAX | historically commercial, currently largely free but no longer actively developed | binaural monitoring, spatial mixing, historically important immersive toolchain |
| [audioCube](https://main.audiocube.app/features) | all-in-one spatial audio app | not described by classical HOA order; 3D spatialization with binaural focus | Spatial Audio, binaural, 3D environment | Standalone for macOS/Windows | free + lifetime license | experimental 3D composition, movement, virtual acoustics, accessible spatial audio sketching |
| [Noise Makers Binauralizer / Ambi Bundle](https://www.noisemakers.fr/) | binaural and immersive monitoring / Ambisonics-adjacent tools | mainly FOA to smaller immersive formats | binaural, Ambi Bundle, surround/immersive formats | VST3/AU/AAX | commercial | monitoring, downmix, binaural control, immersive post-production |
| [Spatial Audio Designer](https://www.newaudiotechnology.com/en/products/spatial-audio-designer/) | multi-format renderer and DAW spatializer | incl. Ambisonics workflows, depending on host and format | binaural, Ambisonics, Atmos, Auro-3D, MPEG-H, custom layouts | plugin for DAWs and some video workstations | commercial | multi-format monitoring, installations, planetariums, film and broadcast |
| [MNTN Spatial Audio Production Suite](https://mntncraft.com/) | production, live, and presentation suite | flexible channel and spatial setups | binaural, Ambisonics, DBAP | Standalone + DAW plugin + virtual audio interfaces | commercial | physical venues, custom loudspeaker layouts, live spatial mixing |
| [REAPER](https://www.reaper.fm) + plugins | DAW host with 128-channel tracks | up to 10th order (technically) | arbitrary (via plugins) | Windows/macOS, Linux (Wine) | commercial, very affordable | central production platform for HOA with ICST, IEM, ambix, SSA, ATK etc. |
| [Nuendo](https://www.steinberg.net/nuendo/) / [Pro Tools Ultimate](https://www.avid.com/pro-tools) | DAW with native Ambisonics buses | typically up to 3rd–7th order | ambiX | Nuendo, Pro Tools Ultimate | commercial DAWs | film/VR post, 360 video, broadcast with native Ambi buses and monitoring |
| [Game Engines + Ambisonics](https://unity.com/glossary/ambisonic-audio) | VR/AR integration, 360° | typically up to 3rd–4th order | ambiX | Unity, Unreal | mixed (engine + plugins) | 3D audio in VR/AR, head-tracking binaural, 360 video engines |

### Quick Orientation

- **For free HOA production**: ICST, IEM, SPARTA, ambix, and ATK are the most important ecosystems.
- **For composition-oriented work**: ICST, IEM, ATK, Audio Brewers, and in some cases audioCube are especially interesting because they bridge precise technical control and creative soundfield manipulation.
- **For VR, film, and commercial immersive workflows**: SSA, Sound Particles, FLUX:: SPAT, dearVR, Spatial Audio Designer, Nuendo, Pro Tools, and game engines play a larger role.
- **For teaching, DIY, and smaller setups**: OAT, ambix, Blue Ripple, Envelop for Live, audioCube, and REAPER-based combinations are often especially attractive.
- **For microphone workflows**: SoundField by RODE is relevant when FOA recordings from A-format microphones need to be processed.
- **For upmixing, specialist decoders, and experimental HOA production chains**: Blue Ripple Sound, FLUX:: SPAT, Spatial Audio Designer, and Audio Brewers are worth exploring.
- **Important note**: Not all tools in this table are classical Ambisonics plugins. Some — such as audioCube, FLUX:: SPAT, Sound Particles, MNTN, or Spatial Audio Designer — are broader immersive production environments in which Ambisonics is one part of the workflow.

### Further Links

- [ICST Ambisonics](https://ambisonics.ch)
- [ICST Ambisonics Plugins at ZHdK](https://www.zhdk.ch/forschungsprojekt/icst-ambisonics-plugins-555245)
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
- [Dear Reality at Sennheiser](https://www.sennheiser.com/en-us/immersive/dear-reality)
- [audioCube Features](https://main.audiocube.app/features)
- [Noise Makers Spatial Audio Plugins](https://www.noisemakers.fr/)
- [Spatial Audio Designer](https://www.newaudiotechnology.com/en/products/spatial-audio-designer/)
- [MNTN Spatial Audio Production Suite](https://mntncraft.com/)
- [Unity: What is Ambisonic Audio](https://unity.com/glossary/ambisonic-audio)
