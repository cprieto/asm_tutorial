%include 'functions.asm'

section .data
msg1    db  'Jumping to finishing label.', 0h
msg2    db  'Inside subroutine number:', 0h
msg3    db  'Inside subroutine "finished"', 0h

section .text
global _start

_start:
subroutineOne:
    mov eax, msg1
    call sprintn
    jmp .finished
.finished:
    mov eax, msg2
    call sprint
    mov eax, 1
    call iprintn

subroutineTwo:
    mov eax, msg1
    call sprintn
    jmp .finished

.finished:
    mov eax, msg2
    call sprint
    mov eax, 2
    call iprintn

finished:
    mov eax, msg3
    call sprintn
    call quit
