
#include "ws2812.h"

#include <avr/wdt.h>
#include <avr/sleep.h>
#include <avr/interrupt.h>
#include <util/delay.h>

#define LIGHT_COUNT 34

#define PIN_POTENTIOMETER PB1

// NOTE: if you change PIN_SWITCH to something else than PB2,
// you can no longer use INT0 but PCINT*, and thus have to switch
// to a lower sleep mode (IDLE instead of ADC-NOISEREDUCTION)
#define PIN_SWITCH PB2

static inline void sweep(void)
{
	_delay_us(3000);
	for(uint8_t current = 1; current <= LIGHT_COUNT; ++current) {
		ws2812_set(0,0,0, current - 1);
		ws2812_set_single(255,0,0);
		ws2812_set(0,0,0, LIGHT_COUNT - current);
		_delay_us(3000);
	}
	ws2812_set(0,0,0, LIGHT_COUNT);
}

volatile uint8_t next_color = 0;
volatile uint8_t next_brightness = 255;

uint8_t decode_colormask(uint8_t val) {
	switch(val & 0b11U) {
		case 0b11U:
			return 255;
		case 0b10U:
			return 170;
		case 0b01U:
			return 85;
		case 0b00U:
		default:
			return 0;
	};
}

uint8_t get_next_color(uint8_t current_color)
{
	switch(0b00111111U & current_color) {
		case 0b00000000U:
			return 0b00111111U;
		case 0b00111111U:
			return 0b00110000U;
		case 0b00110000U:
			return 0b00111100U;
		case 0b00111100U:
			return 0b00001100U;
		case 0b00001100U:
			return 0b00001111U;
		case 0b00001111U:
			return 0b00000011U;
		case 0b00000011U:
			return 0b00110011U;
		case 0b00110011U:
		default:
			return 0b00000000U;
	};
}

int main(void)
{
	uint8_t current_brightness = 0;
	uint8_t current_attenuation = 0;
	uint8_t current_color = 0b00000000U;
	uint8_t current_r = 0;
	uint8_t current_g = 0;
	uint8_t current_b = 0;

	CCP = 0xD8; // allow writes to CLKPSR
	CLKPSR = 0; // disable prescaler => 8MHz system clock

	SMCR = 1; // set sleep-mode to ADC noise reduction

	ws2812_init();

	// prepare switch and potentiometer
	DDRB &= ~((1 << PIN_POTENTIOMETER) | (1 << PIN_SWITCH));
	PUEB = (1 << PIN_SWITCH);
	// enable interrupt for switch
	EICRA = 0b10; // trigger INT0 on falling edge
	EIMSK = 0b1; // enable INT0
	// enable ADC on potentiometer
	ADMUX  = PIN_POTENTIOMETER;	// select ADC pin
	ADCSRA = (1 << ADEN)		// enable ADC circuit
		|(1 << ADATE)		// enable ADC auto triggering
		|(1 << ADIE)		// enable ADC interrupt
		|(0b111U);		// set ADC prescaler to /128
		;
	ADCSRB = 0;			// enable free running mode

	sweep();

	ADCSRA |= (1 << ADSC);		// ADC start conversions
	wdt_enable(0b0110U); // set watchdog timeout to 1s, enable reset.
	sei();

	while(1) {
		sleep_mode();
		wdt_reset();

		cli();
		if(next_color || (current_brightness != next_brightness)) {
			if(next_color) {
				next_color = 0;
				current_color = get_next_color(current_color);
			}

			if(current_brightness != next_brightness) {
				current_brightness = next_brightness;
				current_attenuation = current_brightness >> 4;
			}

			current_r = decode_colormask((current_color >> 4)) >> current_attenuation;
			current_g = decode_colormask((current_color >> 2)) >> current_attenuation;
			current_b = decode_colormask((current_color >> 0)) >> current_attenuation;

			ws2812_set(current_r, current_g, current_b, LIGHT_COUNT);
		}
		sei();
	}
}

ISR(ADC_vect)
{
	next_brightness = ADCL;
}

ISR(INT0_vect)
{
	next_color = 1;
}

