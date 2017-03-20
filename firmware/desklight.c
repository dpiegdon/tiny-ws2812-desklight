
#include "calca.h"

#include <avr/sleep.h>
#include <avr/interrupt.h>

#define PIN_ROTARY1	PB1
#define PIN_ROTARY2	PB2
#define PIN_SWITCH	PB3

static inline void setup_registers(void)
{
	CCP = 0xD8;		// allow writes to CLKPSR
	CLKPSR = 0;		// disable prescaler
	CCP = 0xD8;		// allow writes to CLKPSR
	CLKMSR = 0b00U;		// select internal 8MHz oscillator

	// set sleep-mode to idle
	SMCR = 0;

	// won't need the Timer0 or ADC
	PRR |= (1 << PRADC) | (1 << PRTIM0);

	// disable all unneeded digital inputs
	DIDR0 = ~((1 << PIN_SWITCH) | (1 << PIN_ROTARY1) | (1 << PIN_ROTARY2));

	// prepare switch and potentiometer
	DDRB &= ~((1 << PIN_SWITCH) | (1 << PIN_ROTARY1) | (1 << PIN_ROTARY2));
	PUEB = (1 << PIN_SWITCH) | (1 << PIN_ROTARY1) | (1 << PIN_ROTARY2);

	// enable interrupt for switch and rotary encoder flags
	PCICR |= (1 << PCIE0);
	PCMSK |= (1 << PIN_SWITCH) | (1 << PIN_ROTARY1) | (1 << PIN_ROTARY2);
}

static volatile uint8_t next_io = (1 << PIN_SWITCH)
				| (1 << PIN_ROTARY1)
				| (1 << PIN_ROTARY2);

int main(void)
{
	setup_registers();
	calca_init(); // activates interrupts
	uint8_t previous_io = (1 << PIN_SWITCH)
				| (1 << PIN_ROTARY1)
				| (1 << PIN_ROTARY2);

	while(1) {
		sleep_mode();

		uint8_t current_io = next_io &  ( (1 << PIN_ROTARY1)
						| (1 << PIN_ROTARY2)
						| (1 << PIN_SWITCH) );
		uint8_t triggered = (current_io ^ previous_io);

		if(triggered & ((1 << PIN_ROTARY1) | ( 1 << PIN_ROTARY2))) {
			if(0 == (previous_io & ((1 << PIN_ROTARY1) | ( 1 << PIN_ROTARY2)))) {
				// rotary encoder upwards
				if(0 == (current_io & (1 << PIN_ROTARY1)))
					calca_rotary_up();

				// rotary encoder downwards
				if(0 == (current_io & (1 << PIN_ROTARY2)))
					calca_rotary_down();
			}
		}

		if(triggered & (1 << PIN_SWITCH)) {
			// encoder push-down
			if(0 == (current_io & (1 << PIN_SWITCH))) {
				calca_next();
				// start timer0 for measurement of time
				// until button-release
				PRR &= ~(1 << PRTIM0);
				TCCR0A = 0;
				TCCR0C = 0;
				TCCR0B = 0b00000101; // TimerCLK is IoCLK/1024
				TCNT0 = 0;
			} else {
				if(TCNT0 > 2604) {
					// pressed for more than ~1/3 second
					calca_init();
				}
				PRR |= (1 << PRTIM0);
			}
		}

		previous_io = current_io;
	}
}

ISR(PCINT0_vect)
{
	next_io = PINB;
}

