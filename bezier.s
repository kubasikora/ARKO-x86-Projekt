[bits 64]
section .data
const_one: dd 1.0
const_one_th: dd 0.0001
const_zero: dd 0.0
const_two: dd 2.0
const_three: dd 3.0
const_four: dd 4.0
const_six: dd 6.0

section .text
global bezier

bezier:
	push rbp		;prolog
	mov rbp, rsp

	push rbx
	push r12
	push r13
	push r14
	push r15
	sub rsp, 8
	mov [rsp-8], rdi

	mov r14, rdx
	mov r15, rcx
	mov r9, 0xFF000000
	finit 

begin:	
	cmp rsi, 0
	je end

	cmp rsi, 2
	je two_points

	cmp rsi, 3
	je three_points

	cmp rsi, 4
	je four_points

	cmp rsi, 5
	je five_points

one_point:
	xor r10, r10
	xor r11, r10

	mov r10d, [r14] ;wczytaj wspolrzedna x
	sal r10, 2  ;multiply by 4 

	mov r11d, [r15]
	mov rax, 600
	sub rax, r11

	mov r11, 3200
	mul r11 
	mov r11, rax
	
	add r11, r10 ;obliczony offset
	mov rax, [rsp-8]
	add rax, r11
	
	mov [rax], r9d
	mov [rax+4], r9d
	mov [rax-4], r9d
	mov [rax-3204], r9d
	mov [rax-3196], r9d
	mov [rax-3200], r9d
	mov [rax+3200], r9d
	mov [rax+3204], r9d
	mov [rax+3196], r9d

	jmp end

two_points:
	movss xmm0, dword [const_zero] ; to jest t
	movss xmm1, dword [const_one_th] ; o tyle zmniejszamy t

	cvtsi2ss xmm4, [r14] ;load x0
	cvtsi2ss xmm5, [r14+4] ; load x1
	cvtsi2ss xmm6, [r15] ; load y0
	cvtsi2ss xmm7, [r15+4]; load y1

loop_two_points:
two_points_x:
	movss xmm3, [const_one]
	subss xmm3, xmm0 ; 1-t

	movss xmm8, xmm3 ; (1-t)
	mulss xmm8, xmm4 ; (1-t) * x0

	movss xmm9, xmm0 ; t
	mulss xmm9, xmm5 ; t * x1

	addss xmm8, xmm9
	cvtss2si r10, xmm8

two_points_y:
	movss xmm8, xmm3 ; (1-t)
	mulss xmm8, xmm6 ; (1-t) * y0

	movss xmm9, xmm0 ; t 
	mulss xmm9, xmm7 ; t * y1
	
	addss xmm8, xmm9
	cvtss2si r11, xmm8

draw_from_two_points:
	sal r10, 2  ;multiply by 4 

	mov rax, 600
	sub rax, r11

	mov r11, 3200
	mul r11 
	mov r11, rax
	
	add r11, r10 ;obliczony offset
	mov rax, [rsp-8]
	add rax, r11
	
	mov [rax], r9d

next_two_points:
	addss xmm0, xmm1
	movss xmm3, [const_one]
	cmpss xmm3, xmm0, 2	
	movq rax, xmm3
	cmp rax, 0
	je loop_two_points 
	jmp draw_pressed_points

three_points:
	movss xmm0, dword [const_zero] ; to jest t
	movss xmm1, dword [const_one_th] ; o tyle zmniejszamy t

loop_three_points:
	cvtsi2ss xmm4, [r14] ;load x0
	cvtsi2ss xmm5, [r14+4] ; load x1
	cvtsi2ss xmm6, [r14+8] ; load x2

three_points_x:
	movss xmm3, [const_one]
	subss xmm3, xmm0 ; 1-t

	movss xmm10, xmm3 ; (1-t)
	mulss xmm10, xmm3 ; (1-t) * (1-t)
 	mulss xmm10, xmm4 ; (1-t) * (1-t) * x0

	movss xmm11, xmm3 ; (1-t)
	mulss xmm11, xmm0 ; (1-t) * t
	mulss xmm11, xmm5 ; (1-t) * t * x1
	mulss xmm11, [const_two] ; 2 * (1-t) * t * x1
	addss xmm10, xmm11

	movss xmm11, xmm0 ; t
	mulss xmm11, xmm0 ; t * t
	mulss xmm11, xmm6 ; t * t * x2
	addss xmm10, xmm11 
	
	cvtss2si r10, xmm10

