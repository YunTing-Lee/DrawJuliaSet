	.global	__aeabi_idiv

	.text

	.global	drawJuliaSet

drawJuliaSet:

    ldr ip,[sp] @ load the fourth argument from stack, frame[][] begin address
	stmfd	sp!, {r4-r10,lr}

	sub	sp, sp, #52
	mov r5,sp
	str	r0, [r5]           @ cX
	str	r1, [r5, #4]       @ cY
	str	r2, [r5, #8]       @ width
	str	r3, [r5, #12]      @ height
    str ip, [r5, #16]      @ frame begin address
	mov	r6, #255           @ maxIter
	str	r6, [r5, #20]      @ 255
	mov	r6, #0             @ x = 0
	str	r6, [r5, #24]      @ store x
    subs r0,r14,r13
	b	CmpX_Width

CmpX_Width :
	ldr	r6, [r5, #24]      @ x
	ldr	r7, [r5, #8]       @ width
	cmp	r6, r7

	bge exit               @ x >= width

	movlt	r6, #0         @ y = 0
	str	r6, [r5, #28]      @ y
	b	CmpY_Height

CmpY_Height:
	ldr	r6, [r5, #28]      @ y
	ldr	r7, [r5, #12]      @ height
	cmp	r6, r7
	blt	set_Zx_Zy          @ y < height
	ldr	r6, [r5, #24]      @ load x
	addge	r6, r6, #1     @ x++
	str	r6, [r5, #24]      @ store x
	b CmpX_Width


set_Zx_Zy :
	ldr	r7, [r5, #8]       @ r7=width
	mov	r7, r7, asr #1     @ r7 = width >> 1
	ldr	r6, [r5, #24]      @ r6 = x
	sub	r6, r6, r7         @ r6 = r6 - r7 = x - (width>>1)
	ldr	r8,=1500           @ r8 = 1500
	mul	r8, r8, r6         @ r8 = 1500  * ( x - (width>>1) )

	mov	r0, r8             @ r0= r8=1500  * ( x - (width>>1) )
	mov	r1, r7             @ r1 = width >> 1
	bl	__aeabi_idiv       @ r0 = r0/r1
	str	r0, [r5, #32]      @ store zx

	ldr	r7, [r5, #12]      @ r7 = height
	mov	r7, r7, asr #1     @ r7 = height >> 1
	ldr	r6, [r5, #28]      @ r6 = y
	sub	r6, r6, r7         @ r6 = r6 - r7 = y -( height >> 1 )
	mov	r8, #1000
	mul	r8, r8, r6         @ r8 = 1000 *( y -( height >> 1 ) )

	mov	r0, r8             @ r0 =  1000 *( y -( height >> 1 ) )
	mov	r1, r7             @ r1 =  height >> 1
	bl	__aeabi_idiv

	str	r0, [r5, #36]      @ store zy
	ldr	r6, [r5, #20]      @ i = maxIter = 255
	str	r6, [r5, #40]      @ store i
	b	while

while:
	ldr	r6, [r5, #32]      @ zx
	mul	r6, r6, r6         @ r6 = zx*zx
	ldr	r7, [r5, #36]      @ r7 = zy
	mul	r7, r7, r7         @ r7 = zy*zy
	add	r8, r6, r7         @ r8 = zx*zx + zy*zy
	ldr	r10,=4000000       @ 4000000
	cmp	r8, r10
	bge	setColor           @ zx*zx + zy*zy >= 4000000
	ldr	r6, [r5, #40]      @ i
	cmp	r6, #0
	ble setColor           @ i<=0

	ldr	r6, [r5, #32]      @ zx
	mul	r6, r6, r6         @ r6 =zx*zx
	ldr	r7, [r5, #36]      @ zy
	mul	r7, r7, r7         @ r7 = zy*zy
	sub	r8, r6, r7         @ r8 = zx*zx-zy*zy
    mov r0,r8              @ r0 = zx*zx-zy*zy
    ldr r1,=1000           @ r1 = 1000
    bl __aeabi_idiv        @ r0 = r0/r1
	ldr	r6, [r5, #0]       @ cx
	add	r6, r0, r6         @ r6 = (zx * zx - zy * zy)/1000 + cX;
	str	r6, [r5, #44]      @ store tmp
	ldr	r6, [r5, #32]      @ zx
	mov	r6, r6, asl #1     @ r6 = zx*2
	ldr	r7, [r5, #36]      @ zy
	mul	r8, r6, r7         @ r8 = 2*zx*zy
    mov r0,r8              @ r0 = 2*zx*zy
    ldr r1,=1000           @ r1 = 1000
    bl __aeabi_idiv        @ r0 = r0/r1

	ldr	r6, [r5, #4]       @ r6 = cY
	add	r6, r0, r6         @ r6 =(2*zx*zy/1000) +cY
	str	r6, [r5, #36]      @ store zy
	ldr	r6, [r5, #44]      @ load tmp
	str	r6, [r5, #32]      @ zx = tmp
	ldr	r6, [r5, #40]      @ i
	sub	r6, r6, #1         @ i--
	str	r6, [r5, #40]      @ store i
	b while

setColor:
    ldr	r6, [r5, #40]      @ i
    and r6,r6,#0xff        @ r6 = i & 0xff
    mov r7,r6,lsl #8       @ r7 = (i & 0xff) << 8
    orr r6,r7,r6           @ color = ((i&0xff)<<8) | (i&0xfff)
    strh r6,[r5, #48]      @ store color half word 2bytes
    ldrh r6,[r5, #48]      @ r6 = color
    mvn r6,r6              @ color = ~color
    ldr r7,=0xffff
    and r6,r6,r7           @ r6 = (~color) & 0xffff
    strh r6,[r5, #48]      @ store color half word

	ldr	r9, [r5, #28]      @ r9 = y
	ldr r7, [r5, #8]       @ width
	mul r8,r9,r7           @ r8 = y * width
	ldr r10,[r5, #24]      @ x
	add r6,r8,r10          @ r6 = y*width + x
	mov r6,r6, asl #1      @ r6 = (y*width + x)*2
	ldr	r7, [r5, #16]      @ r7 =frame beginning address
	add r7,r7,r6           @ frame[y][x] address = frame begin address + (y*width+x)*2
	ldrh r2, [r5, #48]     @ load color
	strh r2, [r7]          @ store color in frame[y][x]

	ldr	r6, [r5, #28]      @ load y
	add	r6, r6, #1         @ y++
	str	r6, [r5, #28]      @ store y
	b CmpY_Height

exit :

	add sp,sp, #52
	ldmfd	sp!, {r4-r10,lr}
	mov pc,lr


