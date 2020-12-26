%include 'functions.asm'
section .data
name    db  'readme.txt'

section .text
global _start
_start:
    mov ecx, 0777   ; File permissions
    mov ebx, name   ; File name
    mov eax, 8      ; sys_creat, create file
    int 80h

    call quit
