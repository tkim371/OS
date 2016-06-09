CC=gcc
CFLAGS= -c -masm=intel 
LDFLAGS=
SOURCES=
OBJECTS= -o
B_FILES=bootLoader.bin kernelLoader.bin kernel.bin
OS=os.bin

all: OS_3

bootLoader.bin: bootLoader.asm
	nasm -f bin -o bootLoader.bin bootLoader.asm

kernelLoader.bin: kernelLoader.asm
	nasm -f bin -o kernelLoader.bin kernelLoader.asm

kernel.o: kernel.c
	$(CC) $(CFLAGS) -o kernel.o kernel.c

kernel.bin: kernel.o linker.ld
	#ld -s -o kernel.bin -T linker.ld kernel.o
	ld -e 0x40000 -s -o kernel.bin kernel.o

OS_1: bootLoader.bin 
	cat bootLoader.bin > os.bin
OS_2: OS_1 kernelLoader.bin $(OS)
	cat kernelLoader.bin >> os.bin
OS_3: OS_2 kernel.bin $(OS)
	cat kernel.bin >> os.bin

clean:
	rm *.bin *.o $(LINKED)
