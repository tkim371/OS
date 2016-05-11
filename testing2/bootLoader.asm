;Bootloader, bootsect.asm
org	0x7C00
jmp Entry
%include "func.asm"

Entry:
;call ClearBackground
;rep stosd

mov	ax, 0x1
mov	ebx, 0x8000
mov	ecx, 0x1
call ReadSectors

jmp	0x8000

;**********************************
;	Varialbes
;**********************************



times 510-($-$$) db 0x00
dw 0xaa55
