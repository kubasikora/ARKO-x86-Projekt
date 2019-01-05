section .text
global issue6

issue6:
	push rbp
	mov rbp, rsp
	mov rsi, rdi
	mov rax, 0

	mov cl, [rsi]
	cmp cl, 0
	jz end

begin:
	cmp cl, '0'
	jl next
	cmp cl, '9'
	jg next

	inc rax

next:
	inc rsi
	mov cl, [rsi]
	cmp cl, 0
	jnz begin

end:
	mov rsp, rbp
	pop rbp
	ret

