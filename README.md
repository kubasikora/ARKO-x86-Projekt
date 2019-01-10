# ARKO-x86-Projekt
University Project for ARKO (Computer Architecture) course taken at Warsaw University of Technology 

Projekt z architektury x86 z przedmiotu ARKO (Architektura Komputerów) prowadzonego na Wydziale Elektroniki i Technik Informacyjnych Politechniki Warszawskiej

University Project for ARKO (Computers Architecture) course taken at Faculty of Electronic and Information Technology, Warsaw University of Technology

## Temat projektu

Projekt nr 12. Interaktywne rysowanie krzywych Beziera (krzywa pięciopunktowa).

Project no. 12: Drawing an interactive five point Bezier Curve

## Wersja projektu

Projekt piszemy w wersji 64 bitowej!

## Zalecenia

Zadaniem studenta jest określić jakie parametry dla algorytmu mogą być zmieniane przez użytkownika.
Wszystkie napisane projekty muszą działać w sposób interaktywny – z wykorzystaniem klawiatury lub myszki. Użycie klawiatury lub myszki przez użytkownika ma powodować odświeżenie obrazu generowanego przez algorytm (obraz ma być odświeżany w ramach raz uruchomionego programu).
Obsługa interfejsu użytkownika ma być napisana w C/C++, jedna funkcja assemblerowa ma rysować pełny wynik działania algorytmu na buforze przekazanym z poziomu funkcji main (gdzie został wcześniej utworzony). Funkcja assemblerowa przyjmuje jako argumenty parametry z dla jakich algorytm jest wywoływany. 
Pozostałe wymagania są umieszczone na stronie [laboratorium](home.elka.pw.edu.pl/~sniespod). 

Wskazówki do pisania projektów:
- Projekt polega na napisaniu hybrydowego programu w języku C i Assemblerze x86. Część assemblerowa powinna być JEDNĄ funkcją, wołaną z poziomu języka C. Powinna ona realizować główną funkcjonalność algorytmu.
- Program powinien być interaktywny - powinien zapewniać możliwość zmian parametrów w trakcie działania przy pomocy klawiatury i/lub myszki.
- Obsługa interakcji z używtkowniekiem oraz wyświetlanie wyników powinno być zrealizowane na poziomie języka C (z wykorzystaniem biblioteki graficznej np. Allegro, OpenGL).
- Część assemblerowa powinna być napisana z wykorzystaniem arytmetyki zmiennopozycyjnej(float).
- Prototyp funkcji napisanej w assemblerze: void function(unsigned char *pPixelBuffer, int width, int height, /* inne parametry specyficzne dla danego algorytmu */);
- Funkcja przyjmuje wskaźniek na bufor na którym później bedzie rysować. Bufor ten jest zaalokowany na poziomie języka C. Po potrocie z funkcji program na poziomie języka C powinien wyświetlić wynik działania. Każda zmiana parametru przez użytkownika powinna być wykryta na poziomie języka C i powinna zainicjować kolejne wywołanie funkcji assemblerowej. 


## Notatki do projektu 
### Registers
On a UNIX-like system, the first six parameters go into rdi, rsi, rdx, rcx, r8, and r9.

System V X86_642 	
- return value: rax, rdx 	
- argument registers: rdi, rsi, rdx, rcx, r8, r9 	
- additional parameters: stack (right to left) 	
- stack alignment 16-byte at call 	
- scratch registers: rax, rdi, rsi, rdx, rcx, r8, r9, r10, r11
- preserved register: rbx, rsp, rbp, r12, r13, r14, r15 	
- call list: rbp 

### Jumps
jmp - JuMP - A direct jump without looking at the system flags
je - Jump if Equal
jne - Jump if Not Equal
jl - Jump if Less
jle - Jump if Less or Equal
jg - Jump if Greater
jge - Jump if Greater or Equal
jnz - Jump if not zero 
jz - Jump if zero   

### Register division
RAX -> EAX -> AX -> AH & AL
RBX -> EBX -> BX -> BH & BL
RCX -> ECX -> CX -> CH & CL
RDX -> EDX -> DX -> DH & DL

R8 -> R8D -> R8W -> R8B
R9 -> R9D -> R9W -> R9B
R10 -> R10D -> R10W -> R10B
R11 -> R11D -> R11W -> R11B
R12 -> R12D -> R12W -> R12B
R13 -> R13D -> R13W -> R13B
R14 -> R14D -> R14W -> R14B
R15 -> R15D -> R15W -> R15B

RDI -> EDI -> DI -> DIL
RSP -> ESP -> SP -> SPL
RIP -> EIP -> IP

RFLAGS -> EFLAGS -> FLAGS

RBP -> EBP -> BP > BPL
RSI -> ESI -> SI > SIL

