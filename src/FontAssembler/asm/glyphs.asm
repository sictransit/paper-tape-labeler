/ PAPER TAPE LABELER

        AIX1=10             /SETUP AIX1
		
        *20                 /GLOBALS
		
KEYBUF,	0
KEYMSK, 0177                /ALLOW 7 BITS
LOWMSK, 0140                /UPPER LIMIT (IGNORE LOWERCASE AND SOME SPECIAL CHARS)
KEYSWP, 0
KEYPTR, 0
KEYEND, 0004
CHRMSK, 0370
SUBONE, 7776
CNST32, 0040
ENDCHK, 0

        *200                /LOCATE @ 0200

MAIN,	CLA CLL
		JMS TTYIN
		DCA KEYBUF			/STORE KEY IN ACC
		TAD KEYMSK			/LOAD MASK
		CMA				/INVERT
		AND KEYBUF			/AND WITH KEYBUF
		SZA CLA				/IS BIT 8 SET?
		JMP MAIN			/YES, IGNORE KEY
		TAD KEYBUF                      /GET INPUT CHAR
                CMA IAC                         /MAKE TWOS COMPLEMENT, GET NEGATIVE VALUE
		TAD LOWMSK                      /ADD UPPER LIMIT MASK (THUS SUBTRACTING INPUT KEY)
		SPA SNA CLA                     /IS PRINTABLE? (POSITIVE NON-ZERO IS BELOW LIMIT)
		JMP MAIN			/NO, IGNORE KEY
		CLL                             /CLEAR LINK AFTER COMPARISON, MESSES WITH ROTATIONS BELOW
		TAD CNST32                      /LOAD CONSTANT 32
		CMA IAC                         /COMPLEMENT AND ADD 1 GIVES -32
		TAD KEYBUF                      /GET INPUT KEY AGAIN (THUS SUBTRACT 32)
		TAD (LOOKUP)                    /ADD ARRAY BASE (WE KNOW THAT 31 < KEYBUF < 128, SO AC IS NOW BETWEEN 0 AND 127)
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
		
ROTPRT, 0
		AND KEYMSK
		RTL
		DCA ENDCHK
		TAD ENDCHK
		JMS TTYOUT
		JMS ENDPRT
		CLA CLL
		JMP I ROTPRT

ENDPRT, 0
		TAD ENDCHK
		AND KEYEND
		SNA
		JMP I ENDPRT
		CLA CLL
		JMS TTYOUT
		JMP MAIN
		

TTYIN,  0
        KSF
        JMP .-1
        KRB
        JMP I TTYIN


TTYOUT, 0                   /TTY OUTPUT SUB-ROUTINE
		AND CHRMSK			/STRIP BITS 0-2
        TLS                 /WRITE ACC TO TTY
        TSF                 /TTY READY? SKIP! 
        JMP .-1             /CHECK AGAIN
        JMP I TTYOUT        /RETURN 


/ CODE BELOW THIS LINE IS AUTO-GENERATED. BEWARE!

	*300

SYMSPC,	0100
SYMEXC,	5700
SYMQTE,	0607
SYMHSH,	2476
      	2476
      	2500
SYMDLR,	4452
      	7623
SYMPCT,	4626
      	1064
      	6300
SYMAMP,	6452
      	2651
SYMAPO,	0700
SYMOPA,	4235
SYMCPA,	3443
SYMAST,	2434
      	2500
SYMPLS,	1034
      	1100
SYMCOM,	4021
SYMDSH,	1010
      	1100
SYMPRD,	6061
SYMSLA,	4020
      	1004
      	0300
DIG0,  	3452
      	4635
DIG1,  	4476
      	4100
DIG2,  	4462
      	5245
DIG3,  	4242
      	5225
DIG4,  	1610
      	7611
DIG5,  	5652
      	5223
DIG6,  	3452
      	5223
DIG7,  	0662
      	1207
DIG8,  	2452
      	5225
DIG9,  	0452
      	5235
	*400
SYMCOL,	2500
SYMSCL,	4025
SYMLT, 	1024
      	4300
SYMEQ, 	2424
      	2500
SYMGT, 	4224
      	1100
SYMQM, 	0252
      	1700
SYMAT, 	3442
      	5267
LTRA,  	7412
      	1275
LTRB,  	7652
      	5225
LTRC,  	3442
      	4243
LTRD,  	7642
      	4235
LTRE,  	7652
      	5243
LTRF,  	7612
      	1203
LTRG,  	3442
      	5263
LTRH,  	7610
      	1077
LTRI,  	4276
      	4300
LTRJ,  	2040
      	4037
LTRK,  	7610
      	2443
LTRL,  	7640
      	4041
LTRM,  	7604
      	1004
      	7700
LTRN,  	7614
      	3077
LTRO,  	3442
      	4235
LTRP,  	7612
      	1205
LTRQ,  	3442
      	6234
      	4100
LTRR,  	7612
      	3245
LTRS,  	4452
      	5223
LTRT,  	0202
      	7602
      	0300
LTRU,  	3640
      	4037
LTRV,  	1620
      	4020
      	1700
LTRW,  	7620
      	1020
      	7700
LTRX,  	4224
      	1024
      	4300
LTRY,  	0204
      	7004
      	0300
LTRZ,  	4262
      	5246
      	4300
SYMOBR,	4242
      	7700
SYMBSL,	0204
      	1020
      	4100
SYMCBR,	7642
      	4300
SYMCIR,	0402
      	0500
SYMULN,	4040
      	4041

	*500

LOOKUP,	SYMSPC
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
