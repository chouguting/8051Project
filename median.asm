ORG	0H			;�t�ζ}���������}��0
		JMP	INIT
LENGTH	EQU	40H			;length
ARRAY	EQU	41H 
		ORG	30H          
INIT:           			;��J�_�l�����
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
MAIN:               	;�D�{���_�l��}
		MOV R7, LENGTH
		MOV R6, #ARRAY
		CALL MEDIAN
		JMP	$			;�b���ˬd�^�ǭ� R5
MEDIAN:					;�Ƶ{���b��
		MOV A,R7			
		MOV R3,A
		MOV B,R6
		MOV R0,B
		JMP CHECK
NEXT:
		MOV A,R7
		MOV B, #2
		DIV AB		;�⤤��index
		MOV R0, B
		CJNE R0,#0,ODD  ;�p�G�l�Ƥ�����0��ODD
		EVEN:
			ADD A,R6		;�⤤��index
			MOV R0,A		
			MOV 55H,@R0	;��R0�ȩ�55H
			MOV R0,55H
			DEC A		;�⤤���t�@�Ӫ�index
			MOV R0,A
			MOV A,@R0 	;��R0�ȩ�55H
			ADD A,R0		;�ۥ[
			MOV B, #2		
			DIV AB		;���H2
			MOV R5,A		;����Ʃ��R5
			RET
		ODD:
			ADD A,R6		;�⤤��index
			MOV R0,A
			MOV 55H,@R0  ;��R0�ȩ�55H
			MOV R5,55H	;����Ʃ��R5
			RET
CHECK:
		DJNZ R3,CHECKLOOP
		JMP NEXT
CHECKLOOP:
		MOV A,R0 ; A�s�{�bindex
		MOV R1,A  
		INC R1       ;�U�@��index
		MOV A,@R1 ;��R1�ȩ��ACC
		MOV 59H,@R0 ;��R0�ȩ��59H
		CJNE A,59H,0  ;��j�p
		CPL C      ;�X�����ɼ����᭱���Ʀr�j�󵥩�e�����Ʀr��
				;����1
		MOV P1.0,C 
		INC R0 ;�{�bindex�[�@
		JB P1.0,CHECK ;�᭱�j��e�� �i��U�@���ˬd
		;�_�h�]R5��0
		MOV R5,#0
		RET
END

