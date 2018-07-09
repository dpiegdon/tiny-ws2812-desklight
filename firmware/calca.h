
#ifndef __CALCA_H__
# define __CALCA_H__

#include "ws2812.h"

#include <avr/interrupt.h>

// this is the same as (((x)*15)/16), but does not require software-multiplication:
#define ATTENUATION(x) ( (((x)<<4) - (x)) / 16 )

// given the above formula using integers, there are this many
// attenuations that are distinct (plus one, which is NO attenuation '0')
#define MAX_ATTENUATION 53

static inline uint8_t decode_colormask(uint8_t mask)
{
	uint8_t ret = mask << 6;
	if(ret == 192)
		ret = 255;
	return ret;
}

static uint8_t get_channel_brightness(uint8_t channelmask, uint8_t current_attenuation)
{
	uint16_t val = decode_colormask(channelmask);
	while(current_attenuation--)
		val = ATTENUATION(val);
	return val;
}

enum calca_modes {
	MODE_ATTENUATION = 0,
	MODE_COLOR = 1,
	MODE_SPOTWIDTH = 2,
	MODE_SPOTPOS = 3,
	MODECOUNT = 4,
};

static uint8_t calca_mode;
static uint8_t calca_color;
static int8_t calca_attenuation;
static uint8_t calca_pos;
static uint8_t calca_width;

static void calca_set_new_values(void)
{
	uint8_t r = get_channel_brightness(calca_color >> 0, calca_attenuation);
	uint8_t g = get_channel_brightness(calca_color >> 2, calca_attenuation);
	uint8_t b = get_channel_brightness(calca_color >> 4, calca_attenuation);

	uint8_t calca_offpos = calca_pos + calca_width;
	uint8_t head_on = (calca_offpos > light_count) ? (calca_offpos % light_count) : 0;
	int8_t head_off = calca_pos - head_on;
	int8_t tail_on = calca_width - head_on;
	int8_t tail_off = light_count - head_on - head_off - tail_on;

	cli();
	{
		int8_t i;

		for(i = head_on; i > 0; --i)
			ws2812_set_single(r, g, b);

		for(i = head_off; i > 0; --i)
			ws2812_set_single(0, 0, 0);

		for(i = tail_on; i > 0; --i)
			ws2812_set_single(r, g, b);

		for(i = tail_off; i > 0; --i)
			ws2812_set_single(0, 0, 0);
	}
	sei();
}

static void calca_init(void)
{
	ws2812_init();

	calca_mode = MODE_ATTENUATION;
	calca_color = 0x3;
	calca_attenuation = MAX_ATTENUATION-1;
	calca_pos = 0;
	calca_width = light_count;

	calca_set_new_values();
}

static inline void calca_button(void)
{
	calca_mode++;
	calca_mode %= MODECOUNT;
}

static int8_t check_bounds(int8_t value, int8_t lower, int8_t higher)
{
	return (value < lower) ? lower :
		(value > higher) ? higher :
		value;
}

#if LIGHT_COUNT > 126
# error Only <= 126 lights are supported
#endif

static inline void calca_rotary_step(int8_t dir)
{

	switch(calca_mode) {
		case MODE_ATTENUATION:
			calca_attenuation = check_bounds(calca_attenuation + dir, 0, MAX_ATTENUATION);
			break;
		case MODE_COLOR:
			calca_color += dir;
			break;
		case MODE_SPOTWIDTH:
			calca_width = check_bounds(calca_width + dir, 1, light_count);
			break;
		default:
		case MODE_SPOTPOS:
			int16_t new_pos;
			new_pos = calca_pos;
			new_pos += light_count;
			new_pos += dir;
			while(new_pos > light_count)
				new_pos -= light_count;
			calca_pos = new_pos;
			break;
	};

	calca_set_new_values();
}

#endif // __CALCA_H__

