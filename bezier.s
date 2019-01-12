[bits 64]
section .data
const_one: dd 1.0
const_one_th: dd 0.001
const_zero: dd 0.0
const_two: dd 2.0
const_three: dd 3.0
tmp: dd 0.0 

section .text
global bezier

bezier:
	push rbp		;prolog
	mov rbp, rsp

	push rbx
	push r12
	push r13
	push r14
	push r14
	push r15
	sub rsp, 8
	mov [rsp-8], rdi

	mov r14, rdx
	mov r15, rcx
	mov r9, 0xFF000000
	finit 
	;mov r10, 0
	;movss xmm0, dword [const_one]
	;movss xmm1, dword [const_one_th]
begin:	
	;subss xmm0, xmm1
	;movss xmm2, xmm0
	;inc r10 
	;cmpss xmm2, [const_zero], 2	
	;movq rax, xmm2
	;cmp rax, 0
	;je begin 

	;jmp end
	;cvtss2si r10d, xmm0
	;inc r9
	;cmp r9, 2
	;jne begin
	;ucomiss xmm0, [const_zero]	
	;jg begin
	;movss xmm5, dword [const_zero]
	;;movd eax, xmm5
	;movss xmm0, dword [const_one]
	;movss xmm5, dword [const_zero]
	;mov rax, 10000
	;cvtss2si eax, xmm0
	;mov eax, [const_zero]
	;jmp end

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
	mov [rax-3200], r9d
	mov [rax+3200], r9d
	
	jmp end

two_points:
	movss xmm0, dword [const_zero] ; to jest t
	movss xmm1, dword [const_one_th] ; o tyle zmniejszamy t
	movss xmm2, dword [const_zero]; zero do porownan

	cvtsi2ss xmm4, [r14] ;load x0
	cvtsi2ss xmm5, [r14+4] ; load x1
	cvtsi2ss xmm6, [r15] ; load y0
	cvtsi2ss xmm7, [r15+4]; load y1

loop_two_points:
two_points_x:
	movss xmm8, [const_one]
	subss xmm8, xmm0 
	mulss xmm8, xmm4

	movss xmm9, xmm0
	mulss xmm9, xmm5

	addss xmm8, xmm9
	cvtss2si r10, xmm8

two_points_y:
	movss xmm8, [const_one]
	subss xmm8, xmm0
	mulss xmm8, xmm6

	movss xmm9, xmm0
	mulss xmm9, xmm7
	
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
	mov [rax+4], r9d
	mov [rax-4], r9d
	mov [rax-3200], r9d
	mov [rax+3200], r9d

next_two_points:
	addss xmm0, xmm1
	movss xmm3, [const_one]
	cmpss xmm3, xmm0, 2	
	movq rax, xmm3
	cmp rax, 0
	je loop_two_points 

	jmp end	

three_points:
	movss xmm0, dword [const_zero] ; to jest t
	movss xmm1, dword [const_one_th] ; o tyle zmniejszamy t
	movss xmm2, dword [const_zero]; zero do porownan

loop_three_points:
	cvtsi2ss xmm4, [r14] ;load x0
	cvtsi2ss xmm5, [r14+4] ; load x1
	cvtsi2ss xmm6, [r14+8] ; load x2

three_points_x:
	movss xmm10, [const_one]
	subss xmm10, xmm0 
	mulss xmm10, xmm10
	mulss xmm10, xmm4

	movss xmm11, [const_one]
	subss xmm11, xmm0 ; 1-t
	mulss xmm11, xmm0
	mulss xmm11, xmm5
	mulss xmm11, [const_two]
	addss xmm10, xmm11

	movss xmm11, xmm0 ;t
	mulss xmm11, xmm11
	mulss xmm11, xmm6
	addss xmm10, xmm11
	
	cvtss2si r10, xmm10

three_points_y:
	cvtsi2ss xmm4, [r15] ;load x0
	cvtsi2ss xmm5, [r15+4] ; load x1
	cvtsi2ss xmm6, [r15+8] ; load x2

	movss xmm10, [const_one]
	subss xmm10, xmm0 
	mulss xmm10, xmm10
	mulss xmm10, xmm4

	movss xmm11, [const_one]
	subss xmm11, xmm0 ; 1-t
	mulss xmm11, xmm0 ; (1-t) * t
	mulss xmm11, xmm5 ; (1-t) * t * x1
	mulss xmm11, [const_two]
	addss xmm10, xmm11 

	movss xmm11, xmm0 ;t
	mulss xmm11, xmm11
	mulss xmm11, xmm6
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
	mov [rax+4], r9d
	mov [rax-4], r9d
	mov [rax-3200], r9d
	mov [rax+3200], r9d

