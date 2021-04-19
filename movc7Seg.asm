MAIN:
		MOV DPTR, #TABLE
		;=Mov DPL,#LOW(TABLE)+Mov DPH,#HIGH(TABLE)
	LOOP:	
		MOV R0,#0
		MOV R1,#10
			LOOPinner:				
				MOV A, R0
				MOVC A,@A+DPTR
				MOV P1,A
				INC R0
				CALL DELAY
				DJNZ  R1, LOOPinner
				jmp LOOP
DELAY:
	MOV R2, #60H
DELAY1:
	MOV R7,#80H
	DJNZ R7,$
	DJNZ R2,DELAY1
	RET
			
TABLE:
		db C0H
		db F9H
		db A4H
		db B0H
		db 99H
		db 92H
		db 82H
		db F8H
		db 80H
		db 98H
		db 88H
		db 83H
		db C6H
		db A1H
		db 86H
		db 8EH
