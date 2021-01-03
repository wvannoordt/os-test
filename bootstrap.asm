[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; this is the memory offset to which we will load the kernel
mov [boot_drive], dl
mov bp, 0x9000
mov sp, bp
mov bx, MSG_REAL_MODE
call print_string
call load_kernel
call switch_to_pm
jmp $

%include "print_string.asm"
%include "read_disk.asm"
%include "gdt.asm"
%include "print32.asm"
%include "pm_switch.asm"

[bits 16]
load_kernel:
    mov bx, load_kernel_message
    call print_string
    mov bx, KERNEL_OFFSET
    mov dh, 1
    mov dl, [boot_drive]
    call disk_load
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_str_32
    call KERNEL_OFFSET
    jmp $

boot_drive:          db 0x00
MSG_REAL_MODE:       db 'in 16-bit mode/',0
MSG_PROT_MODE:       db 'in 32-bit PM', 0
load_kernel_message: db 'load kernel/', 0

times 510-($-$$) db 0
dw 0xaa55