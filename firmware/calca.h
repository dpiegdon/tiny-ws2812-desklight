
#ifndef __CALCA_H__
# define __CALCA_H__

#include "ws2812.h"

#include <avr/interrupt.h>

uint8_t decode_colormask(uint8_t mask)
{
	switch(mask & 0b111U) {
		case 0b000:
			return 0;
		case 0b001:
			return 36;
		case 0b010:
			return 73;
		case 0b011:
			return 109;
		case 0b100:
			return 146;
		case 0b101:
			return 182;
		case 0b110:
			return 219;
		default:
		case 0b111:
			return 255;
	}
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

static volatile uint8_t calca_values_changed_flag = 0;
static uint16_t calca_color = 0;
static uint8_t calca_attenuation = 255;

static inline void calca_set_new_values(void)
{
	uint8_t attenuation;
	uint16_t color;

	cli();
	{
		// locked against race conditions with ISR
		color = calca_color;
		attenuation = calca_attenuation;
		calca_values_changed_flag = 0;
	}
	sei();

	uint8_t current_r = get_channel_brightness(color >> 6, attenuation);
	uint8_t current_g = get_channel_brightness(color >> 3, attenuation);
	uint8_t current_b = get_channel_brightness(color >> 0, attenuation);
	cli();
	{
		// timing critical, interrupts may interfere
		ws2812_set(current_r, current_g, current_b, LIGHT_COUNT);
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

static uint8_t calca_choose_color = 0;

static inline void calca_next(void)
{
	calca_choose_color ^= 1;
}

static inline void calca_rotary_up(void)
{
	if(calca_choose_color)
		calca_color += 1;
	else if(calca_attenuation < 255)
			calca_attenuation += 1;

	calca_values_changed_flag = 1;
}

static inline void calca_rotary_down(void)
{
	if(calca_choose_color)
		calca_color -= 1;
	else if(calca_attenuation > 0)
			calca_attenuation -= 1;

	calca_values_changed_flag = 1;
}

#endif // __CALCA_H__

