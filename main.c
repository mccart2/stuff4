/*
 * GccApplication1.c
 *
 * Created: 3/9/2019 4:38:45 PM
 * Author : mccart2
 */ 
#define F_CPU 1000000ul // Calling up our clock of 1 Mhz
#include <avr/io.h> // Include statement for the AVR 
#include <avr/interrupt.h> // Include for Interrupt 
#include <util/delay.h> // Include for the Delay


int main(void) // Int Main
{
  DDRB = (1 << PB5);  PB5 as an output
  PORTD |= 1<<2;  // Pull up turned on
  EICRA = 0X2; // Make INT0 falling edge activates
  
  EIMSK = (1<<INT0); // Enable external interrupt 0
  sei(); // Turn on the ability to use interrupts
  
 while (1) // Wait here infinite loop
  {
	  PORTB ^= (1<<4); 
	 // _delay_ms(1000);
  }
}
ISR (INT0_vect) // ISR for outside interrupt
{
 PORTB ^= (1<<5);  // toggle portb 5
   _delay_ms(1250);
}

