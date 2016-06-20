int main(void) {

asm(".intel_syntax noprefix");
	char *video = (char*)0xB8000;
	char *string = "Hello World!";
	int i = 0;
    int max_background = 80*25*2;


    for(i = 0; i < max_background; i++) {
        *(video+i) = 0;
    }

/*
	for(i = 0; string[i] != 0; i++) {
		//*(video+i) = string[i];
		//*(video+i*2) = 0x09;
		//*(video+i*2) = string[i];
		*video++ = string[i];
		*video++ = 0x09;
	}
*/
	asm
	(
		"jmp $\n\t"
		"jmp $\n\t"
	);
	return 0;
}
