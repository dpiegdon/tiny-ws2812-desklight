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

The firmware is written for an Atmel ATTiny10.
Currently it uses more than 512B flash and an ADC, so it won't work on the
smaller variants (4/5/9).

Use a simple switch that pulls `PIN_SWITCH` to ground when pressed. De-ring at
the switch using a 100nF cap. NB: `PIN_SWITCH` uses the internal pullup.

Connect a potentiometer with one end to VCC, the other to GND and the middle to
`PIN_POTENTIOMETER`.

Connect a strip of 34 (`LIGHT_COUNT`) WS2812 LEDs to `PIN_LED`.

When using TPI related pins for inputs, take care to use e.g. a 1k resistor
between the pin and the actual input signal, and connect TPI directly to the
pin. This way TPI signal integrity is maintained. Otherwise you will not be able
to program the chip in situ.


TODO
----

* Improve brightness steps. Currently only 8 brightness steps exist,
  each halfing the previous.

* Reduce idle powerconsumption by stepping down to 128KHz. Only use 8MHz during
  LED signalling.

* Redesign to use `INT0` for switch instead of `PCINT2`. This allows deeper
sleep modes (no I/O clock required, can use ADC noise reduce).

* Design small PCB.

* Idea for another project: build an H/S/V lamp with three potentiometers.


