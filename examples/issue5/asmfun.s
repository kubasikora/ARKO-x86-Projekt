section .data
buffer: times 200 db 0

section .text
global issue5

issue5:
	push rbp
	mov rbp, rsp
	mov rax, buffer ;output
	mov rdx, rdi ; input

	mov cl, [rdx]
	cmp cl, 0
	jz end
begin:
	

	cmp cl, '0'
	jl nan

	cmp cl, '9'
	jg nan

	jmp next

nan:
	mov [rax], cl
	inc rax

next:
	inc rdx
	mov cl, [rdx]
	cmp cl, 0
	jnz begin

end:
	mov rax, buffer 
	mov rsp, rbp
	pop rbp
	ret