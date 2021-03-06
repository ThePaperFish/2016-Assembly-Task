	ORG	00H
	JMP	START
	ORG	0BH
	JMP	TIM0
START:	MOV	TMOD,#00000001B
	MOV	IE,#10000010B     ;02H MAX
HELLOC:	JB	P2.1,HELLOC1
	CALL	DELAY1
	JNB	P2.1,$
	MOV	31H,#00
	MOV	30H,#<SONG1
	JMP	NEXT
HELLOC1:
	JB	P2.0,HELLOC
	CALL	DELAY1
	JNB	P2.0,$
	MOV	31H,#01H
	MOV	30H,#<SONG2
	JMP	NEXT
NEXT:	MOV	A,30H
	MOV	DPTR,#TABLE
	MOVC	A,@A+DPTR
	MOV 	R2,A
	JZ	END1
	JB	P2.0,INI0
	JMP	END1
INI0:	JB	P2.1,INI1
	JMP	END1
INI1:	ANL	A,#0FH
	MOV	R5,A
	MOV	A,R2
	SWAP	A
	ANL	A,#0FH
	JNZ	SING
	CLR	TR0
	JMP	D1
SING:	DEC	A
	MOV	22H,A
	RL	A
	MOV	DPTR,#TABLE
	MOVC	A,@A+DPTR
	MOV	TH0,A
	MOV	21H,A
	MOV	A,22H	
	RL	A
	INC	A
	MOVC	A,@A+DPTR
	MOV	TL0,A
	MOV	20H,A
	SETB	TR0	
D1:	CALL	DELAY
	INC	30H
	JMP	NEXT
END1:	CLR	TR0	
	MOV	A,31H
	XRL	A,#00H
	JNZ	END2
HELLOA:	JB	P2.1,HELLOA1
	CALL	DELAY1
	JNB	P2.1,$
	INC	31H
	MOV	30H,#<SONG2
	JMP	NEXT
HELLOA1:
	JB	P2.0,HELLOA
	CALL	DELAY1
	JNB	P2.0,$
	MOV	31H,#02H
	MOV	30H,#<SONG0
	JMP	NEXT
END2:	CLR	TR0	
	MOV	A,31H
	XRL	A,#01H
	JNZ	END99
HELLOB:	JB	P2.1,HELLOB1
	CALL	DELAY1
	JNB	P2.1,$
	INC	31H
	MOV	30H,#<SONG0
	JMP	NEXT
HELLOB1:
	JB	P2.0,HELLOB
	CALL	DELAY1
	JNB	P2.0,$
	MOV	31H,#00H
	MOV	30H,#<SONG1
	JMP	END1
END99:	JMP	START
TIM0:	PUSH	A
	PUSH	PSW
	SETB	RS0
	CLR	RS1
	MOV	TL0,20H
	MOV	TH0,21H
	CPL	P1.3
	POP	PSW
	POP	A
	RETI
DELAY:	MOV	R7,#02
D2:	MOV	R4,#187	
D3:	MOV	R3,#248
	DJNZ	R3,$
	DJNZ	R4,D3
	DJNZ	R7,D2
	DJNZ	R5,DELAY
	RET
DELAY1:	MOV	R4,#20
D4:	MOV	R3,#248
	DJNZ	R3,$
	DJNZ	R4,D4
	RET
	ORG	0300H
TABLE:	DW	64580,64684,64777,64820
	DW	64898,64968,65030,65058
	DW	65110,65157,64934,10
	DW	63731,12,63928
SONG2:	;negaraku
	DB	D2H,D2H,32H,14H,02H
	DB	12H,12H,52H,32H,12H,F4H,11H,24H,02H
	DB	D2H,F2H,12H,24H,02H
	DB	32H,42H,62H,52H,41H,34H,02H
	DB	D2H,12H,32H,54H,02H
	DB	32H,42H,31H,42H,52H,64H,02H
	DB	22H,42H,62H,54H,02H
	DB	32H,52H,42H,32H,22H,34H,02H
	DB	D2H,12H,32H,54H,02H
	DB	32H,42H,31H,42H,52H,64H,02H
	DB	22H,42H,62H,54H,02H
	DB	32H,52H,42H,32H,22H,14H,02H
	DB	00H
SONG1:	;TROVE OPENING ;PEACEFUL HILL
	DB	21H,61H,53H,01H,31H,41H,23H,01H
	DB	21H,61H,53H,01H,31H,41H,23H,01H
	DB	21H,61H,73H,01H,21H,61H,53H,01H
	DB	21H,61H,53H,01H,41H,31H,11H,23H
	DB	51H,41H,52H,02H
	DB	51H,41H,51H,61H,51H,01H
	DB	51H,41H,52H,02H
	DB	51H,41H,51H,61H,51H,41H,01H
	DB	51H,41H,52H,41H,01H
	DB	51H,41H,51H,61H,51H,41H,01H
	DB	51H,41H,51H,32H,52H,62H,52H,42H,02H
	DB	00H
SONG0:	;SCHOOL
	DB	82H,71H,61H,52H,52H
	DB	62H,82H,54H
	DB	62H,51H,31H,22H,52H
	DB	36H,02H
	DB	82H,71H,61H,52H,52H
	DB	62H,82H,54H
	DB	62H,51H,31H,22H,52H
	DB	16H,02H
	DB	52H,32H,84H
	DB	62H,82H,54H
	DB	63H,51H,32H,12H
	DB	22H,52H,34H
	DB	32H,32H,54H
	DB	11H,21H,31H,41H,21H,31H,41H,51H
	DB	A4H,94H
	DB	86H,02H
	DB	00
	END