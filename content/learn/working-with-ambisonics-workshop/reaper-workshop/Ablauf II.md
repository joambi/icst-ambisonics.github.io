---
categories:
  - ICST Ambisonics Workshop
---
---
**Dozentenfassung**

**ICST Ambisonics Workshop im Studio**  
4 Stunden | realistische Durchführung | Dozent:innen-Guide

**Ziel des Workshops**  
Die Teilnehmenden sollen am Ende:
- eine Ambisonics-Session im Studio lesen und prüfen können
- Aufnahme-Logik und A/B-Format sicher unterscheiden
- die richtige Formatentscheidung im ICST-Kontext treffen
- den Gesamtworkflow von Vorbereitung bis Export benennen und anwenden

**Didaktische Leitlinie**  
Nicht alles zeigen. Wenige Dinge klar, hörbar und praktisch verankern.

---

**Materialliste**

**Pflichtmaterial**
- vorbereitete REAPER-Session / Template
- funktionierender ICST Encoder / Decoder
- aktives Lautsprecherpreset des Studios
- binauraler Monitoring-Pfad
- 1 bis 2 kurze Testsignale oder Monoquellen
- 1 plausibles Aufnahmebeispiel
- 1 problematisches oder absichtlich fehlerhaftes Beispiel

**Aus deinen Ordnern besonders geeignet**
- Wahrnehmungs-/Bewegungsbeispiele aus [README_Perception.md](/Volumes/T7_Audio/2026_ICST_Ambisonics_Workshop/Perception/README_Perception.md)
- Setup-/Routing-Logik aus [MaxReaper_Ambisonics_Doku.md](/Volumes/T7_Audio/2026_ICST_Ambisonics_Workshop/MaxReaper/MaxReaper_Ambisonics_Doku.md)
- Lautsprecherpreset aus [Speakers_Kompositionsstudio.txt](/Volumes/T7_Audio/2026_ICST_Ambisonics_Workshop/ICST%20Speaker-Settings/Speakers_Kompositionsstudio.txt)
- Grundlagen- und Formattext aus [index.de.md](/Users/jschuet1/GitHub/icst-ambisonics.github.io/content/learn/working-with-ambisonics-workshop/index.de.md) und [ambisonics-formats/index.de.md](/Users/jschuet1/GitHub/icst-ambisonics.github.io/content/learn/ambisonics-formats/index.de.md)

**Optional**
- ein absichtlich falsch geroutetes Projekt
- ein Beispiel für Format-/Ordering-Mismatch
- Whiteboard oder Karten für Workflow-Reihenfolge

---

**Zeitplan 00:00-04:00**

**0. Einstieg und Hörfokus**  
`00:00-00:15`

**Ziel**
- Aufmerksamkeit sammeln
- Ambisonics als Szene und nicht als Lautsprechertrick setzen
- die vier Leitfragen einführen

**Hoerbeispiele**
- statische Quelle frontal
- dieselbe Quelle mit klarer Bewegung

**Dozent:innen-Cue**
- "Hoeren Sie nicht auf den Lautsprecher, sondern auf die wahrgenommene Szene."
- "Was veraendert sich wirklich: Richtung, Distanz, Bewegung oder nur Pegel?"

**Teilnehmenden-Aufgabe**
- pro Beispiel je ein Wort notieren zu:
  - Ortung
  - Bewegung
  - Naehe/Ferne
  - Stabilitaet

**Wichtig**
- keine lange Theorie
- Beispiele kurz halten, je 20 bis 30 Sekunden

---

**1. How to work with and prepare for ambisonics**  
`00:15-01:00`

**Ziel**
- die technische Logik des Setups verankern
- Session-Vorbereitung als entscheidenden Schritt zeigen

**Inhalt**
- `Source -> Encoder -> Bformat Master -> Decoder -> Speakers`
- Unterschied zwischen Szene und Wiedergabe
- Monitoring vs. Export
- Ordnung und Kanalzahl
- Decoder-Preset
- typische Fehlerquellen

**Hoerbeispiele**
- Testquelle vorne
- kurze Rotation
- absichtlicher Fehlerfall

