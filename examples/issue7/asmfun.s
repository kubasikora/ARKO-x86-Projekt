section .data
buffer: times 200 db 0

section .text
global issue7

issue7:
	push rbp
	mov rbp, rsp
	mov rax, buffer ;output
	mov rsi, 1 ;flag whether last byte was a space

	mov cl, [rdi]
	cmp cl, 0
	jz end

loop:
	cmp cl, ' '
	je space

	cmp cl, 'A'
	jl save
	cmp cl, 'Z'
	jg save

	;is a capital letter

	cmp rsi, 1
	je save
	jmp next

space:
	mov rsi, 1
	mov [rax], cl
	inc rax
	inc rdi
	mov cl, [rdi]
	cmp cl, 0
	jnz loop

save:
	mov rsi, 0
	mov [rax], cl
	inc rax

next:
	inc rdi
	mov cl, [rdi]
	cmp cl, 0
	jnz loop

end:
	mov cl, 0
	mov [rax], cl
	mov rax, buffer 
	mov rsp, rbp
	pop rbp
	ret