mov ah, 0x0e ; BIOS
mov al, [the_secret] ; fails since the [org 0x7c00] statement is not present (addresses starting at 0x0 now)
int 0x10

mov bx, 0x7c0
mov ds, bx
mov al, [the_secret] ; mov the starting index for the BIOS boot segment 0x7c0: the_secret is now computed as 16*0x7c0 + the_secret!
int 0x10

mov al, [es:the_secret] ; same thing below but with es
int 0x10

mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10

jmp $

the_secret:
    db 'x'

times 510-($-$$) db 0
dw 0xaa55