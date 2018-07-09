<!-- vim: fo=a tw=80 colorcolumn=80 syntax=markdown :
-->

ATTiny10-powered WS2812 desklight
=================================

Controller firmware and hardware for a very simple desklight that has a button
and a digital encoder for color/brightness selection.

Controls a strip of WS2812 RGB LEDs which could e.g. be mounted at the bottom
edge of your desktop monitor facing down towards the desk surface.

![PCB v1.0 bottom side photo](
https://github.com/dpiegdon/tiny-ws2812-desklight/blob/master/hardware/production/tiny-ws2812-desklight-v1.0_bottom-pcb.jpg?raw=true)

(Above: bottom side of v1.0 PCB)


Authors
-------

David R. Piegdon <dgit@piegdon.de>


License
-------

All files in this repository are released unter the GNU General Public License
Version 3 or later. This includes the schematic, the routed PCB and the firmware
as well as the documentation and accompanying materials. See the file COPYING
for more information.


Device interface
----------------

The rotary encoder has a button and can be rotated in both directions. The
button cycles through different modes. In each mode you change a different
variable by rotating the encoder:

* Mode 1: change brightness

* Mode 2: change color

* Mode 3: change number of enabled LEDs

* Mode 4: change starting position of enabled LEDs

Pressing the button for more than half a second resets all values to their
defaults.


Firmware
--------

You probably have to use a recent AVR-GCC Version for compilation. Version 5.4.0
is good, 7.3.0 yields even better results. As the ATTiny10 is very
space-constrained, older gcc versions may not optimize well enough to meet the
space-constrains with the current feature set.

If you want to change the number of lights in the firmware, please do so in
`ws2812.h`. If you know what you are doing, you can also change the assignment
to `light_count` in the firmware files (in `ws2812_init()`, `calca_init()`, if
you don't want to recompile.)

Note that you can not use more than 126 LEDs. The actual constraint is something
like `lightcount <= max_value(int8_t)-1`.


Hardware
--------

You can find a Kicad-based schematic in the hardware directory.

The firmware is written for an Atmel ATTiny10. The latest version does not use
the ADC anymore, so an ATTiny9 should do fine, too.

Connect a 5V 1500mA (or better 2000mA) power supply for a strip with 34 LEDs.

