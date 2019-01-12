CC = gcc
CFLAGS = -Wall -m64 -no-pie
ASMFILE = bezier
CFILE = main
NAME = bezier
LIBS = -lallegro -lallegro_dialog -lallegro_image

all: main.o bezier.o
	$(CC) $(CFLAGS) main.o bezier.o -o bezier $(LIBS)

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

bezier.o: bezier.s
	nasm -f elf64 -g bezier.s

clean:
	rm -f *.o bezier
