%include 'functions.asm'
section .data
name    db  'readme.txt',0
content db  'hello world!',0
msg     db  'content is: ',0

section .bss
result  resb    255

section .text
global _start

_start:
    mov eax, 8          ; sys_creat
    mov ebx, name
    mov ecx, 0777
    int 80h

    mov ebx, eax
    mov ecx, content
    mov edx, 12
    mov eax, 4          ; sys_write
    int 80h

    mov eax, 5          ; sys_open
    mov ebx, name
    mov ecx, 0
    int 80h



    ; Now handler id is in eax
    mov ebx, eax        ; ebx needs the handler id
    mov ecx, result     ; ecx needs the variable to fill
    mov edx, 12         ; edx needs the max length to read
    mov eax, 3          ; sys_read
    int 80h

    mov eax, msg
    call sprint

    mov eax, result
    call sprintn
    call quit
