section .text
global bezier

bezier:
	push rbp		;prolog
	mov rbp, rsp
	mov rax, [rbp + 8]

begin:
	mov cl, [rax] 		;laduj pierwszy bajt spod wskaznika
	cmp cl, 0 		;czy zero
	jz end 			;czy wynik ostatniej operacji jest zerem

	add cl, 1
	mov [rax], cl
	inc rax
	jmp begin

end:
	mov rsp, rbp		;epilog
	pop rbp			;cofniecie esp o 4 i pobranie starego ebp
	ret 			;skok do adresu ze stosu