three_points_y:
	cvtsi2ss xmm4, [r15] ;load x0
	cvtsi2ss xmm5, [r15+4] ; load x1
	cvtsi2ss xmm6, [r15+8] ; load x2

	movss xmm3, [const_one]
	subss xmm3, xmm0 ; 1-t

	movss xmm10, xmm3 ; (1-t)
	mulss xmm10, xmm3 ; (1-t) * (1-t)
	mulss xmm10, xmm4 ; (1-t) * (1-t) * y0

	movss xmm11, [const_one]
	subss xmm11, xmm0 ; (1-t)
	mulss xmm11, xmm0 ; (1-t) * t
	mulss xmm11, xmm5 ; (1-t) * t * x1
	mulss xmm11, [const_two] ; 2 * (1-t) * t * y1
	addss xmm10, xmm11 

	movss xmm11, xmm0 ; t
	mulss xmm11, xmm0 ; t * t
	mulss xmm11, xmm6 ; t * t * y2
	addss xmm10, xmm11
	
	cvtss2si r11, xmm10

draw_from_three_points:
	sal r10, 2  ;multiply by 4 

	mov rax, 600
	sub rax, r11

	mov r11, 3200
	mul r11 
	mov r11, rax
	
	add r11, r10 ;obliczony offset
	mov rax, [rsp-8]
	add rax, r11
	
	mov [rax], r9d
	;mov [rax+4], r9d
	;mov [rax-4], r9d
	;mov [rax-3200], r9d
	;mov [rax+3200], r9d

next_three_points:
	addss xmm0, xmm1
	movss xmm3, [const_one]
	cmpss xmm3, xmm0, 2	
	movq rax, xmm3
	cmp rax, 0
	je loop_three_points 
	jmp draw_pressed_points

four_points:
	movss xmm0, dword [const_zero] ; to jest t
	movss xmm1, dword [const_one_th] ; o tyle zmniejszamy t

loop_four_points:
	cvtsi2ss xmm4, [r14] ;load x0
	cvtsi2ss xmm5, [r14+4] ; load x1
	cvtsi2ss xmm6, [r14+8] ; load x2
	cvtsi2ss xmm7, [r14+12] ; load x3

four_points_x:
	movss xmm3, [const_one]
	subss xmm3, xmm0 ; 1-t

	movss xmm10, xmm3 ; (1-t)
	mulss xmm10, xmm3 ; (1-t) * (1-t)
	mulss xmm10, xmm3 ; (1-t) * (1-t) * (1-t)
	mulss xmm10, xmm4 ; (1-t) * (1-t) * (1-t) * x0

	movss xmm11, xmm3 ; (1-t)
	mulss xmm11, xmm3 ; (1-t) * (1-t)
	mulss xmm11, xmm0 ; (1-t) * (1-t) * t
	mulss xmm11, [const_three] ; 3 * (1-t) * (1-t) * t
	mulss xmm11, xmm5 ; 3 * (1-t) * (1-t) * t * x1
	addss xmm10, xmm11 

	movss xmm11, xmm3 ; (1-t)
	mulss xmm11, xmm0 ; (1-t) * t
	mulss xmm11, xmm0 ; (1-t) * t * t
	mulss xmm11, [const_three] ; 3 * (1-t) * (1-t) * t
	mulss xmm11, xmm6 ; 3 * (1-t) * (1-t) * t * x2
	addss xmm10, xmm11 

	movss xmm11, xmm0 ; t
	mulss xmm11, xmm0 ; t * t
	mulss xmm11, xmm0 ; t * t * t
	mulss xmm11, xmm7 ; x3 * t * t * t
	addss xmm10, xmm11 
	
	cvtss2si r10, xmm10

