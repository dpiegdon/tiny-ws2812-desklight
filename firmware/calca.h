
#ifndef __CALCA_H__
# define __CALCA_H__

#include "clock.h"
#include "ws2812.h"

#include <avr/interrupt.h>

static uint8_t decode_colormask(uint8_t mask)
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
static uint8_t calca_brightness = 255;

static inline void calca_set_new_values(void)
{
	uint8_t brightness;
	uint16_t color;

	cli(); // so we don't need volatile for more vars, also prevents race condition
	{
		// also only copying values to local improves responsiveness, as
		// interrupts can trigger during new generation of values
		calca_values_changed_flag = 0;
		color = calca_color;
		brightness = calca_brightness;
	}
	sei();

	clock_fast();
	uint8_t current_r = get_channel_brightness(color >> 6, brightness);
	uint8_t current_g = get_channel_brightness(color >> 3, brightness);
	uint8_t current_b = get_channel_brightness(color >> 0, brightness);
	cli();
	{
		// timing critical, interrupts may interfere
		ws2812_set(current_r, current_g, current_b, LIGHT_COUNT);
	}
	sei();
	clock_slow();
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

static uint8_t calca_chose_color=0;

void calca_next(void)
{
	calca_chose_color += 1;
}

void calca_rotary(uint8_t up)
{
	if(calca_chose_color) {
		if(up)
			calca_color += 1;
		else
			calca_color -= 1;
	} else {
		if(up) {
			if(calca_brightness < 255)
				calca_brightness += 1;
		} else {
			if(calca_brightness > 0)
				calca_brightness -= 1;
		}
	}

	calca_values_changed_flag = 1;
}

#endif // __CALCA_H__

