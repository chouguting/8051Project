;���{����²���� or�i���� or ��L(��²�满��)
ORG 0H ;�t�ζ}���������}��0
JMP INIT
LENGTH EQU 40H ;length
ARRAY EQU 41H
ORG 30H
INIT: ;��J�_�l�����
	MOV 40H, #7;
	MOV 41H, #'K';
	MOV 42H, #'e';
	MOV 43H, #'i';
	MOV 44H, #'l';
	MOV 45H, #'A';
	MOV 46H, #'5';
	MOV 47H, #'1';
MAIN: ;�ϥΪ̵{���_�l��}
	MOV A,LENGTH ;����צs��֥[��
	MOV B,#2
	DIV AB   ;����榸��
	MOV R2,A ;R2�s����
	MOV R1,#ARRAY ;�sarray�Y
	MOV A,#ARRAY
	ADD A, LENGTH
	DEC A
	MOV R0,A ;�sarray��
	loop:
		MOV A,@R1 ;���Ʃ�iA
		XCH A, @R0;��R0��A�洫
		MOV @R1,A;��A��iR1
		DEC R2 ;���ƴ�@
		INC R1;�Y����@
		DEC R0;�����e�@
		CJNE R2,#00,loop ;�����e�j��
JMP $ ;���^�ۤv�A�L���j��
