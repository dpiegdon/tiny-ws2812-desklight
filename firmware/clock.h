
#ifndef __CLOCK_H__
# define __CLOCK_H__

#include <avr/io.h>

void clock_slow(void)
{
	CCP = 0xD8;		// allow writes to CLKPSR
	CLKPSR = 0b0001U;	// prescale with /2
	CCP = 0xD8;		// allow writes to CLKPSR
	CLKMSR = 0b01U;		// select internal 128khz oscillator
}

void clock_fast(void)
{
	CCP = 0xD8;		// allow writes to CLKPSR
	CLKPSR = 0;		// disable prescaler
	CCP = 0xD8;		// allow writes to CLKPSR
	CLKMSR = 0b00U;		// select internal 8MHz oscillator
}

#endif // __CLOCK_H__

