/ PAPER TAPE LABELER

        AIX1=10             /SETUP AIX1
		
        *20                 /GLOBALS
		
KEYBUF,	0
KEYMSK, 0177                /ALLOW 7 BITS
LOWMSK, 0340
KEYSWP, 0
KEYPTR, 0
SUBONE, 7776
SUB32,  7737

        *200                /LOCATE @ 0200

MAIN,	CLA CLL
		JMS TTYIN
		DCA KEYBUF			/STORE KEY IN ACC
		TAD KEYMSK			/LOAD MASK
		CMA				/INVERT
		AND KEYBUF			/AND WITH KEYBUF
		SZA CLA				/IS BIT 8 SET?
		JMP MAIN			/YES, IGNORE KEY
		TAD LOWMSK
		AND KEYBUF
		SPA CLA
		JMP MAIN			/IGNORE KEY
		TAD KEYBUF
		AND KEYMSK
		TAD SUB32
		IAC
		DCA KEYBUF
		TAD LOOKUP
		TAD KEYBUF
		IAC
		DCA KEYPTR
		TAD I KEYPTR
		TAD SUBONE
		IAC
		DCA AIX1
		
PRTSEG,	TAD I AIX1
		DCA KEYSWP
		TAD KEYSWP
		BSW
		JMS ROTPRT
		TAD KEYSWP
		JMS ROTPRT
		JMP PRTSEG
		
ROTPRT, .
		AND KEYMSK
		RTL
		JMS TTYOUT
		SNA 
		JMP MAIN
		CLA CLL
		JMP I ROTPRT

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

	*300

SYMSPC,	7777
      	7700
SYMEXC,	5600
SYMQTE,	0606
      	0000
SYMHSH,	2476
      	2476
      	2400
SYMDLR,	4452
      	7622
      	0000
SYMPCT,	4626
      	1064
      	6200
SYMAMP,	6452
      	2650
      	0000
SYMAPO,	0600
SYMOPA,	4234
      	0000
SYMCPA,	3442
      	0000
SYMAST,	2434
      	2400
SYMPLS,	1034
      	1000
SYMCOM,	4020
      	0000
SYMDSH,	1010
      	1000
SYMPRD,	6060
      	0000
SYMSLA,	4020
      	1004
      	0200
DIG0,  	3452
      	4634
      	0000
DIG1,  	4476
      	4000
DIG2,  	4462
      	5244
      	0000
DIG3,  	4242
      	5224
      	0000
DIG4,  	1610
      	7610
      	0000
DIG5,  	5652
      	5222
      	0000
DIG6,  	3452
      	5222
      	0000
DIG7,  	0662
      	1206
      	0000
DIG8,  	2452
      	5224
      	0000
	*400
DIG9,  	0452
      	5234
      	0000
SYMCOL,	2400
SYMSCL,	4024
      	0000
SYMLT, 	1024
      	4200
SYMEQ, 	2424
      	2400
SYMGT, 	4224
      	1000
SYMQM, 	0252
      	1600
SYMAT, 	3442
      	5266
      	0000
LTRA,  	7412
      	1274
      	0000
LTRB,  	7652
      	5224
      	0000
LTRC,  	3442
      	4242
      	0000
LTRD,  	7642
      	4234
      	0000
LTRE,  	7652
      	5242
      	0000
LTRF,  	7612
      	1202
      	0000
LTRG,  	3442
      	5262
      	0000
LTRH,  	7610
      	1076
      	0000
LTRI,  	4276
      	4200
LTRJ,  	2040
      	4036
      	0000
LTRK,  	7610
      	2442
      	0000
LTRL,  	7640
      	4040
      	0000
LTRM,  	7604
      	1004
      	7600
LTRN,  	7614
      	3076
      	0000
LTRO,  	3442
      	4234
      	0000
LTRP,  	7612
      	1204
      	0000
LTRQ,  	3442
      	6234
      	4000
LTRR,  	7612
      	3244
      	0000
LTRS,  	4452
      	5222
      	0000
LTRT,  	0202
      	7602
      	0200
LTRU,  	3640
      	4036
      	0000
LTRV,  	1620
      	4020
      	1600
LTRW,  	7620
      	1020
      	7600
LTRX,  	4224
      	1024
      	4200
LTRY,  	0204
      	7004
      	0200
LTRZ,  	4262
      	5246
      	4200
SYMOBR,	4242
      	7600
SYMBSL,	0204
      	1020
      	4000
SYMCBR,	7642
      	4200
SYMCIR,	0402
      	0400
SYMULN,	4040
      	4040
      	0000

	*500

LOOKUP,	.
      	SYMSPC
      	SYMEXC
      	SYMQTE
      	SYMHSH
      	SYMDLR
      	SYMPCT
      	SYMAMP
      	SYMAPO
      	SYMOPA
      	SYMCPA
      	SYMAST
      	SYMPLS
      	SYMCOM
      	SYMDSH
      	SYMPRD
      	SYMSLA
      	DIG0
      	DIG1
      	DIG2
      	DIG3
      	DIG4
      	DIG5
      	DIG6
      	DIG7
      	DIG8
      	DIG9
      	SYMCOL
      	SYMSCL
      	SYMLT
      	SYMEQ
      	SYMGT
      	SYMQM
      	SYMAT
      	LTRA
      	LTRB
      	LTRC
      	LTRD
      	LTRE
      	LTRF
      	LTRG
      	LTRH
      	LTRI
      	LTRJ
      	LTRK
      	LTRL
      	LTRM
      	LTRN
      	LTRO
      	LTRP
      	LTRQ
      	LTRR
      	LTRS
      	LTRT
      	LTRU
      	LTRV
      	LTRW
      	LTRX
      	LTRY
      	LTRZ
      	SYMOBR
      	SYMBSL
      	SYMCBR
      	SYMCIR
      	SYMULN

$
