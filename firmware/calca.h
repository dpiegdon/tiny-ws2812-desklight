
#ifndef __CALCA_H__
# define __CALCA_H__

#include "ws2812.h"

#include <avr/interrupt.h>

#define ATTENUATION(x) ( (x) * 15 / 16 )
// given the above formula using integers, there are this many
// attenuations that are distinct (plus one, which is NO attenuation '0')
#define MAX_ATTENUATION 53

static inline uint8_t decode_colormask(uint8_t mask)
{
	static const uint8_t brightness_map[4] = {0, 64, 128, 255};
	return brightness_map[mask&3];
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
static uint16_t calca_color;
static int8_t calca_attenuation;
static int8_t calca_pos;
static int8_t calca_oncount;

static void calca_set_new_values(void)
{
	uint8_t r = get_channel_brightness(calca_color >> 0, calca_attenuation);
	uint8_t g = get_channel_brightness(calca_color >> 2, calca_attenuation);
	uint8_t b = get_channel_brightness(calca_color >> 4, calca_attenuation);

	int8_t count;
	int8_t tail = LIGHT_COUNT - calca_pos - calca_oncount;

	for(count = calca_pos; count > 0; --count)
		ws2812_set_single(0,0,0);

	for(count = calca_oncount; count > 0; --count)
		ws2812_set_single(r,g,b);

	for(count = tail; count > 0; --count)
		ws2812_set_single(0,0,0);
}

static void calca_init(void)
{
	ws2812_init();

	calca_mode = 0;
	calca_color = 0x1;
	calca_attenuation = MAX_ATTENUATION-1;
	calca_pos = 0;
	calca_oncount = LIGHT_COUNT;

	cli();
	{
		calca_set_new_values();
	}
	sei();
}

static inline void calca_next(void)
{
	calca_mode++;
	calca_mode %= MODECOUNT;
}

static uint8_t check_bounds(uint8_t value, uint8_t lower, uint8_t higher)
{
	return (value < lower) ? lower :
		(value > higher) ? higher :
		value;
}

static inline void calca_rotary_step(int8_t dir)
{
	switch(calca_mode) {
		case MODE_ATTENUATION:
			calca_attenuation += dir;
			if(calca_attenuation<0)
				calca_attenuation=0;
			else if(calca_attenuation > MAX_ATTENUATION)
				calca_attenuation = MAX_ATTENUATION;
			break;
		case MODE_COLOR:
			calca_color += dir;
			break;
		case MODE_SPOTWIDTH:
			calca_oncount = check_bounds(calca_oncount + dir, 0, LIGHT_COUNT);
			break;
		default:
		case MODE_SPOTPOS:
			calca_pos = check_bounds(calca_pos + dir, 0, LIGHT_COUNT);
			break;
	};

	cli();
	{
		calca_set_new_values();
	}
	sei();
}

#endif // __CALCA_H__

