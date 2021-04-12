ORG	0H			;系統開機的執行位址為0
		JMP	INIT
LENGTH	EQU	40H			;length
ARRAY	EQU	41H 
		ORG	30H          
INIT:           			;填入起始的資料
		MOV 40H, #9;
		MOV 41H, #121;
		MOV 42H, #134;
		MOV 43H, #138;
		MOV 44H, #142;
		MOV 45H, #145;
		MOV 46H, #147;
		MOV 47H, #158;
		MOV 48H, #158;
		MOV 49H, #160;
MAIN:               	;主程式起始位址
		MOV R7, LENGTH
		MOV R6, #ARRAY
		CALL MEDIAN
		JMP	$			;在此檢查回傳值 R5
MEDIAN:					;副程式在此
		MOV A,R7			
		MOV R3,A
		MOV B,R6
		MOV R0,B
		JMP CHECK
NEXT:
		MOV A,R7
		MOV B, #2
		DIV AB		;算中間index
		MOV R0, B
		CJNE R0,#0,ODD  ;如果餘數不等於0做ODD
		EVEN:
			ADD A,R6		;算中間index
			MOV R0,A		
			MOV 55H,@R0	;取R0值放55H
			MOV R0,55H
			DEC A		;算中間另一個的index
			MOV R0,A
			MOV A,@R0 	;取R0值放55H
			ADD A,R0		;相加
			MOV B, #2		
			DIV AB		;除以2
			MOV R5,A		;中位數放到R5
			RET
		ODD:
			ADD A,R6		;算中間index
			MOV R0,A
			MOV 55H,@R0  ;取R0值放55H
			MOV R5,55H	;中位數放到R5
			RET
CHECK:
		DJNZ R3,CHECKLOOP
		JMP NEXT
CHECKLOOP:
		MOV A,R0 ; A存現在index
		MOV R1,A  
		INC R1       ;下一個index
		MOV A,@R1 ;把R1值放到ACC
		MOV 59H,@R0 ;把R0值放到59H
		CJNE A,59H,0  ;比大小
		CPL C      ;旗號取補數讓後面的數字大於等於前面的數字時
				;維持1
		MOV P1.0,C 
		INC R0 ;現在index加一
		JB P1.0,CHECK ;後面大於前面 進行下一次檢查
		;否則設R5為0
		MOV R5,#0
		RET
END

