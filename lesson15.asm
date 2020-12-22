%include 'functions.asm'
section .data
msg db  ' remainer '

section .text
global _start

_start:
    mov eax, 90
    mov ebx, 9
    div ebx         ; Divide eax by ebx, result in eax, remainder in edx
    call iprint     ; Print the stuff
    mov eax, msg    ; That message we have
    call sprint     ; Print it
    mov eax, edx    ; Now it is time to print the reminder
    call iprintn    ; Print it

    call quit
