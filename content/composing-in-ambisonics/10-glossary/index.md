---
title: "Glossary"
description: "Key terms from Ambisonics, psychoacoustics, and spatial composition — concisely explained."
date: 2026-01-01T00:00:00
weight: 100
draft: true
translationKey: "composing-glossary"
---

This glossary explains the key technical terms used throughout the *Composing in Ambisonics* section. Entries are in alphabetical order and oriented toward compositional relevance.

---

**ACN (Ambisonic Channel Numbering)**
Standardised numbering of Ambisonics channels: channel 0 = W (omnidirectional), channel 1 = Y, channel 2 = Z, channel 3 = X, and so forth for higher orders. ACN is part of the ambiX convention and is now the most widely used standard for HOA production. Contrast: FuMa channel ordering (W, X, Y, Z).

---

**ambiX**
The modern Ambisonics file format, combining ACN channel ordering with SN3D normalisation. ambiX is the current industry standard for exchanging HOA files and is supported by the ICST Plugins, the IEM Plugin Suite, and SPARTA. Older systems use FuMa instead.

---

**ASW (Apparent Source Width)**
Psychoacoustic measure of how wide or spatially extended a sound source is perceived to be. ASW depends on early lateral reflections and the spatial coherence of the signal, and is compositionally controllable via spread and diffusion.

---

**Azimuth**
The horizontal angle of a sound source in the Ambisonics coordinate system, measured in degrees (0° = front, ±180° = rear). In the ambiX convention, +90° corresponds to the left side. Azimuth is the primary parameter for horizontal positioning and movement of sounds.

---

**B-Format**
The fundamental Ambisonics signal format. In FOA it consists of four channels: W (omnidirectional), X (front–back), Y (left–right), and Z (up–down). In HOA, the B-format extends to (N+1)² channels for order N. The B-format serves as both the primary working format and the preferred archival format in the ICST context. For the methodological background, see also [Why the Decoder Sounds the Way It Does – Methodological Context](/post/decoder-methodological-context/).

---

**Binaural**
A playback method that simulates spatial sound over headphones. Binaural rendering uses HRTFs to encode directional and distance information for the human ear. Ambisonics masters can be decoded directly into binaural stereo; from 3rd order upwards, binaural quality is adequate for most applications.

---

**D/R Ratio (Direct-to-Reverberant Ratio)**
The ratio of direct sound from a source to the diffuse reverberant component at the listening position. A high D/R ratio signals closeness and presence; a low D/R ratio produces the impression of distance or a large room volume. Compositionally controllable via distance, reverb amount, and room size.

---

**Decoding**
Conversion of an Ambisonics signal (B-format) into a loudspeaker-specific or binaural output format. Decoding is setup-dependent and can produce different output configurations from the same B-format master without altering the composition. For a deeper conceptual framing, see [Why the Decoder Sounds the Way It Does – Methodological Context](/post/decoder-methodological-context/).

---

**Diffusion / Spread**
Compositional parameter that determines how concentrated or spread out a sound object is perceived in space. Low diffusion (low spread) produces precise point-source localisation; high diffusion creates envelopment, field character, and spatial breadth. Spread is directly automatable in the ICST MonoEncoder and MultiEncoder_64.

---

**Elevation**
The vertical angle of a sound source in the Ambisonics coordinate system: 0° = ear level, +90° = zenith (directly above), −90° = nadir (directly below). Elevation is the central parameter for the vertical dimension of the sound field and a defining compositional feature over horizontal surround formats.

---

**Encoding**
Conversion of a mono or multichannel audio signal into the Ambisonics B-format. Encoding defines the position (azimuth, elevation, distance), movement, and spread of a source in the sound field. In the ICST workflow, this is handled by the MonoEncoder, StereoEncoder, and MultiEncoder_64.

---

**Envelopment**
The psychoacoustic sensation of being surrounded by sound rather than positioned in front of a source. Envelopment (→ LEV) is produced by diffusion, reverberation structure, and lateral spatial energy, and is a central compositional goal in spatial music.

---

**FOA (First Order Ambisonics)**
First-order Ambisonics with 4 channels (W, X, Y, Z). FOA offers a spatial resolution of approximately 45° and is the historically first practical Ambisonics format. Today it is used as a robust archival format and for simpler productions; for precise spatial composition, HOA is recommended.

---

**FuMa (Furse-Malham)**
An older normalisation convention and channel ordering for Ambisonics, named after Dave Furse and Richard Malham. FuMa is incompatible with the modern ambiX standard (ACN/SN3D). When working with older plugins or audio files, the convention must be checked explicitly and converted if necessary.

---

**HOA (Higher Order Ambisonics)**
Ambisonics of second order and above. By using higher-order spherical harmonics, HOA allows finer spatial resolution, a larger sweet spot, and more precise localisation. The channel count is calculated as (N+1)² for 3D order N: 3rd order = 16 channels, 5th order = 36 channels, 7th order = 64 channels.

