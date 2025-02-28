---
Created at: 2025-02-26
Last updated at: 2025-02-28
tags:
  - index
---

# What is new in v3.1


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
		* ?![[./_resources/What_is_new_in_v3.1.resources/Speaker_setting_managment.gif]]

* Multi-Decoder mode
	* Default is the ICST Decoder (Basic)
		* Channel weights:
			* Basic
			* InPhase
			* Max-rE
			* Manual
		* Ambisonics order: 1st(4ch) to 7th (64ch)![[./_resources/What_is_new_in_v3.1.resources/decoder_weights.gif]]

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
			![[./_resources/What_is_new_in_v3.1.resources/MultiDecoder.gif]]

	bidirektional mute & solo (shift + ctrl & "M" or "S"
	

* Encoder:
	* Bugfixes

* OSC:
		Group manipulation with absolute angles
		![[./_resources/What_is_new_in_v3.1.resources/osc-decoder-euler-absolute.gif]]

### 

* * *

### 

### What we now?

* Speaker settings:  \[?\] About is empty
	The website [ambisonics.ch](https://ambisonics.ch/) is temporarily unavailable.

