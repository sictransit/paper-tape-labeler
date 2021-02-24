/ PAPER TAPE LABELER

        AIX1=10             /SETUP AIX1
		
        *20                 /GLOBALS
		
KEYBUF,	0
KEYMSK, 0077                /ALLOW 6 BITS
KEYOFS, 7737
KEYSWP, 0

        *200                /LOCATE @ 0200

        CLA CLL             /CLEAR ACC, CLEAR LINK
        HLT                 /TO BE SAFE!

LOOP,	JMS TTYIN
		DCA KEYBUF			/STORE KEY IN ACC
		TAD KEYMSK
		CMA
		AND KEYBUF
		SNA CLA				/>63?
		JMP LOOP			/IGNORE KEY
		AND KEYBUF
		TAD KEYOFS
		IAC
		SNL					/<32?
		JMP LOOP			/IGNORE KEY
		AND KEYMSK
		DCA KEYBUF
        JMS PRTLTR
		JMP LOOP
		
PRTLTR, 0
		AND LOOKUP
		ADD KEYBUF
		ADD 7776
		IAC
		DCA AIX1		
SWPLP,	TAD I AIX1
		DCA KEYSWP
		TAD KEYSWP
		BSW
		AND KEYMSK
		JMS TTYOUT
		SNA 
		JMS PRTLTR
		CLA
		TAD KEYSWP
		AND KEYMSK
		SNA 
		JMS PRTLTR
		JMP SWPLP

TTYIN,  0
        KSF
        JMP .-1
        KRB
        JMP I TTYIN


TTYOUT, 0                   /TTY OUTPUT SUB-ROUTINE
        TLS                 /WRITE ACC TO TTY
        TSF                 /TTY READY? SKIP! 
        JMP .-1             /CHECK AGAIN
        JMP I TTYOUT        /RETURN 

/ CODE BELOW THIS LINE IS AUTO-GENERATED. BEWARE!

LOOKUP,	SY_SPC
       	SY_EXC
       	SY_QTE
       	SY_HSH
       	SY_DLR
       	SY_PCT
       	SY_AMP
       	SY_APO
       	SY_OPA
       	SY_CPA
       	SY_AST
       	SY_PLS
       	SY_COM
       	SY_DSH
       	SY_PRD
       	SY_SLA
       	DI_0
       	DI_1
       	DI_2
       	DI_3
       	DI_4
       	DI_5
       	DI_6
       	DI_7
       	DI_8
       	DI_9
       	SY_COL
       	SY_SCL
       	SY_LT
       	SY_EQ
       	SY_GT
       	SY_QM
       	SY_AT
       	LT_A
       	LT_B
       	LT_C
       	LT_D
       	LT_E
       	LT_F
       	LT_G
       	LT_H
       	LT_I
       	LT_J
       	LT_K
       	LT_L
       	LT_M
       	LT_N
       	LT_O
       	LT_P
       	LT_Q
       	LT_R
       	LT_S
       	LT_T
       	LT_U
       	LT_V
       	LT_W
       	LT_X
       	LT_Y
       	LT_Z
       	SY_OBR
       	SY_BSL
       	SY_CBR
       	SY_CIR
       	SY_ULN

SY_SPC	7777
      	7700
SY_EXC	5600
SY_QTE	0606
      	0000
SY_HSH	2476
      	2476
      	2400
SY_DLR	4452
      	7622
      	0000
SY_PCT	4626
      	1064
      	6200
SY_AMP	6452
      	2650
      	0000
SY_APO	0600
SY_OPA	4234
      	0000
SY_CPA	3442
      	0000
SY_AST	2434
      	2400
SY_PLS	1034
      	1000
SY_COM	4020
      	0000
SY_DSH	1010
      	1000
SY_PRD	6060
      	0000
SY_SLA	4020
      	1004
      	0200
DI_0  	3452
      	4634
      	0000
DI_1  	4476
      	4000
DI_2  	4462
      	5244
      	0000
DI_3  	4242
      	5224
      	0000
DI_4  	1610
      	7610
      	0000
DI_5  	5652
      	5222
      	0000
DI_6  	3452
      	5222
      	0000
DI_7  	0662
      	1206
      	0000
DI_8  	2452
      	5224
      	0000
DI_9  	0452
      	5234
      	0000
SY_COL	2400
SY_SCL	4024
      	0000
SY_LT 	1024
      	4200
SY_EQ 	2424
      	2400
SY_GT 	4224
      	1000
SY_QM 	0252
      	1600
SY_AT 	3442
      	5266
      	0000
LT_A  	7412
      	1274
      	0000
LT_B  	7652
      	5224
      	0000
LT_C  	3442
      	4242
      	0000
LT_D  	7642
      	4234
      	0000
LT_E  	7652
      	5242
      	0000
LT_F  	7612
      	1202
      	0000
LT_G  	3442
      	5262
      	0000
LT_H  	7610
      	1076
      	0000
LT_I  	4276
      	4200
LT_J  	2040
      	4036
      	0000
LT_K  	7610
      	2442
      	0000
LT_L  	7640
      	4040
      	0000
LT_M  	7604
      	1004
      	7600
LT_N  	7614
      	3076
      	0000
LT_O  	3442
      	4234
      	0000
LT_P  	7612
      	1204
      	0000
LT_Q  	3442
      	6234
      	4000
LT_R  	7612
      	3244
      	0000
LT_S  	4452
      	5222
      	0000
LT_T  	0202
      	7602
      	0200
LT_U  	3640
      	4036
      	0000
LT_V  	1620
      	4020
      	1600
LT_W  	7620
      	1020
      	7600
LT_X  	4224
      	1024
      	4200
LT_Y  	0204
      	7004
      	0200
LT_Z  	4262
      	5246
      	4200
SY_OBR	4242
      	7600
SY_BSL	0204
      	1020
      	4000
SY_CBR	7642
      	4200
SY_CIR	0402
      	0400
SY_ULN	4040
      	4040
      	0000
