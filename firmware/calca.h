
#ifndef __CALCA_H__
# define __CALCA_H__

#include "ws2812.h"

#include <avr/interrupt.h>

#define ATTENUATION(x) ( (x) * 15 / 16 )
// given the above formula using integers, there are this many
// attenuations that are distinct (plus one, which is NO attenuation '0')
#define MAX_ATTENUATION 53

static inline uint16_t decode_colormask(uint8_t mask)
{
	switch(mask & 0b11U) {
		case 0b00:
			return 0U;
		case 0b01:
			return 64U;
		case 0b10:
			return 128U;
		default:
		case 0b11:
			return 255U;
	}
}

static uint8_t get_channel_brightness(uint8_t channelmask, uint8_t current_attenuation)
{
	uint16_t val = decode_colormask(channelmask);

	while(current_attenuation) {
		val = ATTENUATION(val);
		--current_attenuation;
	}

	return val;
}

static uint8_t calca_choose_color;
static uint16_t calca_color;
static uint8_t calca_attenuation;

static void calca_set_new_values(void)
{
	ws2812_set( get_channel_brightness(calca_color >> 0, calca_attenuation),
		    get_channel_brightness(calca_color >> 2, calca_attenuation),
		    get_channel_brightness(calca_color >> 4, calca_attenuation),
		    LIGHT_COUNT );
}

static void calca_init(void)
{
	cli();
	{
		ws2812_init();
		ws2812_sweep();

		calca_choose_color = 0;
		calca_color = 0b11;
		calca_attenuation = MAX_ATTENUATION;

		calca_set_new_values();
	}
	sei();
}

static inline void calca_next(void)
{
	calca_choose_color = !calca_choose_color;
}

static inline void calca_rotary_up(void)
{
	if(calca_choose_color)
		calca_color += 1;
	else if(calca_attenuation > 0)
		calca_attenuation -= 1;
	else
		return;

	cli();
	{
		calca_set_new_values();
	}
	sei();
}

static inline void calca_rotary_down(void)
{
	if(calca_choose_color)
		calca_color -= 1;
	else if(calca_attenuation < MAX_ATTENUATION)
		calca_attenuation += 1;
	else
		return;

	cli();
	{
		calca_set_new_values();
	}
	sei();
}

#endif // __CALCA_H__

