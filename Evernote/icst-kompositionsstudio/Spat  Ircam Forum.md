---

tags: 
  - published

source: https://forum.ircam.fr/projects/detail/spat/
---
# Ircam Forum

Spat (or Spatialisateur in French) is a real-time spatial audio processor that allows composers, sound artists, performers, and sound engineers to control the localization of sound sources in 3D auditory spaces. In addition, Spat provides a powerful reverberation engine that can be applied to real and virtual auditory spaces. The processor receives sounds from instrumental or synthetic sources, adds spatialization effects in real-time, and outputs signals for reproduction on an electroacoustic system (loudspeakers or headphones).

Its modular signal processing architecture and design are guided by computational efficiency and configurability considerations. This allows, in particular, straightforward adaptation to various multichannel output formats and reproduction setups, over loudspeakers or headphones, while the control interface provides direct access to perceptually relevant parameters for specifying distance and reverberation effects, irrespective of the chosen reproduction format.

Another original feature of Spat is its room effect control interface relying on perceptive criteria. This allows the user to intuitively specify the characteristics of a specific room without having to use an acoustic or architectural vocabulary.

Spat is, for instance, used for real-time 3D audio rendering with a 350-loudspeaker array in IRCAM’s variable acoustics concert hall.

![[./_resources/Spat__Ircam_Forum.resources/spat_oper.png]]

## Main Features

Spat relies on an efficient signal-processing library programmed in C++ to provide state-of-the-art software technologies. The software bundle comes as a set of [Max/MSP](https://forum.ircam.fr/projects/detail/max-8/) external objects (i.e. plugins that can be inserted into the [Max/MSP](https://forum.ircam.fr/projects/detail/max-8/) environment). Spat contains more than 250 external objects, many abstraction patchers, help patches, tutorials, large HRTF database, etc. Spat objects are highly configurable and most of them support up to 250 input/output channels (in Max 6 or 7) and up to 8192 input/output channels (in Max8). DSP objects are also compatible with Max8 MC (« multi-channel ») patchcords.

The main features are:

* **sound spatialization (panning) in 2D or 3D**. Here is a non exhaustive list of supported panning algorithms:

* stereo (AB, XY, MS)
* binaural (with near field compensation) and transaural
* vector-base amplitude panning (VBAP)
* vector-base intensity panning (VBIP)
* distance-based amplitude panning (DBAP)
* nearest-neighbor amplitude panning (KNN)
* speaker-placement correction amplitude panning (SPCAP)
* B-format and higher order Ambisonics (HOA) without order restrictions
* near-field compensated higher order [Ambisonics](https://www.ircam.fr/projects/pages/systeme-wfs-et-ambisonique-a-lespace-de-projection/) (NFC-HOA)
* [wavefield synthesis](https://www.ircam.fr/projects/pages/systeme-wfs-et-ambisonique-a-lespace-de-projection/) (WFS)
* layer based amplitude panning (LBAP)
* **artificial reverberation**. Multichannel scalable/tunable algorithmic reverberation based on feedback delay networks. Efficient multichannel real-time convolution without latency.
	* **perceptual control of the acoustic quality of the room**: warmth and brilliance; presence/proximity of the sound source; room presence; early and late reverberation, heaviness and liveness. Easy control over the radiation of sound sources (aperture and orientation).
	* **low-level signal processing:** equalization, Doppler effect, air absorption, etc.
	* **graphical user interfaces** for controlling/authoring/monitoring the spatial sound scene.
	* many objects to create/edit/transform spatial trajectories.
	* many useful tools to **manipulate multichannel audio signals**: multichannel sound file player/recorder (spat.sfplay~, spat.sfrecord~) up to 250 channels; multichannel EQ, compressor, limiter, gate, etc.
	* utility tools for linear time code (LTC), quaternions, etc.
	* tools for **room acoustics and/or speakers calibration**: delays/gains measurement and correction; measurement, analysis and denoising of multichannel room impulse responses, etc.
	* **headphones monitoring** of any multichannel stream.
	* various **audio effects**: stereo enlargement, Leslie cabinet simulation, ping pong delays, graphical equalizers, parametric equalizers, etc.
	* **OSC** remote control of all processors.
	* full-fledged mixing environment ([**Panoramix**](https://forum.ircam.fr/projects/detail/panoramix/)) for 3D audio.
	* Import/export/realtime rendering of object-based audio according to the Audio Definition Model (**ADM format**).
	* etc...

![[./_resources/Spat__Ircam_Forum.resources/spat_1.png]]

The Spat bundle contains [Max/MSP](https://forum.ircam.fr/projects/detail/max-8/) implementation of the award-winning [Flux:: Ircam Tools plugins](https://forum.ircam.fr/collections/detail/ircam-tools-by-flux/) (Ircam-Spat, [Ircam-Verb](https://www.flux.audio/project/ircam-verb-v3/), [Ircam-VerbSession](https://www.flux.audio/project/ircam-verb-session-v3/), [Ircam-Hear](https://forum.ircam.fr/projects/detail/ircam-tools-by-flux-hear-v3/)), and [Flux:: Spat-Revolution](https://www.flux.audio/project/spat-revolution/)

## Fields of Application

* Composition
* Film & Video
* Post-production
* Scientific Research & Development
* Virtual reality
* Sound Design

Spat can be used in several contexts:

* **Live concerts, sound installation and spatialization in real-time**. The composer can associate each note or sound event in the score with a room effect or a specific position in space. Spat can be controlled by a sequencer, a score-following system, or any other algorithmic approach. Being integrated into the [Max/MSP](http://forumnet.ircam.fr/product/max8-en/) environment, Spat can easily be linked to any remote control device (tracking system, tablet, smartphone, joystick, gestural sensors, etc.).

* **Mixing and Post-production.** A spatialization module can be affected to each channel on the mixing table in order to have access to an intuitive and global control of the positions of each source and their associated room effect.

* **Virtual Reality.** The spatialized auditory component is essential in creating the sensations of presence and immersion in virtual reality applications, or in interactive installations. In such scenario, the binaural mode (3D reproduction over headphones) of Spat is particularly well suited. Binaural rendering is remarkably convincing when the processor is linked either to a tracking system (that follow the subject’s position and orientation) or to gestural controllers.

> **References**
> 
> * [Thibaut Carpentier](https://www.ircam.fr/person/thibaut-carpentier/). [Récents développements du Spatialisateur](https://hal.archives-ouvertes.fr/hal-01247502v1). In Proc of Journées d’Informatique Musicale (JIM), Montréal, May 2015.
> 
> * [Thibaut Carpentier](https://www.ircam.fr/person/thibaut-carpentier/). [Une nouvelle implémentation du Spatialisateur dans Max](https://hal.archives-ouvertes.fr/hal-01791435). In Proc Journées d’Informatique Musicale (JIM), May 2018, Amiens, France. 2018.
> 
> * [Thibaut Carpentier](https://www.ircam.fr/person/thibaut-carpentier/). [A new implementation of Spat in Max](https://zenodo.org/record/1422552#.XYDnyC3pN0s). In Proc of the 15th Sound & Music Computing Conference (SMC), pp 184 – 191, Limassol, Cyprus, July 2018
> 
> **Legal Information**
> 
> _Spatialisateur is an [IRCAM](https://www.ircam.fr/) registered trademark. The design of Spat and the reverberation module are protected under several French and international patents (\[FR\] 92 02528; \[US\] 5,491,754, \[FR\] 95 10111; \[US\] 5,812,674). All other trademarks belong to their owners. Max/MSP is the property of [IRCAM](https://www.ircam.fr/) and [Cycling’74](https://cycling74.com/)._
