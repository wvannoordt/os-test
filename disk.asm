; Reads some bytes from the disk - is this roughly what caching is?
mov ah, 0x02 ; BIOS read sector function

mov dl, 0 ; Read drive 0 (i.e. first floppy drive)
mov ch, 3 ; read cyliner 3
mov dh, 1 ; select the track on the second side of the floppy disk (0-based)
mov cl, 4 ; set the 4th sector on this track (not the 5th - this is 1-based)
mov al, 5 ; read 5 sectors from the start point

mov bx, 0xa000 ; set the address to read the bytes on the disk to. BIOS expects to find this in es:bx
mov es, bx ; set es
mov bx, 0x1234 ; set to 1234
; in this case, the data from disk is read to 0xa0000:0x1234, which translates to address 0xa1234

int 0x13 ; issue the command to read. If this fails becase some address goes out of bounds, then the carry flag is raised on jc.
jc disk_error:


%include "print_string.asm"

disk_error:
    mov bx, error_message
    call print_string
    jmp $

error_message:
    db 'Error: could not read disk!', 0