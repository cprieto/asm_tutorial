%include 'functions.asm'
section .data
name    db  'readme.txt',0
content db  'hello world!'

section .text
global _start
_start:
    mov ecx, 0777
    mov ebx, name
    mov eax, 8          ; sys_creat, the file must be delete for this to work
    int 80h

    mov edx, 12         ; Write 12 bytes
    mov ecx, content    ; Write this content
    mov ebx, eax        ; File handler is in eax, put in ebx
    mov eax, 4          ; sys_write
    int 80h

    call quit
