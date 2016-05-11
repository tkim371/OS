
;***************************************
;ReadSectors
;       param   @ax - Number of sectors
;               @ebx - Transfer Buffer
;               @ecx - Starting LBA
;***************************************

ReadSectors:

        pusha
        .retry:
                push    ax

                mov     dl, 0x10
                mov     [0x500], dl
                mov     dl, 0x00
                mov     [0x501], dl
                mov     [0x502], ax
                mov     [0x504], ebx
                mov     [0x508], ecx

                mov     ax, 0x500
                mov     si, ax
                mov     ax, 0
                mov     ds, ax

                mov     ah, 0x42
                mov     dl, 0x80
                int     0x13

                pop     ax
                ;jc      .retry
        popa
        ret




;**********************************
;	ClearBackground
;**********************************
ClearBackground:
        pusha
        mov     ax, 0xB800
        mov     es, ax

        mov     ax, [Background]
        mov     bx, 0
        mov     cx, 80*25*2

        CLS:
                mov     [es:bx], ax
                add     bx, 1
                loop    CLS
        popa
        ret

Background	db 0x0

