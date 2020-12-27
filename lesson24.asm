%include 'functions.asm'
section .data
name    db  'readme.txt',0
content db  'Hello world!',0
msg     db  'File id handler is: ',0

section .text
global _start

_start:
    mov eax, 8      ; sys_creat
    mov ebx, name
    mov ecx, 0777
    int 80h

    ; Now eax has the file handler id
    mov ebx, eax    ; ebx has the file handler id
    mov ecx, content
    mov edx, 12
    mov eax, 4      ; sys_write
    int 80h

    mov eax, msg
    call sprint

    ; Now we want to open the file
    mov eax, 5      ; sys_open
    mov ebx, name   ; filename
    mov ecx, 0      ; Readonly
    int 80h

    ; eax has the file handler id
    call iprintn
    call quit
