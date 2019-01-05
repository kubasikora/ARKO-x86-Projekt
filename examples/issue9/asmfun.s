section .text
global issue9

issue9:
	push rbp
	mov rbp, rsp

	mov cl, [rdi]
	cmp cl, 0
	jz end

loop:
	cmp cl, 'a'
	jl capital

	cmp cl, 'z'
	jg next

	sub cl, 0x20
	mov [rdi], cl
	jmp next


capital:
	cmp cl, 'A'
	jl next

	cmp cl, 'Z'
	jg next

	add cl, 0x20
	mov [rdi], cl

next:
	inc rdi
	mov cl, [rdi]
	cmp cl, 0
	jnz loop
	
end:
	mov rsp, rbp
	pop rbp
	ret