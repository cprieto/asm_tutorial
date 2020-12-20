section .data
msg db 'Hello, lesson 3!', 0Ah

section .text
global _start

_start:
    mov edx, msg    ; We start at msg address
    mov eax, edx    ; We copy eax to ebx

nextchar:
    cmp byte [edx], 0   ; Compare what is at address eax to 0
    jz finished         ; If they are equal, we go to finish
    inc edx             ; Increment eax
    jmp nextchar        ; Loop back to nextchar

finished:
    sub edx, eax        ; Substract eax to edx
    ; Now edx has the size of the string
    mov eax, 4          ; sys_write
    mov ebx, 1          ; to std out
    mov ecx, msg        ; message
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h
