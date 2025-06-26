---
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

* * *

1. Download the newest CSI from here: <https://stash.reaper.fm/v/40638/CSI%20v1_0.zip>
2. Follow the installation guide here: <https://github.com/GeoffAWaddington/reaper_csurf_integrator/wiki>
3. M1 download  & installation: <https://github.com/GeoffAWaddington/reaper_csurf_integrator/wiki/Installation>
4. Mac: put the .dylib file in the same UserPlugins folder (requires Mac OS 10.12 or later).
5. In Reaper go to Options>Preferences (or just Ctrl+P) (a new window will appear).
6. Scroll down to the bottom and click on Control/OSC/web. Note: while on this screen, it is recommended to uncheck the box next to "Close control surface devices when stopped and not active application" as this will disconnect CSI when Reaper is not the focused application (unless that's what you want).
7. Now, while still on the Control/OSC/Web preferences window, click on "Add" (a new window will open).
8. Click on the empty dropdown beside "control surface mode" and select Control Surface Integrator - this will now show the settings for CSI.
9. Hint: If Control Surface Integrator is not visible, take the following steps: go to: ~/Library/Application\\ Support/REAPER/UserPlugins, then right-click this 'reaper\_csurf\_integrator.dylib', and restart Reaper.
10. There is a default Page ("HomePage") already defined to get you started. Click on the word HomePage to activate the page and see the contents.
11. Click "Add Midi", "Add OSC", or "Add EuCon". -- see more detailed instructions for EuCon below.
12. Enter the number of channels on your surface -- e.g. MCU has 8 channels. Note: if you're using a one-fader surface with a SelectedTrackNavigator, enter 0 channels here.
13. Enter the number of Sends you would like to display -- must be no more than number of channels -- e.g. for MCU 8 Sends is maximum.
14. Enter the number of FX Menu choices you would like to display -- must be no more than number of channels -- e.g. for MCU 8 FX Menu choices is maximum.
15. Select your midi in and midi out ports (however you have your surface plugged into your computer), or your Remote IP, OSC in port, and OSC out port (however your OSC device is configured). Start any OSC device apps now.
16. Choose an mst template for your Midi surface or an OSC template for your OSC surface.
17. Choose the folder where your Zone files are located, CSI will attempt to guess based on your mst/osc choice, but you can override this.
18. "OK" everything.
19. While still in Options|Preferences, if your device is MIDI, go to MIDI Devices and make sure the Surfaces you wish to use with CSI are Disabled for both Input and Output.
