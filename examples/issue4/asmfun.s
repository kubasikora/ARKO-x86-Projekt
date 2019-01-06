section .text
global issue4

issue4:
	push rbp		;prolog
	mov rbp, rsp
	mov rax, 0

	mov cl, [rdi]
	cmp cl, 0
	jz end

loop:
	cmp cl, 'a'
	jl next

	cmp cl, 'z'
	jg next

	inc rax
	cmp rax, 3
	jne next

	and cl, 0xdf
	mov [rdi], cl
	mov rax, 0

next:
	inc rdi
	mov cl, [rdi]
	cmp cl, 0
	jnz loop

end:
	mov rsp, rbp		;epilog
	pop rbp			;cofniecie rsp o 8 i pobranie starego ebp
	ret 			;skok do adresu ze stosu

