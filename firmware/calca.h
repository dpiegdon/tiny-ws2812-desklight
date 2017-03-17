
#ifndef __CALCA_H__
# define __CALCA_H__

#include "clock.h"
#include "ws2812.h"

static inline uint16_t decode_colormask(uint8_t val)
{
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

static volatile uint8_t calca_values_changed_flag;
static volatile uint8_t next_color = 0;
static volatile uint16_t next_attenuation_5_3 = 0; // lower three bits are fractions

static inline void calca_set_new_values(void)
{
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

static inline void calca_init(void)
{
	ws2812_init();
	ws2812_sweep();
}

static inline uint8_t calca_values_changed(void)
{
	return calca_values_changed_flag;
}

void calca_next(void)
{
	
}

void calca_up(void)
{
	
}

void calca_down(void)
{
	
}

#endif // __CALCA_H__

