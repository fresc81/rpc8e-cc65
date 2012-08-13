;
; File generated by cc65 v 2.13.9
;
	.fopt		compiler,"cc65 v 2.13.9"
	.setcpu		"65816"
	.smart		on
	.autoimport	on
	.case		on
	.debuginfo	on
	.importzp	sp, sreg, regsave, regbank
	.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4
	.macpack	longbranch
	.dbg		file, "mktime.c", 6703, 1068590022
	.dbg		file, "/Users/steven/bin/lib/cc65/include/limits.h", 2978, 1344797532
	.dbg		file, "/Users/steven/bin/lib/cc65/include/stdlib.h", 5606, 1344797532
	.dbg		file, "/Users/steven/bin/lib/cc65/include/time.h", 5015, 1344797532
	.dbg		sym, "div", "00", extern, "_div"
	.import		_div
	.export		_mktime

.segment	"RODATA"

_MonthLength:
	.byte	$1F
	.byte	$1C
	.byte	$1F
	.byte	$1E
	.byte	$1F
	.byte	$1E
	.byte	$1F
	.byte	$1F
	.byte	$1E
	.byte	$1F
	.byte	$1E
	.byte	$1F
_MonthDays:
	.word	$0000
	.word	$001F
	.word	$003B
	.word	$005A
	.word	$0078
	.word	$0097
	.word	$00B5
	.word	$00D4
	.word	$00F3
	.word	$0111
	.word	$0130
	.word	$014E

; ---------------------------------------------------------------
; unsigned long __near__ __fastcall__ mktime (register __near__ struct tm*)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_mktime: near

	.dbg	func, "mktime", "00", extern, "_mktime"
	.dbg	sym, "TM", "00", register, "regbank", 4
	.dbg	sym, "D", "00", register, "regbank", 0
	.dbg	sym, "Max", "00", auto, -6
	.dbg	sym, "DayCount", "00", auto, -8

.segment	"CODE"

