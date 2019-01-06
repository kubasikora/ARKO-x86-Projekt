section .data
buffer: times 200 db 0

section .text
global issue12

issue12:
	push rbp
	mov rbp, rsp
	push rbx
	mov rax, buffer ;output
	mov rsi, rdi

	mov cl, [rsi]
	cmp cl, 0
	jz end

outer_loop:
	mov rbx, rdi
	mov r8, 0
	mov dl, [rbx]

inner_loop:
	cmp cl, dl
	jne inner_loop_check
	inc r8	

inner_loop_check:
	cmp rbx, rsi
	je outer_loop_save

inner_loop_next:
	inc rbx
	mov dl, [rbx]
	jmp inner_loop
	
outer_loop_save:
	mov [rax], cl
	inc rax

	add r8, '0'
	mov [rax], r8b
	inc rax

outer_loop_next:
	inc rsi
	mov cl, [rsi]
	cmp cl, 0
	jnz outer_loop

end:
	mov rax, buffer 
	pop rbx
	mov rsp, rbp
	pop rbp
	ret