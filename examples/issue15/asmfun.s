section .data
	buffer: times 200 db 0

section .text
global issue15

issue15:
	push rbp
	mov rbp, rsp
	sub esp, 16 
	mov r8, 0	; equals n-1
	mov r9, rdi ; wskaznik na wyrazenie sortowane

find_length:
	mov cl, [rdi]
	inc r8
	inc rdi
	cmp cl, 0
	jnz find_length
	sub r8, 2 ; zapisz wartosc n-1 do r8

	cmp r8, 0 ; jesli n = 1 to nie sortuj
	je end

	mov r11, 0

outer_loop:
	mov r10, 0
	mov rax, r9 ;rax = d[0]
inner_loop:  
	mov r14b, [rax]
	mov r15b, [rax+1]

	cmp r14b, r15b
	jle inner_loop_next

swap:
	mov [rax], r15b
	mov [rax+1], r14b

inner_loop_next:
	inc r10
	inc rax
	cmp r10, r8
	jne inner_loop

outer_loop_next:
	inc r11
	cmp r11, r8
	jne outer_loop

end:
	mov rax, r9
	mov rsp, rbp
	pop rbp
	ret

