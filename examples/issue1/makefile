CC = gcc
CFLAGS = -Wall

all: main.o issue1.o
	$(CC) $(CFLAGS) main.o issue1.o -o issue1

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

issue1.o: issue1.s
	nasm -f elf64 -g issue1.s

clean:
	rm -f *.o  
