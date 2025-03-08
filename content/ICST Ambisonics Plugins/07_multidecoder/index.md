---
date: 2025-02-02T04:14:54-08:00
draft: false
params:
  author: Johannes Schuett
weight: 10
tags: 
title:
---

# 07_MultiDecoder


Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *

We are pleased to announce the latest version (v.3.1) of our ICST Ambisonics plugins.
In this version, we have focused on a new multi-decoder and implemented the latest findings from our empirical research. Four different weightings and filter banks can be applied to four loudspeaker arrays. This results in a more differentiated sound image of the decoded result. So a new way to control the B-format and interpret it in physical space.

## What's new in 3.1

* **Decoder:**
	* New Settings Management
		* Speaker
		* Decoding
		* Filter
		* Options
		
		![Speaker_setting_managment](content/ICST%20Ambisonics%20Plugins/07_multidecoder/Speaker_setting_managment.gif)

* Multi-Decoder mode
	* Default is the ICST Decoder (Basic)
		* Channel weights:
			* Basic
			* InPhase
			* Max-rE
			* Manual
		* Ambisonics order: 1st(4ch) to 7th (64ch)!

		![decoder_weights](content/ICST%20Ambisonics%20Plugins/07_multidecoder/decoder_weights.gif)

* Multi-Decoder is a new version and allows up to 4 decoder units to be operated in parallel.
	* Activate Multi-Decoder mode
		* Channel weights:
			* Basic
			* InPhase
			* Max-rE
			* Manual
		* Ambisonics order: 1st(4ch) to 7th (64ch)
		Add up to four decoder units
			name for decoder (low, middle, high)
			
			speaker activation
			
			different orders
			
			different weights
			
			volume (+/- dB)
			
			mute
			
			bidirektional mute & solo (shift + ctrl & "M" or "S"
	
		![MultiDecoder](content/ICST%20Ambisonics%20Plugins/07_multidecoder/MultiDecoder.gif)
* Encoder:
	* Bugfixes

* OSC:
		Group manipulation with absolute angles
		![osc-decoder-euler-absolute](content/ICST%20Ambisonics%20Plugins/07_multidecoder/osc-decoder-euler-absolute.gif)

* * *



### What we now?

* Speaker settings:  \[?\] About is empty
- The website [ambisonics.ch](https://ambisonics.ch/) is temporarily unavailable.

