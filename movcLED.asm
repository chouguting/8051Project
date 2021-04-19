ORG		0H          	;系統開機的執行位址為0
main:
	mov DPL,#LOW(table)
	mov DPH,#HIGH(table)

	loop:
		mov R0,#0
		mov R1,#18
		loopinner:
			mov A,R0
			movc A,@A+DPTR
			mov P1,A
			INC R0
			DJNZ R1,loopinner
		jmp loop
	jmp $

table:
		db 7FH
		db 3FH
		db 1FH
		db 0FH
		db 07H
		db 3H
         	db 01H
		db 00H
         	db 0FFH
		db 0FEH
		db 0FCH
         	db 0F8H
		db 0F0H
	         db 0E0H
          	db 0C0H
		db 080H
		db 0H
		db 0FFH
	END
