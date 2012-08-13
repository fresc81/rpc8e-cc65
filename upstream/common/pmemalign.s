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
	.dbg		file, "pmemalign.c", 7690, 1122209820
	.dbg		file, "/Users/steven/bin/lib/cc65/include/stddef.h", 2972, 1344797532
	.dbg		file, "/Users/steven/bin/lib/cc65/include/stdlib.h", 5606, 1344797532
	.dbg		file, "/Users/steven/bin/lib/cc65/include/_heap.h", 1145, 1344797532
	.dbg		file, "/Users/steven/bin/lib/cc65/include/errno.h", 4695, 1344797532
	.dbg		sym, "malloc", "00", extern, "_malloc"
	.dbg		sym, "free", "00", extern, "_free"
	.import		_malloc
	.import		_free
	.export		_posix_memalign

; ---------------------------------------------------------------
; int __near__ __fastcall__ posix_memalign (__near__ __near__ void**, unsigned int, unsigned int)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_posix_memalign: near

	.dbg	func, "posix_memalign", "00", extern, "_posix_memalign"
	.dbg	sym, "memptr", "00", auto, 4
	.dbg	sym, "alignment", "00", auto, 2
	.dbg	sym, "size", "00", auto, 0
	.dbg	sym, "rawsize", "00", auto, -2
	.dbg	sym, "uppersize", "00", auto, -4
	.dbg	sym, "lowersize", "00", auto, -6
	.dbg	sym, "b", "00", register, "regbank", 4
	.dbg	sym, "u", "00", register, "regbank", 2
	.dbg	sym, "p", "00", register, "regbank", 0

.segment	"CODE"

