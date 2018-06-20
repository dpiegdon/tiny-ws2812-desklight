
#include "calca.h"

#include <avr/sleep.h>
#include <avr/interrupt.h>

#define PIN_ROTARY1	PB1
#define PIN_ROTARY2	PB2
#define PIN_SWITCH	PB3

static const uint8_t rotary_mask = ((1 << PIN_ROTARY1) | ( 1 << PIN_ROTARY2));
static const uint8_t switch_mask = (1 << PIN_SWITCH);
static const uint8_t event_mask = rotary_mask | switch_mask;

static inline void setup_registers(void)
{
	CCP = 0xD8;		// allow writes to CLKPSR
	CLKPSR = 0;		// disable prescaler
	CCP = 0xD8;		// allow writes to CLKPSR
	CLKMSR = 0x0U;		// select internal 8MHz oscillator

	// set sleep-mode to idle
	SMCR = 0;

	// won't need the Timer0 or ADC
	PRR |= (1 << PRADC) | (1 << PRTIM0);

	// disable all unneeded digital inputs
	DIDR0 = ~event_mask;

	// prepare switch and potentiometer
	DDRB &= ~event_mask;
	PUEB = event_mask;

	// enable interrupt for switch and rotary encoder flags
	PCICR |= (1 << PCIE0);
	PCMSK |= event_mask;
}

int main(void)
{
	setup_registers();
	calca_init(); // activates interrupts

	uint8_t previous_io = event_mask;

	while(1) {
		sleep_mode(); // will return once interrupted by ISR.

		uint8_t current_io = PINB & event_mask;
		uint8_t changed_io = (current_io ^ previous_io);

		if((changed_io & rotary_mask) && (0 == (previous_io & rotary_mask)))
			calca_rotary_step( (current_io & (1 << PIN_ROTARY1)) ? 1 : -1);

		if(changed_io & switch_mask) {
			if(current_io & switch_mask) {
				// switch push-down event
				calca_next();
				// start timer0 for measurement of time
				// until button-release
				PRR &= ~(1 << PRTIM0);
				TCCR0A = 0;
				TCCR0C = 0;
				TCCR0B = 0x5; // TimerCLK is IoCLK/1024
				TCNT0 = 0;
			} else {
				// switch release event
				if(TCNT0 > 2604) // pressed for more than ~1/3 second
					calca_init();
				PRR |= (1 << PRTIM0);
			}
		}

		previous_io = current_io;
	}
}

ISR(PCINT0_vect)
{ /* this just pulls us out of sleep mode */ }