**Dozent:innen-Cues**
- "Wo im System liegt die Szene?"
- "Der Decoder erzeugt nicht die Komposition, sondern übersetzt sie."
- "Wenn das Setup hier nicht stimmt, wird alles danach unscharf."

**Teilnehmenden-Aufgabe**
1. Signalkette skizzieren
2. markieren:
   - Wo liegt das B-Format?
   - Wo beginnt das Decoding?
1. Im Fehlerbeispiel sagen:
   - Encoder?
   - HOA-Bus?
   - Decoder?
   - Monitoring?

**Puffer-Hinweis**
Wenn Fragen aufkommen, lieber hier Zeit investieren und später kürzen. Dieser Block ist der wichtigste technische Sockel.

---

**2. How to record ambisonics**  
`01:00-01:35`

**Ziel**
- Aufnahme-Logik verstaendlich machen
- A-Format / B-Format praktisch trennen

**Inhalt**
- A-Format als Rohsignal
- B-Format als Produktionssignal
- A-to-B-Konversion
- Mikrofonposition und Perspektive
- Monitoring waehrend der Aufnahme
- QC und Metadaten

**Hoerbeispiele**
- ein gutes Beispiel
- ein problematisches Beispiel

**Dozent:innen-Cues**
- "A-Format ist noch nicht die fertige Szene."
- "Die Konversion ist kein Nebenschritt, sondern zentral."
- "Wenn Richtung instabil wirkt, ist das ein Warnsignal."

**Teilnehmenden-Aufgabe**
- Welche Infos muessen dokumentiert werden?
- Woran koennte man eine schlechte Konversion hoeren?
- Was waere vor Ort euer erster Kontrollschritt?

**Optional nur wenn Zeit**
- kurzer Mikrofonvergleich
- Diskussion verschiedener Aufnahmeszenarien

**Bei Verzug streichen**
- ausfuehrliche Mikrofonuebersicht

---

**Pause**  
`01:35-01:45`

---

**3. Which file formats to use**  
`01:45-02:15`

**Ziel**
- sichere Formatentscheidung fuer die Praxis

**Inhalt**
- A-Format
- B-Format
- ambiX
- FuMa
- ACN/SN3D
- Ordnung und Kanalzahl

**Dozent:innen-Cues**
- "Die Frage ist nicht nur: Ist das B-Format?"
- "Praeziser: Welche Konvention, welche Ordnung, welche Kanalzahl?"
- "Im ICST-Kontext ist ambiX mit ACN/SN3D der sichere Default."

**Teilnehmenden-Aufgabe**
1. Was ist Rohmaterial?
2. Was ist Produktionsmaster?
3. Welche Konvention waehlt ihr fuer eine neue Session?
4. Welche Angaben muessen dokumentiert werden?

**Hoerbeispiel**
- optional ein kurzer Mismatch-Fall

**Wichtig**
- diesen Block straff halten
- keine Formatgeschichte, nur Entscheidungswissen

---

**4. Overall workflow**  
`02:15-02:45`

**Ziel**
- die einzelnen Teile zu einer Gesamtlogik verbinden

**Inhalt**
- `Record -> Convert -> Organize -> Produce -> Monitor -> Decode -> Export -> Verify`

**Dozent:innen-Cues**
- "Der Fehler passiert oft nicht im Plugin, sondern im Uebergang zwischen zwei Schritten."
- "Monitoring und Delivery sind nicht dasselbe."
- "Der Workflow ist die eigentliche Kompetenz."

**Teilnehmenden-Aufgabe**
- Schritte in die richtige Reihenfolge bringen
- zwei kritische Fehlerstellen markieren
- in einem Satz formulieren:
  - Was ist der Unterschied zwischen Monitoring und Export?

**Hilfsmittel**
- Whiteboard
- Karten
- oder einfache Liste am Screen

**Bei Zeitdruck**
- diesen Block nicht streichen
- lieber nur knapper moderieren

---

**5. Gefuehrte Studio-Uebung**  
`02:45-03:35`

