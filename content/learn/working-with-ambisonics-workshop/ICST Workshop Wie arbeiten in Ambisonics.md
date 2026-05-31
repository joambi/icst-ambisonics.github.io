---
categories:
  - ICST Ambisonics Workshop
description: ICST Ambisonics Workshop (4H)
date: 2026-05-19T11:20:00
draft: true
build:
  render: never
  list: never
created: 2026-05-17
---
---

### A: Overall workflow
- [ ] How Ambisonics works

![[Pasted image 20260515123225.png]]

----
### B: How to record ambisonics

![[Pasted image 20260517111220.png]]

- [ ] Workflow (praxis with Zylia) --> Main Reaper
	- [ ] Short Recording session
	- [ ] A to B Converting
		- [ ] A-Format (PCM Audio)
		- [ ] B-Format (Mathematical format)
	- [ ] Listening B-Format
	- [ ] Upsampling & FX
	- [ ] Mastering B-Format
- [ ] Gewitter Zylia Recording (example)

---
### Composers Workflow

- [ ] The three stages of work in ambisonics (simple) 
![[Pasted image 20260517110852.png|697]]
	- [ ] **Encoding** --> Where is the sound in 3D space?
	- [ ] **Processing** --> Rotation, movement, reverb, spatial sound, etc.
	- [ ] **Decoding** --> How do I play this track on my audio system?


![[Pasted image 20260517111845.png]]

---
### C: Reaper Workflow
[🎛 Open Reaper session]()
- [ ] Open workflow & Overview
- [ ] Encoding 
- [ ] Processing 
	- [ ] Fuma to AmbiX
- [ ] Decoding
	- [ ] MultiDecoder
	- [ ] Binaural

---
### D: External to Reaper
- [ ] Workflow with MaxMSP
- [ ] Workflow with Csound (Cabbage.app)
- [ ] Workflow with Max for Live

### E: Csound 

Cabbage

![[Pasted image 20260518160110.png]]

- Additive Synth & Random Example

----

### F: MaxMSP

![[Pasted image 20260518160535.png]]

- ACT-Tool Example
---

### G: Composer Discoussion
- [Themen](obsidian://open?vault=icst-ambisonics.github.io&file=content%2Flearn%2Fworking-with-ambisonics-workshop%2Freaper-workshop%2FComposer%20Fragen%20erg%C3%A4nzend)



> [!Tip]
> In the case of a multichannel file, **Mono (left)** usually means: **Channel 1** of the item is played back in mono.
> 
> If you want to create a new mono file from this:
> 
> 1. Set **Channel mode → Mono (left)** as described above.
> 2. Right-click on the item.
> 3. Select **Glue items**.
> 
> REAPER will then create a new mono audio file from Channel 1.