%include 'functions.asm'

section .data
msg1    db  'Hello NULL terminated strings',0Ah,0
msg2    db  'This is NASM!',0Ah,0

section .text
global _start

_start:
    mov eax, msg1
    call print
    mov eax, msg2
    call print
    call end