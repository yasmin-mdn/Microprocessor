.include "m32def.inc"
.org 0

		LDI		R16,0xFF
		OUT		DDRB,R16
		LDI		R16,0b00000000
		OUT		PORTB,R16
		
HERE:	RJMP	HERE
