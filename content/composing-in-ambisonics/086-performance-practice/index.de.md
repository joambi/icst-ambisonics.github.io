---
title: "Konzert- und Aufführungspraxis"
description: "Technischer Rider, Vorabkommunikation mit dem Venue, Soundcheck-Logistik und häufige Fallstricke bei Ambisonics-Fixed-Media-Aufführungen."
date: 2026-01-01T00:00:00
weight: 86
draft: true
translationKey: "composing-performance-practice"
languageCode: de
---

Ein Fixed-Media-Ambisonics-Stück führt sich nicht von selbst auf. Zwischen dem Studiomaster und einer geglückten Konzertaufführung liegt eine Kette technischer Entscheidungen, Kommunikationsaufgaben und praktischer Checks, die genauso zur kompositorischen Arbeit gehören wie das Stück selbst. Je früher diese vorbereitet werden, desto weniger bleibt dem Zufall überlassen — oder der angespannten Stunde vor Einlass.

## Der Technische Rider

Der technische Rider ist das zentrale Dokument, das zwischen Komponist:in und Venue ausgetauscht wird. Er sollte gut im Voraus verschickt werden — idealerweise Wochen vor dem Konzert — und alles enthalten, was das Technikteam für Aufbau und Durchführung des Stücks braucht.

Ein minimaler Rider für ein Ambisonics-Fixed-Media-Stück umfasst:

**Playback-Datei**
- Format: AmbiX, Kanalanzahl, Samplerate, Bittiefe
- Oder: vordecodierte Mehrkanaldatei mit Kanalanzahl und Kanalreihenfolge
- Lautheit: integrierter LUFS-Wert und ob die Datei normalisiert wurde

**Lautsprecherkonfiguration**
- Erforderliche Mindestkonfiguration (z.B. Ring 8, Ring 16, Dome 24)
- Ob das Stück in einem 2D-Ring funktioniert oder Overhead-Lautsprecher benötigt
- Ob ein Subwoofer erforderlich ist und wie er gespeist werden soll

**Dekodierung**
- Wer dekodiert: Komponist:in (bringt eigenen Decoder), oder Venue (nutzt ihr System)?
- Wenn das Venue dekodiert: welcher Decoder und welche Layout-Datei soll verwendet werden?
- Wenn die Komponist:in dekodiert: welche Software, und welches Ausgabeformat wird vom Venue erwartet (MADI, AES67, Analog)?

**Playback-Software und Hardware**
- Was spielt die Datei ab: Reaper, Max/MSP, Qlab oder ähnliches?
- Wer bringt die Playback-Maschine, oder stellt das Venue eine bereit?
- Latenz- oder Synchronisationsanforderungen?

**Monitoring**
- Wird während der Aufführung ein separater Monitoring-Mix benötigt?
- Muss die Komponist:in am Mischpult sitzen, oder kann das Stück autonom laufen?

**Zeitbedarf**
- Mindestdauer des Soundchecks (realistisch: 45–90 Minuten für eine Erstaufführung in einem neuen Venue)
- Dauer des Stücks sowie allfälliges Verhalten von Stille, Ein- und Ausblendungen

---

Eine Rider-Vorlage kann aus der [ICST Ambisonics Dokumentation](/de/ICST-Ambisonics-Plugins/) übernommen oder als einfaches PDF verschickt werden. Ein klarer Rider verhindert die häufigsten Konzertprobleme, bevor sie entstehen.

## Vorabkommunikation

Den Rider verschicken — und dann nachfassen. Venues und Festivals erhalten viele technische Dokumente und lesen sie nicht immer sorgfältig. Ein kurzes Telefon- oder Videogespräch mit der technischen Leitung ein bis zwei Wochen vor dem Konzert ist oft effektiver als eine lange E-Mail-Kette. Zentrale Fragen, die vorab zu klären sind:

- Wie viele Lautsprecher hat das Array, und wie ist das genaue Layout?
- Sind alle Lautsprecher funktionstüchtig und korrekt kalibriert?
- Ist das System delay-aligned (alle Lautsprecher auf eine gemeinsame Hörposition zeitlich abgestimmt)?
- Ist der Raum akustisch behandelt, oder hat er signifikanten unbehandelten Nachhall?
- Wie ist die Playback-Strecke aufgebaut: digital (MADI, Dante, AES67) oder analog?

Wenn das Venue eine Lautsprecher-Layout-Datei (Azimut, Elevation, Distanz pro Kanal) im Voraus liefern kann, lässt sich das Stück vorab auf das exakte Array dekodieren — und man kommt mit einer abspielreifen Mehrkanal-Datei ins Konzert, statt beim Soundcheck auf den Decoder des Venues angewiesen zu sein.

## Der Soundcheck

Der Soundcheck ist der wichtigste Moment des Aufführungsprozesses. Er verdient ernsthafte Vorbereitung.

**Was in welcher Reihenfolge zu prüfen ist:**

1. **Signal-Routing** — ein Testsignal (Rosa Rauschen oder eine bekannte Quelle) abspielen und verifizieren, dass jeder Lautsprecher funktioniert und dem richtigen Kanal zugewiesen ist. Eine rotierende Rauschquelle bei 0° Elevation ist nützlich: sie sollte gleichmässig um den Ring kreisen.

