---
title: gyrosc
date: 2025-05-28T14:57:00
author: Johannes Schuett
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

---

ICST MultiEncoder and iOS [GyrOSC.app ](https://www.bitshapesoftware.com/instruments/gyrosc/)

**GyrOSC** is a lightweight utility that sends motion sensor data (from your iPhone, iPod Touch, or iPad) over a local wireless network to any OSC-compatible host application. It allows you to control live audio or video applications using your device's built-in gyroscope, accelerometer, compass, and altimeter.

![GyrOSC](content/post/gyrosc/gyrOSC.png)

The following GIF demonstrates how the ICST AmbiEncoder receives OSC data from the GyrOSC app.

 ![Example video:](content/post/gyrosc/GyroOSC_Demo.gif)
 
 ### How it works:
This tutorial is a short step-by-step guide on how to use the iOS app 'GyrOSC' with the ICST Ambisonics Encoder.

### How It Works:

This tutorial provides a step-by-step guide on using the iOS app _GyrOSC_ with the ICST Ambisonics Encoder.

#### Setting Up the GyrOSC App:

1. Download the [GyrOSC app](https://apps.apple.com/us/app/gyrosc/id418751595).
2. Configure the app as follows:
    - Enable _Gravity_ (disable all other sensors).

 ![Gyro_01](content/post/gyrosc/Gyro_grav.jpeg)
#### OSC Configuration in GyrOSC App:

1. Enter the IP address of your machine in field (1).
2. The default port number for the ICST Ambisonics Encoder is 50001 (field 2).
3. Choose the index (source-number) for the plugin in field (3).
4. Field (4) shows the OSC message sent by GyrOSC.

![GyrOSC_Config](content/post/gyrosc/Gyro_Config.jpeg)

The GyrOSC app will send the 'Gravity' data via OSC (port 50001) to the ICST MultiEncoder.

### Setting Up the ICST Ambisonics Encoder Plugin:

![Reaper_GyrOSC](content/post/gyrosc/Reaper_GyrOSC.png)

1.  Open the ICST AmbiEncoder_64 plugin.
2. Access the Encoder Settings.
3. Open the _OSC IN_ section and enable OSC-IN (port: 50001).
4. Double-click in the _OSC-Message_ field and enter:

    `/gyrosc/{i}/grav {x} {y} {z}`
    
5. Enable the plugin by selecting _en_.
6. Move your iPhone to generate motion data.

---

# Inspirations:

### OSC-Swarm

**OSC-Message:**

`/gyrosc/1/grav`

JS-Code:

`s.setXYZ(1, s.arg(2), -s.arg(1), 0); for(i = 2; i <= 8; i++) s.setXYZ(i, s.arg(2)+Math.random()*0.2, -s.arg(1) + Math.random()* 0.2, 0)`

![OSC-Swarm](content/post/gyrosc/GyrOSC-SWARM.gif)


---
©2025 ICST




