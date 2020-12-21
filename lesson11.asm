%include 'functions.asm'
section .text
global _start

_start:
    mov ecx, 0          ; Start at 0

nextNumber:
    inc ecx             ; We increment ecx
    mov eax, ecx        ; Put current counter in eax
    call iprintn        ; Call the itoa
    cmp ecx, 10         ; Are we in 10 already?
    jne nextNumber      ; No? well, continue!

    call quit
