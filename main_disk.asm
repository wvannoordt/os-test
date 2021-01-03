[org 0x7c00]
;see page 29
mov [boot_drive], dl ; BIOS stores the boot drive in dl, so good to store for later
mov bp, 0x8000 ; set stack pointer far away
mov sp, bp

mov bx, greeting
call print_line

; mov ax, 0x0000
; mov ds, ax
mov bx, 0x9000 ; we want to load 5 sectors to 0x0000(es):0x9000(bx)
mov dh, 2 ; NOTE crash when this is 5. Not sure why, probably a symptom of the emulator...
mov dl, [boot_drive]
call disk_load

mov bx, [0x9000] ; print out the first loaded word which should be 0xdada
call print_hex_string

mov bx, newline
call print_string

mov bx, [0x9000+512] ; print from the 2nd loaded sector, which should be 0xface
call print_hex_string

mov bx, newline
call print_string

mov bx, done
call print_line
jmp $

%include "print_string.asm"
%include "read_disk.asm"
; data
greeting:
    db 'Initializing... ',0

newline:
    db 10, 13, 0

done:
    db 'Done.', 0

boot_drive:
    db 0x00

times 510-($-$$) db 0
dw 0xaa55

; this creates a larger binary than 512 bytes. The BIOS will only load 512 bytes for the boot sector,
; so extending this file with these words will let us prove that we loaded data
times 256 dw 0xdada
times 256 dw 0xface