[org 0x7c00] ; boot sector

; set stack
mov bp, 0x9000
mov sp, bp
mov bx, MSG_REAL_MODE
call print_line
call switch_to_pm ; never return
jmp $
%include "print_string.asm"
%include "gdt.asm"
%include "print32.asm"
%include "pm_switch.asm"
[bits 32]
BEGIN_PM:
    mov ebx, MSG_PM
    call print_str_32
    jmp $


MSG_REAL_MODE:
    db "Initialize 16-bit real mode",0
MSG_PM:
    db "Success! (look at me all the way up here!)",0
times 510-($-$$) db 0
dw 0xaa55