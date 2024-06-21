; initial register
SECTION MBR vstart=0x7c00  ; compiler instruction
    mov ax, cs
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov sp, 0x7c00
    
; scroll screen for clear window
    mov ah, 0x06  ; scroll
    mov al, 0x00  ; all line
    mov bh, 0x07  ; line attr
    mov bl, 0x00  ; unused
    mov cx, 0     ; top left corner
    mov dx, 0x184f; bottom right corner
    int 0x10      ; 0x00 ~ 0xff, the index of interrupt vector table

; get cursor pos
    mov ah, 0x03
    mov bh, 0x00
    int 0x10

; print content
    mov ax, content
    mov bp, ax
    mov ax, 0x1301
    mov bx, 0x0002
    mov cx, 0x0026
    int 0x10

    jmp $  ; blocking in order to not quit

    content db "rb_mbr has been loaded and is running."
    times 510 - ($-$$) db 0
    db 0x55, 0xaa
