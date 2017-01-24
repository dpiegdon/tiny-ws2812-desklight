
#include "ws2812.h"

#include <avr/wdt.h>
#include <util/delay.h>

#define LIGHT_COUNT 34

int main(void)
{
	CCP = 0xD8; // allow writes to CLKPSR
	CLKPSR = 0; // disable prescaler => 8MHz system clock

	ws2812_init();

	wdt_enable(0b0110U); // set watchdog timeout to 1s, enable reset.

	ws2812_set(255,255,255, LIGHT_COUNT);

	while(1) {
		wdt_reset();
		_delay_us(100);
	}
}