next_three_points:
	addss xmm0, xmm1
	movss xmm3, [const_one]
	cmpss xmm3, xmm0, 2	
	movq rax, xmm3
	cmp rax, 0
	je loop_three_points 
	jmp end	


four_points:
	movss xmm0, dword [const_zero] ; to jest t
	movss xmm1, dword [const_one_th] ; o tyle zmniejszamy t
	movss xmm2, dword [const_zero]; zero do porownan

loop_four_points:
	cvtsi2ss xmm4, [r14] ;load x0
	cvtsi2ss xmm5, [r14+4] ; load x1
	cvtsi2ss xmm6, [r14+8] ; load x2
	cvtsi2ss xmm7, [r14+12] ; load x3

four_points_x:
	movss xmm10, [const_one]
	subss xmm10, xmm0 ; 1-t
	mulss xmm10, xmm10 ; (1-t) * (1-t)
	mulss xmm10, xmm10 ; (1-t) * (1-t) * (1-t)
	mulss xmm10, xmm4 ; (1-t) * (1-t) * (1-t) * x0

	movss xmm11, [const_one]
	subss xmm11, xmm0 ; 1-t
	mulss xmm11, xmm11 ; (1-t) * (1-t)
	mulss xmm11, xmm0 ; (1-t) * (1-t) * t
	mulss xmm11, [const_three] ; 3 * (1-t) * (1-t) * t
	mulss xmm11, xmm5 ; 3 * (1-t) * (1-t) * t * x1
	addss xmm10, xmm11 

	movss xmm11, [const_one]
	subss xmm11, xmm0 ; 1-t
	mulss xmm11, xmm0 ; (1-t) * t
	mulss xmm11, xmm0 ; (1-t) * t * t
	mulss xmm11, [const_three] ; 3 * (1-t) * (1-t) * t
	mulss xmm11, xmm6 ; 3 * (1-t) * (1-t) * t * x2
	addss xmm10, xmm11 

	movss xmm11, xmm0 ; t
	mulss xmm11, xmm11 ; t * t
	mulss xmm11, xmm11 ; t * t * t
	mulss xmm11, xmm7 ; x3 * t * t * t
	addss xmm10, xmm11 
	
	cvtss2si r10, xmm10

four_points_y:
	cvtsi2ss xmm4, [r15] ;load y0
	cvtsi2ss xmm5, [r15+4] ; load y1
	cvtsi2ss xmm6, [r15+8] ; load y2
	cvtsi2ss xmm7, [r15+12] ; load y3

	movss xmm10, [const_one]
	subss xmm10, xmm0 ; 1-t
	mulss xmm10, xmm10 ; (1-t) * (1-t)
	mulss xmm10, xmm10 ; (1-t) * (1-t) * (1-t)
	mulss xmm10, xmm4 ; (1-t) * (1-t) * (1-t) * y0

	movss xmm11, [const_one]
	subss xmm11, xmm0 ; 1-t
	mulss xmm11, xmm11 ; (1-t) * (1-t)
	mulss xmm11, xmm0 ; (1-t) * (1-t) * t
	mulss xmm11, [const_three] ; 3 * (1-t) * (1-t) * t
	mulss xmm11, xmm5 ; 3 * (1-t) * (1-t) * t * y1
	addss xmm10, xmm11 

	movss xmm11, [const_one]
	subss xmm11, xmm0 ; 1-t
	mulss xmm11, xmm0 ; (1-t) * t
	mulss xmm11, xmm0 ; (1-t) * t * t
	mulss xmm11, [const_three] ; 3 * (1-t) * (1-t) * t
	mulss xmm11, xmm6 ; 3 * (1-t) * (1-t) * t * y2
	addss xmm10, xmm11 

	movss xmm11, xmm0 ; t
	mulss xmm11, xmm11 ; t * t
	mulss xmm11, xmm11 ; t * t * t
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
	mov [rax+4], r9d
	mov [rax-4], r9d
	mov [rax-3200], r9d
	mov [rax+3200], r9d

next_four_points:
	addss xmm0, xmm1
	movss xmm3, [const_one]
	cmpss xmm3, xmm0, 2	
	movq rax, xmm3
	cmp rax, 0
	je loop_four_points 
	jmp end	


five_points: 
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
	mov [rax-3200], r9d
	mov [rax+3200], r9d

	add r14, 4
	add r15, 4

	dec rsi
	cmp rsi, 0
	jnz five_points

end:
	;mov rax, rsi
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	mov rsp, rbp		;epilog
	pop rbp			;cofniecie esp o 8 i pobranie starego ebp
	ret 			;skok do adresu ze stosu

