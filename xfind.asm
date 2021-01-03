;[org 0x7c00]
; addressing demonstration
mov ah, 0x0e ; int 10/ah = 0eh -> scrolling teletype BIOS routine

mov al, the_secret
int 0x10 ; interrupt: is there an "x" here?

mov al, [the_secret] ; not sure what the difference is here... I think [] is some kind of dereferencing... yes it is
int 0x10

mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

mov al, [0x7c1e]
int 0x10

jmp $ ;loop here forever

the_secret:
    db "X" ; declare bytes: remember, assembly is literally mapped directly onto binary (basically)
    
times 510-($-$$) db 0 ; pad with zeros
dw 0xaa55;declare word