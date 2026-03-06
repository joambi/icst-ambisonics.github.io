---
title: "Ambisonic Mixing in Reaper | DXARTS: Digitale Kunst und experimentelle Medien | Universität von Washington"
source: "https://dxarts.washington.edu/wiki/ambisonic-mixing-reaper"
author:
published:
created: 2026-01-15
description: "Springen Sie Zu:"
tags:
  - "clippings"
---
Springen Sie Zu:

- [Grundlagen](https://dxarts.washington.edu/wiki/#basics)
- [Hardware-Ausgabe-Routing](https://dxarts.washington.edu/wiki/#hw-routing)
- [Track Routing, Channel Count, Sendet, Empfängt](https://dxarts.washington.edu/wiki/#track-routing)
- [Mixer Track Layouts und Metering](https://dxarts.washington.edu/wiki/#track-layouts)
- [Ordner](https://dxarts.washington.edu/wiki/#folders)
- [Einrichten von Ordnern](https://dxarts.washington.edu/wiki/#folder-setup)
	- [Durch Ordner mischen](https://dxarts.washington.edu/wiki/#folders-mixing)
- [Decoderspuren](https://dxarts.washington.edu/wiki/#decoder-tracks)
- [Rendering your mix](https://dxarts.washington.edu/wiki/#rendering)
- [Plugin-Routing](https://dxarts.washington.edu/wiki/#plugin-routing)
- [Tipps und Tricks](https://dxarts.washington.edu/wiki/#tips)

## Grundlagen

Einige der ersten Dinge, die Sie festlegen möchten, sind:

- Klicken Sie mit der rechten Maustaste auf die Timeline "Ruler" über dem Spurfenster und wählen Sie die gewünschten Zeitnotationen aus. Wahrscheinlich **Minuten: Sekunden**
- Siehe **Menü>Optionen>Snap/Grid**, um die Rasteranzeige oder das Einschnappen zu deaktivieren, oder die erweiterten Snap- und Rastereinstellungen im Dialog **Snap/Grid festlegen...**
- Wählen Sie oder **Befehlstaste+T**, um Ihre erste Spur hinzuzufügen und mit der Einrichtung Ihrer Kanalanzahl und des Routings zu beginnen.

## Hardware-Ausgabe-Routing

Als nächstes müssen Sie Audio auf Ihre Hardware leiten. Es gibt ein paar verschiedene Ansätze, um Ihren Mix (Decode) an Ihre Lautsprecher zu senden:

- Eine typische Strategie besteht darin, durch die Master-Spur zu mischen, um Ihren Ausgabemix (Decode) an Ihre Lautsprecher oder Kopfhörer weiterzuleiten; Reaper ist so angeordnet, dass er dieses Paradigma unterstützt.
- \* **Empfohlen** \* Individuelle Tracks und Folder-Tracks haben den Vorteil von etwas mehr Routing-Flexibilität und, was wichtig ist, die Flexibilität für hohe Kanalzahlen. (Mehr dazu in Ordnern und Decoder Tracks unten.)

Egal, ob Sie die Master-Spur, eine Ordnerspur oder normale Tracks für Auditing-Submixe oder verschiedene Decodes verwenden, das Routing-Setup ist das gleiche:

![Zwei Möglichkeiten, Routing-Einstellungen für eine Spur zu öffnen](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/routing-open-dialog-labeled.png?itok=ZTlAcmVS "Zwei Möglichkeiten, Routing-Einstellungen für eine Spur zu öffnen")

Ein Dialog öffnet sich mit verschiedenen Spureinstellungen, aber für die Hardwareeinstellung, schauen Sie sich einfach das untere linke Dropdown-Menü an. Sie können mehrere Hardware-Sendungen hinzufügen, ihre Sendestufen anpassen, stummschalten und löschen. Stellen Sie sicher, dass Sie alle Ihre Track-Kanäle an Ihre Hardware senden. Sie können auch eine Teilmenge der Kanäle an die Hardware senden. Sehen Sie sich das Dropdown-Menü im Bild an:

![Hinzufügen, Ändern, Entfernen von Hardware-Sends](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/routing-hw-labeled.png?itok=s0s91RgO "Hinzufügen, Ändern, Entfernen von Hardware-Sends")

## Track Routing, Channel Count, Sendet, Empfängt

Sie werden aus dem obigen Bild feststellen, dass das Routing-Fenster verschiedene zusätzliche Spursteuerelemente freilegt, darunter:

- **Master/Mutter senden**: Dis/Enables durch Routing zum Master-Track oder Ordner-Track in dem Fall, dass sich die Spur in einem Ordner befindet.
- **Track Volume**: Bequem für die Einstellung eines bestimmten dB-Werts, anstatt nur den Track-Fader zu verwenden.
- **Panning/Width** Schwenk-/Breitenwerte: Am besten nicht für Mehrkanal-Audio
- **Sends** to other tracks: Senden Sie die Ausgabe von diesem Track an andere Tracks, Pre- oder Post-Fader, Pre- oder Post-FX, mit unabhängiger Sendeebene an jeden Send.
- **Receives** from other tracks: Zeigt an, welche anderen Tracks an den aktuellen Track gesendet werden. Sie können die Empfangseinstellungen ändern, die wiederum die Sendeeinstellungen aus dem Quelltrack ändern. Das Hinzufügen eines Empfangs zu einem Zielspur ist identisch mit dem Hinzufügen des Sendens zum Quelltrack.
- **Hardware-Ausgänge**: Senden Sie Audio für diese Spur direkt an bestimmte Hardwarekanäle mit den gleichen Steuerelementen wie ein Track-Send.
![Spur-Routing-Steuerelemente](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/track-folder-routing-labeled.png?itok=sSPmdnP9 "Spur-Routing-Steuerelemente")

Nachdem Sie die richtige Anzahl von Track-Kanälen aktiviert haben, spielen Sie Ihr Audio ab, um sicherzustellen, dass Sie die richtige Anzahl von Audiokanälen sehen, die in Ihrer Spur gemessen werden. Wenn nicht, überprüfen Sie, ob Ihre Track-Routing-Einstellungen die richtige Anzahl von Kanälen angeben (siehe Track Routing).

## Mixer Track Layouts und Metering

Die standardmäßigen Mixer-Spurlayouts eignen sich nicht sehr gut für die Überwachung von Mehrkanal-Audio. Und für Multichannel-Mischprojekte gibt es eine Reihe von Steuerelementen, die nicht benötigt werden, wie Phase, Schwenken, Trimmen, Eingabe-Routing und Datensatzsteuerungen. Wir haben speziell Mixer-Track-Layouts entwickelt, die Sie für Mehrkanal-Mischen nützlich finden können.

Diese Layouts sind im MultiChanMix-Theme verfügbar, das Sie herunterladen können [hier](https://github.com/ambisonictoolkit/atk-reaper/raw/3bffec9e80d8be3e7e18c1791361b6c0c8f948cf/installer/shared/ColorThemes/MultiChanMix.ReaperThemeZip).

Dies ist das gleiche wie das Standard-Theme, aber mit diesen zusätzlichen Track-Layout-Optionen hinzugefügt. Wenn Sie noch nicht im MultiChanMix-Theme sind, wechseln Sie zu diesem Thema:

![Wählen Sie MultiChanMix-Theme aus](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/theme-select-theme.png?itok=57zr0tRH "Wählen Sie MultiChanMix-Theme aus")

Nachdem Sie nun das richtige Design haben (dies wird durch Reaper-Neustarts fortgesetzt), klicken Sie mit der rechten Maustaste auf eine Spur oder wählen Sie mehrere Spuren aus, um eine Gruppe von Spuren zu ändern. Klicken Sie mit der rechten Maustaste und wählen Sie **„Track-Layout festlegen>Mixer-Panel>MultiChan-Mix - \*. \*“** wird entweder:

- **Groß**: ähnlich wie beim Standard-Spurlayout, mit unnötigen Steuerelementen und einem höheren Füllstandsmesser oder
- **Wide Meter**: Meter, die so breit wie möglich gemacht sind, um viele Kanäle in einer Strecke zu sehen
![Wählen Sie ein Mixer-Track-Layout](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/track-layout-select-layout.png?itok=d_n64P-N "Wählen Sie ein Mixer-Track-Layout")

Dieses Beispiel zeigt 2 Ordnerspurstrukturen, eine mit einem 4-Kanal-Signalpfad, eine andere mit einem 16-Kanal-Signalpfad. Beachten Sie die Sichtbarkeit einzelner Kanalebenen:

Spielen Sie Ihr Audio ab, um sicherzustellen, dass Sie die richtige Anzahl von Audiokanälen sehen, die in Ihrer Spur gemessen werden. Wenn nicht, überprüfen Sie, ob Ihre Track-Routing-Einstellungen die richtige Anzahl von Kanälen angeben (siehe [Track Routing](https://dxarts.washington.edu/wiki/#track-routing)). Überprüfen Sie außerdem, ob die Mehrkanalmessung auf Ihrer Spur aktiviert ist, indem Sie mit der rechten Maustaste auf die Spur klicken (nicht auf den Pegelmesser selbst) und wählen Sie **Mehrkanal-Spurmessung** aus:

![`](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/metering-multichannel.png?itok=o-tqvOMm "Klicken Sie mit der rechten Maustaste auf die Spur und wählen Sie Mehrkanal-Spurmessung")

## Ordner

Beachten Sie, dass das obige Bild Tracks zeigt, die koloriert sind und zwei verschiedene Track-Layout-Stile verwenden. Die Layouts und Farben helfen, die Ordnerstruktur der Mischsitzung zu verdeutlichen.

#### Was sind Folder?

Ordner sind nützlich, um Mehrkanalspuren auf eine gemeinsame Spur zu leiten, ähnlich einem Bus oder dem Master-Track. **Ein Ordner ist eine Spur**, aber mit einigen hilfreichen Unterschieden. Ein Ordnertrack ist konzeptionell wie ein Elterntrack, und die Tracks "in", in denen Folder wie Kinder sind:

- Die Ausgabe der Kinder (post-FX) wird automatisch (summiert) durch den Ordner geleitet und nicht die Master-Spur gesendet
- Beim Stummschalten oder Solonieren der Folder-Spur werden die Kinder gedeckt/Soloed
- Der Volume-Fader der Folder-Spur fungiert als Master-Volume für die Mischung der Kinder

Genau wie eine normale Spur kann die Folder-Spur eine FX-Kette enthalten, kann zu anderen Spuren oder zu Hardware-Ausgängen weitergeleitet werden.

#### Einrichten von Ordnern

Um einen Ordner zu erstellen, wird eine Spur als Ordnerspur ausgewählt, dann eine oder mehrere folgend (aufeinanderfolgende!) Die Spuren werden durch diese Strecke geführt. Um dies zu tun:

- Mit der Maus über das Ordnersymbol der Spur, um als Ordner zu aktivieren, wird das Symbol zu einem „+“ und klicken Sie dann zum Aktivieren. Jeder Track danach ist jetzt "in" (durchgeleitet) dieser Ordnerspur.
- Um die letzte "Kind"-Spur im Ordner auszuwählen, klicken Sie auf das Ordnersymbol der letzten Spur, das in den Ordner aufgenommen werden soll, bis das Symbol ein "X" (zweimal) ist, und klicken Sie dann erneut, um die Ordnergrenze abzuschließen. Alle Tracks danach behalten ihre frühere Ordner- / Sitzungsstruktur.
![Wählen Sie eine Spur aus, um die Folder-Spur ("Mutter") zu sein](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/folders-start-folder-labeled2.png?itok=UyElOaGZ "Wählen Sie eine Spur aus, um die Folder-Spur ("Mutter") zu sein") ![Wählen Sie eine Spur aus, um das letzte "Kind" im Ordner zu sein ](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/folders-end-folder-labeled.png?itok=YrZuWyut "Wählen Sie eine Spur aus, um das letzte "Kind" im Ordner zu sein")

Im Track Panel werden unter der Ordnerspur untergeordnete Tracks eingerückt. Sie können die Kinderspuren mit dem kleinen Dreieck oben rechts im Bedienfeld der Folder-Spur erweitern und einklappen:

![Track-Panel zeigt Ordnerausdehnungen und Ein-/Ausbausteuerungen](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/folders-track-labeled.png?itok=5eLJ34MH "Track-Panel zeigt Ordnerausdehnungen und Ein-/Ausbausteuerungen")

Im Mixer-Panel sind die Ordner mit einem Ordnersymbol gekennzeichnet, und das letzte Kind hat eine abgerundete Kante auf die Spurnummernbezeichnung:

![Mischer-Panel zeigt Ordnerausdehnungen](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/folders-mixer-panel-labeled.png?itok=ftgs0WLl "Mischer-Panel zeigt Ordnerausdehnungen")

Beachten Sie auch, dass eine Wellenform auf der Zeitleiste der Ordnerspur dargestellt wird, die eine Anzeige der summierten Kinderspuren darstellt.

Schließlich ist es nützlich, eine Ordnerspur und ihre Kinder auf eine einzigartige Farbe einzustellen. Wählen Sie einen oder mehrere Spuren aus, klicken Sie mit der rechten Maustaste, um zu färben:

![Wählen Sie einen oder mehrere Titel aus, klicken Sie mit der rechten Maustaste, um zu färben](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/track-layouts-colorize.png?itok=agkadG4q "Wählen Sie einen oder mehrere Titel aus, klicken Sie mit der rechten Maustaste, um zu färben")

...sowie die Ordnerspuren auf einen anderen Layout-Stil als ihre Kinder zu setzen, wodurch sie visuell gruppiert erscheinen:

![Distinguish Folder from child tracks with different Layouts](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/track-layout-folder-style-labeled.png?itok=WMPfUvJL "Distinguish Folder from child tracks with different Layouts")

#### Mixing through Folders (Parent) Tracks

You can use Folders as groups for submixes of instruments. A simple example would be to use a Folder for a sub mix of a drumset, which uses many mics, each with separate effects, and the Folder volume gives you Volume, Mute and Solo control over the drum mix. You could put a compressor on the full drum mix by placing the effect on the Folder track.

You can use Folders as busses for multichannel audio to capture, for example, all Third Order Ambisonic material before routing a folder to different decoder tracks (like a UHJ, or 7.1, or speaker array decoder). You can then monitor and render stems from the Folder tracks for different output formats, such as native TOA, stereo, and 7.1, all independently of one another.

Folders can be nested in other folders, in which case the nested folders are the topmost folder's children.

#### An example of a nested folder might be:

- 4 mono microphones capture instruments in a space, while an Eigenmike captures the full scene.
- The 4 mono microphone tracks have TOA encoders in the FX chain, and so output TOA signals. They are placed "in" a 16-channel Folder track called "Mics" so their outputs are all summed into that Folder track.
- The Eigenmike is its own 16-channel track
- An effect track is added that has a TOA Reverb in its FX chain.
- A send is added on the "Mics" Folder track to the Reveb Track for independent control over the amount sent to the reverb.
- The "Mics" Folder track (with it's children mic tracks), Eigenmike track, and Reverb track are placed "in" another Folder that is the "TOA Master" Folder. All child tracks and folders are therefore summed into the "TOA Master" Folder track.
- " TOA Master " Folder track can...
- then be routed directly out to hardware for auditioning through an outboard decoder, and/or
	- have a decoder plugin added to the track to decode the TOA mix in the track itself, and/or
	- send to one or more other tracks which may have various decoder plugins in their FX chain. Continue reading the next section for more information about decoder tracks.

## Decoder Tracks

As mentioned in the previous section, it can be convenient to have multiple decoders in your session, each on their own tracks.

If your FOA or HOA mix is bussed through a "B-format Master" Folder track, you can add track sends from this Folder track to one or more tracks that have decoders in their FX chain. This has many advantages:

- These decoder tracks would send to the hardware outputs according to their type of decoding. For example,
- a UHJ decode may be set to stereo speakers
	- an HRTF decode may be sent to headphone outputs from the audio interface
	- a 5.1 decode may get sent to a 5.1 surround system
	- the TOA mix may be sent to a dedicated decoding system run on another computer or piece of hardware
- Each decoder track could be muted, solo'ed, and have levels adjusted independently.
- Additionally, each decoder track can be selected for (stem) rendering to a desired output format, without changing the core routing setup of the session. Read on for instrunctions on how to render your mix.

## Rendering your mix

You may want to render your b-format mix into various formats, say, native FOA/HOA, Stereo UHJ, and an HRTF decode for headphone playback. If you've used decoder tracks, as described in the previous section, you'll want to create Stem Renders for each of your decoders.

**Note:** if you're using the Master track to mix and render your session, **you can only render up to 8 tracks**. For rendering higher channel counts, you'll need to use a regular track as your master (most easily a Folder track, as discussed throughout this tutorial), and do a Stem render of that track.

Before rendering, confirm that you have all of your track and channel routing correct, plugins enabled or disabled as needed in your final mix, check that your tracks are not clipping, and that you're running at the sample rate you expect for your final mix (if you don't plan to re-sample in the rendering process).

Select the track you want to render, then choose **Menu>File>Render...** or Option+r to open the rendering dialog. The first option is Sources, which, for the decoder track mixing method we're using, you'll want to select Stems (Selected tracks). In the following dropdown, you'll select the bounds you'd like to render. If you've selected a region in the timeline, you could render just that Time Selection, or the entire project (up to the last bit of audio data), a custom start and end point, etc. Note the **Tail** option, to add time at the end of your render bounds, in for example there may be a plugin's reverb tail to account for.

![Render source and bounds options](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/render-source-bounds.png?itok=Pzi0M0KA "Render source and bounds options")

The file render path is straightforward, and also provides options such as wildcard names in the case that you're rendering multiple tracks/stems at once.

Confirm your sample rate settings. If you'll be resampling, you can choose various resampling modes and you have the option to add dither and noise shaping in the case of resampling and bit resolution changes.

**Important:** If you're rendering a multichannel track (stem), check **Multichannel tracks to multichannel files**. This ensures you'll render all of your channels.  In this case the selection in the  **Channels** dropdown is overridden (this pertains only to the Master track).

Choose your file format and bit depth. Note that if you have a long project with a high channel count, you can select a **Large files** option to best suit what you'd like to do in the case that you'll have a file size that exceeds the WAV file format (4GB).

![Render options](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/render-options.png?itok=hTLOCv2u "Render options")

Lastly, you can either render the project file(s) immediately, or add to a render queue, in which case you can return to your session to make edits to the project to render with different mix settings, etc, add that state to the render queue, open another session, add that to the render queue, etc. and render all of these in one go later, while you get some coffee.

## Plugin routing

Multichannel plugins require some attention to how they are routed in Reaper.

Plugins specify their own channel counts, both inputs and outputs. When you add a plugin to your track, you want to make sure that your track has as many channels as your plugin uses. For example an FOA stereo decoder plugin may define four inputs (FOA signal) and just two outputs (Stereo decoded signal). Similarly, an FOA planewave encoder plugin may specify one input (mono audio) and 4 outputs (FOA signal). In both cases, your track needs to have at least as many channels as the maximum number of input or output channels in your plugins— **four** in the case of both examples mentioned. Add a plugin to your track, open its interface window, and nore a button at the top righ that says "X in X out". This shows the number of ins and outs specified by the plugin.

![Plugin routing and matrix settings](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/plugin-routing-4i2o-labeled.png?itok=LEi5sWGn "Plugin routing and matrix settings")

If you click on this button, a "Plug-in pin connector" (routing matrix) window will open (above), showing how audio is routed from the track (numbers on the left, **1-4**) into the plugin (letters on the top row, left matrix, **W, X, Y, Z**), out of the plugin (letters on the top row, right matrix, **L, R**), and out of the plugin back into the track (number on the righ, **1-4**)—or following plugins.

You can select or de-select "pins" in the matrix to add, remove, or re-route channels in and out of the plugin. However, defaults are typically what you want to stick with.

### Unused channels in the Plug-in pin connector

Note in the above image that the output of the plugin (right matrix) shows track channels 3 and 4 get no routing assignment. This is OK in the case of JS plugins, which will simply send silence out to tracks 3 and 4. These channels are unused anyway in the FX chain after the plugin does its processing, because it outputs stereo.

**WARNING:** If the above plugin were a **VST**, the behavior would be different! Because the plugin doesn't output anything to channels 3 and 4, VST behavior is such that the  *inputs 3 and 4 are forewarded to outputs 3 and 4.* The stereo output in channels 1 and 2 are still a proper UHJ decode and can be used as such, but just know that there will be data on channels 3 and 4 that will need to be either silenced or discarded through routing down the processing chain.

### Missing channels in the Plug-in pin connector

When adding a multichannel soundfile or a multichannel plugin to a track, the track channel count will automatically update to accomodate as many channels as is required by the soundfile or plugin. However, if you later change the channel count of the track to be *less* than the specified channel count in the plugin, the missing channels will not be routed into the plugin. This error will be visible in the pin connector button in the plugin interface:

![Track channel and plugin channel mismatch](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/plugin-routing-io-mismatch-labeled.png?itok=lfdsg48H "Track channel and plugin channel mismatch")

The in and out channel counts are indicated in the form of **numTrackChannels/ExpectedTrackChannels**. In this example, the plugin expects 4 channels in and out, but the track is set to only 2 channels. To correct this, you can change the channel count in the Track's Routing dialog, or simple click the '+' button on the pin connector matrix to add the number of channels needed for the plugin. Note this will also change the track channel count.

![Correct the plugin channel mismatch](https://dxarts.washington.edu/sites/dxarts/files/styles/large/public/plugin-routing-io-mismatch-correct-labeled.png?itok=-7vgzfKW "Correct the plugin channel mismatch")

## Tips and Tricks

Plugins

- **Shift+Click** on a plugin in a mixer track panel to **bypass** it.
- **Option+Click** on a plugin in a mixer mixer track panel to **remove** it.

Routing

- **Shift+Click** on a send (hardware or track send) in a mixer track  panel to **mute** it.
- **Option+Click** on a send (hardware or track send) in a mixer track panel to **remove** it.
- **Option+Click** on the 'M' in the routing section of a mixer track to en/disable master/parent routing

Layout

- Resize a group of tracks in either the track or mixer window: **Select tracks, option+resize one track in the selection.**
- Resize all of tracks in either the track or mixer window: **cmd+resize one track.**

Envelopes

- Logarithmic (fader) scaling on envelope views: **Preferences>Track/Send Defaults>Scaling for new volume envelopes>Volume fader scaling**
- Change envelope volume range: **Preferences>Envelope Display>Volume envelope range**
- Double-clicking an envelope point sets it to the parameter's default value

Faders / Meters

- Change fader range: **Preferences>Track Control Panels**
	- Reset meter peak indicators on play/seek (useful for resetting clipped meters autmatically)
- VU meters: change min/max meter values and update rate
	- Volume/pan faders: change fader max/min levels

Playback

- No scrubbing sound with cursor seek: P **references>Mouse Modifiers>Context drop down menu>"Edit cursor handle">set "Default action" to No action.**