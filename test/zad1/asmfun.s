section .text
global zad1

zad1:
	push rbp
	mov rbp, rsp

	mov r9, rdi ; wskaznik na wyrazenie sortowane argument

	mov cl, [rdi]
	cmp cl, 0
	jz end	

find_end:
	inc rdi 
	mov cl, [rdi]
	cmp cl, 0
	jnz find_end


	dec r9	;wracamy do ostatniego znaku a nie '\0'
	;r9 poczatek, rdi koniec stringa

start_loop:
	inc r9
	cmp r9, rdi 
	jge end
	mov al, [r9]

	;jesli nie cyfra, szukaj dalej
	cmp al, '0'
	jl start_loop
	cmp al, '9'
	jg start_loop

end_loop:
	dec rdi
	cmp r9, rdi
	jge end

	mov cl, [rdi]

	
	cmp cl, '0'
	jl end_loop	
	cmp cl, '9'
	jg end_loop

	;znalazl dwie cyfry -> zamien

	mov [rdi], al
	mov [r9], cl

	jmp start_loop

end:
	mov rsp, rbp
	pop rbp
	ret

