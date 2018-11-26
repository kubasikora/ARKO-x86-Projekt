section .text
global f

f:
	push ebp		;prolog
	mov ebp, esp
	mov eax, [ebp + 8]

begin:
	mov cl, [eax] 		;laduj pierwszy bajt spod wskaznika
	cmp cl, 0 		;czy zero
	jz end 			;czy wynik ostatniej operacji jest zerem

	add cl, 1
	mov [eax], cl
	inc eax
	jmp begin

end:
	mov esp, ebp		;epilog
	pop ebp			;cofniecie esp o 4 i pobranie starego ebp
	ret 			;skok do adresu ze stosu

