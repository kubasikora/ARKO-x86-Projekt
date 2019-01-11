section .text
global bezier

bezier:
	push rbp		;prolog
	mov rbp, rsp
	; rdi - poczatek bitmapy
	; rsi - liczba elementow
	; rdx/r14 - poczatek tablicy x
	; rcx/r15 - poczatek tablicy y
	push r14
	push r15
	sub rsp, 8
	mov [rsp-8], rdi

	mov r14, rdx
	mov r15, rcx
	mov r9, 0xFF000000

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
	mov [rax-3200], r9d
	mov [rax+3200], r9d
	
	jmp end

two_points:
	


three_points:
four_points:

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
	pop r15
	pop r14
	mov rsp, rbp		;epilog
	pop rbp			;cofniecie esp o 8 i pobranie starego ebp
	ret 			;skok do adresu ze stosu

