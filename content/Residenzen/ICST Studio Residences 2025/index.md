---
title: "2025 ICST Artist in Studio-Residency"
date: 2025-09-16T00:00:00
hideDate: true
---

<style>
/* ── Artist-in-Residence Cards — Anatole theme aligned ── */

/* Anatole colour tokens (mirrors _variables.scss)
   Light:  accent=#fff  primary=#464646  primary-light=#9f9f9f
           primary-lighter=#eeeeee  info=#6086b4
   Dark:   accent=#152028  primary=#eeeeee  primary-light=#9f9f9f
           primary-lighter=#464646  info=#6086b4               */

.artist-card {
  overflow: hidden;               /* clearfix for float */
  margin: 2rem 0 2.5rem 0;
  padding: 1.5rem;
  border-left: 3px solid #6086b4;
  border-radius: 2px;
  font-family: inherit;
}
.theme--light .artist-card {
  background: #eeeeee;
  color: #464646;
  box-shadow: 0 8px 16px rgba(10,10,10,0.07);
}
.theme--dark .artist-card {
  background: #2a3a44;
  color: #eeeeee;
  box-shadow: 0 8px 16px rgba(226,226,226,0.06);
}

/* Float image left — text wraps around it */
.artist-card img {
  float: left !important;
  display: block !important;
  margin: 0 1.8rem 1rem 0 !important;
  width: 260px !important;
  height: 174px !important;
  max-width: 260px !important;
  max-height: 174px !important;
  object-fit: cover;
  object-position: center center;
  border-radius: 2px;
}

.artist-card__name {
  font-size: 1.8rem;
  font-weight: bold;
  letter-spacing: 1px;
  margin: 0 0 0.4rem 0;
  line-height: 1.2;
}

.artist-card__period {
  display: inline-block;
  font-size: 1.1rem;
  padding: 2px 10px;
  border-radius: 20px;
  margin-bottom: 0.7rem;
  font-family: monospace;
  letter-spacing: 0.03em;
}
.theme--light .artist-card__period {
  background: #fff;
  color: #9f9f9f;
  border: 1px solid #eeeeee;
}
.theme--dark .artist-card__period {
  background: #152028;
  color: #9f9f9f;
  border: 1px solid #464646;
}

.artist-card__badge {
  display: inline-block;
  background: #6086b4;
  color: #fff;
  font-size: 1rem;
  padding: 2px 9px;
  border-radius: 20px;
  margin-left: 0.4rem;
  margin-bottom: 0.7rem;
  letter-spacing: 0.05em;
  text-transform: uppercase;
}

.artist-card__links {
  margin: 0.5rem 0 0.8rem 0;
  font-size: 1.3rem;
}
.artist-card__links a {
  margin-right: 1.2rem;
  color: #6086b4;
}
.artist-card__links a:hover {
  text-decoration: underline;
}

.artist-card__bio {
  font-size: 1.4rem;
  margin: 0.6rem 0;
  line-height: 1.75;
}
.theme--light .artist-card__bio { color: #464646; }
.theme--dark  .artist-card__bio { color: #eeeeee; }

@media (max-width: 600px) {
  .artist-card img {
    float: none !important;
    width: 100% !important;
    max-width: 100% !important;
    height: 260px !important;
    max-height: 260px !important;
    margin: 0 0 1rem 0 !important;
  }
}
</style>

<div class="artist-card">
  <img src="nandele_01.png" alt="Nandele Maguni">
  <div class="artist-card__body">
    <div class="artist-card__name">Nandele Maguni</div>
    <span class="artist-card__period">16 Jun – 06 Jul 2025</span>
    <p class="artist-card__bio">During his three-week ICST Studio Residency, Nandele Maguni produced a new release entitled <em>Kampfumo</em> based on his field recordings from Maputo.</p>
  </div>
</div>

<div class="artist-card">
  <img src="Youngjae_Cho.jpg" alt="Youngjae Cho">
  <div class="artist-card__body">
    <div class="artist-card__name">Youngjae Cho</div>
    <span class="artist-card__period">07 Jul – 27 Jul 2025</span>
    <div class="artist-card__links">
      <a href="https://www.youngjaecho.com/about.html">Website</a>
      <a href="../youngjae-cho/">Full profile & B-Format project →</a>
    </div>
    <p class="artist-card__bio">Composer based in Korea and Germany, working with electroacoustic music, live electronics, and immersive multi-channel audio. His accolades include the George Enescu Competition (1st Prize) and the Via Nova Competition (1st Prize).</p>
  </div>
</div>

<div class="artist-card">
  <img src="Lucas_Daniel.jpg" alt="Dániel Péter Biró">
  <div class="artist-card__body">
    <div class="artist-card__name">Dániel Péter Biró</div>
    <span class="artist-card__period">18 Aug – 07 Sep 2025</span>
    <p class="artist-card__bio">Professor of Composition at the Grieg Academy, University of Bergen. His research project <em>Sounding Philosophy</em> is funded by the Norwegian Artistic Research Program (2021–2025).</p>
  </div>
</div>

<div class="artist-card">
  <img src="GOPR4281.jpg" alt="Ana Gonzalez Gamboa">
  <div class="artist-card__body">
    <div class="artist-card__name">Ana Gonzalez Gamboa <span class="artist-card__badge">Prix CIME 2025</span></div>
    <span class="artist-card__period">08 Sep – 16 Sep 2025</span>
    <div class="artist-card__links">
      <a href="https://anagonzalezgamboa0.wixsite.com/anagamboa">Website</a>
      <a href="https://www.instagram.com/ana___gamboa/">Instagram</a>
      <a href="../ana-gonzalez-gamboa/">Full profile →</a>
    </div>
    <p class="artist-card__bio"><em>Lúmina</em> is a composition that intertwines travel recordings with fragments of anime, constructing an imaginary world where memory and fiction intersect.</p>
  </div>
</div>

