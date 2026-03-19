---
title: "Live Electronics and Performance in Ambisonics"
description: "Ambisonics in the performance context: real-time spatial processing, instrument and live electronics, performance workflow, and specific challenges."
date: 2026-01-01T00:00:00
weight: 88
draft: true
translationKey: "composing-live-electronics"
---

The approach to composing in Ambisonics described so far is oriented primarily toward **fixed media**: a piece is produced in the studio, archived as a B-format master, and played back in performance. This workflow has clear advantages — complete control over every parameter, independent quality control, transferability across formats and setups.

As soon as Ambisonics is used in a **live context**, however — with instruments, voice, or interactive electronics — priorities shift fundamentally. Reactivity replaces control. Stability and precision must be balanced against real-time demands, varying performance conditions, and the dynamics of the performative moment.

## What Distinguishes Live Ambisonics from Fixed Media

The decisive difference is the **time structure of decisions**. In the production studio, spatial decisions can be undone or refined at any moment. In performance, they are irreversible: what has been placed in the Ambisonics field remains there — until the next controllable change.

This has direct compositional consequences:

- **Spatial precision** must be weighed against robustness. An elaborate automation that sounds perfect in the studio can be destabilised in performance by latency, hardware variance, or monitoring deviation.
- **Monitoring for performers** is fundamentally different from monitoring for production. Someone playing on a stage often hears the Ambisonics field only partially, or not at all — or through stage monitors that provide no spatial image.
- **Spatial dramaturgy** must be performance-viable: transitions, movements, and field changes must be reproducible and safely executable under performance conditions.

## Typical Live Setups in the ICST Context

In the ICST studio, three main configurations for live Ambisonics have emerged:

### 1. Fixed Media with Live Instrument

The most common configuration: a pre-produced Ambisonics playback is complemented by an instrument that is itself encoded live into Ambisonics. The fixed-media playback provides the spatial "ground" of the piece; the instrument contributes live material to the field.

**Compositional considerations:**
- The separability of fixed-media sources and the live instrument within the Ambisonics field depends on their spatial positioning and timbral differentiation.
- The live instrument can be statically positioned (fixed azimuth/elevation in the encoder) or moved via an OSC controller or a performer's movements.
- Even with purely static positioning, the instrument's spatial presence can be varied through room effects (reverb, spread).

### 2. Fully Live — Real-Time Ambisonics

All sonic events are encoded and spatially processed in real time. Typical for interactive systems, algorithmic composition, or improvised spatial music.

**Essential technical requirements:**
- Low latency is crucial: for Ambisonics encoding with ICST plugins, REAPER should run in a stable real-time mode (ASIO or CoreAudio driver, buffer sizes typically 64–256 samples).
- Dedicated hardware: performance-capable CPU, stable audio interface.
- OSC or MIDI for real-time control of spatial parameters is recommended when multiple sources need to be moved simultaneously.

### 3. Hybrid Form — Interactive Triggering

A middle ground: spatial events or positions are triggered or modulated live, but within a predefined structure. The piece has a fixed dramaturgical logic, but the performer can act spatially within designated zones.

This configuration is well suited to compositionally controlled but performatively lively performance situations.

## For Composers: ICST Externals, Envelopes, and Ableton Live

If you are composing live electronics in Ambisonics, the most useful ICST paths are not only the REAPER plugins but also the **ICST Ambisonics Tools** in Max/MSP and their extension into Ableton-oriented workflows.

- **ICST Ambisonics Tools / Externals**: for custom live patches, algorithmic spatialisation, and real-time source control in Max. This is the right path when the performance logic itself is part of the composition. See [ICST Ambisonics Tools](/icst-ambisonics-tools/).
- **Envelope-based movement in REAPER**: for pieces where spatial trajectories need to remain repeatable but still performable. This is useful for cue-based live form, hybrid playback, or precisely timed entrances. See [Step by Step Setup](/icst-ambisonics-plugins/06_step_by_step_setup/) and [ICST ReaScripts](/post/icst-scripts/).
- **Ableton Live + ICST workflow**: useful when clips, scene logic, Max for Live, or hybrid electronic performance are central to the piece. See [Ableton Live & ICST Ambisonics Integration](/post/ableton_reaper/).
- **Envelop for Live and related Ableton-centred approaches**: relevant when spatial performance is organised around Live sets, Max for Live devices, and hands-on gestural control. For the broader tool comparison, see [Tools and Software](/composing-in-ambisonics/08-tools-and-software/).

