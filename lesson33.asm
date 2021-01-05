%include 'functions.asm'
%define sys_socketcall 102
%define sys_fork 2
%define sys_read 3

section .bss
    handler resd    1
    buffer  resb    255

section .text
    global _start

_start:
    push byte 6
    push byte 1
    push byte 2
    mov eax, sys_socketcall
    mov ebx, 1      ; open socket
    mov ecx, esp
    int 80h

    mov [handler], eax

_bind:
    push dword 0
    push word 0x2923
    push word 2
    mov ecx, esp
    push byte 16
    push ecx
    push dword [handler]
    mov ecx, esp
    mov eax, sys_socketcall
    mov ebx, 2
    int 80h

_listen:
    push byte 1
    push dword [handler]
    mov eax, sys_socketcall
    mov ebx, 4
    mov ecx, esp
    int 80h

_accept:
    push byte 0
    push byte 0
    push dword [handler]
    mov ecx, esp
    mov ebx, 5
    mov eax, sys_socketcall
    int 80h

_fork:
    mov edi, eax
    mov eax, sys_fork
    int 80h

    cmp eax, 0
    jz _read
    jmp _accept

_read:
    mov edx, 255            ; buffer to read
    mov ecx, buffer         ; put it here
    mov ebx, edi            ; this is our handler
    mov eax, sys_read       ; sys_read, it is like a file
    int 80h

    mov eax, buffer
    call sprintn

    call quit
