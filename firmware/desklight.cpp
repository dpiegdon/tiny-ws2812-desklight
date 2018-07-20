
#include "calca.h"

#include <avr/sleep.h>
#include <avr/interrupt.h>

#define PIN_ROTARY1	PB1
#define PIN_ROTARY2	PB2
#define PIN_SWITCH	PB3

#define ROTARY_MASK ((1 << PIN_ROTARY1) | ( 1 << PIN_ROTARY2))
#define SWITCH_MASK (1 << PIN_SWITCH)
#define EVENT_MASK (ROTARY_MASK | SWITCH_MASK)

static inline void setup_registers(void)
{
	CCP = 0xD8;		// allow writes to CLKPSR
	CLKPSR = 0;		// disable system clock prescaler

	// set sleep-mode to idle
	SMCR = 0;

	// won't need the Timer0 or ADC
	PRR = (1 << PRADC) | (1 << PRTIM0);

	// disable all unneeded digital inputs
	DIDR0 = ~EVENT_MASK;

	// prepare switch and potentiometer
	DDRB &= ~EVENT_MASK;
	PUEB = EVENT_MASK;

	// enable interrupt for switch and rotary encoder flags
	PCICR |= (1 << PCIE0);
	PCMSK |= EVENT_MASK;
}

int main(void)
{
	setup_registers();
	calca_init(); // activates interrupts

	uint8_t previous_io = EVENT_MASK;

	while(1) {
		sleep_mode(); // will return once interrupted by ISR.

		uint8_t current_io = PINB & EVENT_MASK;
		uint8_t changed_io = (current_io ^ previous_io);

		if((changed_io & ROTARY_MASK) && (0 == (previous_io & ROTARY_MASK))) {
			calca_rotary_step( (current_io & (1 << PIN_ROTARY2)) ? 1 : -1);
		} else if(changed_io & SWITCH_MASK) {
			if(!(current_io & SWITCH_MASK)) {
				// switch push-down event
				calca_button();
				// start timer0 for measurement of time
				// until button-release
				PRR = (1 << PRADC);
				TCCR0A = 0;
				TCCR0C = 0;
				TCCR0B = 0x5; // TimerCLK is IoCLK/1024
				TCNT0 = 0;
			} else {
				// switch release event
				if(TCNT0 > 2604) // pressed for more than ~1/3 second
					calca_init();
				PRR = (1 << PRADC) | (1 << PRTIM0);
			}
		}

		previous_io = current_io;
	}
}

ISR(PCINT0_vect)
{ /* this just pulls us out of sleep mode */ }

