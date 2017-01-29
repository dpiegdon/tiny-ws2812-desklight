
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

void clock_slow(void)
{
	CCP = 0xD8; // allow writes to CLKPSR
	CLKPSR = 0b0001U; // prescale with /2
	CCP = 0xD8; // allow writes to CLKPSR
	CLKMSR = 0b01U; // select internal 128khz WDT oscillator
}

void clock_fast(void)
{
	CCP = 0xD8; // allow writes to CLKPSR
	CLKPSR = 0; // disable prescaler
	CCP = 0xD8; // allow writes to CLKPSR
	CLKMSR = 0b00U; // select internal 8MHz oscillator
}

void setup_registers(void)
{
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
		|(0b010U);		// set ADC prescaler to /4
		;
	ADCSRB = 0;			// enable free running mode

	clock_fast();
	sweep();
	clock_slow();

	ADCSRA |= (1 << ADSC);		// ADC start conversions
	wdt_enable(0b0110U); // set watchdog timeout to 1s, enable reset.
	sei();
}

static inline uint16_t decode_colormask(uint8_t val) {
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

static uint8_t get_channel_brightness(uint8_t channelmask, uint8_t current_attenuation)
{
	uint16_t val = decode_colormask(channelmask);

	while(current_attenuation) {
		// using no fractions at this point seems ok as flickering is
		// no longer an issue here. only the linearity of the
		// potentiometer is affected, while gaining the full
		// spectrum of the potentiometer.
		val = (val * 239) / 240;
		--current_attenuation;
	}

	return val;
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

static volatile uint8_t next_color = 0;
static volatile uint16_t next_attenuation_5_3 = 0; // lower three bits are fractions

int main(void)
{
	uint8_t current_attenuation = 0;
	uint8_t current_color = 0b00000000U;
	uint8_t current_r = 0;
	uint8_t current_g = 0;
	uint8_t current_b = 0;

	setup_registers();

	while(1) {
		sleep_mode();
		wdt_reset();

		cli();
		uint8_t next_attenuation = (next_attenuation_5_3 >> 3) & 0xff;
		if(next_color || (current_attenuation != next_attenuation)) {
			ADCSRA &= ~(1 << ADSC); // stop ADC conversions
			clock_fast();
			if(next_color) {
				next_color = 0;
				current_color = get_next_color(current_color);
			}
			current_attenuation = next_attenuation;

			current_r = get_channel_brightness(current_color >> 4, current_attenuation);
			current_g = get_channel_brightness(current_color >> 2, current_attenuation);
			current_b = get_channel_brightness(current_color >> 0, current_attenuation);
			ws2812_set(current_r, current_g, current_b, LIGHT_COUNT);
			clock_slow();
			ADCSRA |= (1 << ADSC); // restart ADC conversions
		}
		sei();
	}
}


ISR(ADC_vect)
{
	// simple exponential moving average IIR filter
	// effectively this calculates: (average * 127/128 + newvalue * 1/127)
	// remembers the three most significant fractions
	// in the three least significant bits.
	next_attenuation_5_3 = ( (next_attenuation_5_3 << 5) - next_attenuation_5_3
			         + (((uint16_t)ADCL) << 3)) >> 5;
}

ISR(INT0_vect)
{
	next_color = 1;
}

