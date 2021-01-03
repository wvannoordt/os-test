; load DH into es:bx from Drive dl

disk_load:
    push dx ; store dx on the stack to recall how many sectors we wanted to read
    mov ah, 0x02 ; BIOS read selector function
    mov al, dh ; read dh sectors
    mov ch, 0x00 ; select cylinder 0
    mov dh, 0x00 ; select head 0
    mov cl, 0x02 ; start reading from sector 2
    int 0x13 ; BIOS interrupt
    
    jc disk_error1 ; jumps if carry flag is set (i.e. disk read error)
    pop dx ; recall the number of sectors
    cmp dh, al ; check to see if al (sectors read) equals dh (sectors expected)
    jne disk_error2 ; error if this is not the case
    ret

disk_error1:
    mov bx, disk_error_message1
    call print_string
    mov bx, ax
    shr bx, 8
    call print_hex_string
    mov bx, dx
    call print_hex_string
    jmp $
    
disk_error2:
    mov bx, disk_error_message2
    call print_string
    jmp $

%include "print_string.asm"

; data
; disk_er_1_info:
; db ' See http://www.bioscentral.com/misc/biosint13.htm',0

disk_error_message1:
    db 'General disk error. Error code: ', 0

disk_error_message2:
    db 'Wrong sectors', 0

; after:
;     db ' Attempted to read using dx (0x[dh][dl]): ',0

boot_drive_l:
    db 0x00