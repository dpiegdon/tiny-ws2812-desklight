
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

enum {
	MODE_ATTENUATION = 0,
	MODE_COLOR = 1,
	MODE_SPOTWIDTH = 2,
	MODE_SPOTPOS = 3,
	MODECOUNT = 4,
} calca_modes;


static uint8_t calca_mode;
static uint16_t calca_color;
static uint8_t calca_attenuation;
static uint8_t calca_pos;
static uint8_t calca_oncount;

static void calca_set_new_values(void)
{
	uint8_t r = get_channel_brightness(calca_color >> 0, calca_attenuation);
	uint8_t g = get_channel_brightness(calca_color >> 2, calca_attenuation);
	uint8_t b = get_channel_brightness(calca_color >> 4, calca_attenuation);

	uint8_t count;
	uint8_t tail = LIGHT_COUNT - calca_pos - calca_oncount;

	for(count = calca_pos; count > 0; --count)
		ws2812_set_single(0,0,0);

	for(count = calca_oncount; count > 0; --count)
		ws2812_set_single(r,g,b);

	for(count = tail; count > 0; --count)
		ws2812_set_single(0,0,0);
}

static void calca_init(void)
{
	cli();
	{
		ws2812_init();

		calca_mode = 0;
		calca_color = 0b000001;
		calca_attenuation = MAX_ATTENUATION-1;
		calca_pos = 0;
		calca_oncount = LIGHT_COUNT;

		calca_set_new_values();
	}
	sei();
}

static inline void calca_next(void)
{
	calca_mode = (calca_mode + 1) % MODECOUNT;
}

static inline void calca_rotary_up(void)
{
	switch(calca_mode) {
		case MODE_ATTENUATION:
			if(calca_attenuation > 0)
				calca_attenuation -= 1;
			break;
		case MODE_COLOR:
			calca_color += 1;
			break;
		case MODE_SPOTWIDTH:
			if(LIGHT_COUNT > calca_pos + calca_oncount)
				calca_oncount += 1;
			break;
		case MODE_SPOTPOS:
			if(LIGHT_COUNT > calca_pos + calca_oncount)
				calca_pos += 1;
			break;
		default:
			return;
	};

	cli();
	{
		calca_set_new_values();
	}
	sei();
}

static inline void calca_rotary_down(void)
{
	switch(calca_mode) {
		case MODE_ATTENUATION:
			if(calca_attenuation < MAX_ATTENUATION)
				calca_attenuation += 1;
			break;
		case MODE_COLOR:
			calca_color -= 1;
			break;
		case MODE_SPOTWIDTH:
			if(calca_oncount > 0)
				calca_oncount -= 1;
			break;
		case MODE_SPOTPOS:
			if(calca_pos > 0)
				calca_pos -= 1;
			break;
		default:
			return;
	};


	cli();
	{
		calca_set_new_values();
	}
	sei();
}

#endif // __CALCA_H__

