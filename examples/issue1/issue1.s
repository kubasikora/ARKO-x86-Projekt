section .text
global issue1

issue1:
	push rbp		;prolog
	mov rbp, rsp
	mov rax, rdi

begin:
	mov cl, [rax] 		;laduj pierwszy bajt spod wskaznika
	cmp cl, 0 		;czy zero
	jz end 			;czy wynik ostatniej operacji jest zerem

	cmp cl, '0'
	jnge next
	cmp cl, '9'
	jnle next

	mov rdx, 69h
	sub rdx, rcx
	mov rcx, rdx

next:
	mov [rax], cl
	inc rax
	jmp begin


end:
	mov rsp, rbp		;epilog
	pop rbp			;cofniecie rsp o 8 i pobranie starego ebp
	ret 			;skok do adresu ze stosu

