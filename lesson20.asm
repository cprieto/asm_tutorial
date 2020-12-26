%include 'functions.asm'
section .data
parent  db  'This is the parent process',0
child   db  'This is the child process',0

section .text
global _start
_start:
    mov eax, 2      ; sys_fork
    int 80h

    cmp eax, 0
    jz  .isChild
.isParent:
    mov eax, parent
    call sprintn
    call quit
.isChild:
    mov eax, child
    call sprintn
    call quit
