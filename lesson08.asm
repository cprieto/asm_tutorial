%include 'functions.asm'

section .text
global _start

; App parameters are actually passed in the stack!
; First the number of parameters
; Then each parameter is in the stack, in order
_start:
    pop ecx     ; ecx in the stack has the number of parameters
params:
    cmp ecx, 0  ; ecx is our counter
    jz done
    pop eax     ; Get the next parameter
    call sprintn
    dec ecx
    jmp params
done:
    call end
