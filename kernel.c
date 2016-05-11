//.intel_syntax noprefix
int main(void) {

//asm(".intel_syntax noprefix");
	char *video = (char*)0xB8000;
	char *string = "Hello World!";
	int i = 0;

	for(i = 0; string[i] != 0; i++) {
		*video++ = string[i];
		*video++ = 0x09;
	}

	asm
	(
		"jmp $\n\t"
		"jmp $"
	);
	return 0;
}
