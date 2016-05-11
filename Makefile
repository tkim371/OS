CC=gcc
CFLAGS= -c -masm=intel
LDFLAGS=
SOURCES=
OBJECTS= -o
B_FILES=bootLoader.bin kernelLoader.bin kernel.bin
LINKED=kernel_linked
OS=os.bin

all: OS_3

bootLoader.bin: bootLoader.asm
	nasm -f bin -o bootLoader.bin bootLoader.asm

kernelLoader.bin: kernelLoader.asm
	nasm -f bin -o kernelLoader.bin kernelLoader.asm

kernel.o: kernel.c
	$(CC) $(CFLAGS) -o kernel.o kernel.c

$(LINKED): kernel.o linker.ld
	ld -s -o $(LINKED) -T linker.ld kernel.o

kernel.bin: $(LINKED)
	#ld -o kernel.bin -Ttext 0x40000 kernel.o --oformat binary
	objcopy -O binary $(LINKED) kernel.bin
#mv $(LINKED) kernel.bin

#objcopy --set-start 0x40000 -O binary $(LINKED) kernel.bin
#kernel.bin: kernel_org.bin
#objcopy --set-start 40000 

OS_1: bootLoader.bin 
	cat bootLoader.bin > os.bin
OS_2: OS_1 kernelLoader.bin $(OS)
	cat kernelLoader.bin >> os.bin
OS_3: OS_2 kernel.bin $(OS)
	cat kernel.bin >> os.bin

clean:
	rm *.bin *.o $(LINKED)
