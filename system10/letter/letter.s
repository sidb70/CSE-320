	.cpu generic+fp+simd
	.file	"letter.c"
	.section	.rodata
	.align	3
.LC46:
	.string	"Your name: "
	.align	3
.LC47:
	.string	"Recipient name: "
	.align	3
.LC48:
	.string	"\nDear %s,\n\n"
	.align	3
.LC49:
	.string	"\n\nLove,\n%s\n\n"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB2:
	.cfi_startproc
	stp	x29, x30, [sp, -144]!
	.cfi_def_cfa_offset 144
	.cfi_offset 29, -144
	.cfi_offset 30, -136
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	w0, [x29,28]
	str	x1, [x29,16]
	mov	x0, 0
	bl	time
	bl	srand
	adrp	x0, .LC46
	add	x0, x0, :lo12:.LC46
	bl	printf
	adrp	x0, stdin
	add	x0, x0, :lo12:stdin
	ldr	x2, [x0]
	add	x0, x29, 88
	mov	w1, 50
	bl	fgets
	add	x0, x29, 88
	bl	trim_newline
	adrp	x0, .LC47
	add	x0, x0, :lo12:.LC47
	bl	printf
	adrp	x0, stdin
	add	x0, x0, :lo12:stdin
	ldr	x2, [x0]
	add	x0, x29, 32
	mov	w1, 50
	bl	fgets
	add	x0, x29, 32
	bl	trim_newline
	adrp	x0, .LC48
	add	x0, x0, :lo12:.LC48
	add	x1, x29, 32
	bl	printf
	mov	w0, 10
	bl	generate_letter
	adrp	x0, .LC49
	add	x0, x0, :lo12:.LC49
	add	x1, x29, 88
	bl	printf
	mov	w0, 0
	ldp	x29, x30, [sp], 144
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.align	2
	.global	trim_newline
	.type	trim_newline, %function
trim_newline:
.LFB3:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29,24]
	ldr	x0, [x29,24]
	bl	strlen
	str	x0, [x29,40]
	ldr	x0, [x29,40]
	cmp	x0, xzr
	bne	.L4
	b	.L3
.L4:
	ldr	x0, [x29,40]
	sub	x0, x0, #1
	ldr	x1, [x29,24]
	add	x0, x1, x0
	ldrb	w0, [x0]
	cmp	w0, 10
	bne	.L3
	ldr	x0, [x29,40]
	sub	x0, x0, #1
	ldr	x1, [x29,24]
	add	x0, x1, x0
	strb	wzr, [x0]
.L3:
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE3:
	.size	trim_newline, .-trim_newline
	.section	.rodata
	.align	3
.LC51:
	.string	" "
	.align	3
.LC52:
	.string	"%s "
	.text
	.align	2
	.global	generate_letter
	.type	generate_letter, %function
generate_letter:
.LFB4:
	.cfi_startproc
	sub	sp, sp, #624
	.cfi_def_cfa_offset 624
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 640
	.cfi_offset 29, -640
	.cfi_offset 30, -632
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	add	x1, x29, 28
	str	w0, [x1]
	add	x0, x29, 240
	adrp	x1, .LC50
	add	x1, x1, :lo12:.LC50
	mov	x2, 360
	bl	memcpy
	add	x0, x29, 40
	strb	wzr, [x0,199]
	mov	w0, 45
	str	w0, [x29,620]
	str	wzr, [x29,632]
	ldrsw	x0, [x29,620]
	mov	x1, 4
	bl	calloc
	str	x0, [x29,608]
	str	wzr, [x29,636]
	b	.L7
.L8:
	ldrsw	x0, [x29,636]
	lsl	x0, x0, 2
	ldr	x1, [x29,608]
	add	x0, x1, x0
	ldr	w1, [x29,636]
	str	w1, [x0]
	ldr	w0, [x29,636]
	add	w0, w0, 1
	str	w0, [x29,636]
.L7:
	ldr	w1, [x29,636]
	ldr	w0, [x29,620]
	cmp	w1, w0
	blt	.L8
	str	wzr, [x29,636]
	b	.L9
