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
	.dbg		file, "fsetpos.c", 398, 1068141847
	.dbg		file, "/Users/steven/bin/lib/cc65/include/stdio.h", 5951, 1344797532
	.dbg		file, "/Users/steven/bin/lib/cc65/include/stddef.h", 2972, 1344797532
	.dbg		file, "/Users/steven/bin/lib/cc65/include/stdarg.h", 2817, 1344797532
	.dbg		sym, "fseek", "00", extern, "_fseek"
	.export		_fsetpos
	.import		_fseek

; ---------------------------------------------------------------
; int __near__ __fastcall__ fsetpos (__near__ struct _FILE*, __near__ const unsigned long*)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_fsetpos: near

	.dbg	func, "fsetpos", "00", extern, "_fsetpos"
	.dbg	sym, "f", "00", auto, 2
	.dbg	sym, "pos", "00", auto, 0

.segment	"CODE"

;
; {
;
	.dbg	line, "fsetpos.c", 20
	jsr     pushax
;
; return fseek (f, (fpos_t)*pos, SEEK_SET);
;
	.dbg	line, "fsetpos.c", 21
	jsr     decsp6
	ldy     #$09
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	ldy     #$04
	sta     (sp),y
	iny
	txa
	sta     (sp),y
	ldy     #$07
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	jsr     ldeaxi
	jsr     steax0sp
	ldx     #$00
	lda     #$02
	jsr     _fseek
;
; }
;
	.dbg	line, "fsetpos.c", 22
	jmp     incsp4
	.dbg	line

.endproc
