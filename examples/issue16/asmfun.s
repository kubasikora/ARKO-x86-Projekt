section .data
	buffer: times 200 db 0

section .text
global issue16

issue16:
	push rbp
	mov rbp, rsp

	mov rsi, buffer ; rax == ptr to buffer

	mov cl, [rdi]
	cmp cl, 0
	jz end
loop:
	cmp cl, '0'
	jl save

	cmp cl, '9'
	jg save

	mov rdx, rcx
	and rdx, 0x01

	cmp rdx, 0
	jz next

save: 
	mov [rsi], cl
	inc rsi

next:
	inc rdi
	mov cl, [rdi]
	cmp cl, 0
	jnz loop

end:
	mov rax, buffer

	mov rsp, rbp
	pop rbp
	ret

