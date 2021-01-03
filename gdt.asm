; GDT: describes segments of memory and their associated privileges.
gdt_start:

gdt_null: ; this is the mandatory null descriptor, i.e. NULL should point here
    dd 0x0 ; 'dd' is 'declare double word', i.e. 4 bytes
    dd 0x0

gdt_code: ; code segment descriptor
    ; base = 0x0, limit = 0xfffff,
    ; 1st flags: (present)1 (privilege)00 (descriptor type)1 -> 0b1001
    ; type flags (code)1 (conforming)0 (readable)1 (accessed) -> 0b1010
    ; 2nd flags: (granularity)1 (32-bit default)1 (64-bit segment)0 (AVL)0 -> 0b1100
    dw 0xffff ; limit (bits 0-15)
    dw 0x0 ; base (bits 0-15)
    db 0x0 ; base (bits 16-23)
    db 10011010b ; 1st flags, type flags
    db 11001111b ; 2nd flags, limit (bits 16-19)
    db 0x0 ; base (bits 24-31)

gdt_data: ; data segment descriptor, which is the same as the code segment except for:
    ; type flags: (code)0 (expand down)0 (writeable)1 (accessed)0 -> 0b0010
    dw 0xffff ; limit (bits 0-15)
    dw 0x0 ; base (bits 0-15)
    db 0x0 ; base (bits 16-23)
    db 10010010b ; 1st flags, type flags
    db 11001111b ; 2nd flags, limit (bits 16-19)
    db 0x0 ; base (bits 24-31)

gdt_end: ; label the end to that the assembler can compute the size of the descriptor

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; size of gdt, less one.
    dd gdt_start ; start address of the GDT

; some handy constants for gdt descriptor offets, which are what
; segment registers must contain when in protected mode.
; E.g. when ds = 0x10 in protected mode, teh CPU knows that we mean
; it to use the segment described at offset 0x10 (i.e. 16 bytes)
; in our gdt, which in our case is the data segment
; (0x0) = null
; (0x08) = code
; (0x10) = data
CODE_SEG equ gdt_code-gdt_start
DATA_SEG equ gdt_data-gdt_start