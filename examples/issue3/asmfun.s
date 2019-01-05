section .text
global issue3

issue3: ;prolog
	push rbp ;wrzuc na stos wskaznik ramki
	mov rbp, rsp ;ustaw wskaznik ramki wskaznikiem stosu
	mov rax, rdi ;ustaw argument do rax
	push rbx
	mov rbx, 0

begin:
	mov cl, [rax]
	cmp cl, 0
	jz end

	inc rbx
	push rcx
	inc rax
	jmp begin

end:
	mov rax, rdi

end_loop:
	pop rcx
	mov [rax], cl
	inc rax

	dec rbx
	cmp rbx, 0
	jnz end_loop

return_call:
	pop rbx
	mov rsp, rbp
	pop rbp
	ret





