%include 'functions.asm'
section .data
msg db  'The seconds since January 1, 1970: ',0

section .text
global _start
_start:
    mov eax, msg
    call sprint

    mov eax, 13     ; sys_time, result in eax
    int 80h

    call iprintn

    call quit
