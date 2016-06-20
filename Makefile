CC=gcc
CFLAGS= -c -O0 -masm=intel -m32 
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

linked_kernel: kernel.o linker.ld
	ld -m elf_i386 -e 0x40000 -s -o linked_kernel kernel.o

kernel.bin: linked_kernel
	objcopy -O binary linked_kernel kernel.bin

extend_file: extend_file.sh
	sh extend_file.sh

OS_1: bootLoader.bin 
	cat bootLoader.bin > os.bin
OS_2: OS_1 kernelLoader.bin $(OS)
	cat kernelLoader.bin >> os.bin
OS_3: OS_2 kernel.bin $(OS) extend_file
	cat kernel.bin >> os.bin

clean:
	rm *.bin *.o $(LINKED)
