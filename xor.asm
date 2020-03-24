section .text
    global _start

_start:

    mov edx , msg1_len    ; message length
    mov ecx , msg1        ; message to write
    mov eax , 4           ; system call number (sys_write)
    mov ebx , 1           ; file descriptor (stdout)
    int 0x80              ; call kernel

    mov eax , 3           ; system call number (sys_read)
    mov ebx , 0           ; file descriptor (stdin)
    mov ecx , input       ; store input in input
    mov edx , 100         ; max length of input
    int 0x80              ; call kernel

    mov [i] , al          ; loop counter

    mov edx , msg2_len    ; message length
    mov ecx , msg2        ; message to write
    mov eax , 4           ; system call number (sys_write)
    mov ebx , 1           ; file descriptor (stdout)
    int 0x80              ; call kernel

    mov eax , 3           ; system call number (sys_read)
    mov ebx , 0           ; file descriptor (stdin)
    mov ecx , key         ; store key in key
    mov edx , 1           ; length of key
    int 0x80              ; call kernel

    call xor              ; call procedure xor

    mov edx , msg3_len    ; message length
    mov ecx , msg3        ; message to write
    mov eax , 4           ; system call number (sys_write)
    mov ebx , 1           ; file descriptor (stdout)
    int 0x80              ; call kernel

    mov eax , 4           ; system call number (sys_write)
    mov ebx , 1           ; file descriptor (stdout)
    mov ecx , input
    mov edx , 100
    int 0x80              ; call kernel

    ;exit program
    mov eax , 1           ; system call number (sys_exit)
    mov ebx , 0
    int  0x80             ; call kernel

xor:

    mov ecx , [i]         ; move i in ecx register
    mov al , [key]        ; move key in al
    mov ebx , input       ; move input byte to ebx

    l1:

    xor byte [ebx] , al   ; xor input and key
    add ebx , 1           ; get next byte
    loop l1               ; loop
    ret                   ; return


section .data
    msg1 db 'Enter string:',0xa
    msg1_len equ $-msg1
    msg2 db 'Enter key:',0xa
    msg2_len equ $-msg2
    msg3 db 'The xored string is:',0xa
    msg3_len equ $-msg3


section .bss
    input resb 100   ; input
    key resb 1       ; key
    i resb 1         ; loop counter
