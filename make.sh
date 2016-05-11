nasm -f bin -o kernelLoader.bin kernelLoader.asm
nasm -f bin -o bootLoader.bin bootLoader.asm
cat bootLoader.bin > os.bin
cat kernelLoader.bin >> os.bin
cat kernel.bin >> os.bin