.L10:
	bl	rand
	ldr	w2, [x29,620]
	ldr	w1, [x29,636]
	sub	w1, w2, w1
	sub	w1, w1, #1
	sdiv	w2, w0, w1
	mul	w1, w2, w1
	sub	w1, w0, w1
	ldr	w0, [x29,636]
	add	w0, w1, w0
	add	w0, w0, 1
	str	w0, [x29,604]
	ldrsw	x0, [x29,636]
	lsl	x0, x0, 2
	ldr	x1, [x29,608]
	add	x0, x1, x0
	ldr	w0, [x0]
	str	w0, [x29,600]
	ldrsw	x0, [x29,636]
	lsl	x0, x0, 2
	ldr	x1, [x29,608]
	add	x0, x1, x0
	ldrsw	x1, [x29,604]
	lsl	x1, x1, 2
	ldr	x2, [x29,608]
	add	x1, x2, x1
	ldr	w1, [x1]
	str	w1, [x0]
	ldrsw	x0, [x29,604]
	lsl	x0, x0, 2
	ldr	x1, [x29,608]
	add	x0, x1, x0
	ldr	w1, [x29,600]
	str	w1, [x0]
	ldr	w0, [x29,636]
	add	w0, w0, 1
	str	w0, [x29,636]
.L9:
	ldr	w0, [x29,620]
	sub	w1, w0, #1
	ldr	w0, [x29,636]
	cmp	w1, w0
	bgt	.L10
	str	wzr, [x29,636]
	b	.L11
.L15:
	ldrsw	x0, [x29,636]
	lsl	x0, x0, 2
	ldr	x1, [x29,608]
	add	x0, x1, x0
	ldr	w0, [x0]
	add	x1, x29, 240
	sxtw	x0, w0
	lsl	x0, x0, 3
	add	x0, x1, x0
	ldr	x1, [x0]
	add	x0, x29, 40
	mov	x2, 199
	bl	strncpy
	add	x0, x29, 40
	adrp	x1, .LC51
	add	x1, x1, :lo12:.LC51
	bl	strtok
	str	x0, [x29,624]
	b	.L12
.L14:
	adrp	x0, .LC52
	add	x0, x0, :lo12:.LC52
	ldr	x1, [x29,624]
	bl	printf
	ldr	x0, [x29,624]
	bl	strlen
	mov	w1, w0
	ldr	w0, [x29,632]
	add	w0, w1, w0
	add	w0, w0, 1
	str	w0, [x29,632]
	ldr	w0, [x29,632]
	cmp	w0, 60
	ble	.L13
	mov	w0, 10
	bl	putchar
	str	wzr, [x29,632]
.L13:
	adrp	x0, .LC51
	add	x1, x0, :lo12:.LC51
	mov	x0, 0
	bl	strtok
	str	x0, [x29,624]
.L12:
	ldr	x0, [x29,624]
	cmp	x0, xzr
	bne	.L14
	ldr	w0, [x29,636]
	add	w0, w0, 1
	str	w0, [x29,636]
.L11:
	add	x0, x29, 28
	ldr	w1, [x29,636]
	ldr	w0, [x0]
	cmp	w1, w0
	blt	.L15
	ldr	x0, [x29,608]
	bl	free
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 624
	add	sp, sp, 624
	.cfi_def_cfa_offset 608
	ret
	.cfi_endproc
.LFE4:
	.size	generate_letter, .-generate_letter
	.section	.rodata
	.align	3
.LC0:
	.string	"I love you with all my heart."
	.align	3
.LC1:
	.string	"If I don't see you again soon I'm a gonna die!"
	.align	3
.LC2:
	.string	"Just as Darth Vader, an evil Sith Lord, could not leave his son to die, nor shall I ever leave you."
	.align	3
.LC3:
	.string	"I love you more than Sparty."
	.align	3
.LC4:
	.string	"When you are away, my toes ache."
	.align	3
.LC5:
	.string	"I would rob a convenience store for you."
	.align	3
.LC6:
	.string	"Every minute you are away seems like 17.53 hours."
	.align	3
.LC7:
	.string	"You are the hamster to my wheel."
	.align	3
.LC8:
	.string	"You are the Style to my Gangnum."
	.align	3
.LC9:
	.string	"When I smell flowers, I think of you, but only if the flowers smell really good."
	.align	3
.LC10:
	.string	"Every day we are apart an angel loses a wing."
	.align	3
.LC11:
	.string	"I love you more than Tony loved Elvira."
	.align	3
