---
categories:
  - ICST Ambisonics Workshop
---
---
Ja. Hier ist ein sauberer Workflow für einen Ambisonics-Studio-Test mit genau diesem Decoder-Setup.

**Ziel**
Prüfen, ob dein Ambisonics-Decoder korrekt auf das Lautsprecherlayout übersetzt: Positionen, Pegel, Delays, Höhenebene, Bass/Deep-Layer und räumliche Stabilität.

**1. Session vorbereiten**

1. DAW-Projekt mit 64-kanaligem Ambisonics-Bus anlegen.
2. AmbiDecoder auf den Decoder-/Monitor-Track legen.
3. Decoder-Ausgang auf die physikalischen Lautsprecherausgänge routen.
4. Sicherstellen:
   - Ambisonics-Format: passend zur Quelle, z. B. ACN/SN3D oder FuMa.
   - Ordnung: mindestens 3rd order für Grundtest, bei deinem Setup Middle offenbar 6th order.
   - Alle Speaker im Decoder aktiv.
   - Sub nur für LFE/Bass-Test verwenden, nicht versehentlich Fullrange füttern.

**2. Lautsprecher-Check**

Im Decoder zuerst die einzelnen Speaker-Testbuttons verwenden.

Reihenfolge:

1. Speaker 1-8: untere horizontale Ebene prüfen.
2. Speaker 9-12: erhöhte innere/obere Ebene prüfen.
3. Speaker 13-16: äußere tiefe/seitliche Ebene prüfen.
4. Speaker 17: Top/Zenith prüfen.
5. SUB: separat mit Low-Frequency-Test prüfen.

Bei jedem Speaker notieren:

```text
Speaker Nr. | erwartete Position | tatsächliche Position | Pegel ok? | Delay ok? | Bemerkung
```

Wichtig: Nicht nur hören, ob Signal kommt, sondern ob es räumlich an der richtigen Stelle sitzt.

**3. Pegelkalibrierung**

1. Rosa Rauschen oder bandbegrenztes Pink Noise auf einzelne Decoder-Ausgänge geben.
2. Am Hörplatz mit SPL-Meter messen.
3. Zielpegel definieren, z. B. 73 dB SPL pro Lautsprecher für Studioarbeit oder 79/82/85 dB je nach Raumgröße.
4. Gains im Decoder oder im Lautsprechercontroller angleichen.

Aus deinem Screenshot sind bereits unterschiedliche Gains gesetzt, z. B. einige Speaker bei -1 dB, Speaker 8 bei +1.5 dB, Speaker 12 bei -3 dB, Sub bei -10 dB. Diese Werte solltest du messtechnisch verifizieren, nicht nur übernehmen.

**4. Delay- und Distanztest**

Dein Decoder zeigt bereits Distanzen und Delay-Kompensation. Trotzdem testen:

1. Kurze Klicks/Impuls-Signale auf alle Speaker.
2. Am Hörplatz messen, idealerweise mit REW, Smaart oder ähnlichem.
3. Prüfen, ob Transienten aus allen Lautsprechern zeitlich zusammenfallen.
4. Besonders kontrollieren:
   - Speaker 13-16, da sie weiter entfernt wirken.
   - Speaker 17 Top.
   - Sub, wegen Laufzeit und Crossover.

**5. Decoder-Bänder prüfen**

Dein Setup nutzt Multi-Decoder mode mit drei Bereichen:

```text
Height: 6 speakers, 3rd order, basic
Middle: 16 speakers, 6th order, maxRE
Deep: 0 speakers, 3rd order, inPhase
```

Test:

1. Sinus-Sweeps oder Pink Noise durch den gesamten Frequenzbereich abspielen.
2. Prüfen, ob die Übergänge zwischen Deep/Middle/Height natürlich klingen.
3. Bewegte Quellen testen:
   - Kreis horizontal um den Hörplatz.
   - Vertikaler Kreis vorne.
   - Diagonale Bewegung von unten hinten nach oben vorne.
4. Auf Sprünge, Löcher oder Pegeländerungen achten.

**6. Ambisonics-Quellentest**

Mit einem Encoder oder Testfile folgende Positionen erzeugen:

```text
Front
Back
Left
Right
Top
Bottom / Low
Front-Left
Front-Right
Back-Left
Back-Right
kreisende Quelle horizontal
kreisende Quelle vertikal
```

Für jede Position prüfen:

1. Sitzt die Phantomquelle stabil?
2. Wandert sie gleichmäßig?
3. Gibt es Vorne/Hinten-Verwechslungen?
4. Gibt es Links/Rechts-Spiegelung?
5. Kippt Höheninformation korrekt nach oben?

**7. Musikalischer Test**

Danach nicht nur technische Signale verwenden. Nimm 3 Referenzen:

1. Mono-Sprachsignal als bewegte Ambisonics-Quelle.
2. Atmosphärische Ambisonics-Aufnahme mit viel Diffusschall.
3. Präzise Objekte, z. B. Klick, Stimme, Percussion.

Achte auf:

```text
Lokalisation
Sweet Spot
Klangfarbe bei Bewegung
Stabilität im Zentrum
Bass-Anbindung
Höhenabbildung
```

**8. Fehlerdiagnose**

Typische Fehlerbilder:

```text
Quelle vorne klingt hinten:
Azimut/Channel-Mapping falsch.

Links und rechts vertauscht:
Speaker-Output-Mapping prüfen.

Top klingt diffus oder seitlich:
Z-Koordinate / Elevation / Speaker 17 prüfen.

Bewegung springt:
Decoder-Ordnung, Speaker-Reihenfolge oder Multi-Decoder-Übergänge prüfen.

Bass zieht räumlich:
Sub zu laut, falsche Laufzeit oder Crossover falsch.
```

**9. Abschluss-Protokoll**

Am Ende eine kurze Abnahme machen:

```text
Datum:
Decoder-Version: AmbiDecoder 3.2.0
Ambisonics-Format:
Ordnung:
Sample Rate:
Speaker-Layout:
Kalibrierpegel:
Messposition:
Auffälligkeiten:
Finale Gain-Korrekturen:
Finale Delay-Korrekturen:
Bestanden: Ja / Nein
```

Mein Vorschlag: Starte zuerst mit reinem 3rd-order Ambisonics ohne komplexe Musik, kalibriere Speaker/Delay/Sub sauber, und aktiviere danach erst die endgültige Multi-Decoder-Abstimmung. So trennst du technische Routingfehler von psychoakustischen Decoder-Effekten.