;
; {
;
	.dbg	line, "pmemalign.c", 63
	jsr     pushax
;
; register struct usedblock* b;       /* points to raw Block */
;
	.dbg	line, "pmemalign.c", 67
	jsr     decsp6
	lda     regbank+4
	ldx     regbank+5
	jsr     pushax
;
; register struct usedblock* u;       /* points to User block */
;
	.dbg	line, "pmemalign.c", 68
	lda     regbank+2
	ldx     regbank+3
	jsr     pushax
;
; register struct usedblock* p;       /* Points to upper block */
;
	.dbg	line, "pmemalign.c", 69
	lda     regbank+0
	ldx     regbank+1
	jsr     pushax
;
; if (size == 0) {
;
	.dbg	line, "pmemalign.c", 72
	ldy     #$0C
	lda     (sp),y
	iny
	ora     (sp),y
	bne     L0002
;
; *memptr = NULL;
;
	.dbg	line, "pmemalign.c", 73
	ldy     #$11
	lda     (sp),y
	sta     ptr1+1
	dey
	lda     (sp),y
	sta     ptr1
	lda     #$00
	sta     (ptr1)
	ldy     #$01
	sta     (ptr1),y
;
; return EINVAL;
;
	.dbg	line, "pmemalign.c", 74
	tax
	lda     #$07
	jmp     L0001
;
; if (alignment == 0 || (alignment & --alignment) != 0) {
;
	.dbg	line, "pmemalign.c", 78
L0002:	iny
	lda     (sp),y
	iny
	ora     (sp),y
	beq     L0009
	ldy     #$11
	jsr     pushwysp
	ldx     #$00
	lda     #$01
	ldy     #$10
	jsr     subeqysp
	jsr     tosandax
	cpx     #$00
	bne     L0009
	cmp     #$00
	beq     L0008
;
; *memptr = NULL;
;
	.dbg	line, "pmemalign.c", 79
L0009:	ldy     #$11
	lda     (sp),y
	sta     ptr1+1
	dey
	lda     (sp),y
	sta     ptr1
	lda     #$00
	sta     (ptr1)
	ldy     #$01
	sta     (ptr1),y
;
; return EINVAL;
;
	.dbg	line, "pmemalign.c", 80
	tax
	lda     #$07
	jmp     L0001
;
; b = malloc (size + alignment);
;
	.dbg	line, "pmemalign.c", 89
L0008:	ldy     #$0C
	lda     (sp),y
	ldy     #$0E
	clc
	adc     (sp),y
	pha
	dey
	lda     (sp),y
	ldy     #$0F
	adc     (sp),y
	tax
	pla
	jsr     _malloc
	sta     regbank+4
	stx     regbank+4+1
;
; if (b == NULL) {
;
	.dbg	line, "pmemalign.c", 92
	cpx     #$00
	bne     L0014
	cmp     #$00
	bne     L0014
;
; *memptr = NULL;
;
	.dbg	line, "pmemalign.c", 93
	ldy     #$11
	lda     (sp),y
	sta     ptr1+1
	dey
	lda     (sp),y
	sta     ptr1
	txa
	sta     (ptr1)
	ldy     #$01
	sta     (ptr1),y
;
; return ENOMEM;
;
	.dbg	line, "pmemalign.c", 94
	tax
	lda     #$02
	jmp     L0001
;
; u = *memptr = (struct usedblock*) (((unsigned)b + alignment) & ~alignment);
;
	.dbg	line, "pmemalign.c", 100
L0014:	ldy     #$13
	jsr     pushwysp
	ldy     #$11
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	clc
	adc     regbank+4
	sta     ptr1
	txa
	adc     regbank+4+1
	sta     ptr1+1
	iny
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	jsr     complax
	and     ptr1
	pha
	txa
	and     ptr1+1
	tax
	pla
	ldy     #$00
	jsr     staxspidx
	sta     regbank+2
	stx     regbank+2+1
;
; p = (struct usedblock*) ((char*)u + size);
;
	.dbg	line, "pmemalign.c", 103
	sta     ptr1
	stx     ptr1+1
	ldy     #$0D
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	clc
	adc     ptr1
	sta     regbank+0
	txa
	adc     ptr1+1
	sta     regbank+0+1
;
; b = (b-1)->start;
;
	.dbg	line, "pmemalign.c", 109
	lda     regbank+4
	ldx     regbank+4+1
	sec
	sbc     #$04
	bcs     L0025
	dex
L0025:	sta     ptr1
	stx     ptr1+1
	ldy     #$03
	lda     (ptr1),y
	tax
	dey
	lda     (ptr1),y
	sta     regbank+4
	stx     regbank+4+1
;
; rawsize = b->size;
;
	.dbg	line, "pmemalign.c", 110
	dey
	lda     (regbank+4),y
	tax
	lda     (regbank+4)
	ldy     #$0A
	jsr     staxysp
;
; uppersize = rawsize - (lowersize = (char*)p - (char*)b);
;
	.dbg	line, "pmemalign.c", 118
	jsr     pushax
	lda     regbank+0
	sec
	sbc     regbank+4
	pha
	lda     regbank+0+1
	sbc     regbank+4+1
	tax
	pla
	ldy     #$08
	jsr     staxysp
	jsr     tossubax
	ldy     #$08
	jsr     staxysp
;
; if (uppersize >= sizeof (struct freeblock) &&
;
	.dbg	line, "pmemalign.c", 119
	cmp     #$06
	txa
	sbc     #$00
	bcc     L002C
;
; lowersize >= sizeof (struct freeblock)) {
;
	.dbg	line, "pmemalign.c", 120
	ldy     #$07
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	cmp     #$06
	txa
	sbc     #$00
	bcc     L002C
;
; p->size  = uppersize;
;
	.dbg	line, "pmemalign.c", 123
	ldy     #$09
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	sta     (regbank+0)
	ldy     #$01
	txa
	sta     (regbank+0),y
;
; p->start = p;
;
	.dbg	line, "pmemalign.c", 124
	lda     regbank+0
	ldx     regbank+0+1
	iny
	sta     (regbank+0),y
	iny
	txa
	sta     (regbank+0),y
;
; free (p + 1);
;
	.dbg	line, "pmemalign.c", 127
	lda     regbank+0
	ldx     regbank+0+1
	clc
	adc     #$04
	bcc     L0036
	inx
L0036:	jsr     _free
;
; rawsize = lowersize;
;
	.dbg	line, "pmemalign.c", 130
	ldy     #$07
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	ldy     #$0A
	jsr     staxysp
;
; lowersize = ((char*)u - (char*)b) - sizeof (struct usedblock);
;
	.dbg	line, "pmemalign.c", 141
L002C:	lda     regbank+2
	sec
	sbc     regbank+4
	pha
	lda     regbank+2+1
	sbc     regbank+4+1
	tax
	pla
	sec
	sbc     #$04
	bcs     L003C
	dex
L003C:	ldy     #$06
	jsr     staxysp
;
; if (           lowersize  >= sizeof (struct freeblock) &&
;
	.dbg	line, "pmemalign.c", 142
	cmp     #$06
	txa
	sbc     #$00
	bcc     L003D
;
; (rawsize - lowersize) >= sizeof (struct freeblock)) {
;
	.dbg	line, "pmemalign.c", 143
	ldy     #$0B
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	sec
	ldy     #$06
	sbc     (sp),y
	pha
	txa
	iny
	sbc     (sp),y
	tax
	pla
	cmp     #$06
	txa
	sbc     #$00
	bcc     L003D
;
; b->size  = lowersize;
;
	.dbg	line, "pmemalign.c", 148
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	sta     (regbank+4)
	ldy     #$01
	txa
	sta     (regbank+4),y
;
; b->start = b;
;
	.dbg	line, "pmemalign.c", 149
	lda     regbank+4
	ldx     regbank+4+1
	iny
	sta     (regbank+4),y
	iny
	txa
	sta     (regbank+4),y
;
; free (b + 1);
;
	.dbg	line, "pmemalign.c", 152
	lda     regbank+4
	ldx     regbank+4+1
	clc
	adc     #$04
	bcc     L0048
	inx
L0048:	jsr     _free
;
; rawsize -= lowersize;
;
	.dbg	line, "pmemalign.c", 155
	ldy     #$07
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	ldy     #$0A
	jsr     subeqysp
;
; b = u - 1;
;
	.dbg	line, "pmemalign.c", 158
	lda     regbank+2
	ldx     regbank+2+1
	sec
	sbc     #$04
	bcs     L004D
	dex
L004D:	sta     regbank+4
	stx     regbank+4+1
;
; b->size = rawsize;
;
	.dbg	line, "pmemalign.c", 167
L003D:	ldy     #$0B
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	sta     (regbank+4)
	ldy     #$01
	txa
	sta     (regbank+4),y
;
; (u-1)->start = b;
;
	.dbg	line, "pmemalign.c", 168
	lda     regbank+2
	ldx     regbank+2+1
	sec
	sbc     #$04
	bcs     L0052
	dex
L0052:	sta     ptr1
	stx     ptr1+1
	lda     regbank+4
	iny
	sta     (ptr1),y
	iny
	lda     regbank+4+1
	sta     (ptr1),y
;
; return EOK;
;
	.dbg	line, "pmemalign.c", 170
	ldx     #$00
	txa
;
; }
;
	.dbg	line, "pmemalign.c", 171
L0001:	pha
	ldy     #$00
L0055:	lda     (sp),y
	sta     regbank+0,y
	iny
	cpy     #$06
	bne     L0055
	pla
	ldy     #$12
	jmp     addysp
	.dbg	line

.endproc

