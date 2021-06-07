MAIN:
		MOV DPTR, #dofly_table
		mov P1,#0FFH
	;=Mov DPL,#LOW(TABLE)+Mov DPH,#HIGH(TABLE)
	LOOP:		
		mov P2,P3 ;暫存P3的value
		mov  A,P2	;把P3的值給A
		CLR C ;清掉carry
		subb A,#0FEH ;判斷是不是第一個按鍵
		JZ change  ;是就跳

		mov  A,P2
		CLR C
		subb A,#0FDH ;判斷是不是第二個按鍵
		JZ change
		
		mov  A,P2
             CLR C
		subb A,#0FBH ;判斷是不是第三個按鍵
		JZ change

		mov  A,P2
		CLR C
		subb A,#0F7H ;判斷是不是第四個按鍵
		JZ change

		mov  A,P2
		CLR C
		subb A,#0EFH ;判斷是不是第五個按鍵
		JZ change

		mov  A,P2
		CLR C
		subb A,#0DFH ;判斷是不是第六個按鍵
		JZ change

		mov  A,P2
		CLR C
		subb A,#0BFH ;判斷是不是第七個按鍵
		JZ change

		mov  A,P2
		CLR C
		subb A,#7FH ;判斷是不是第八個按鍵
		JZ change
		jmp LOOP ;重複執行判斷程式

		change:
			mov A,P2
			mov R0,#0
			innerLoop:   ;判斷哪個bit為0
				RRC A
				INC R0
				JC innerLoop
			MOV A,R0  ;把算出的位置丟進index裡
			movc A,@A+DPTR ;取出對應的數字
			MOV P1,A			;show the number
			jmp LOOP			 ;重複執行判斷程式
			
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
