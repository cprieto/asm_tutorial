%include 'functions.asm'
section .text
  global _start

_start:
  xor eax, eax

_socket:
  push byte 6       ; IPPROTO_TCP
  push byte 1       ; SOCK_STREAM
  push byte 2       ; PF_INET

  mov eax, 102      ; sys_socketcall
  mov ebx, 1        ; subroutine 1, create socket
  mov ecx, esp      ; parameters for routine
  int 80h

  call iprintn      ; what is the socket handler id?

  call quit
