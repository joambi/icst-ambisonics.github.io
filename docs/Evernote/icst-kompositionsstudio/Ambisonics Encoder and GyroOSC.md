---

tags: 
  - published

---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *

From version.2.2.1f you will be able to scale and edit the OSC input messages.
![[./_resources/Ambisonics_Encoder_and_GyroOSC.resources/Bildschirmfoto 2022-03-16 um 16.56.20.png]]

1. Open  'OSC RX'
2. In the 'OSC RX' choose your Port-number (default is 50001) and activate the 'Receive OSC' toggle. (show next picture)![[./_resources/Ambisonics_Encoder_and_GyroOSC.resources/Bildschirmfoto 2022-03-16 um 17.01.34.png]]![[./_resources/Ambisonics_Encoder_and_GyroOSC.resources/IMG_880207646921-1.jpeg]]
3. Open the OSC-Send tool and set the IP address and port accordingly.  (I show them the next steps using the example of the app 'GyrOSC', which they can also find in the App Store).
4. After opening 'GyrOSC', I select this setup there:![[./_resources/Ambisonics_Encoder_and_GyroOSC.resources/IMG_880207646921-1.1.jpeg]]

		'GyrOSC' sends now this OSC-messages over the port 50001 to the 'ICST Ambisonics Encoder'

* /gyrosc  = from where
* /1 = index (point-number)
* /grav = Gravity
* / x, y, z

5\. Now activate in the  'ICST Ambisonics Encoder' the 'Show OSC Log' window.
![[./_resources/Ambisonics_Encoder_and_GyroOSC.resources/Bildschirmfoto 2022-03-16 um 17.24.59.png]]
You get the OSC-messages from the 'GyrOSC'  (green frame)

6. Press 'Add' and write the following Instead of the '/demo/{i} {x} {y}'

```
/gyrosc/{i}/grav {x} {y} {z}
```

7. Activate the 'hide warnings' toggle.

![[./_resources/Ambisonics_Encoder_and_GyroOSC.resources/Bildschirmfoto 2022-03-16 um 17.42.47.png]]
Now the OSC messages are green and therefore correct!
You can now move the point-1 in the encoder.
**Hint:** To move another point, select the desired point in the 'GyrOSC' under 'Tag'.

8. For scaling of incoming OSC messages please refer to the Help file.![[./_resources/Ambisonics_Encoder_and_GyroOSC.resources/Bildschirmfoto 2022-03-16 um 17.52.35.png]]

* * *

<< [Tutorials Studiopraxis](https://icst-kompositionsstudio.ch/post/tutorials-studiopraxis)
