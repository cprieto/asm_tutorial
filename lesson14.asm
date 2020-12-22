%include 'functions.asm'
section .text
global _start

_start:
    mov eax, 90
    mov ebx, 9
    mul ebx         ; Multiply eax by ebx, place result in eax
    call iprintn

    call quit