.LC12:
	.string	"Would you kiss me if I wear the hat?"
	.align	3
.LC13:
	.string	"Where've you been? It's 10:00, honey, I'm starving!"
	.align	3
.LC14:
	.string	"I like you better than better."
	.align	3
.LC15:
	.string	"When I look at you the ice melts in my drink."
	.align	3
.LC16:
	.string	"Our love will last longer than a cell phone contract."
	.align	3
.LC17:
	.string	"You are the cheese on my pepperoni pizza."
	.align	3
.LC18:
	.string	"Roses are red, violets are blue, Sparty is awesome, and so are you."
	.align	3
.LC19:
	.string	"When I saw you had ears, I knew you would be mine."
	.align	3
.LC20:
	.string	"If I was in one of those movies, I would saw off a foot for you."
	.align	3
.LC21:
	.string	"Love means never having to say that love means never having to say you're sorry."
	.align	3
.LC22:
	.string	"I love you so much it's creepy sometimes."
	.align	3
.LC23:
	.string	"I dream every day of your beautiful <insert color here> eyes."
	.align	3
.LC24:
	.string	"I will stand by you even when you smell really bad."
	.align	3
.LC25:
	.string	"I am the minion to your villianry."
	.align	3
.LC26:
	.string	"Together we are like Luke and Leia, before they found out they are brother and sister and it got creepy."
	.align	3
.LC27:
	.string	"You make me sing like a caged bird."
	.align	3
.LC28:
	.string	"You are my Neo in the matrix of life."
	.align	3
.LC29:
	.string	"We are like Norman and Marion, except for the ones in Psycho."
	.align	3
.LC30:
	.string	"You had me at hello."
	.align	3
.LC31:
	.string	"I would go to sea and fight Jaws with some really annoying people if you asked me to."
	.align	3
.LC32:
	.string	"You are my monolyth."
	.align	3
.LC33:
	.string	"You'll always be a T1000 model to my lowly T800."
	.align	3
.LC34:
	.string	"I would chop off the black knights arm just for you."
	.align	3
.LC35:
	.string	"Our love will survive, even after I've been turned into a newt."
	.align	3
.LC36:
	.string	"My broken heart is only a flesh wound."
	.align	3
.LC37:
	.string	"I would walk the desert while the Lawrence of Arabia soundtrack loudly plays if you asked."
	.align	3
.LC38:
	.string	"Let us grow old together as prisoners on Devil's island until we can escape on bags of coconuts."
	.align	3
.LC39:
	.string	"Let me be the Muriel to your Macon, but can we please leave Sarah out of this?"
	.align	3
.LC40:
	.string	"My face in thine eye, thine in mine appears, and true plain hearts do in three faces rest."
	.align	3
.LC41:
	.string	"You have a face like Vulnavia, at least before the acid messed it up."
	.align	3
.LC42:
	.string	"Is this real life?"
	.align	3
.LC43:
	.string	"I wish you were a Cylon so there could be even more copies of you out there."
	.align	3
.LC44:
	.string	"I will make you an offer you can't refuse."
	.align	3
.LC50:
	.xword	.LC0
	.xword	.LC1
	.xword	.LC2
	.xword	.LC3
	.xword	.LC4
	.xword	.LC5
	.xword	.LC6
	.xword	.LC7
	.xword	.LC8
	.xword	.LC9
	.xword	.LC10
	.xword	.LC11
	.xword	.LC12
	.xword	.LC13
	.xword	.LC14
	.xword	.LC15
	.xword	.LC16
	.xword	.LC17
	.xword	.LC18
	.xword	.LC19
	.xword	.LC20
	.xword	.LC21
	.xword	.LC22
	.xword	.LC23
	.xword	.LC24
	.xword	.LC25
	.xword	.LC26
	.xword	.LC27
	.xword	.LC28
	.xword	.LC29
	.xword	.LC30
	.xword	.LC31
	.xword	.LC32
	.xword	.LC33
	.xword	.LC34
	.xword	.LC35
	.xword	.LC36
	.xword	.LC37
	.xword	.LC38
	.xword	.LC39
	.xword	.LC40
	.xword	.LC41
	.xword	.LC42
	.xword	.LC43
	.xword	.LC44
	.text
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-44)"
	.section	.note.GNU-stack,"",%progbits
