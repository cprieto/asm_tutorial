%include 'functions.asm'

section .text
global _start

_start:
    mov ecx, 0          ; Counter starts at 0
nextnumber:
    mov eax, ecx        ; We copy the counter in eax
    add eax, 48         ; Add 48 to whatever is there
    push eax            ; Save eax to the stack
    mov eax, esp        ; Put the current stack pointer in eax
    call sprintn        ; Call sprintn
    pop eax             ; Return the previous stack value
    inc ecx             ; Increment one to ecx
    cmp ecx, 10         ; Is 10 already?
    jne nextnumber      ; Loop if not equal

    call quit
