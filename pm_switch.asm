[bits 16]
; switch to protected mode
switch_to_pm:
    mov bx, msg
    call print_string
    cli ; clear interrupts, since interrupt vector
    ; is not set up.
    lgdt [gdt_descriptor] ; load the global descriptor table
    mov eax, cr0 ; make the switch to protected mode, i.e. set the first
    ; bit of cr0, a control register
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:init_pm

[bits 32]
; initialize the stack and registers once in pm
init_pm:
    mov ax, DATA_SEG ; now in pm, our old segments are meaningless
    mov ds, ax ; point the segment registers to the 
    mov ss, ax ; data selector defined in the GDT
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ebp, 0x90000 ; set stack position at the top of the free space
    mov esp, ebp
    call BEGIN_PM ; call some well-known label

msg:
    db 'Attempt to switch to 32 bit mode',0