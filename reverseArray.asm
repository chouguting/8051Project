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
	MOV A,LENGTH ;把長度存到累加器
	MOV B,#2
	DIV AB   ;算執行次數
	MOV R2,A ;R2存次數
	MOV R1,#ARRAY ;存array頭
	MOV A,#ARRAY
	ADD A, LENGTH
	DEC A
	MOV R0,A ;存array尾
	loop:
		MOV A,@R1 ;把資料放進A
		XCH A, @R0;把R0跟A交換
		MOV @R1,A;把A放進R1
		DEC R2 ;次數減一
		INC R1;頭往後一
		DEC R0;尾往前一
		CJNE R2,#00,loop ;做完前迴圈
JMP $ ;跳回自己，無限迴圈
