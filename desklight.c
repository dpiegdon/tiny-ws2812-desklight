
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
		ws2812_set_single(128,0,0);
		ws2812_set(0,0,0, LIGHT_COUNT - current);
		_delay_us(2000);
	}
	ws2812_set(0,0,0, LIGHT_COUNT);
}

volatile uint8_t next_color = 0;
volatile uint8_t current_brightness = 255;

uint8_t decode_colormask(uint8_t val) {
	switch(val & 0b11) {
		case 0b11:
			return 255;
		case 0b10:
			return 170;
		case 0b01:
			return 85;
		case 0b00:
		default:
			return 0;
	};
}

uint8_t get_next_color(uint8_t current_color)
{
	switch(0b00111111 & current_color) {
		case 0b00000000:
			return 0b00111111;
		case 0b00111111:
			return 0b00110000;
		case 0b00110000:
			return 0b00111100;
		case 0b00111100:
			return 0b00001100;
		case 0b00001100:
			return 0b00001111;
		case 0b00001111:
			return 0b00000011;
		case 0b00000011:
			return 0b00110011;
		case 0b00110011:
		default:
			return 0b00000000;
	};
}

int main(void)
{
	uint8_t current_color = 0b00000000;
	uint8_t current_r = 0;
	uint8_t current_g = 0;
	uint8_t current_b = 0;

	CCP = 0xD8; // allow writes to CLKPSR
	CLKPSR = 0; // disable prescaler => 8MHz system clock

	SMCR = 0; // set sleep-mode to idle (i/o clock required for PCI0)

	PCMSK = (1 << PCINT1);
	PCICR = (1 << PCIE0);

	ws2812_init();

	// prepare switch and potentiometer
	DDRB &= ~((1 << PIN_POTENTIOMETER) | (1 << PIN_SWITCH));
	PUEB = (1 << PIN_SWITCH);

	///wdt_enable(0b0110U); // set watchdog timeout to 1s, enable reset.

	sweep();

	sei();

	while(1) {
		sleep_mode();
		//wdt_reset();

		//_delay_us(1000);
		if(next_color) {
			current_color = get_next_color(current_color);
			current_r = decode_colormask((current_color >> 4));
			current_g = decode_colormask((current_color >> 2));
			current_b = decode_colormask((current_color >> 0));
			next_color = 0;
		}
		/* TODO fix brightness here */
		ws2812_set(current_r, current_g, current_b, LIGHT_COUNT);
	}
}

/*
ISR(ADC_vect)
{
	
}
*/

ISR(PCINT0_vect)
{
	if(0 == (PINB & (1<<PIN_SWITCH)))
		next_color = 1;
}

