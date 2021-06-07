ORG 0000H ;RESET BIOS
LJMP main

ORG 000BH ;Timer 0 ISR
timer0ISR:
	CPL P1.1
	MOV TH0,R2
	RETI

ORG 0030H ;主程式開始位置
main:
	MOV SP,#40H
	MOV IE,#82H
	MOV R2,#9CH ;初始頻率
	MOV TMOD,#02H
	MOV TH0,R2
	MOV TL0,R2
	MOV TCON,#10H 
checkKey:
	MOV R0, #0			; clear R0 - the first key is key0
	MOV P0,#0FFH
	; scan row2
	SETB P0.1			; set row1
	CLR P0.2			; clear row2
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
	MOV P1,#0FFH
	JMP checkKey			; | go back to scan row 0
						; | (this is why row3 is set at the start of the program
						; | - when the program jumps back to start, row3 has just been scanned)

finish:
	CALL buttonEvent
	CLR F0
	JMP checkKey				; program execution arrives here when key is found - do nothing


; column-scan subroutine
colScan:
	JNB P0.4, gotKey	; if col0 is cleared - key found
	INC R0				; otherwise move to next key
	JNB P0.5, gotKey	; if col1 is cleared - key found
	INC R0				; otherwise move to next key
	JNB P0.6, gotKey	; if col2 is cleared - key found
	INC R0				; otherwise move to next key
	RET					; return from subroutine - key not found
gotKey:
	SETB F0				; key found - set F0
	RET					; and return from subroutine

buttonEvent:

	;六號按鈕
	MOV A,R0
	CLR C
	SUBB A,#00H
	JZ increaseFrequency

	;五號按鈕
	MOV A,R0
	CLR C
	SUBB A,#01H
	JZ  stopAndWait

	;四號按鈕
	MOV A,R0
	CLR C
	SUBB A,#02H
	JZ decreaseFrequency
	JMP  endButtonEvent
increaseFrequency:
	MOV A,R2
	CLR C
	SUBB A,#6AH
	JZ  endButtonEvent
	MOV A,R2
	CLR C
	SUBB A,#10
	MOV R2,A
	JMP endButtonEvent

decreaseFrequency:
	MOV A,R2
	CLR C
	SUBB A,#0CEH
	JZ  endButtonEvent
	MOV A,R2
	CLR C
	ADD A,#10
	MOV R2,A
	JMP endButtonEvent
stopAndWait:
	MOV A,IE
	XRL A,#80H
	MOV IE,A

endButtonEvent:
	RET
