%include 'functions.asm'
section .text
global _start

_start:
    pop ecx         ; Get first value from the stack, number of arguments
    pop edx         ; Second value in the stack is the program name
    sub ecx, 1      ; Remove 1 to the number of arguments
    mov edx, 0
.next:
    cmp ecx, 0
    jz .finish
    pop eax
    call atoi
    add edx, eax
    dec ecx
    jmp .next

.finish:
    mov eax, edx
    call iprintn
    call quit
