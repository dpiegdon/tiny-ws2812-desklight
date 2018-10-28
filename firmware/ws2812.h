
#ifndef __WS2812_H__
# define __WS2812_H__

#include <stdint.h>
#include <avr/cpufunc.h>
#include <avr/io.h>
#include <util/delay.h>

#define PIN_LED PB0
#define PORT_LED ((&PORTB)-__SFR_OFFSET)

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
					     "nop \n\t"
					     "nop \n\t"
					     "cbi %0, %1 \n\t"
					     :
					     : "i" (PORT_LED), "i" (PIN_LED)
					     :
					);
		} else {
			__asm__ __volatile__("sbi %0, %1 \n\t"
					     "nop \n\t"
					     "cbi %0, %1 \n\t"
					     "nop \n\t"
					     "nop \n\t"
					     :
					     : "i" (PORT_LED), "i" (PIN_LED)
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

#endif // __WS2812_H__

