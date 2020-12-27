%include 'functions.asm'
section .data
name    db  'readme.txt',0
content db  'hello world!',0
msg     db  'File content is: ',0

section .bss
data    resb    255

section .text
global _start

_start:
    mov eax, 8          ; sys_creat
    mov ebx, name
    mov ecx, 0777
    int 80h

    mov ebx, eax        ; handler
    mov ecx, content
    mov edx, 12
    mov eax, 4          ; sys_write
    int 80h

    mov eax, 5          ; sys_open
    mov ebx, name
    mov ecx, 0
    int 80h

    mov ebx, eax
    mov ecx, data
    mov edx, 12
    mov eax, 3          ; sys_read
    int 80h

    mov eax, msg
    call sprint

    mov eax, data
    call sprintn

    ; ebx has the file handler id
    mov eax, 6          ; sys_close
    int 80h

    call quit