---

**HRTF (Head-Related Transfer Function)**
A frequency-response function describing how the outer ear, head, and shoulders modify sound arriving from a given direction before it reaches the eardrums. HRTFs are the basis for binaural rendering. Individual HRTFs improve externalisation; generic HRTFs are adequate for most production contexts.

---

**ICST Ambisonics Plugins**
A suite of Ambisonics tools for REAPER, developed at the ICST (Institute for Computer Music and Sound Technology) at ZHdK Zurich. Includes MonoEncoder, StereoEncoder, MultiEncoder_64, AmbiDecoder, and further utilities. All plugins work in ambiX format (ACN/SN3D).

---

**ILD (Interaural Level Difference)**
The level difference between the left and right ear, caused by sound diffraction around the head. ILD is an important binaural localisation cue, especially for high frequencies and lateral sound events (above approximately 1.5 kHz).

---

**ITD (Interaural Time Difference)**
The time difference between a sound signal arriving at the left and right ear. ITD is the primary binaural localisation cue for low and mid frequencies (up to approximately 1.5 kHz). Sound from the left reaches the left ear earlier than the right; the brain uses this difference for directional processing.

---

**LEV (Listener Envelopment)**
A psychoacoustic measure of the degree to which a listener feels surrounded by sound. LEV is produced primarily by late lateral sound reflections and is a key quality criterion of spatial audio reproduction. In Ambisonics compositions it is controllable via diffusion, reverb character, and lateral/rear sound components.

---

**MonoEncoder / StereoEncoder / MultiEncoder_64**
Individual plugins in the ICST Ambisonics suite for REAPER. The MonoEncoder encodes a single mono source; the StereoEncoder a stereo source; the MultiEncoder_64 up to 64 sources simultaneously via a shared radar GUI and group controls. All three support automation of azimuth, elevation, distance, and spread.

---

**N3D (Full Normalisation)**
A normalisation convention for Ambisonics in which all spherical harmonics are normalised to the same maximum value. N3D is used in some scientific contexts and IEM plugins; for production interchange, SN3D is more common today.

---

**Perspectival Space**
Category from Denis Smalley's *space-form* theory: the experience of an imagined acoustic location (cathedral, forest, abstract sound volume). Compositionally controllable via reverberation character, distance stratification, and frequency distribution. Contrast: source-bonded space, spectral space.

---

**SN3D (Semi-Normalised)**
A normalisation convention for Ambisonics signals in which the spherical harmonics are normalised according to a consistent scheme. SN3D is part of the ambiX convention and is now the preferred standard for HOA production and plugin interoperability.

---

**Source-Bonded Space**
Category from Denis Smalley's *space-form* theory: space tied to recognisable sound objects — the distance of a voice, the path of an instrument. Source-bonded space enables narrative spatial events (approach, flight, dialogue). Contrast: spectral space, perspectival space.

---

**Spectral Space**
Category from Denis Smalley's *space-form* theory: space arising from the spatial distribution of spectral qualities rather than discrete localisation. For example: high frequencies in the upper hemisphere, low frequencies near the floor. Compositionally most relevant for diffuse textures and spatial atmospheres.

---

**Spectromorphology**
Denis Smalley's analytical concept for describing the temporal development of electroacoustic sounds. It describes how spectrum, texture, and sound shape unfold over time. In the Ambisonics context this extends to spatio-morphology: spatial and spectral development as an integrated dimension.

---

**Spherical Harmonics**
Mathematical basis functions on the surface of a sphere that form the foundation of HOA mathematics. Ambisonics signals are weighted sums of spherical harmonics up to the chosen order N. The number of terms grows as (N+1)²; higher orders capture finer directional structures. A readable introduction to their role in decoding is [Why the Decoder Sounds the Way It Does – Methodological Context](/post/decoder-methodological-context/).

---

**Sweet Spot**
The zone within a loudspeaker array in which spatial reproduction and localisation work as intended. In FOA the sweet spot is very small (ideally a single point); in HOA it grows with increasing order, allowing multiple listeners to perceive spatial information correctly at the same time.

---

**Trajectory**
The movement path of a sound source through the Ambisonics sound field over time, defined by the automation of azimuth, elevation, and/or distance. Trajectories are a central element of spatial counterpoint and can be geometric (circle, line, spiral) or gestural (approach, flight, implosion).

---

**W, X, Y, Z**
The four channels of an FOA B-format signal in the FuMa convention. W is omnidirectional (0th order); X, Y, and Z are directed 1st-order components (front–back, left–right, up–down). In the ambiX convention (ACN), these correspond to channels 0, 3, 1, 2 respectively.
