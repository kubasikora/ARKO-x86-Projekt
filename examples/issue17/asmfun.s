section .text
global issue17

issue17:
	push rbp		;prolog
	mov rbp, rsp

	mov ecx, 0xFFFFFFCF
	mov r8, 0x20002000
	mov r9, 0x0000FFFF

loop:
	mov eax, [rdi]

	and eax, ecx
	or rax, r8

	mov [rdi], eax
	add rdi, 4

next:
	mov cl, [rdi]
	cmp cl, 0
	jnz loop

end:
	mov rsp, rbp		;epilog
	pop rbp			;cofniecie rsp o 8 i pobranie starego ebp
	ret 			;skok do adresu ze stosu

