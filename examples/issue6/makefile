CC = gcc
CFLAGS = -Wall
NAME = issue6

all: main.o asmfun.o
	$(CC) $(CFLAGS) main.o asmfun.o -o $(NAME)
	rm -f *.o

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

asmfun.o: asmfun.s
	nasm -f elf64 -g asmfun.s

clean:
	rm -f *.o  $(NAME)
