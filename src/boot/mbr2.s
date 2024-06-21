; initial register
SECTION MBR vstart=0x7c00  ; compiler instruction
    mov ax, cs
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov sp, 0x7c00
    mov ax, 0xb800
    mov gs, ax
    
; scroll screen for clear window
    mov ah, 0x06  ; scroll
    mov al, 0x00  ; all line
    mov bh, 0x07  ; line attr
    mov bl, 0x00  ; unused
    mov cx, 0     ; top left corner
    mov dx, 0x184f; bottom right corner
    int 0x10      ; 0x00 ~ 0xff, the index of interrupt vector table

; manual gpu memory
    mov byte [gs:0x00], 'r'
    mov byte [gs:0x01], 0x49
    mov byte [gs:0x02], 'b'
    mov byte [gs:0x03], 0x49
    mov byte [gs:0x04], '_'
    mov byte [gs:0x05], 0x49
    mov byte [gs:0x06], 'm'
    mov byte [gs:0x07], 0x49
    mov byte [gs:0x08], 'b'
    mov byte [gs:0x09], 0x49
    mov byte [gs:0x0a], 'r'
    mov byte [gs:0x0b], 0x49

    jmp $  ; blocking in order to not quit

    content db "rb_MBR has been loaded and is running."
    times 510 - ($-$$) db 0
    db 0x55, 0xaa
