MOV TMOD, #20H ;timer1 , mode 2
MOV TH1, #0CEH  ;(-50)reload value in TH1
MOV TL1, #0CEH
SETB TR1 ;Start timer
LOOP:
	 JNB TF1, LOOP ;Wait for overflow
	CLR TF1   ;Clear timer 1 overflow flag
	CPL p1.7   ;Toggle port bit
	JMP LOOP ;Repeat
END