; | 0000 0001 0010 0011 0100 0101 0110 0111 | ------> EAX
; |                     0100 0101 0110 0111 | ------> AX
; |                               0110 0111 | ------> AL
; |                     0100 0101           | ------> AH
; see https://stackoverflow.com/questions/15191178/how-do-ax-ah-al-map-onto-eax#:~:text=AH%20is%20the%208%20high,EAX%20as%20well%20as%20AX.
[bits 32]
; constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a null-terminated string pointed to by edx
print_str_32:
    pusha
    mov edx, VIDEO_MEMORY ; set edx to start of video memory
    loopst:
        mov al, [ebx] ; store char in al
        mov ah, WHITE_ON_BLACK ; attributes
        cmp al, 0
        je done
        mov [edx], ax ; store attributes and char at current character cell
        add ebx, 1 ; increment ebx to next char in string
        add edx, 2 ; move to next char in video memory
        jmp loopst
    done:
    popa
    ret