---
---
* * *

Examples for the [GyrOSC.app](https://apps.apple.com/us/app/gyrosc/id418751595)
![[./_resources/ICST_AmbiPlugins_OSC-JavaScript_for_the_GyrOSC.resources/Bildschirmfoto 2022-05-09 um 14.20.10.png]]

* * *

### 01 OSC-Swarm

OSC-Message:
```
/gyrosc/1/grav
```
Command:
```
s.setXYZ(1, s.arg(2), -s.arg(1), 0); for(i = 2; i <= 8; i++) s.setXYZ(i, s.arg(2)+Math.random()*0.2, -s.arg(1) + Math.random()* 0.2, 0)
```

* * *

### 02 Pearl chain

OSC-Message:
```
/gyrosc/1/grav
```
Command:
```
s.setXYZ(1, s.arg(2), -s.arg(1), 0); for(i = 2; i <= 8; i++) s.setXYZ(i, s.x(i) + (s.x(i-1)-s.x(i))*0.1, s.y(i) + (s.y(i-1)-s.y(i))*0.1, 0)
```

* * *

### 03 OSC-Cloud

OSC-Message:
```
/gyrosc/1/grav
```
Command:
```
s.setXYZ(1, s.arg(2), -s.arg(1), 0); for(i = 2; i <= 8; i++) s.setXYZ(i, s.arg(2)+Math.random()*0.2-0.1, -s.arg(1) + Math.random()*0.2-0.1, 0)
```

* * *

### 04 OSC-Säule

OSC-Message:
```
/gyrosc/1/grav
```
Command:
```
s.setXYZ(1, s.arg(2), -s.arg(1), 0); for(i = 2; i <= 8; i++) s.setXYZ(i, s.x(i) + (s.arg(2)-s.x(i))*0.1, -s.arg(1) + 0.05*i, 0)
```

* * *

### 04 OSC-Random

OSC-Message:
```
/gyrosc/1/grav
```
Command:
```
s.setXYZ(1, s.arg(2), -s.arg(1), 0); for(i = 2; i <= 8; i++) s.setXYZ(i, s.arg(2)+Math.random()*0.2-0.1, -s.arg(1) + Math.random()*0.2-0.1, 0)
```

* * *
