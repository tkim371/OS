int main(void) {

asm(".intel_syntax noprefix");
	char *video = (char*)0xB8000;
	char *string = "Hello World!";
	int i = 0;
    int max_background = 80*25*2;

/*
	for(i = 0; string[i] != '\0'; i++) {
		*video++ = string[i];
		*video++ = 0x09;
	}
*/
    for(i = 0; i < max_background; i++) {
        *(video+i) = 0;
    }

	asm
	(
		"jmp $\n\t"
		"jmp $\n\t"
        //"dup 512-($-$$) db 0x00"
	);
	return 0;
}
