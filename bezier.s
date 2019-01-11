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
	mov r9, 0xFF00FF00

begin:	
	cmp rsi, 0
	jz end

points: 
	xor r10, r10
	xor r11, r10

	mov r10d, [r14] ;wczytaj wspolrzedna x
	sal r10, 2  ;multiply by 4 

	mov r11d, [r15]
	mov rax, r11

	mov r11, 3200
	mul r11 
	mov r11, rax
	
	add r11, r10 ;obliczony offset
	mov rax, [rsp-8]
	add rax, r11
	
	mov [rax], r9d

	
	
end:
	pop r15
	pop r14
	mov rsp, rbp		;epilog
	pop rbp			;cofniecie esp o 8 i pobranie starego ebp
	ret 			;skok do adresu ze stosu

