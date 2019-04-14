	.byt 'TAB',$a8
tabtk	=@243
	.byt 'T',$cf
totk	=@244
	.byt 'F',$ce
fntk	=@245
	.byt 'SPC',$a8
spctk	=@246
	.byt 'THE',$ce
thentk	=@247
	.byt 'NO',$d4
nottk	=@250
	.byt 'STE',$d0
steptk	=@251
	.byt $ab
plustk	=@252
	.byt $ad
minutk	=@253
	.byt $aa
	.byt $af
	.byt $de
	.byt 'AN',$c4
	.byt 'O',$d2
	.byt 190
greatk	=@261
	.byt $bd
equltk	=@262
	.byt 188
lesstk	=@263
	.byt 'SG',$ce
onefun	=@264
	.byt 'IN',$d4
	.byt 'AB',$d3
	.byt 'US',$d2
	.byt 'FR',$c5
	.byt 'PO',$d3
	.byt 'SQ',$d2
	.byt 'RN',$c4
	.byt 'LO',$c7
	.byt 'EX',$d0
	.byt 'CO',$d3
	.byt 'SI',$ce
	.byt 'TA',$ce
	.byt 'AT',$ce
	.byt 'PEE',$cb
	.byt 'LE',$ce
	.byt 'STR',$a4
	.byt 'VA',$cc
	.byt 'AS',$c3
	.byt 'CHR',$a4
lasnum	=@307
	.byt 'LEFT',$a4
	.byt 'RIGHT',$a4
	.byt 'MID',$a4
	.byt 'G',$cf
gotk	=@313
	.byt 0

err01	.byt 'TOO MANY FILE',$d3
err02	.byt 'FILE OPE',$ce
err03	.byt 'FILE NOT OPE',$ce
err04	.byt 'FILE NOT FOUN',$c4
err05	.byt 'DEVICE NOT PRESEN',$d4
err06	.byt 'NOT INPUT FIL',$c5
err07	.byt 'NOT OUTPUT FIL',$c5
err08	.byt 'MISSING FILE NAM',$c5
err09	.byt 'ILLEGAL DEVICE NUMBE',$d2
err10	.byt 'NEXT WITHOUT FO',$d2
errnf	=10
err11	.byt 'SYNTA',$d8
errsn	=11
err12	.byt 'RETURN WITHOUT GOSU',$c2
errrg	=12
err13	.byt 'OUT OF DAT',$c1
errod	=13
err14	.byt 'ILLEGAL QUANTIT',$d9
errfc	=14
err15	.byt 'OVERFLO',$d7
errov	=15
err16	.byt 'OUT OF MEMOR',$d9
errom	=16
err17	.byt 'UNDEF',$27
	.byt 'D STATEMEN',$d4
errus	=17
err18	.byt 'BAD SUBSCRIP',$d4
errbs	=18
err19	.byt 'REDIM',$27,'D ARRA',$d9
errdd	=19
err20	.byt 'DIVISION BY ZER',$cf
errdvo	=20
err21	.byt 'ILLEGAL DIREC',$d4
errid	=21
err22	.byt 'TYPE MISMATC',$c8
errtm	=22
err23	.byt 'STRING TOO LON',$c7
errls	=23
err24	.byt 'FILE DAT',$c1
errbd	=24
err25	.byt 'FORMULA TOO COMPLE',$d8
errst	=25
err26	.byt 'CAN',$27,'T CONTINU',$c5
errcn	=26
err27	.byt 'UNDEF',$27,'D FUNCTIO',$ce
erruf	=27
err28	.byt 'VERIF',$d9
ervfy	=28
err29	.byt 'LOA',$c4
erload	=29

; table to translate error message #
; to address of string containing message
;
errtab	.wor err01
	.wor err02
	.wor err03
	.wor err04
	.wor err05
	.wor err06
	.wor err07
	.wor err08
	.wor err09
	.wor err10
	.wor err11
	.wor err12
	.wor err13
	.wor err14
	.wor err15
	.wor err16
	.wor err17
	.wor err18
	.wor err19
	.wor err20
	.wor err21
	.wor err22
	.wor err23
	.wor err24
	.wor err25
	.wor err26
	.wor err27
	.wor err28
	.wor err29
	.wor err30

okmsg	.byt $d,'OK',$d,$0
err	.byt $20,' ERROR',0 ;add a space for vic-40 screen
intxt	.byt ' IN ',0
reddy	.byt $d,$a,'READY.',$d,$a,0
erbrk	=30
brktxt	.byt $d,$a
err30	.byt 'BREAK',0,$a0 ;shifted space

forsiz	=@22
fndfor	tsx
	inx
	inx
	inx
	inx
ffloop	lda 257,x
	cmp #fortk
	bne ffrts
	lda forpnt+1
	bne cmpfor
	lda 258,x
	sta forpnt
	lda 259,x
	sta forpnt+1
cmpfor	cmp 259,x
	bne addfrs
	lda forpnt
	cmp 258,x
	beq ffrts
addfrs	txa 
	clc
	adc #forsiz
	tax
	bne ffloop
ffrts	rts
bltu	jsr reason
	sta strend
	sty strend+1
bltuc	sec
	lda hightr
	sbc lowtr
	sta index
	tay
	lda hightr+1
	sbc lowtr+1
	tax
	inx
	tya
	beq decblt
	lda hightr
	sec
	sbc index
	sta hightr
	bcs blt1
	dec hightr+1
	sec
blt1	lda highds
	sbc index
	sta highds
	bcs moren1
	dec highds+1
	bcc moren1
bltlp	lda (hightr),y
	sta (highds),y
moren1	dey
	bne bltlp
	lda (hightr),y
	sta (highds),y
decblt	dec hightr+1
	dec highds+1
	dex
	bne moren1
	rts
getstk	asl a
	adc #numlev+numlev+16
	bcs omerr
	sta index
	tsx
	cpx index
	bcc omerr
	rts
reason	cpy fretop+1
	bcc rearts
	bne trymor
	cmp fretop
	bcc rearts
trymor	pha
	ldx #8+addprc
	tya
reasav	pha
	lda highds-1,x
	dex
	bpl reasav
	jsr garba2
	ldx #248-addprc
reasto	pla
	sta highds+8+addprc,x
	inx
	bmi reasto
	pla
	tay
	pla
	cpy fretop+1
	bcc rearts
	bne omerr
	cmp fretop
	bcs omerr
rearts	rts

