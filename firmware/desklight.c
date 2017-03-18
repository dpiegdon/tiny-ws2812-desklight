
#include "calca.h"

#include <avr/sleep.h>
#include <avr/interrupt.h>

#define PIN_ROTARY1	PB1
#define PIN_ROTARY2	PB2
#define PIN_SWITCH	PB3

void setup_registers(void)
{
	// set sleep-mode to idle
	SMCR = 0;

	// won't need the Timer0
	PRR |= (1 << PRTIM0);
	// disable all unneeded digital inputs
	DIDR0 = ~((1 << PIN_SWITCH) | (1 << PIN_ROTARY1) | (1 << PIN_ROTARY2));

	// prepare switch and potentiometer
	DDRB &= ~((1 << PIN_SWITCH) | (1 << PIN_ROTARY1) | (1 << PIN_ROTARY2));
	PUEB = (1 << PIN_SWITCH) | (1 << PIN_ROTARY1) | (1 << PIN_ROTARY2);
	// enable interrupt for switch and rotary encoder flags
	PCICR |= PCIE0;
	PCMSK |= (1 << PIN_SWITCH) | (1 << PIN_ROTARY1) | (1 << PIN_ROTARY2);
}

int main(void)
{
	setup_registers();
	calca_init();

	sei();

	while(1) {
		sleep_mode();
		if(calca_values_changed())
			calca_set_new_values();
	}
}

ISR(PCINT0_vect)
{
	static uint8_t previous = (1 << PIN_SWITCH)
				| (1 << PIN_ROTARY1)
				| (1 << PIN_ROTARY2);

	uint8_t  now  =  PINB & ( (1 << PIN_SWITCH)
				| (1 << PIN_ROTARY1)
				| (1 << PIN_ROTARY2));

	uint8_t triggered = now ^ previous;

	if(triggered & ((1 << PIN_ROTARY1) | ( 1 << PIN_ROTARY2))) {
		if(0 == (previous & ((1 << PIN_ROTARY1) | ( 1 << PIN_ROTARY2)))) {
			if(0 == (now & (1 << PIN_ROTARY1)))
				calca_rotary(1);
			if(0 == (now & (1 << PIN_ROTARY2)))
				calca_rotary(0);
		}
	}

	if(triggered & PIN_SWITCH) {
		// encoder push-down
		if(now & (1 << PIN_SWITCH))
			calca_next();
	}

	previous = now;
}

