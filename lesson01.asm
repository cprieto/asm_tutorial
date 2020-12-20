section .data
msg db  'Hello, World!',0Ah

section .text
global _start

_start:
    mov eax, 4      ; sys_write
    mov ebx, 1      ; File to write (std out)
    mov ecx, msg    ; Address of message
    mov edx, 14     ; Length of string
    int 80h         ; Go do it!
