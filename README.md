<!-- vim: fo=a tw=80 colorcolumn=80 syntax=markdown :
-->

WS2812 desklight
================

Controller firmware and hardware for a very simple desklight that has
one button to cycle through a palette of colors
and one potentiometer to dim the brightness.

Controls a strip of WS2812 RGB LEDs which could e.g. be mounted at the bottom
of your desktop monitor facing down towards the desk surface.


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

Here is are a few notes:

The firmware is written for an Atmel ATTiny10.
Currently it uses more than 512B flash and an ADC, so it won't work on the
smaller variants (4/5/9).

A simple switch pulls `PIN_SWITCH` to ground when pressed. De-ringing is done
with a 100nF cap. `PIN_SWITCH` uses the internal pullup.

A potentiometer is connected between GND and VCC. The center-tap is connected to
a 10uF electrolytic cap (to smoothen the ADC value which seems very noisy at
very low CLK frequencies of the atmel uC) and via 470 Ohm to the
`PIN_POTENTIOMETER` for measurement by the ADC of the atmel uC. The resistor
makes sure that TPI programming in situ is still possible.

A WS2812 RGB LED strip (of 34 LEDs) is connected to the `PIN_LED` line.

connect a 5V 1500mA (or better 2000mA) power supply for a strip with 34 LEDs.


Ideas for expansions
--------------------

* full H/S/V lamp with three potentiometers

