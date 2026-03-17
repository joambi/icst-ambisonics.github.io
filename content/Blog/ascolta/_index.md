---
title: ICST Ascolta
description: "Acousmatic listening sessions at the ICST Composition Studio, ZHdK — public events featuring spatial and electroacoustic music."
date: 2025-01-01T00:00:00
weight: 1
group: "Listening"
---

<style>
.hub-hero {
  display: grid;
  grid-template-columns: minmax(0, 1.35fr) minmax(280px, 0.9fr);
  gap: 1.2rem;
  align-items: stretch;
  margin: 1rem 0 1.5rem;
}
.hub-kicker {
  font-size: 0.92rem;
  text-transform: uppercase;
  letter-spacing: 0.12em;
  color: #6086b4;
  margin-bottom: 0.55rem;
}
.hub-intro {
  font-size: 1.45rem;
  line-height: 1.65;
  margin: 0 0 0.8rem;
  max-width: 54rem;
}
.hub-lead {
  margin: 0;
  font-size: 1.12rem;
  color: #9f9f9f;
  line-height: 1.55;
  max-width: 46rem;
}
.hub-upcoming {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  gap: 0.5rem;
  text-decoration: none;
  border-radius: 2px;
  padding: 1.05rem 1.15rem;
  min-height: 100%;
  margin-top: -2rem;
  transition: transform 0.12s ease, border-color 0.12s ease, background 0.12s ease;
}
.theme--light .hub-upcoming {
  background: #f6f8fb;
  border: 1px solid #d9e3ef;
  color: #1f3142;
}
.theme--dark .hub-upcoming {
  background: #2c4352;
  border: 1px solid #5f84a7;
  color: #eeeeee;
}
.hub-upcoming:hover {
  transform: translateY(-1px);
}
.hub-upcoming__eyebrow {
  font-size: 0.88rem;
  text-transform: uppercase;
  letter-spacing: 0.12em;
  color: #6086b4;
}
.hub-upcoming__date {
  font-size: 1.55rem;
  font-weight: 700;
  line-height: 1.15;
}
.hub-upcoming__meta {
  font-size: 1rem;
  color: #9f9f9f;
}
.hub-upcoming__title {
  font-size: 1.2rem;
  font-weight: 700;
  line-height: 1.3;
}
.hub-upcoming__text {
  font-size: 1.06rem;
  line-height: 1.45;
  color: #9f9f9f;
}
.hub-note {
  margin: 1rem 0 0;
  padding: 0.95rem 1rem;
  border-left: 3px solid #6086b4;
  font-size: 1rem;
  line-height: 1.5;
}
.theme--light .hub-note {
  background: #fbfbfb;
}
.theme--dark .hub-note {
  background: #22313a;
}
.hub-purpose {
  margin: 0.8rem 0 0;
  padding-left: 1.15rem;
}
.hub-purpose li {
  margin: 0.35rem 0;
}
.post__content h2 {
  margin-top: 2.4rem;
  margin-bottom: 0.9rem;
  padding-top: 0.15rem;
  font-size: 1.75rem;
  letter-spacing: 0.01em;
}
.post__content h3 {
  margin-top: 1.8rem;
  margin-bottom: 0.7rem;
  font-size: 1.28rem;
  color: #9f9f9f;
}
.hub-start,
.hub-related {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 1.15rem;
  margin: 1.1rem 0 1.75rem;
}
.hub-start a,
.hub-related a {
  display: block;
  text-decoration: none;
  border-radius: 2px;
  min-height: 100%;
  padding: 1.15rem 1.2rem 1.1rem;
  border-top: 3px solid #6086b4;
  transition: transform 0.12s ease, border-color 0.12s ease, background 0.12s ease, box-shadow 0.12s ease;
}
.theme--light .hub-start a,
.theme--light .hub-related a {
  background: linear-gradient(180deg, #ffffff 0%, #f7f9fc 100%);
  border: 1px solid #dfe7ef;
  color: #243546;
  box-shadow: 0 1px 0 rgba(96, 134, 180, 0.05);
}
.theme--dark .hub-start a,
.theme--dark .hub-related a {
  background: linear-gradient(180deg, #2b3f4c 0%, #243640 100%);
  border: 1px solid #486275;
  color: #eeeeee;
}
.theme--light .hub-start a:hover,
.theme--light .hub-related a:hover {
  border-color: #6086b4;
  box-shadow: 0 6px 18px rgba(96, 134, 180, 0.12);
}
.theme--dark .hub-start a:hover,
.theme--dark .hub-related a:hover {
  border-color: #6086b4;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.22);
}
.hub-card__title {
  display: block;
  font-weight: 700;
  margin-bottom: 0.45rem;
  font-size: 1.08rem;
  letter-spacing: 0.01em;
}
.hub-card__text {
  display: block;
  font-size: 1.08rem;
  color: #9f9f9f;
  line-height: 1.45;
}
.season-section { margin-bottom: 1.5rem; }
.season-label {
  font-size: 1rem;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  color: #9f9f9f;
  padding-bottom: 4px;
  margin-bottom: 0.7rem;
}
.theme--light .season-label { border-bottom: 1px solid #eeeeee; }
.theme--dark  .season-label { border-bottom: 1px solid #464646; }

.session-list { display: flex; flex-direction: column; gap: 0.35rem; }
.session-row {
  display: flex;
  align-items: flex-start;
  gap: 0.8rem;
  padding: 0.6rem 0.7rem;
  border-radius: 2px;
  text-decoration: none;
  transition: background 0.1s;
}
.theme--light .session-row { color: #464646; background: #eeeeee; }
.theme--dark  .session-row { color: #eeeeee; background: #2a3a44; }
.theme--light .session-row:hover { background: #e0e0e0; }
.theme--dark  .session-row:hover { background: #354f5e; }

.session-row__num {
  font-size: 1rem;
  font-weight: bold;
  min-width: 32px;
  border-radius: 2px;
  display: flex; align-items: center; justify-content: center;
  flex-shrink: 0;
  color: #6086b4;
  padding-top: 2px;
}
.session-row__content {
  display: flex;
  flex-direction: column;
  gap: 2px;
  flex: 1;
}
.session-row__title {
  font-size: 1.1rem;
  font-weight: bold;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}
.session-row__subtitle {
  font-size: 1.3rem;
}
.session-row__date {
  font-size: 1.1rem;
  color: #9f9f9f;
  margin-top: 2px;
}
@media (max-width: 760px) {
  .hub-hero {
    grid-template-columns: 1fr;
    gap: 0.9rem;
  }
  .hub-upcoming {
    margin-top: 0;
  }
  .hub-intro {
    font-size: 1.3rem;
    line-height: 1.65;
  }
  .hub-lead,
  .hub-note {
    font-size: 1rem;
  }
  .post__content h2 {
    margin-top: 2rem;
    font-size: 1.55rem;
  }
  .post__content h3 {
    font-size: 1.18rem;
  }
  .hub-start,
  .hub-related {
    grid-template-columns: 1fr;
    gap: 0.9rem;
  }
  .hub-start a,
  .hub-related a {
    padding: 1rem 1rem 0.95rem;
  }
  .session-row {
    gap: 0.65rem;
    padding: 0.7rem 0.75rem;
  }
  .session-row__subtitle {
    font-size: 1.2rem;
  }
}
</style>

<div class="hub-hero">
  <div>
    <div class="hub-kicker">Public Listening Series</div>
    <div class="hub-intro">
    <strong>ascolta</strong> brings acousmatic and electroacoustic music into an intimate listening situation at the ICST Composition Studio of the Zurich University of the Arts.
    </div>
    <p class="hub-lead">We listen on a higher-order Ambisonics speaker system to works from the ICST residency programme and from the international repertoire, presented as immersive spatial audio.</p>
    <div class="hub-note">
    <strong>Next session:</strong> <strong>#18 ascolta</strong> is dedicated to <strong>Éliane Radigue</strong> (24 January 1932 – 23 February 2026). At the centre is <em>The Resonant Island</em>, released on <strong>Shiiin</strong> (2005), a 55-minute sound sculpture of extraordinary slowness and concentration.
    </div>
  </div>
  <a class="hub-upcoming" href="/blog/ascolta/18-ascolta/">
    <span class="hub-upcoming__eyebrow">Upcoming Date</span>
    <span class="hub-upcoming__date">02 April 2026</span>
    <span class="hub-upcoming__meta">18:00–19:00 · Free admission</span>
    <span class="hub-upcoming__title">#18 ascolta — Éliane Radigue</span>
    <span class="hub-upcoming__text"><em>The Resonant Island</em>, released on Shiiin (2005)</span>
  </a>
</div>

---

## What This Page Is For

This is the **listening and programme hub** for ascolta. Here you can:

- find upcoming and past listening sessions
- navigate programme themes and listening resources
- move between the public series, the studio context, and the residency projects behind many programmes

If you are looking for technical information about the **studio setup**, go to the [ICST Composition Studio](/blog/icst-composer-studio-blog/). If you want to explore the **artists and projects** behind many of the programmes, go to [Residencies](/residenzen/).

---

## Start here

<div class="hub-start">
  <a href="/blog/ascolta/18-ascolta/">
    <span class="hub-card__title">Next session</span>
    <span class="hub-card__text">Go straight to the current ascolta date and programme.</span>
  </a>
  <a href="/blog/ascolta-listening-guide/">
    <span class="hub-card__title">Listening Guide</span>
    <span class="hub-card__text">Questions, categories, and exercises for active spatial listening.</span>
  </a>
  <a href="/residenzen/">
    <span class="hub-card__title">Residency projects</span>
    <span class="hub-card__text">Artists and projects behind many ascolta programmes.</span>
  </a>
</div>

---

## All Sessions

<div class="season-section">
  <div class="season-label">2026</div>
  <div class="session-list">
    <a class="session-row" href="/blog/ascolta/18-ascolta/">
      <span class="session-row__num">#18</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">Éliane Radigue — The Resonant Island</span>
        <span class="session-row__date">02 Apr 2026</span>
      </span>
    </a>
    <a class="session-row" href="/blog/ascolta/19-ascolta/">
      <span class="session-row__num">#19</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">Acousmatic Listening Sessions — ICST Studio Residencies 2025</span>
        <span class="session-row__date">21 May 2026</span>
      </span>
    </a>
  </div>
</div>

<div class="season-section">
  <div class="season-label">2025</div>
  <div class="session-list">
    <a class="session-row" href="/blog/ascolta/16-ascolta/">
      <span class="session-row__num">#16</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">B-Format Archiving – immersive access to the electroacoustic repertoire</span>
        <span class="session-row__date">16 Oct 2025</span>
      </span>
    </a>
    <a class="session-row" href="/blog/ascolta/15-ascolta/">
      <span class="session-row__num">#15</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">Listening Twice – Ambisonics UHJ recordings from the 1970s</span>
        <span class="session-row__date">06 May 2025</span>
      </span>
    </a>
    <a class="session-row" href="/blog/ascolta/14-ascolta/">
      <span class="session-row__num">#14</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">Listening Twice – 5.1 surround vs. Ambisonics UHJ (1970s)</span>
        <span class="session-row__date">22 Apr 2025</span>
      </span>
    </a>
  </div>
</div>

<div class="season-section">
  <div class="season-label">2024</div>
  <div class="session-list">
    <a class="session-row" href="/blog/ascolta/13-ascolta/">
      <span class="session-row__num">#13</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">Listening Twice – stereo vs. immersive, an experimental comparison</span>
        <span class="session-row__date">17 Dec 2024</span>
      </span>
    </a>
    <a class="session-row" href="/blog/ascolta/12-ascolta/">
      <span class="session-row__num">#12</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">Georg Katzer – electroacoustic works</span>
        <span class="session-row__date">17 Sep 2024</span>
      </span>
    </a>
    <a class="session-row" href="/blog/ascolta/11-ascolta/">
      <span class="session-row__num">#11</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">Mario Mary, portrait</span>
        <span class="session-row__date">11 Jun 2024</span>
      </span>
    </a>
    <a class="session-row" href="/blog/ascolta/10-ascolta/">
      <span class="session-row__num">#10</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">The Composer, Herself – Natasha Barrett</span>
        <span class="session-row__date">19 Mar 2024</span>
      </span>
    </a>
  </div>
</div>

<div class="season-section">
  <div class="season-label">2023</div>
  <div class="session-list">
    <a class="session-row" href="/blog/ascolta/09-ascolta/">
      <span class="session-row__num">#09</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">Hans Tutschku — Remembering Japan</span>
        <span class="session-row__date">05 Dec 2023</span>
      </span>
    </a>
    <a class="session-row" href="/blog/ascolta/08-ascolta/">
      <span class="session-row__num">#08</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">La Canción de la Tierra — Mesias Maiguashca</span>
        <span class="session-row__date">24 Oct 2023</span>
      </span>
    </a>
    <a class="session-row" href="/blog/ascolta/07-ascolta/">
      <span class="session-row__num">#07</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">ICST Artists in Residence — concert with works by former residents</span>
        <span class="session-row__date">06 Jun 2023</span>
      </span>
    </a>
    <a class="session-row" href="/blog/ascolta/06-ascolta/">
      <span class="session-row__num">#06</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">Zbigniew Karkowski — noise and experimental electronic music</span>
        <span class="session-row__date">04 Apr 2023</span>
      </span>
    </a>
    <a class="session-row" href="/blog/ascolta/05-ascolta/">
      <span class="session-row__num">#05</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">Field-Recordings & Soundscapes — Philip Samartzis</span>
        <span class="session-row__date">14 Mar 2023</span>
      </span>
    </a>
  </div>
</div>

<div class="season-section">
  <div class="season-label">2022</div>
  <div class="session-list">
    <a class="session-row" href="/blog/ascolta/04-ascolta/">
      <span class="session-row__num">#04</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">Glocken — bells and tape, Werner Geissberger</span>
        <span class="session-row__date">13 Dec 2022</span>
      </span>
    </a>
    <a class="session-row" href="/blog/ascolta/03-ascolta/">
      <span class="session-row__num">#03</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">Granular — Nikos Stavropoulos & Horacio Vaggione</span>
        <span class="session-row__date">15 Nov 2022</span>
      </span>
    </a>
    <a class="session-row" href="/blog/ascolta/02-ascolta/">
      <span class="session-row__num">#02</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">Gerald Bennett portrait — electroacoustic works by the co-founder of ICST</span>
        <span class="session-row__date">04 Oct 2022</span>
      </span>
    </a>
  </div>
</div>

<div class="season-section">
  <div class="season-label">2019</div>
  <div class="session-list">
    <a class="session-row" href="/blog/ascolta/01-ascolta/">
      <span class="session-row__num">#01</span>
      <span class="session-row__content">
        <span class="session-row__subtitle">Jean-Claude Risset — Songs, Octant, Sud I–III, Resonant</span>
        <span class="session-row__date">26 Nov 2019</span>
      </span>
    </a>
  </div>
</div>

---

## Listening

→ [Ascolta Listening Guide](/blog/ascolta-listening-guide/) — Smalley's spatial categories, five analytical questions, three exercises for active spatial listening.

A selection of online resources for listening to Ambisonics and spatial audio:

- [Sounding Future — Tracks](https://audiospace.soundingfuture.com/tracks) — spatial audio archive
- [Sounding Future — Artists](https://audiospace.soundingfuture.com/artists) — composer and artist profiles
- [HOAST Library (IEM)](https://hoast.iem.at/) — Higher-Order Ambisonics recordings
- [Nimbus UHJ](https://www.wyastone.co.uk/all-labels/nimbus.html) — classic Ambisonics UHJ recordings

---

## ICST B-Format Archive

The ICST maintains an archive of works recorded and encoded in ambiX B-format.

---

## Related Areas

<div class="hub-related">
  <a href="/blog/icst-composer-studio-blog/">
    <span class="hub-card__title">ICST Composition Studio</span>
    <span class="hub-card__text">Studio setup, infrastructure, and technical resources.</span>
  </a>
  <a href="/residenzen/">
    <span class="hub-card__title">Residencies</span>
    <span class="hub-card__text">Artists in residence, profiles, and projects.</span>
  </a>
</div>

→ [Explore the B-Format Archive](https://ambisonics.ch/blog/audio-examples/)

→ [Audio Examples – Binaural Previews](/blog/audio-examples/)

---

## Related Areas

- [ICST Composition Studio](/blog/icst-composer-studio-blog/) — studio setup, infrastructure, and resources
- [Residencies](/residenzen/) — artist-in-residence programme and project context
