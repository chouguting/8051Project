;本程式為簡易版 or進階版 or 其他(請簡單說明)
ORG 0H ;系統開機的執行位址為0
JMP INIT
LENGTH EQU 40H ;length
ARRAY EQU 41H
ORG 30H
INIT: ;填入起始的資料
	MOV 40H, #7;
	MOV 41H, #'K';
	MOV 42H, #'e';
	MOV 43H, #'i';
	MOV 44H, #'l';
	MOV 45H, #'A';
	MOV 46H, #'5';
	MOV 47H, #'1';
MAIN: ;使用者程式起始位址
	MOV A,LENGTH
	MOV B,#2
	DIV AB
	MOV R2,A ;R2存次數
	MOV R1,#ARRAY
	MOV A,#ARRAY
	ADD A, LENGTH
	DEC A
	MOV R0,A
	loop:
		MOV A,@R1
		XCH A, @R0
		MOV @R1,A
		MOV A,R0
		DEC R2
		INC R1
		DEC R0
		CJNE R2,#00,loop
		
		
		


	
JMP $ ;跳回自己，無限迴圈
