%include 'functions.asm'

section .bss
  handler resb  1  

section .text
  global _start

_start:
  ; needed parameters
  push byte 6
  push byte 1
  push byte 2
  mov eax, 102      ; sys_socketcall
  mov ebx, 1        ; open socket
  mov ecx, esp      ; parameters
  int 80h

  mov [handler], eax

  mov eax, [handler]
  call iprintn

  call quit
