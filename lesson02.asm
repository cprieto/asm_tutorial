section .data
msg db  'Hello, World!', 0Ah

section .text
global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 14
    int 80h

    ; We have to exit now
    mov eax, 1  ; sys_exit
    mov ebx, 0  ; retval
    int 80h
