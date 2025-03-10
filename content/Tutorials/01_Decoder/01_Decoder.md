---
date: 2025-02-02T04:14:54-08:00
draft: false
params:
  author: Johannes Schuett
weight: 10
tags: 
title:
---

# 01_Decoder


Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *
## Decoder:
-  New Settings Management
	* Speaker
	* Decoding
	* Filter
	* Options

    ![Speaker_setting_managment](Speaker_setting_managment.gif)

----

## Multi-Decoder mode

* Default is the ICST Decoder (Basic)
	- Channel weights:
		* Basic
		* InPhase
		* Max-rE
		* Manual

- Ambisonics order: 1st(4ch) to 7th (64ch)!

	![decoder_weights](content/Tutorials/01_Decoder/decoder_weights.gif)

- ##### Multi-Decoder allows up to 4 decoder units to operate in parallel:

	- Activate Multi-Decoder mode
	- Channel weights:
	    - Basic
	    - InPhase
	    - Max-rE
	    - Manual
- Ambisonics order: 1st (4 channels) to 7th (64 channels)
- Add up to four decoder units, each with:
	- Decoder name (low, middle, high)
    - Speaker activation
    - Different orders and weights
    - Volume control (+/- dB)
    - Mute
    - Bidirectional mute & solo (Shift + Ctrl + "M" or "S")
	
	![MultiDecoder](content/Tutorials/01_Decoder/MultiDecoder.gif)
* Encoder:
	* Bugfixes

### OSC:

- Group manipulation with absolute angles

  ![osc-decoder-euler-absolute](content/Tutorials/01_Decoder/osc-decoder-euler-absolute.gif)
  
  

* * *
©2025 ICST