**Ziel**
- die vier Leitfragen an einer konkreten Session anwenden

**Arbeitsform**
- Einzelarbeit oder Zweiergruppen
- nur eine vorbereitete Uebung
- keine offene freie Komposition

**Empfohlene Uebung**
`Workflow Check + kleine Raumgeste`

**Aufgabenfolge**
1. Session oeffnen
2. Signalkette pruefen
3. Ordnung und Kanalzahl benennen
4. Decoder-Preset pruefen
5. Monitoring pruefen
6. Quelle korrekt platzieren oder kurz bewegen
7. benennen:
   - In welchem Format arbeiten wir?
   - Was waere der Master?
   - Was waere nur Monitoring?
8. sagen, wie der korrekte Exportweg aussieht

**Dozent:innen-Cues**
- "Nicht sofort klicken, zuerst lesen."
- "Welche Information braucht ihr, bevor ihr einen Export macht?"
- "Ist die Bewegung klar oder nur technisch vorhanden?"

**Teilnehmenden-Ergebnis**
Jede Gruppe soll am Ende kurz sagen:
- was technisch geprueft wurde
- welche Entscheidung wichtig war
- wo eine Fehlergefahr lag

**Optional wenn es sehr gut laeuft**
- eine kleine 15-30 Sekunden Raumbewegung bauen

**Bei Verzug streichen**
- alles Kreative zuerst
- der Workflow-Check bleibt, die Mini-Geste ist optional

---

**6. Praesentation und Abschluss**  
`03:35-04:00`

**Ziel**
- Transfer sichern
- Ergebnisse kurz spiegeln
- die vier Leitfragen schliessen

**Ablauf**
- 2 bis 4 Gruppen praesentieren kurz
- pro Gruppe etwa 2 Minuten
- danach 1 kurzer Feedbackpunkt

**Feedbackfragen**
- Was war technisch klar?
- Wo war die groesste Fehlerquelle?
- Welche Entscheidung war fuer den Workflow zentral?

**Abschluss-Cues**
- "Was wuerdet ihr vor der naechsten Session immer zuerst pruefen?"
- "Was nehmt ihr als wichtigste Unterscheidung mit?"
- "Wo im Workflow passieren die gefaehrlichsten Missverstaendnisse?"

**Takeaways fuer die Schlussfolie**
- Ambisonics ist szenenbasiert
- B-Format ist nicht der Lautsprecher-Output
- A-Format und B-Format muessen sauber getrennt gedacht werden
- ambiX / ACN / SN3D ist der sichere ICST-Default
- gute Workflows verhindern die meisten spaeteren Fehler

---

**Empfohlene Hoerbeispiel-Anzahl**

Realistisch fuer 4 Stunden:
- `6 bis 8` Hoerbeispiele insgesamt

Empfehlung:
- 2 im Einstieg
- 2 in Block 1
- 1 bis 2 in Block 2
- 0 bis 1 in Block 3
- Rest aus der Übung oder den Praesentationen

Mehr wird fast sicher zu viel.

---

**Wo du Puffer brauchst**

Die größten Zeitrisiken sind:
- technische Rückfragen zum Routing
- Wiederholung von Hörbeispielen
- Unsicherheit bei A-Format / B-Format
- Gruppenarbeit mit unterschiedlichem Tempo

Wenn du kürzen musst, dann hier:
1. Mikrofonvergleich kürzen
2. Formatblock radikal straffen
3. Kreative Mini-Geste optional machen

Nicht kuerzen wuerde ich:
- Block 1 Setup / Preparation
- Block 4 Overall Workflow
- den gefuehrten Praxischeck

---

**Mein ehrliches Fazit**
Diese Fassung ist in 4 Stunden realistisch, wenn du diszipliniert moderierst und bei einer gefuehrten Uebung bleibst. Sie ist deutlich belastbarer als die fruehere, breitere Version.

Wenn du willst, schreibe ich dir jetzt noch eine **ultrakurze 1-Seiten-Moderationskarte** mit nur:
- Uhrzeit
- Cue
- Beispiel
- Aufgabe
- Zeitreserve.