;
; {
;
	.dbg	line, "mktime.c", 83
	jsr     pushax
	ldy     #$00
	ldx     #$04
	jsr     regswap2
;
; register div_t D;
;
	.dbg	line, "mktime.c", 84
	jsr     decsp4
	ldy     #$03
L002A:	lda     regbank-1,x
	sta     (sp),y
	dey
	dex
	bne     L002A
;
; if (TM == 0) {
;
	.dbg	line, "mktime.c", 89
	jsr     decsp4
	lda     regbank+4
	ora     regbank+4+1
;
; goto Error;
;
	.dbg	line, "mktime.c", 91
	jeq     L002E
;
; D = div (TM->tm_sec, 60);
;
	.dbg	line, "mktime.c", 95
	ldy     #$01
	lda     (regbank+4),y
	tax
	lda     (regbank+4)
	jsr     pushax
	ldx     #$00
	lda     #$3C
	jsr     _div
	sta     regbank+0
	stx     regbank+0+1
	ldy     sreg
	sty     regbank+0+2
	ldy     sreg+1
	sty     regbank+0+3
;
; TM->tm_sec = D.rem;
;
	.dbg	line, "mktime.c", 96
	lda     regbank+0
	sta     (regbank+4)
	ldy     #$01
	lda     regbank+0+1
	sta     (regbank+4),y
;
; if (TM->tm_min + D.quot < 0) {
;
	.dbg	line, "mktime.c", 99
	ldy     #$03
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	clc
	adc     regbank+2
	txa
	adc     regbank+2+1
	tax
	cpx     #$80
;
; goto Error;
;
	.dbg	line, "mktime.c", 100
	jcs     L002E
;
; TM->tm_min += D.quot;
;
	.dbg	line, "mktime.c", 102
	lda     regbank+4
	ldx     regbank+4+1
	jsr     pushax
	ldy     #$03
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	clc
	adc     regbank+2
	pha
	txa
	adc     regbank+2+1
	tax
	pla
	jsr     staxspidx
;
; D = div (TM->tm_min, 60);
;
	.dbg	line, "mktime.c", 103
	iny
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	jsr     pushax
	ldx     #$00
	lda     #$3C
	jsr     _div
	sta     regbank+0
	stx     regbank+0+1
	ldy     sreg
	sty     regbank+0+2
	ldy     sreg+1
	sty     regbank+0+3
;
; TM->tm_min = D.rem;
;
	.dbg	line, "mktime.c", 104
	lda     regbank+0
	ldy     #$02
	sta     (regbank+4),y
	iny
	lda     regbank+0+1
	sta     (regbank+4),y
;
; if (TM->tm_hour + D.quot < 0) {
;
	.dbg	line, "mktime.c", 107
	ldy     #$05
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	clc
	adc     regbank+2
	txa
	adc     regbank+2+1
	tax
	cpx     #$80
;
; goto Error;
;
	.dbg	line, "mktime.c", 108
	jcs     L002E
;
; TM->tm_hour += D.quot;
;
	.dbg	line, "mktime.c", 110
	lda     regbank+4
	ldx     regbank+4+1
	jsr     pushax
	ldy     #$05
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	clc
	adc     regbank+2
	pha
	txa
	adc     regbank+2+1
	tax
	pla
	jsr     staxspidx
;
; D = div (TM->tm_hour, 24);
;
	.dbg	line, "mktime.c", 111
	iny
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	jsr     pushax
	ldx     #$00
	lda     #$18
	jsr     _div
	sta     regbank+0
	stx     regbank+0+1
	ldy     sreg
	sty     regbank+0+2
	ldy     sreg+1
	sty     regbank+0+3
;
; TM->tm_hour = D.rem;
;
	.dbg	line, "mktime.c", 112
	lda     regbank+0
	ldy     #$04
	sta     (regbank+4),y
	iny
	lda     regbank+0+1
	sta     (regbank+4),y
;
; if (TM->tm_mday + D.quot < 0) {
;
	.dbg	line, "mktime.c", 115
	ldy     #$07
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	clc
	adc     regbank+2
	txa
	adc     regbank+2+1
	tax
	cpx     #$80
;
; goto Error;
;
	.dbg	line, "mktime.c", 116
	jcs     L002E
;
; TM->tm_mday += D.quot;
;
	.dbg	line, "mktime.c", 118
	lda     regbank+4
	ldx     regbank+4+1
	jsr     pushax
	ldy     #$07
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	clc
	adc     regbank+2
	pha
	txa
	adc     regbank+2+1
	tax
	pla
L0099:	jsr     staxspidx
;
; D = div (TM->tm_mon, 12);
;
	.dbg	line, "mktime.c", 126
	ldy     #$09
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	jsr     pushax
	ldx     #$00
	lda     #$0C
	jsr     _div
	sta     regbank+0
	stx     regbank+0+1
	ldy     sreg
	sty     regbank+0+2
	ldy     sreg+1
	sty     regbank+0+3
;
; TM->tm_mon = D.rem;
;
	.dbg	line, "mktime.c", 127
	lda     regbank+0
	ldy     #$08
	sta     (regbank+4),y
	iny
	lda     regbank+0+1
	sta     (regbank+4),y
;
; if (TM->tm_year + D.quot < 0) {
;
	.dbg	line, "mktime.c", 128
	ldy     #$0B
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	clc
	adc     regbank+2
	txa
	adc     regbank+2+1
	tax
	cpx     #$80
;
; goto Error;
;
	.dbg	line, "mktime.c", 129
	jcs     L002E
;
; TM->tm_year += D.quot;
;
	.dbg	line, "mktime.c", 131
	lda     regbank+4
	ldx     regbank+4+1
	jsr     pushax
	ldy     #$0B
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	clc
	adc     regbank+2
	pha
	txa
	adc     regbank+2+1
	tax
	pla
	jsr     staxspidx
;
; if (TM->tm_mon == FEBRUARY && IsLeapYear (TM->tm_year + 1900)) {
;
	.dbg	line, "mktime.c", 136
	dey
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	cpx     #$00
	bne     L005B
	cmp     #$01
	bne     L005B
	ldy     #$0B
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	clc
	adc     #$6C
	pha
	txa
	adc     #$07
	tax
	pla
	jsr     _IsLeapYear
	tax
	beq     L005B
;
; Max = 29;
;
	.dbg	line, "mktime.c", 137
	ldy     #$02
	lda     #$1D
	sta     (sp),y
	lda     #$00
	iny
	sta     (sp),y
;
; } else {
;
	.dbg	line, "mktime.c", 138
	bra     L0063
;
; Max = MonthLength[TM->tm_mon];
;
	.dbg	line, "mktime.c", 139
L005B:	ldy     #$09
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	sta     ptr1
	txa
	clc
	adc     #>(_MonthLength)
	sta     ptr1+1
	ldy     #<(_MonthLength)
	lda     (ptr1),y
	ldx     #$00
	ldy     #$02
	jsr     staxysp
;
; if (TM->tm_mday > Max) {
;
	.dbg	line, "mktime.c", 141
L0063:	ldy     #$07
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	jsr     pushax
	ldy     #$05
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	jsr     tosicmp
	bmi     L004E
	beq     L004E
;
; if (TM->tm_mon == DECEMBER) {
;
	.dbg	line, "mktime.c", 143
	ldy     #$09
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	cpx     #$00
	bne     L0069
	cmp     #$0B
	bne     L0069
;
; TM->tm_mon = JANUARY;
;
	.dbg	line, "mktime.c", 144
	txa
	sta     (regbank+4),y
	iny
	sta     (regbank+4),y
;
; ++TM->tm_year;
;
	.dbg	line, "mktime.c", 145
	ldy     #$0B
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
;
; } else {
;
	.dbg	line, "mktime.c", 146
	bra     L00A4
;
; ++TM->tm_mon;
;
	.dbg	line, "mktime.c", 147
L0069:	iny
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
L00A4:	ina
	bne     L009B
	inx
L009B:	sta     (regbank+4),y
	iny
	txa
	sta     (regbank+4),y
;
; TM->tm_mday -= Max;
;
	.dbg	line, "mktime.c", 149
	lda     regbank+4
	ldx     regbank+4+1
	jsr     pushax
	ldy     #$07
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	sec
	ldy     #$04
	sbc     (sp),y
	pha
	txa
	iny
	sbc     (sp),y
	tax
	pla
	iny
;
; } else {
;
	.dbg	line, "mktime.c", 150
	jmp     L0099
;
; TM->tm_yday = MonthDays[TM->tm_mon] + TM->tm_mday - 1;
;
	.dbg	line, "mktime.c", 159
L004E:	lda     regbank+4
	ldx     regbank+4+1
	jsr     pushax
	ldy     #$09
	lda     (regbank+4),y
	sta     tmp1
	dey
	lda     (regbank+4),y
	asl     a
	rol     tmp1
	clc
	adc     #<(_MonthDays)
	sta     ptr1
	lda     tmp1
	adc     #>(_MonthDays)
	sta     ptr1+1
	ldy     #$01
	lda     (ptr1),y
	tax
	lda     (ptr1)
	jsr     pushax
	ldy     #$07
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	jsr     tosaddax
	sec
	sbc     #$01
	bcs     L0079
	dex
L0079:	ldy     #$0E
	jsr     staxspidx
;
; if (TM->tm_mon > FEBRUARY && IsLeapYear (TM->tm_year + 1900)) {
;
	.dbg	line, "mktime.c", 160
	ldy     #$09
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	cmp     #$02
	txa
	sbc     #$00
	bvs     L007C
	eor     #$80
L007C:	bpl     L007A
	ldy     #$0B
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	clc
	adc     #$6C
	pha
	txa
	adc     #$07
	tax
	pla
	jsr     _IsLeapYear
	tax
	beq     L007A
;
; ++TM->tm_yday;
;
	.dbg	line, "mktime.c", 161
	ldy     #$0F
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	ina
	bne     L009E
	inx
L009E:	sta     (regbank+4),y
	iny
	txa
	sta     (regbank+4),y
;
; DayCount = ((unsigned) (TM->tm_year-70)) * 365U +
;
	.dbg	line, "mktime.c", 169
L007A:	ldy     #$0B
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	sec
	sbc     #$46
	bcs     L0086
	dex
L0086:	jsr     pushax
	ldx     #$01
	lda     #$6D
	jsr     tosumulax
;
; (((unsigned) (TM->tm_year-(68+1))) / 4) +
;
	.dbg	line, "mktime.c", 170
	sta     ptr1
	stx     ptr1+1
	ldy     #$0B
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	sec
	sbc     #$45
	bcs     L008B
	dex
L008B:	jsr     shrax2
	clc
	adc     ptr1
	pha
	txa
	adc     ptr1+1
	tax
	pla
;
; TM->tm_yday;
;
	.dbg	line, "mktime.c", 171
	jsr     pushax
	ldy     #$0F
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	jsr     tosaddax
	jsr     stax0sp
;
; TM->tm_wday = (JAN_1_1970 + DayCount) % 7;
;
	.dbg	line, "mktime.c", 174
	lda     regbank+4
	ldx     regbank+4+1
	jsr     pushax
	ldy     #$03
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	clc
	adc     #$04
	bcc     L008F
	inx
L008F:	jsr     pushax
	lda     #$07
	jsr     tosumoda0
	ldy     #$0C
	jsr     staxspidx
;
; TM->tm_isdst = 0;
;
	.dbg	line, "mktime.c", 177
	lda     #$00
	ldy     #$10
	sta     (regbank+4),y
	iny
	sta     (regbank+4),y
;
; return DayCount * 86400UL +
;
	.dbg	line, "mktime.c", 180
	ldy     #$01
	lda     (sp),y
	tax
	lda     (sp)
	jsr     push0ax
	ldx     #$51
	lda     #$01
	sta     sreg
	lda     #$80
	jsr     tosumuleax
;
; ((unsigned) TM->tm_hour) * 3600UL +
;
	.dbg	line, "mktime.c", 181
	jsr     pusheax
	ldy     #$05
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	jsr     push0ax
	ldx     #$0E
	lda     #$10
	jsr     tosumul0ax
	jsr     tosaddeax
;
; ((unsigned) TM->tm_min) * 60U +
;
	.dbg	line, "mktime.c", 182
	jsr     pusheax
	ldy     #$03
	lda     (regbank+4),y
	tax
	dey
	lda     (regbank+4),y
	jsr     pushax
	lda     #$3C
	jsr     tosumula0
	jsr     tosadd0ax
;
; ((unsigned) TM->tm_sec);
;
	.dbg	line, "mktime.c", 183
	jsr     pusheax
	ldy     #$01
	lda     (regbank+4),y
	tax
	lda     (regbank+4)
	jsr     tosadd0ax
	bra     L0029
;
; return (time_t) -1L;
;
	.dbg	line, "mktime.c", 187
L002E:	ldx     #$FF
	stx     sreg
	stx     sreg+1
	txa
;
; }
;
	.dbg	line, "mktime.c", 188
L0029:	pha
	stx     tmp1
	ldy     #$09
	ldx     #$05
L0097:	lda     (sp),y
	sta     regbank+0,x
	dey
	dex
	bpl     L0097
	ldx     tmp1
	pla
	ldy     #$0A
	jmp     addysp
	.dbg	line

.endproc

; ---------------------------------------------------------------
; unsigned char __near__ __fastcall__ IsLeapYear (unsigned int)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_IsLeapYear: near

	.dbg	func, "IsLeapYear", "00", static, "_IsLeapYear"
	.dbg	sym, "Year", "00", auto, 0

.segment	"CODE"

;
; {
;
	.dbg	line, "mktime.c", 72
	jsr     pushax
;
; return (((Year % 4) == 0) && ((Year % 100) != 0 || (Year % 400) == 0));
;
	.dbg	line, "mktime.c", 73
	lda     (sp)
	ldx     #$00
	and     #$03
	bne     L00A5
	jsr     pushw0sp
	lda     #$64
	jsr     tosumoda0
	cpx     #$00
	bne     L0022
	cmp     #$00
	bne     L00A9
	jsr     pushw0sp
	ldx     #$01
	lda     #$90
	jsr     tosumodax
	cpx     #$00
	bne     L00A8
	cmp     #$00
	beq     L00A9
L00A8:	ldx     #$00
	txa
	jmp     incsp2
L0022:	ldx     #$00
L00A9:	lda     #$01
	jmp     incsp2
L00A5:	txa
	jmp     incsp2
	.dbg	line

.endproc

