%include 'syscalls.asm'
%include 'functions.asm'

section .data
  request db 'GET / HTTP/1.1', 0Dh, 0Ah, 'Host: 139.162.39.66:80', 0Dh, 0Ah, 0Dh, 0Ah, 0

section .bss
  buffer  resb 1

section .text
  global _start

_start:
  push byte IPPROTO_TCP
  push byte SOCK_STREAM
  push byte PF_INET
  mov eax, SYS_SOCKETCALL
  mov ebx, SOCKET_OPEN
  mov ecx, esp
  int 80h

  mov edi, eax

_connect:
  push dword 0x4227a28b     ; 139.162.39.66 in hex (opposite order 66.39.162.139)
  push word 0x5000          ; port 0080 in reverse hex (8000)
  push word AF_INET
  mov ecx, esp
  push byte 16
  push ecx
  push edi
  mov eax, SYS_SOCKETCALL
  mov ebx, SOCKET_CONNECT
  mov ecx, esp
  int 80h

_write:
  mov eax, SYS_WRITE
  mov ebx, edi
  mov ecx, request
  mov edx, 43
  int 80h

_read:
  mov eax, SYS_READ
  mov ebx, edi
  mov ecx, buffer
  mov edx, 1
  int 80h

  cmp eax, 0
  jz _close

  mov eax, buffer
  call sprint
  jmp _read

_close:
  mov eax, SYS_CLOSE
  mov ebx, edi
  int 80h

  call quit
