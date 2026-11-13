---
title: Animator Choreographer
date: 2026-11-12T00:00:00
weight: 86
draft: false
toc: true
type: docs
translationKey: animator-choreographer-docs
docs_nav_id: animator-choreographer
docs_nav_label: Animator Choreographer
description: "Desktop app that builds scene XML for the ICST Animator in five steps: groups, gestures, relations and REAPER regions as sections."
---

Level: Advanced | Audience: Composers, sound designers | **Works with:** [ICST Animator](/icst-ambisonics-plugins/11_animator/)

The **Animator Choreographer** is a desktop app for planning how groups of sources move through space over time. You describe the choreography in listening terms (direction, distance, height, gesture). The app turns it into the scene XML that the [Animator](/icst-ambisonics-plugins/11_animator/) imports and plays in the ICST AmbiEncoder_64.

{{< notice warning >}}
**Evaluation beta, unsigned.** macOS 15 and later: open the app, close the message, then go to **System Settings › Privacy & Security › Open Anyway** and confirm with your password. Up to macOS 14, Ctrl-click › Open on first launch is enough. Alternative in Terminal: `xattr -dr com.apple.quarantine "Animator Choreographer.app"`. Windows: SmartScreen › **More info › Run anyway**.
{{< /notice >}}

![The Form step in the Animator Choreographer: sections, room size and encoder on the left, top view, side view and timeline on the right](/images/icst-animator-choreographer-form.jpg)

## Where it fits in the workflow

1. Optionally export the regions or markers of your REAPER project as CSV.
2. Plan the choreography in the app: import sections, adjust groups and gestures.
3. Export the scene as XML.
4. Import the XML in the [Animator](/icst-ambisonics-plugins/11_animator/) and play it.

## The five steps

1. **Form**: title, duration and sections of the piece, importable from REAPER regions.
2. **Groups**: the groups of sources that move together.
3. **Gestures**: the movement of each group in each section, in listening terms.
4. **Relations**: how the groups relate to each other.
5. **Check & export**: check the plan and write the XML.

## Requirements

| Item | Details |
|------|---------|
| System | macOS 11+ (Universal), Windows 10/11 (x64), Linux x86_64 (glibc 2.35+) |
| Plugins | ICST Ambisonics Plugins with the Animator (AmbiEncoder_64) in REAPER; tested with 3.2.0.9 |
| Optional | [Ollama](https://ollama.com) for drafting a plan from a description |
| Source | [Release on GitHub](https://github.com/joambi/animator-choreographer/releases/tag/v0.1.0); the macOS app is also included in the [ICST Ambi REAPER Bundle](/icst-ambisonics-plugins/19_icst_ambi_reaper_bundle/) (`Animator` folder, toolbar button 16 *Open Animator*) |
| Licence | GPL-3.0 |
| Source code | [joambi/animator-choreographer](https://github.com/joambi/animator-choreographer) |

## Download

{{< release "animator-choreographer" >}}

Tested with ICST Ambisonics Plugins 3.2.0.9, not yet with 4.0.0. The macOS `.pkg` has not yet been installed on a test machine; until then the ZIP is the safe choice. Windows and Linux have so far only been built, installed and started in GitHub Actions, not on a machine with REAPER.

## Further reading

The detailed guide with REAPER region import, plan from a text description and examples is in the post [Animator Choreographer – plan space choreographies and export them for the Animator](/post/icst-animator-choreographer/).
