%ifndef PRINT_STR_ASM
%define PRINT_STR_ASM

newline_char:
    db 13, 10, 0

print_string:
    pusha
    mov ah, 0x0e ; bios routine select register (teletype)
    ;mov bx 'BBASDA'
    beginloop:
        cmp byte [bx], 0x0
        je endloop
        mov al, [bx]
        int 0x10
        add bx, 0x0001
        jmp beginloop
    endloop:
        popa
        ret

print_hex_string:
    pusha
    mov ah, 0x0e ; BIOS scrolling routine
    mov cx, bx ; store the input in bx into cx reg
    mov bx, hex_string_data ; set bx to point at the output location
    add bx, 5 ; move to the end
    beginloop2: ; begin loop
        mov dx, cx ; copy the 'argument' of the function to temporaary dx register for shifting 
        shr cx, 4 ; shift by 4 bits
        and dx, 0x000f ; and by 0x000f to get the last 4 bits
        add [bx], dx
        cmp dx, 0x000a ; check if a-f
        jge big
        jmp end
        big: ; add the numerical value of the current 4 bits and an offset accounting for the fact that a-z are not adjacent to 0-9
            add byte [bx], 0x27
        end:
        sub bx, 1
        cmp byte [bx], 'x'
        je endloop2
        jmp beginloop2
    endloop2:
    sub bx, 1
    call print_string
    mov byte [bx], '0'
    add bx, 1
    mov byte [bx], 'x'
    add bx, 1
    mov byte [bx], '0'
    add bx, 1
    mov byte [bx], '0'
    add bx, 1
    mov byte [bx], '0'
    add bx, 1
    mov byte [bx], '0'
    sub bx, 4
    popa
    ret

hex_string_data:
    db '0x0000', 0

%endif