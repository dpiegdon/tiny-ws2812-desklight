
#include "calca.h"

#include <avr/sleep.h>
#include <avr/interrupt.h>

#define LIGHT_COUNT 34

#define PIN_ROTARY1	PB1
#define ISR_ROTARY1	PCINT2_vect

#define PIN_ROTARY2	PB2
#define ISR_ROTARY2	PCINT2_vect

#define PIN_SWITCH	PB3
#define ISR_SWITCH	PCINT3_vect

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

	ws2812_sweep();

	sei();
}

int main(void)
{
	setup_registers();

	while(1) {
		sleep_mode();
		if(calca_values_changed())
			calca_set_new_values();
	}
}

ISR(ISR_ROTARY1, ISR_ALIASOF(ISR_ROTARY2));
ISR(ISR_ROTARY2)
{
	static uint8_t previous = (1 << PIN_ROTARY1) | (1 << PIN_ROTARY2);
	uint8_t now = PINB & ((1 << PIN_ROTARY1) | (1 << PIN_ROTARY2));

	if(0 == previous)
	{
		if(0 == (now & (1 << PIN_ROTARY1)))
			calca_up();
		if(0 == (now & (1 << PIN_ROTARY2)))
			calca_down();
	}

	previous = now;
}

ISR(ISR_SWITCH)
{
	// encoder push-down
	if(PINB & (1 << PIN_SWITCH))
		calca_next();
}

