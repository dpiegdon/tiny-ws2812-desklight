
#ifndef __WS2812_H__
# define __WS2812_H__

#include "clock.h"

#include <stdint.h>
#include <avr/cpufunc.h>
#include <avr/io.h>
#include <util/delay.h>

#define PIN_LED PB0

static inline void ws2812_init(void)
{
	DDRB |= (1 << PIN_LED);
}

static inline void ws2812_send_single_byte(uint8_t byte)
{
	for(uint8_t mask = 0x80; mask != 0; mask >>= 1) {
		if(byte & mask) {
			__asm__ __volatile__("sbi %0, %1 \n\t"
					     "nop \n\t"
					     "nop \n\t"
					     "nop \n\t"
					     "cbi %0, %1 \n\t"
					     :
					     : "i" (0x2), "i" (PIN_LED)
					     :
					);
		} else {
			__asm__ __volatile__("sbi %0, %1 \n\t"
					     "nop \n\t"
					     "cbi %0, %1 \n\t"
					     :
					     : "i" (0x2), "i" (PIN_LED)
					     :
					);
		}
	}
}

static inline void ws2812_set_single(uint8_t r, uint8_t g, uint8_t b)
{
	ws2812_send_single_byte(g);
	ws2812_send_single_byte(r);
	ws2812_send_single_byte(b);
}

static inline void ws2812_set(uint8_t r, uint8_t g, uint8_t b, uint8_t count)
{
	while(count) {
		ws2812_set_single(r,g,b);
		--count;
	}
}

static inline void ws2812_sweep(void)
{
	clock_fast();
	_delay_us(3000);
	for(uint8_t current = 1; current <= LIGHT_COUNT; ++current) {
		ws2812_set(0,0,0, current - 1);
		ws2812_set_single(255,0,0);
		ws2812_set(0,0,0, LIGHT_COUNT - current);
		_delay_us(3000);
	}
	ws2812_set(0,0,0, LIGHT_COUNT);
	clock_slow();
}

#endif // __WS2812_H__