four_points_y:
	cvtsi2ss xmm4, [r15] ;load y0
	cvtsi2ss xmm5, [r15+4] ; load y1
	cvtsi2ss xmm6, [r15+8] ; load y2
	cvtsi2ss xmm7, [r15+12] ; load y3

	movss xmm3, [const_one]
	subss xmm3, xmm0 ; 1-t

	movss xmm10, xmm3 ; (1-t)
	mulss xmm10, xmm3 ; (1-t) * (1-t)
	mulss xmm10, xmm3 ; (1-t) * (1-t) * (1-t)
	mulss xmm10, xmm4 ; (1-t) * (1-t) * (1-t) * y0

	movss xmm11, xmm3 ; (1-t)
	mulss xmm11, xmm3 ; (1-t) * (1-t)
	mulss xmm11, xmm0 ; (1-t) * (1-t) * t
	mulss xmm11, [const_three] ; 3 * (1-t) * (1-t) * t
	mulss xmm11, xmm5 ; 3 * (1-t) * (1-t) * t * y1
	addss xmm10, xmm11 

	movss xmm11, xmm3 ; (1-t)
	mulss xmm11, xmm0 ; (1-t) * t
	mulss xmm11, xmm0 ; (1-t) * t * t
	mulss xmm11, [const_three] ; 3 * (1-t) * (1-t) * t
	mulss xmm11, xmm6 ; 3 * (1-t) * (1-t) * t * y2
	addss xmm10, xmm11 

	movss xmm11, xmm0 ; t
	mulss xmm11, xmm0 ; t * t
	mulss xmm11, xmm0 ; t * t * t
	mulss xmm11, xmm7 ; y3 * t * t * t
	addss xmm10, xmm11 
	
	cvtss2si r11, xmm10

draw_from_four_points:
	sal r10, 2  ;multiply by 4 

	mov rax, 600
	sub rax, r11

	mov r11, 3200
	mul r11 
	mov r11, rax
	
	add r11, r10 ;obliczony offset
	mov rax, [rsp-8]
	add rax, r11
	
	mov [rax], r9d

next_four_points:
	addss xmm0, xmm1
	movss xmm3, [const_one]
	cmpss xmm3, xmm0, 2	
	movq rax, xmm3
	cmp rax, 0
	je loop_four_points 
	jmp draw_pressed_points

five_points:
	movss xmm0, dword [const_zero] ; to jest t
	movss xmm1, dword [const_one_th] ; o tyle zmniejszamy t

loop_five_points:
	cvtsi2ss xmm4, [r14] ;load x0
	cvtsi2ss xmm5, [r14+4] ; load x1
	cvtsi2ss xmm6, [r14+8] ; load x2
	cvtsi2ss xmm7, [r14+12] ; load x3
	cvtsi2ss xmm8, [r14+16] ; load x4

five_points_x:
	movss xmm3, [const_one]
	subss xmm3, xmm0 ; 1-t

	movss xmm10, xmm3 ; (1-t)
	mulss xmm10, xmm3 ; (1-t) * (1-t)
	mulss xmm10, xmm3 ; (1-t) * (1-t) * (1-t)
	mulss xmm10, xmm3 ; (1-t) * (1-t) * (1-t) * (1-t)
	mulss xmm10, xmm4 ; (1-t) * (1-t) * (1-t) * (1-t) * x0

	movss xmm11, xmm3 ; (1-t)
	mulss xmm11, xmm3 ; (1-t) * (1-t)
	mulss xmm11, xmm3 ; (1-t) * (1-t) * (1-t)
	mulss xmm11, xmm0 ; (1-t) * (1-t) * (1-t) * t
	mulss xmm11, [const_four] ; 4 * (1-t) * (1-t) * (1-t) * t
	mulss xmm11, xmm5 ; 4 * (1-t) * (1-t) * (1-t) * t * x1
	addss xmm10, xmm11 

	movss xmm11, xmm3 ; (1-t)
	mulss xmm11, xmm3 ; (1-t) * (1-t)
	mulss xmm11, xmm0 ; (1-t) * (1-t) * t 
	mulss xmm11, xmm0 ; (1-t) * (1-t) * t  * t
	mulss xmm11, [const_six] ; 6 * (1-t) * (1-t) * t * t
	mulss xmm11, xmm6 ; 6 * (1-t) * (1-t) * t * t * x2
	addss xmm10, xmm11 

	movss xmm11, xmm3 ; (1-t)
	mulss xmm11, xmm0 ; (1-t) * t
	mulss xmm11, xmm0 ; (1-t) * t * t
	mulss xmm11, xmm0 ; (1-t) * t * t * t
	mulss xmm11, [const_four] ; 4 * t * (1-t) * t * t
	mulss xmm11, xmm7 ; 4 * (1-t) * t * t * t * x3
	addss xmm10, xmm11 

	movss xmm11, xmm0 ; t
	mulss xmm11, xmm0 ; t * t
	mulss xmm11, xmm0 ; t * t * t
	mulss xmm11, xmm0 ; t * t * t * t
	mulss xmm11, xmm8 ; x4 * t * t * t * t
	addss xmm10, xmm11 
	
	cvtss2si r10, xmm10

