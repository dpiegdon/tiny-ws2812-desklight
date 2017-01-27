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

Use a simple switch that pulls `PB1` (`PIN_SWITCH`) to ground when pressed.
De-ring using a 100nF cap. NB: `PIN_SWITCH` uses the internal pullup.

Connect a potentiometer with one end to VCC, the other to GND and the middle to
`PB2` (`PIN_POTENTIOMETER`).

Connect a strip of 34 (`LIGHT_COUNT`) WS2812 LEDs to `PB0` (`PIN_LED`).

To allow in-system programming (only with TPI interface if you are using
ATTiny10), you might need to place a 1k resistor between switch and
`PIN_SWITCH`. Otherwise the extra capacitance may break the TPI signalling.


TODO
----

* Improve brightness steps. Currently only 8 brightness steps exist,
  each halfing the previous.

* Reduce idle powerconsumption by stepping down to 128KHz. Only use 8MHz during
  LED signalling.

* Redesign to use `INT0` (`PB2`) for switch instead of `PB1`. This allows deeper
sleep modes (no I/O clock required, can use ADC noise reduce).

* Design small PCB.

* For another project: build an H/S/V lamp with three potentiometers.


