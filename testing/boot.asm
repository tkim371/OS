[org 0x700]
mov bp, 0x9000
mov sp , bp

cli
lgdt [gdt_descriptor] 

; Enter PM
mov eax, cr0
or  eax, 0x1
mov cr0, eax

jmp 0x8:init_pm 


[bits 32]
init_pm :
    mov ax, 0x10
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ;Tried to call my C function from here 
    call 0x8000      ; Kernel entry point       

    jmp $


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
[bits 16]

GDT:
;null : 
    dd 0x0 
    dd 0x0

;code : 
    dw 0xffff       ;Limit
    dw 0x0          ;Base
    db 0x0          ;Base
    db 0b10011010   ;1st flag, Type flag
    db 0b11001111   ;2nd flag, Limit
    db 0x0          ;Base

;data : 
    dw 0xffff       
    dw 0x0          
    db 0x0
    db 0b10010010 
    db 0b11001111 
    db 0x0

gdt_descriptor :
    dw $ - GDT - 1      ;16-bit size
    dd GDT              ;32-bit start address


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55
