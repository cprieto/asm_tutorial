%include 'functions.asm'

section .text
global _start

_start:
    mov eax, 90
    mov ebx, 9
    sub eax, ebx    ; Substract 9 to 90, put result in eax
    call iprintn

    call quit
