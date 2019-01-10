section .text
global bezier

bezier:
	push rbp		;prolog
	mov rbp, rsp
	; rdi - poczatek bitmapy
	; rsi - liczba elementow
	; rdx - poczatek tablicy x
	; rcx - poczatek tablicy y

begin:
	mov rax, rdi
	cmp rax, 0
	jz end

	mov r10, 240000 ;max 480000

loop:
	mov [rax], DWORD 0xFF0000FF
	add rax, 4
	dec r10
	cmp r10, 0
	jnz loop

	;mov rax, rdi
	mov r9, 300

loop2:
	mov r10, 200
	mov r11, rax

inner_loop2:
	mov [rax], DWORD 0xFFFF0000
	add rax, 4
	dec r10
	cmp r10, 0
	jnz inner_loop2

	mov rax, r11
	add rax, 3200

	dec r9
	cmp r9, 0
	jnz loop2


end:
	mov rsp, rbp		;epilog
	pop rbp			;cofniecie esp o 4 i pobranie starego ebp
	ret 			;skok do adresu ze stosu

