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
**In development, unsigned.** On macOS, open the app the first time with right-click › Open or remove the quarantine flag: `xattr -dr com.apple.quarantine "Animator Choreographer.app"`.
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
| System | macOS and Windows |
| Plugins | ICST Ambisonics Plugins with the Animator (AmbiEncoder_64) in REAPER |
| Optional | [Ollama](https://ollama.com) for drafting a plan from a description |
| Source | Part of the [ICST Ambi REAPER Bundle](/icst-ambisonics-plugins/19_icst_ambi_reaper_bundle/) (`Animator` folder, toolbar button *Open Animator*) |
| Licence | GPL3 |

## Further reading

The detailed guide with REAPER region import, plan from a text description and examples is in the post [Animator Choreographer – plan space choreographies and export them for the Animator](/post/icst-animator-choreographer/).
