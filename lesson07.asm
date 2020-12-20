%include 'functions.asm'

section .data
msg1 db 'Hello Sprintn!', 0 ; See? no 0Ah!
msg2 db 'See? no ENTER!', 0

section .text
global _start

_start:
    mov eax, msg1
    call sprintn    ; Notice the usage of sprintN
    mov eax, msg2
    call sprintn
    call end
