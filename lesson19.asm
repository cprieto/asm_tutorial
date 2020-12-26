%include 'functions.asm'
section .data
command db  '/usr/bin/echo',0h
arg1    db  'hello world',0h
args    dd  command
        dd  arg1
        dd  0h
env     dd  0h

section .text
global _start
_start:
    mov edx, env        ; Environment
    mov ecx, args       ; arguments array, including command
    mov ebx, command    ; command
    mov eax, 11         ; sys_execv
    int 80h

    call quit