five_points_y:
	cvtsi2ss xmm4, [r15] ;load y0
	cvtsi2ss xmm5, [r15+4] ; load y1
	cvtsi2ss xmm6, [r15+8] ; load y2
	cvtsi2ss xmm7, [r15+12] ; load y3
	cvtsi2ss xmm8, [r15+16] ; load y4

	movss xmm3, [const_one]
	subss xmm3, xmm0 ; 1-t 

	movss xmm10, xmm3 ; (1-t)
	mulss xmm10, xmm3 ; (1-t) * (1-t)
	mulss xmm10, xmm3 ; (1-t) * (1-t) * (1-t)
	mulss xmm10, xmm3 ; (1-t) * (1-t) * (1-t) * (1-t)
	mulss xmm10, xmm4 ; (1-t) * (1-t) * (1-t) * (1-t) * y0

	movss xmm11, xmm3 ; (1-t)
	mulss xmm11, xmm3 ; (1-t) * (1-t)
	mulss xmm11, xmm3 ; (1-t) * (1-t) * (1-t)
	mulss xmm11, xmm0 ; (1-t) * (1-t) * (1-t) * t
	mulss xmm11, [const_four] ; 4 * (1-t) * (1-t) * (1-t) * t
	mulss xmm11, xmm5 ; 4 * (1-t) * (1-t) * (1-t) * t * y1
	addss xmm10, xmm11 

	movss xmm11, xmm3 ; (1-t)
	mulss xmm11, xmm3 ; (1-t) * (1-t)
	mulss xmm11, xmm0 ; (1-t) * (1-t) * t 
	mulss xmm11, xmm0 ; (1-t) * (1-t) * t  * t
	mulss xmm11, [const_six] ; 6 * (1-t) * (1-t) * t * t
	mulss xmm11, xmm6 ; 6 * (1-t) * (1-t) * t * t * y2
	addss xmm10, xmm11 

	movss xmm11, xmm3 ; (1-t)
	mulss xmm11, xmm0 ; (1-t) * t
	mulss xmm11, xmm0 ; (1-t) * t * t
	mulss xmm11, xmm0 ; (1-t) * t * t * t
	mulss xmm11, [const_four] ; 4 * (1-t) * t * t * t
	mulss xmm11, xmm7 ; 4 * (1-t) * t * t * t * y3
	addss xmm10, xmm11 

	movss xmm11, xmm0 ; t
	mulss xmm11, xmm0 ; t * t
	mulss xmm11, xmm0 ; t * t * t
	mulss xmm11, xmm0 ; t * t * t * t
	mulss xmm11, xmm8 ; y4 * t * t * t * t
	addss xmm10, xmm11 
	
	cvtss2si r11, xmm10

draw_from_five_points:
	sal r10, 2  ;multiply by 4 

	mov rax, 600
	sub rax, r11

	mov r11, 3200
	mul r11 
	mov r11, rax
	
	add r11, r10 ;obliczony offset
	mov rax, [rsp-8]
	add rax, r11
	
	mov [rax], r9d
	;mov [rax+4], r9d
	;mov [rax-4], r9d
	;mov [rax-3200], r9d
	;mov [rax+3200], r9d

next_five_points:
	addss xmm0, xmm1
	movss xmm3, [const_one]
	cmpss xmm3, xmm0, 2	
	movq rax, xmm3
	cmp rax, 0
	je loop_five_points 

draw_pressed_points:
	mov r10d, [r14] ;wczytaj wspolrzedna x
	sal r10, 2  ;multiply by 4 

	mov r11d, [r15]
	mov rax, 600
	sub rax, r11

	mov r11, 3200
	mul r11 
	mov r11, rax
	
	add r11, r10 ;obliczony offset
	mov rax, [rsp-8]
	add rax, r11
	
	mov [rax], r9d
	mov [rax+4], r9d
	mov [rax-4], r9d
	mov [rax-3204], r9d
	mov [rax-3196], r9d
	mov [rax-3200], r9d
	mov [rax+3200], r9d
	mov [rax+3204], r9d
	mov [rax+3196], r9d

	add r14, 4
	add r15, 4

	dec rsi
	cmp rsi, 0
	jnz draw_pressed_points

end:
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	mov rsp, rbp		;epilog
	pop rbp			;cofniecie esp o 8 i pobranie starego ebp
	ret 			;skok do adresu ze stosu

