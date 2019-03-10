//
// AssemblerApplication1.asm
//
// Created: 3/9/2019 4:38:20 PM
// Author : mccart2
//

.include <m328pdef.inc>
.ORG 0
JMP MAIN // Jump to main
.ORG 0x02
JMP EX0_ISR // Jump to EXO_ISR label
MAIN:
	LDI R20,HIGH(RAMEND) // the value from the high byte to R20
	OUT SPH,R20 // Loads R20 into Stack Pointer High
	LDI R20,LOW(RAMEND) // Loads value from 
	OUT SPL, R20 // Loads R20 into Stack pointer Low

	LDI R20,0x2  // Loads the value 0x2 into R20
	STS EICRA,R20 // Stores R20 in SRAM
	SBI DDRB, 5 //Set pin 5 on port b as output
	SBI PORTD, 2 // set pin 2 on port d as output
	LDI R20,1<<INT0 // Load the flag from our interrupt into R20
	OUT EIMSK, R20  // Load values into our Mask Register
	SEI//

HERE:JMP HERE // Here Label
EX0_ISR: // Exo_Iso Label
DELAY:  // Start of delay subroutine.

	IN R21,PORTB  // 
	LDI R22,(1<<5) // Shifting bits in R22
	EOR R21,R22 // Exclusive OR of R21 and R22
	RCALL delay_1s // Call our delay subroutine for 1 second
	rcall delay_100ms// Call our delay subroutine for .1 second
	rcall delay_100ms// Call our delay subroutine for .1 second
	rcall delay_5ms// Call our delay subroutine for 0.005 second
	rcall delay_5ms// Call our delay subroutine for 0.005 second
	rcall delay_5ms// Call our delay subroutine for 0.005 second
	rcall delay_5ms// Call our delay subroutine for 0.005 second
	rcall delay_5ms// Call our delay subroutine for 0.005 second
	rcall delay_5ms// Call our delay subroutine for 0.005 second
	rcall delay_5ms// Call our delay subroutine for 0.005 second
	rcall delay_5ms// Call our delay subroutine for 0.005 second
	rcall delay_5ms// Call our delay subroutine for 0.005 second
	rcall delay_5ms// Call our delay subroutine for 0.005 second
	OUT PORTB,R21 // Output Port B the value from R21
	RETI




delay_1s: // 1s delay subroutine
push r16 // Push this value onto the stack
ldi r16,200 // Loads the value 200 into R16
delay_1s1:
rcall delay_5ms // Relative call to our 5ms delay
dec r16 // Decrement R16
brne delay_1s1 // Branch if not equal 
pop r16 // Pops value from the stack into R16
ret

delay_100ms: //100ms delay subroutine
push r16// Push this value onto the stack
ldi r16,100
delay_100ms1: 
rcall delay_1ms
dec r16// Decrement R16
brne delay_100ms1
pop r16// Pops value from the stack into R16
ret

delay_5ms: // 5ms delay subroutine
rcall delay_1ms
rcall delay_1ms
rcall delay_1ms
rcall delay_1ms
rcall delay_1ms
ret

delay_1ms: // 1ms delay subroutine
push r16// Push this value onto the stack
ldi r16,99 //accounts for overhead of 12 cycles.
delay_1ms1:
nop // nop just delays for one cycle
nop // nop just delays for one cycle
nop // nop just delays for one cycle
nop // nop just delays for one cycle
nop // nop just delays for one cycle
nop // nop just delays for one cycle
nop // nop just delays for one cycle
dec r16// Decrement R16
brne delay_1ms1
pop r16// Pops value from the stack into R16
ret
