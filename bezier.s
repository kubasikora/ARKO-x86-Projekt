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

	mov [rax], DWORD 0xFF0000FF
	add rax, 4
	mov  [rax], DWORD 0x000000FF
	add rax, 4

	mov rax, rdi

end:
	mov rsp, rbp		;epilog
	pop rbp			;cofniecie esp o 4 i pobranie starego ebp
	ret 			;skok do adresu ze stosu

