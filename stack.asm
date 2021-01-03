mov ah, 0x0e ; BIOS scrolling routine

mov bp, 0x8000 ; set stack pointer to a while after BIOS memory
mov sp, bp ; move the stack pointer to bp
push 'a'
push 'b'
push 'c' ; push some characters: note that these are 16-bit-aligned, so the ascii values are not pushed as conscutive bytes
pop bx ; pop value from stack to bx
mov al, bl ; why bl instead of bx?
int 0x10 ; print al
;repeat
pop bx ; pop value from stack to bx
mov al, bl ; why bl instead of bx?
int 0x10 ; print al

mov al, [0x7ffe] ; stack grows downwards and starts at 0x8000, so 0x7ffe
; = 0x8000-0x2
int 0x10
;magic
jmp $
times 510-($-$$) db 0
dw 0xaa55