[org 0x7c00] ; tells the assembler where the code will be loaded, 0x7c00 is the offset for BIOS boot sector
mov bx, message ; loads the stuff at label 'hello' to bx
call print_string
mov bx, 0x7c00
call print_hex_string
jmp $ ; hang

%include "print_string.asm"
;data
message:
    db 'Boot load from ',0

times 510-($-$$) db 0
dw 0xaa55