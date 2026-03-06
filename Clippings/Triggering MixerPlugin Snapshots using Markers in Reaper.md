---
title: "Triggering Mixer/Plugin Snapshots using Markers in Reaper"
source: "https://www.haroon.audio/blog/2016/7/5/triggering-mixerplugin-snapshots-using-markers-in-reaper#comments-577c0614ebbd1aa40ee8cd59="
author:
  - "[[Haroon Thantrey]]"
  - "[[Maria]]"
  - "[[Duss]]"
  - "[[Aaron]]"
published: 2016-07-05
created: 2026-01-14
description: "Long time no see...  Hi again, been a long time since i've written a Blog post and a lot of things have happened. I'm know working at Rebellion as a Junior Audio Designer which is pretty sweet. Part of this change however meant making the leap between DAWs from Pro Tools to Reaper, which I've totall"
tags:
  - "clippings"
---
### Long time no see...

Hi again, been a long time since i've written a Blog post and a lot of things have happened. I'm know working at Rebellion as a Junior Audio Designer which is pretty sweet. Part of this change however meant making the leap between DAWs from Pro Tools to Reaper, which I've totally fallen in love with and wish i had switched sooner, it's phenomenal. As part of my transition i've had to work out ways to replicate my old workflow. Here's how I have managed to use Snapshots in Reaper and have them triggered through the Markers of the timeline, allowing for easy mixing of multiple sounds of the same type that perhaps share the same effects chains or elements, but have slight mix tweaks from each one.

A few people in the Gameaudio Slack group were interested in this, so I decided to do a quick writeup.

## 1.) Setting up Snapshots

So first thing you're going to need to do is install [SWS extensions](http://www.sws-extension.org/) which I would strongly recommend every Reaper user does as it gives countless extra actions that I find useful every day. One of these includes that snapshot automation feature. You can pull up the window for this by finding "Open Snapshots Window" in your actions menu.

Once you do that you'll be presented with the following window;

From here, simply make your first mix, and then hit the New button. Before doing this you can also decide how much or how little information is going to be stored by using the tick boxes below the New button. With your first mix snapshot saved you can make any alterations safe in the knowledge that the original mix can be recalled at a moments notice.

From here you can make as many mixes as you need, saving each one sequentially.

![](https://images.squarespace-cdn.com/content/v1/54b50e18e4b07fae9545d698/1467747547990-P0F63Z3SLDXY165SBIZP/image-asset.jpeg?format=100w)

Mix 1

![Mix 2](https://images.squarespace-cdn.com/content/v1/54b50e18e4b07fae9545d698/1467747607003-WT3TMELNXCTRYFGB54OK/image-asset.jpeg?format=100w)

Mix 2

Dies an sich ist unglaublich nützlich für A / B-Ideen und hält Mixe für mehrere verschiedene Sounds in einem Projekt... aber was wäre, wenn wir ihren Rückruf automatisieren könnten?

## 2.) Abrufen von Snapshots mit Markern

Marker sind ein ziemlich Standard-Feature von Reaper, aber wenn Sie nicht auf sie gestoßen sind, platzieren sie einfach eine Markierung auf der Zeitlinie, die leicht zu sehen ist, und springen zu. Sie sind auch insgeheim sehr mächtig, da Sie jede Aktion von einem Marker aus auslösen können, indem Sie den Namen dieses Befehls im Namen des Markers platzieren.

Das erste, was zu tun ist, wäre also, die Befehls-ID für die Aktion zu erhalten, die wir ausführen möchten, in unserem Fall wäre das die Aktion, die an Snapshot 1 erinnert, es ist "\_SWSSNAPSHOT\_GET1". Diese finden Sie auf jeder einzelnen Aktion in der Aktionsliste.

![](https://images.squarespace-cdn.com/content/v1/54b50e18e4b07fae9545d698/1467748673531-NHJAWCNCYAR44ZJQ6V78/image-asset.jpeg?format=100w)

Jetzt doppelklicken wir einfach auf unseren Marker und fügen diese Befehls-ID in den Namen ein und setzen ein "!" Symbol am Anfang.

![](https://images.squarespace-cdn.com/content/v1/54b50e18e4b07fae9545d698/1467748994267-J5GLRAZ5W3YF1QG8H4TK/image-asset.jpeg?format=100w)

Wenn der Abspielkopf nun die Markierung in der Zeitleiste passiert, wird der ihm zugewiesene Snapshot automatisch geladen.

Danke fürs Lesen und ich hoffe, das hat geholfen! Fühlen Sie sich frei zu kommentieren oder kontaktieren Sie uns, wenn Sie Fragen haben oder einfach nur Game Audio sprechen möchten.

Haroon

UPDATE: Eine Sache, die ich vergessen habe, ist, dass diese Methode derzeit nicht für Standard-Offline-Rendering funktioniert. Hoffentlich wird das bald behoben!