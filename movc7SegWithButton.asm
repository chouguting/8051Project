MAIN:
		MOV DPTR, #dofly_table
		mov P1,#0FFH
	;=Mov DPL,#LOW(TABLE)+Mov DPH,#HIGH(TABLE)
	LOOP:		
		mov P2,P3 ;�ȦsP3��value
		mov  A,P2	;��P3���ȵ�A
		CLR C ;�M��carry
		subb A,#0FEH ;�P�_�O���O�Ĥ@�ӫ���
		JZ change  ;�O�N��

		mov  A,P2
		CLR C
		subb A,#0FDH ;�P�_�O���O�ĤG�ӫ���
		JZ change
		
		mov  A,P2
             CLR C
		subb A,#0FBH ;�P�_�O���O�ĤT�ӫ���
		JZ change

		mov  A,P2
		CLR C
		subb A,#0F7H ;�P�_�O���O�ĥ|�ӫ���
		JZ change

		mov  A,P2
		CLR C
		subb A,#0EFH ;�P�_�O���O�Ĥ��ӫ���
		JZ change

		mov  A,P2
		CLR C
		subb A,#0DFH ;�P�_�O���O�Ĥ��ӫ���
		JZ change

		mov  A,P2
		CLR C
		subb A,#0BFH ;�P�_�O���O�ĤC�ӫ���
		JZ change

		mov  A,P2
		CLR C
		subb A,#7FH ;�P�_�O���O�ĤK�ӫ���
		JZ change
		jmp LOOP ;���ư���P�_�{��

		change:
			mov A,P2
			mov R0,#0
			innerLoop:   ;�P�_����bit��0
				RRC A
				INC R0
				JC innerLoop
			MOV A,R0  ;���X����m��iindex��
			movc A,@A+DPTR ;���X�������Ʀr
			MOV P1,A			;show the number
			jmp LOOP			 ;���ư���P�_�{��
			
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
