%include 'functions.asm'

section .text
global _start

_start:
    mov eax, 90     ; Put 90 in eax
    mov ebx, 9      ; Put 9 in ebx
    add eax, ebx    ; Sum eax and ebx, put result in eax
    call iprintn    ; Call itoa

    call quit