One concrete ICST live reference is Vincent Cears's **A Year in Dark Tones**, documented in [ASCOLTA #3](/blog/ascolta/03-ascolta/): a **live improvisation in 3rd-order Ambisonics** developed during the residency, combining performance, immersive staging, and Ambisonics conversion in practice.

Another useful artistic reference is Franziska Baumann's live spatial work:

{{< youtube g2ZGXN_2oX4 >}}

## Monitoring in the Live Context

In the studio, monitoring can shift between different perspectives — loudspeakers, binaural, various decoders. In the performance context, this flexibility is constrained. This has practical consequences:

**Performer monitoring:** Stage monitors generally provide no spatial image of the Ambisonics field. Instrumentalists hear themselves and the fixed-media playback as a mono or stereo mix. This means: the spatial embedding of the instrument within the Ambisonics field is primarily for the audience — not for the performer.

**Consequence for notation and score:** If performers are meant to adapt spatial aspects of their playing (e.g. through instrument movement, or by adjusting dynamics in particular spatial zones), the score must state this explicitly. The spatial feedback loop is absent; what was possible in the studio as an immediate reaction to what was heard is effectively blind on stage.

**Audience monitoring:** The listening position of the audience varies with every performance. Fixed seating in a sweet spot is rare; in dome setups or loudspeaker arrays, different people hear different versions of the sound field. Compositions for live Ambisonics should therefore prioritise spatial energy and envelopment — which are experienceable from non-central positions — over precise localisation, which functions only near the centre.

## Spatial Parameters in the Live Context

Not all spatial parameters are equally well suited to live use.

**Robust parameters for live:**
- Azimuth positioning (laterality) — reliably perceptible across the full audience field
- Spread/diffusion — easily controllable, delivers consistent effect across the space
- Distance/reverb balance — generates LEV effects that are perceivable regardless of setup
- Slow movement / largo trajectories — can be safely executed on stage

**Fragile parameters for live:**
- Elevation with small arrays — many venues have no or minimal overhead configuration
- Precise localisation of small angular separations — depends on decoder quality and loudspeaker calibration
- Fast movements across narrow azimuth ranges — can become unstable with latency or jitter

## Notation for Live Ambisonics

For pieces with live Ambisonics components, a **performance-viable notation** is recommended — one that combines parametric precision with scenographic readability. Some guidelines:

**What should be in the score:**
- Spatial zones (not exact angles) for each source: "left rear", "overhead audience", "front field"
- Timing and duration of spatial events or transitions
- Critical moments where spatial coordination between instrument and playback matters
- Notes on the monitoring situation and dependencies

**What must be clarified technically:**
- Latency compensation between fixed media and live encoding
- Loudspeaker configuration at the venue: adjust HOA order?
- OSC/MIDI routing for any moving parameters
- Soundcheck time for spatial calibration

## Compositional Consequence

Live Ambisonics is not a straightforwardly extended production-studio workflow. It is a distinct compositional genre with its own strengths and constraints. The strengths lie in reactivity, the performative moment, the connection between body and spatial sound. The constraints lie in reduced precision, limited monitoring, and increased dependency on varying performance conditions.

Compositionally, live Ambisonics becomes most productive where the imprecision of the live moment itself becomes material — where spatial variance is not treated as error but as part of the performance dimension. This differs fundamentally from a production approach aimed at maximum reproducibility. Those composing for the live context are also composing for the unforeseen: the acoustic profile of the venue, the distribution of the audience across the space, the energy of the performative moment.

The ICST offers opportunities to test live Ambisonics concepts across different performance contexts through its [residency programmes](/residenzen/). The technical documentation of the ICST plugins also contains guidance on [real-time routing configuration in REAPER](/icst-ambisonics-plugins/06_step_by_step_setup/).
