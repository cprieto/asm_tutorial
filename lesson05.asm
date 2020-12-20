%include 'functions.asm'

section .data
msg db 'Hello Include files!', 0Ah

section .text
global _start

_start:
    mov eax, msg
    call print
    call end
