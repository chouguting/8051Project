loop1:
	MOV P1,#7FH
	MOV B,#2
	MOV R2,#8
	loop2:	
		MOV A,R2
		DEC A
		JZ loop1
		MOV R2,A
		MOV A,P1
		DIV AB
		MOV B,#2
		ADD A,#10000000B
		MOV P1,A
		JMP loop2
	JMP loop1
	
	