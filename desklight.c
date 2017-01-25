
#include "ws2812.h"

#include <avr/wdt.h>
#include <avr/sleep.h>
#include <avr/interrupt.h>
#include <util/delay.h>

#define LIGHT_COUNT 34

#define PIN_POTENTIOMETER PB2
#define PIN_SWITCH PB1

static inline void sweep(void)
{
	for(uint8_t current = 1; current <= LIGHT_COUNT; ++current) {
		ws2812_set(0,0,0, current - 1);
		ws2812_set_single(32,0,0);
		ws2812_set(0,0,0, LIGHT_COUNT - current);
		_delay_us(1000);
	}
	ws2812_set(0,0,0, LIGHT_COUNT);
}

typedef uint8_t color[3];

color white   = {255,255,255};
color red     = {255,0,0};
color yellow  = {255,255,0};
color green   = {0,255,0};
color cyan    = {0,255,255};
color blue    = {0,0,255};
color magenta = {255,0,255};
color gray    = {16,16,16};

color *colorlist[8] = {
	&gray,
	&white,
	&red,
	&yellow,
	&green,
	&cyan,
	&blue,
	&magenta
};

volatile uint8_t next = 0;
uint8_t current_color = 0;
uint8_t current_brightness = 255;

int main(void)
{
	CCP = 0xD8; // allow writes to CLKPSR
	CLKPSR = 0; // disable prescaler => 8MHz system clock

	SMCR = 1; // set sleep-ode to ADC noise reduction

	PCMSK = (1 << PCINT1);
	PCICR = (1 << PCIE0);

	ws2812_init();

	// prepare switch and potentiometer
	DDRB &= ~((1 << PIN_POTENTIOMETER) | (1 << PIN_SWITCH));
	PUEB = (1 << PIN_SWITCH);

	//wdt_enable(0b0110U); // set watchdog timeout to 1s, enable reset.

	sweep();

	sei();

	while(1) {
		sleep_mode();
		wdt_reset();

		//_delay_us(1000);
		color *c = colorlist[current_color];
		ws2812_set((*c)[0],
			   (*c)[1],
			   (*c)[2],
			   LIGHT_COUNT);
		if(next) {
			current_color = (current_color + 1) & 0x07;
			next = 0;
		}
	}
}

ISR(ADC_vect)
{
	
}

ISR(PCINT0_vect)
{
	if(PINB & (1<<PIN_SWITCH))
		next = 1;
}

