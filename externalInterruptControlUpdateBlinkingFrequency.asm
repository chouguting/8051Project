		ORG	0000H	;Reset 
		LJMP	MAIN

		ORG	000BH 	;Timer0 interrupt vector 
		JMP	T0ISR  ;跳到T0的ISR

		ORG	0013H  ;INT1 interrupt vector
;P3.3輸入會觸發INT1 interrupt
INT1ISR:    
		;判斷是哪一個按鈕被按下
		JNB	P0.4, UP_PERIOD
		JNB	P0.5, STOP_GO
		JNB	P0.6, DOWN_PERIOD
		RETI
		ORG	0030H	;Program Start
MAIN:
		MOV	SP, #40H	;Init SP
		MOV	TMOD, #02H 	;timer0, mode 2 
		MOV	TH0, #-10 	;10 us delay 
		MOV	TL0, #-10 	;10 us delay
		;10muSec的Timer執行R7次
		;所以只要R7改變1, TIMER DELAY就會差10muSec
		MOV	R7, #10	;R7 = Initial Value of Counter
		MOV	R6, 07H	;R6 = Counter

		MOV	P0, #0FBH	;= '1', except row2

		MOV 	IE,#86H	;enable timer0 interrupt 
		MOV	TCON,#14H
		;SETB	TR0 	;Start timer 
		JMP	 $
;下降週期 (頻率增加)
DOWN_PERIOD:
		CJNE	R7, #5, DEC1 ;如果已經到下限 就不跳
		JMP ENDISR
DEC1:
		DEC	R7 
		JMP ENDISR
;上升週期 (頻率減少)
UP_PERIOD:
		CJNE	R7, #15, INC1 ;如果已經到上限 就不跳
		JMP ENDISR
INC1:
		INC	R7
		JMP ENDISR
;暫停閃爍(Timer)
STOP_GO:
		CPL	TR0
ENDISR: 
		;MOV TH0,R7 ;ISR結束 更新THO(Reload值)
		RETI

T0ISR:
		DJNZ	R6, NOTHING  ;3Byte
		MOV	R6, 07H	;AR7 ;2Byte
		CPL	P1.1	;Toggle port bit  2Byte
NOTHING:
		RETI		;Return to main program 1
		END
