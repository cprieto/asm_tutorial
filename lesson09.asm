%include 'functions.asm'

section .data
msg1 db  'Please enter your name: ',0
msg2 db  'Hello, ',0

; This section is for unitialize variables
section .bss
entry   resb  255     ; entry will be byte length 255

section .text
global _start

_start:
    mov eax, msg1
    call sprint

    mov eax, 3      ; sys_read
    mov ebx, 0      ; read from std in
    mov ecx, entry  ; read to entry variable
    mov edx, 255    ; read up to 255 bytes
    int 80h

    mov eax, msg2
    call sprint

    mov eax, entry
    call sprintn

    call quit