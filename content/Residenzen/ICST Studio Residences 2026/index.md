---
title: "2026 ICST Artist in Studio-Residency"
date: 2026-03-01T00:00:00
hideDate: true
---

Institute for Computer Music and Sound Technology (ICST) Zurich University of the Arts

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

.sessions-table {
  font-size: 1.3rem;
  margin-top: 0.8rem;
  border-collapse: collapse;
}
.sessions-table th {
  text-align: left;
  padding: 3px 14px 3px 0;
  font-weight: normal;
  text-transform: uppercase;
  font-size: 1.1rem;
  letter-spacing: 0.05em;
  color: #9f9f9f;
}
.sessions-table td {
  padding: 3px 14px 3px 0;
}

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
  <img src="monoc-small-2.jpg" alt="Pierre Alexandre Tremblay">
  <div class="artist-card__body">
    <div class="artist-card__name">Pierre Alexandre Tremblay</div>
    <span class="artist-card__period">28 Apr – 21 Aug 2026</span>
    <div class="artist-card__links">
      <a href="https://www.zhdk.ch/forschung/icst/icst-air/pierre-alexandre-tremblay-25360">ICST Projektseite</a>
      <a href="https://www.pierrealexandretremblay.com/">Website</a>
    </div>
    <p class="artist-card__bio">Born in Montréal in 1975, Pierre Alexandre Tremblay is a composer and performer specialising in bass guitar and electronic devices. His work spans electroacoustic music, contemporary jazz, mixed music, and improvisation, with releases on the empreintes DIGITALes label. He served as Professor of Composition and Improvisation at the University of Huddersfield from 2005 to 2024, and currently holds a research professor position in composition at the Conservatorio della Svizzera italiana.</p>
    <table class="sessions-table">
      <tr><th>Session</th><th>Von</th><th>Bis</th></tr>
      <tr><td>1.</td><td>28 Apr 2026</td><td>01 Mai 2026</td></tr>
      <tr><td>2.</td><td>22 Jun 2026</td><td>24 Jun 2026</td></tr>
      <tr><td>3.</td><td>13 Jul 2026</td><td>17 Jul 2026</td></tr>
      <tr><td>4.</td><td>27 Jul 2026</td><td>30 Jul 2026</td></tr>
      <tr><td>5.</td><td>17 Aug 2026</td><td>21 Aug 2026</td></tr>
    </table>
  </div>
</div>

<div class="artist-card">
  <img src="monoc-small.jpg" alt="Yoko Konishi">
  <div class="artist-card__body">
    <div class="artist-card__name">Yoko Konishi</div>
    <span class="artist-card__period">24 Aug – 13 Sep 2026</span>
    <div class="artist-card__links">
      <a href="https://www.zhdk.ch/forschung/icst/icst-air/yoko-konishi-25367">ICST Projektseite</a>
    </div>
    <p class="artist-card__bio">Yoko Konishi is a Japanese sound artist and performer currently based in France. Her practice centres on the intersection of sound, body, and technology through spatial audio, interactive systems, and sensor-based processes. She holds a Master's degree in ambisonics and spatial sound composition from Université Paris 8, attended a post-master's programme at the mdw – University of Music and Performing Arts Vienna, and completed IRCAM's Cursus programme in 2024–25.</p>
    <p class="artist-card__bio">From 24 August to 13 September 2026, Konishi will be at ICST for her Studio Residency. She will create a new work for presentation at the <strong>Sonic Matter Festival 2027</strong>, deepening the integration of narrative structures and sensory immersion in spatial composition.</p>
  </div>
</div>

<div class="artist-card">
  <img src="monoc-small-1.jpg" alt="Eli Stine">
  <div class="artist-card__body">
    <div class="artist-card__name">Eli Stine</div>
    <span class="artist-card__period">29 Jun – 06 Jul 2026</span>
    <span class="artist-card__badge">Prix CIME 2025</span>
    <div class="artist-card__links">
      <a href="https://elistine.com/">Website</a>
    </div>
    <p class="artist-card__bio">Eli Stine is a composer, programmer, and educator. He holds a Ph.D. and Master's in Composition and Computer Technologies from the University of Virginia and bachelor's degrees in Technology in Music and Computer Science from Oberlin College. He is a Visiting Assistant Professor at Oberlin Conservatory. His work explores electroacoustic sound and multimedia technologies using custom-built software, video projection, and multi-channel speaker systems. His piece <em>Where Water Meets Memory</em> won the <strong>Prix CIME 2025</strong> international electroacoustic music competition.</p>
  </div>
</div>

---

<span style="font-size:9px;color:#9f9f9f;">©2026 ICST</span>