2. **Pegelkalibrierung** — alle Lautsprecher sollten einen angeglichenen Schalldruckpegel haben. Viele Venues haben ihr Array bereits kalibriert; manche nicht. Als Referenz: –18 dBFS Rosa Rauschen sollte im Sweet Spot ungefähr 85 dB SPL ergeben.

3. **Decoder-Check** — wenn das Venue dekodiert, einen kurzen B-Format-Ausschnitt abspielen und bestätigen, dass das räumliche Bild den Erwartungen entspricht. Vorne sollte vorne sein, oben sollte oben sein.

4. **Kompletter Durchlauf** — wenn die Zeit es erlaubt, das gesamte Stück auf Aufführungslautstärke abspielen. Dies zeigt Resonanzen, Phasenprobleme oder Abschnitte, die sich im Venue unerwartet anders verhalten.

5. **Hörposition** — der Sweet Spot eines Ambisonics-Arrays hängt von seiner Geometrie ab. Bestätigen, wo das Publikum sitzt, und selbst von dieser Position aus hören. Klänge, die am Mischpult räumlich präzise erscheinen, können aus der Zuhörerposition anders wirken.

6. **Lautheitscheck** — auf Aufführungslautstärke und aus der Zuhörerposition prüfen, ob die Dynamik stimmt: Leise Passagen dürfen nicht unhörbar sein, Peaks nicht unangenehm laut.

**Zeitbudget:** Mindestens 45 Minuten für einen einfachen Aufbau mit vordecodierter Datei und einem kooperativen Venue. Für eine Erstaufführung in einem neuen Venue mit Live-Decoding sind 90 Minuten realistischer. Aufbauzeit vor dem eigentlichen Soundcheck einrechnen.

## Flexibilität und Fallback-Pläne

Auch mit einem sorgfältigen Rider und einem kooperativen Venue kann etwas schiefgehen. Häufige Probleme und wie man sich darauf vorbereitet:

| Problem | Prävention | Fallback |
|---------|-----------|---------|
| Falsche Kanal-Zuordnung | Eigenes Routing-Patch mitbringen; Kanalreihenfolge-Referenz | Vordecodierte Datei für mehrere gängige Konfigurationen |
| Fehlender oder defekter Lautsprecher | Kritische Lautsprecher vorab prüfen | Im Voraus wissen, welche Lautsprecher wegfallen können, ohne das räumliche Bild zu zerstören |
| Decoder des Venues nicht verfügbar | Eigenen Laptop mit Decoder mitbringen | Vordecodierte Datei für das erwartete Layout |
| Playback-Gerät defekt | Zweiten Laptop mitbringen; Backup-Festplatte | Binaural-Stereo- oder Stereo-Mix als letzter Ausweg |
| Übermässiger Raumhall | Vorab testen; Mix wenn möglich anpassen | Direkte/trockene Signalanteile erhöhen |
| Pegelabweichung | Mit Lautheit-Metadaten und Referenzaufnahme anreisen | Gesamtlautstärke am Pult anpassen |

Eine Binaural-Stereo-Backup-Datei auf einem USB-Stick hat schon manches Konzert gerettet. Es ist nicht die ideale Hörerfahrung — aber besser als Stille.

## Während der Aufführung

Bei einem vollständig autonomen Fixed-Media-Stück erfordert die Aufführung selbst wenig Eingriff: Playback beim vereinbarten Cue starten, Pegel beobachten, sauber beenden. Einige praktische Punkte:

- **Während der Aufführung im Raum sitzen**, nicht am Technikpult. Hören, was das Publikum hört.
- **Den Startcue klar kommunizieren** — mit dem Techniker:innen-Team: ein Countdown, ein visuelles Signal oder ein schriftliches Cue-Sheet.
- **Keinen Pegeleingriff während des Stücks** vornehmen, ausser etwas ist ernsthaft falsch. Pegeländerungen mitten in einer Aufführung sind meist störender als ein leicht zu lautes oder zu leises Moment.
- **Den Notausschalter kennen** — wenn die Playback-Software abstürzt oder Audio ausfällt, sauber stoppen können, statt Stille unkontrolliert andauern zu lassen.

## Dokumentation nach dem Konzert

Nach der Aufführung festhalten:

- Welche Playback-Datei verwendet wurde (Dateiname, Datum, Format)
- Welche Lautsprecherkonfiguration und Decoder-Einstellung genutzt wurden
- Anpassungen beim Soundcheck
- Reaktion des Publikums und räumliche Elemente, die nicht wie erwartet funktionierten
- Technische Probleme und wie sie gelöst wurden

Diese Dokumentation fliesst direkt in die [Raumpartitur](/de/composing-in-ambisonics/075-raumpartitur/) und den [Archivierungsprozess](/de/composing-in-ambisonics/084-formats-archiving/) zurück: Sie zeigt, ob das Stück ausserhalb des Studios standhält, welche räumlichen Zonen fragil sind und was für die nächste Aufführung oder künftige Produktionen geändert werden sollte.
