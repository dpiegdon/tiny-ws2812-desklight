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

You probably have to use AVR-GCC Version >= 7.3.0 for compilation. As the
ATTiny10 is very space-constrained, older gcc versions don't optimize well
enough to meet the space-constrains with the current feature set.

If you don't have an AVR-GCC optimizing well enought, but want to change the
number of lights for the supplied BIN file: a current build should be supplied
in `firmware/build/`. Open `desklight.asm` and search for `ws2812_init` or
`calca_init`. There should be some assignment to `light_count`. You need to
change this immediate value in the BIN file. e.g.:


		0000024e <calca_init()>:
			light_count = LIGHT_COUNT;
		 24e:	42 e2       	ldi	r20, 0x22	; 34
		 250:	40 a9       	sts	0x40, r20	; 0x800040 <_edata>
			DDRB |= (1 << PIN_LED);
		 252:	08 9a       	sbi	0x01, 0	; 1


So you need to replace the bytes `42 e2` at offset 0x2e4 with a command
assigning your required value to r20.

Note that you can not use more than 63 lights. The actual constraint is: `2 *
lightcount + 1 <= max_value(int8_t)/2`.


Hardware
--------

You can find a Kicad-based schematic in the hardware directory.

The firmware is written for an Atmel ATTiny10. The latest version does not use
the ADC anymore, so an ATTiny9 should do fine, too.

Connect a 5V 1500mA (or better 2000mA) power supply for a strip with 34 LEDs.

