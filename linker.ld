    
/*
MEMORY
    {
     ram (rw): ORIGIN = 0x40000, LENGTH = 1M
    }
*/

SECTIONS
{
    .text.start (0x40000) : {
        *(.text)
    }
    .data :
    {
        . = ALIGN(4);
        *(.data)
    }
}
