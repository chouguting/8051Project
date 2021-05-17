; This program scans the keypad.

; While no key is pressed the program
; scans row0, row1, row2, row3 and back to
; row0, continuously.

; When a key is pressed the key number
; is placed in R0.

; For this program, the keys are numbered
; as:

;	+----+----+----+
;	| 11 | 10 |  9 |	row3
;	+----+----+----+
;	|  8 |  7 |  6 |	row2
;	+----+----|----+
;	|  5 |  4 |  3 |	row1
;	+----+----+----+
;	|  2 |  1 |  0 |	row0
;	+----+----+----+
;	 col2 col1 col0

; The pressed key number will be stored in
; R0. Therefore, R0 is initially cleared.
; Each key is scanned, and if it is not
; pressed R0 is incremented. In that way,
; when the pressed key is found, R0 will
; contain the key's number.

; The general purpose flag, F0, is used
; by the column-scan subroutine to indicate
; whether or not a pressed key was found
; in that column.
; If, after returning from colScan, F0 is
; set, this means the key was found.

start:

	MOV R0, #0			; clear R0 - the first key is key0
	MOV P0,#0FFH
	
	; scan row0
	SETB P0.3			; set row3
	CLR P0.0			; clear row0
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)

	; scan row1
	SETB P0.0			; set row0
	CLR P0.1			; clear row1
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)

	; scan row2
	SETB P0.1			; set row1
	CLR P0.2			; clear row2
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)

	; scan row3
	SETB P0.2			; set row2
	CLR P0.3			; clear row3
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)

	MOV P1,#0FFH



	JMP start			; | go back to scan row 0
						; | (this is why row3 is set at the start of the program
						; | - when the program jumps back to start, row3 has just been scanned)

finish:
	CALL MAIN
	CLR F0
	
	JMP start				; program execution arrives here when key is found - do nothing


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


MAIN:
		MOV DPTR, #dofly_table
		
	LOOP:		
		mov R2,#12
		mov R1,00H
	
		mov  A,R1	;把R1的值給A
		CLR C ;清掉carry
		subb A,#0H ;判斷是不是#(0號)按鍵
		JZ change  ;是就跳
		DEC R2

		mov  A,R1
		CLR C
		subb A,#01H ;判斷是不是0(1號)按鍵
		JZ change
		DEC R2

		mov  A,R1
		CLR C
		subb A,#02H ;判斷是不是*(2號)按鍵
		JZ change
		DEC R2

		mov  A,R1
		CLR C
		subb A,#03H ;判斷是不是9(3號)按鍵
		JZ change
		DEC R2

		mov  A,R1
		CLR C
		subb A,#04H ;判斷是不是8(4號)按鍵
		JZ change
		DEC R2

		mov  A,R1
		CLR C
		subb A,#05H ;判斷是不是7(5號)按鍵
		JZ change
		DEC R2

		mov  A,R1
		CLR C
		subb A,#06H ;判斷是不是6(6號)按鍵
		JZ change
		DEC R2

		mov  A,R1
		CLR C
		subb A,#07H ;判斷是不是5(7號)按鍵
		JZ change
		DEC R2

		mov  A,R1
		CLR C
		subb A,#08H ;判斷是不是4(8號)按鍵
		JZ change
		DEC R2

		mov  A,R1
		CLR C
		subb A,#09H ;判斷是不是3(9號)按鍵
		JZ change
		DEC R2

		mov  A,R1
		CLR C
		subb A,#0AH ;判斷是不是2(10號)按鍵
		JZ change
		DEC R2

		mov  A,R1
		CLR C
		subb A,#0BH ;判斷是不是1(11號)按鍵
		JZ change

		RET 

		change:
			mov A,R2  ;把算出的位置丟進index裡
			movc A,@A+DPTR ;取出對應的數字
			MOV P1,A			;show the number
			RET			
			
dofly_table:
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

