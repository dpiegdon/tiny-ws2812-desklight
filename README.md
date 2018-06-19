<!-- vim: fo=a tw=80 colorcolumn=80 syntax=markdown :
-->

ATTiny10-powered WS2812 desklight
=================================

Controller firmware and hardware for a very simple desklight that has a button
and a digital encoder for color/brightness selection.

Controls a strip of WS2812 RGB LEDs which could e.g. be mounted at the bottom
edge of your desktop monitor facing down towards the desk surface.


Authors
-------

David R. Piegdon <dgit@piegdon.de>


License
-------

All files in this repository are released unter the GNU General Public License
Version 3 or later. This includes the schematic, the routed PCB and the firmware
as well as the documentation and accompanying materials. See the file COPYING
for more information.


Hardware
--------

You can find a Kicad-based schematic in the hardware directory.

The firmware is written for an Atmel ATTiny10. The latest version does not use
the ADC anymore, so an ATTiny9 should do fine, too.

Connect a 5V 1500mA (or better 2000mA) power supply for a strip with 34 LEDs.


