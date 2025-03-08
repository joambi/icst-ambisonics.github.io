---
tags: 
title: 03_how_it_works
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

----

The ICST Ambisonics plugins are designed for an intuitive and easy-to-use workflow. 
In this tutorial, we will show you three “how it works” workflows.

To create Ambisonic content, we need the following workflow setup in our DAW:   
-  Mono sources   
- Encoder for the mono movement or placement  
- A B-format master track for bouncing or recording the encoded files  
- A decoder for decoding the B-format (encoded data) for the physical speaker arrangement or binaural (headphone) monitoring.

Overview for the easy signalflow:
  ![01_easyworkflow](01_easy_workflow.png)
This image shows a schematic representation of a paradigmatic Ambisonics workflow.

The next image shows a schematic overview of the signal flow of the ICST Ambisonics plugins.
![0_workflow_](02_workflow.png)
In the DAW Reaper, it looks like this:
![03_reaper_workflow](03_reaper_workflow.png)
-  Master output
- Decoder
- Bformat master
- Bformat (ambiX) player
- MultiEncoder with 16-channel mono source as children tracks.

Of course, you can also create your own workflow.

----
©2025 ICST