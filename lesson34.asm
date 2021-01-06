%include 'functions.asm'
%include 'syscalls.asm'

section .data
  response db 'HTTP/1.1 200 OK', 0Dh, 0Ah, 'Content-Type: text/html', 0Dh, 0Ah, 'Content-Length: 14', 0Dh, 0Ah, 0Dh, 0Ah, 'Hello World!', 0Dh, 0Ah, 0h

section .bss
  handler resd  1
  buffer  resb  255

section .text
  global _start

_start:
  push byte IPPROTO_TCP
  push byte SOCK_STREAM
  push byte AF_INET
  mov eax, SYS_SOCKETCALL
  mov ebx, SOCKET_OPEN
  mov ecx, esp
  int 80h

  mov [handler], eax

_bind:
  push dword 0
  push word 0x2923
  push word AF_INET
  mov ecx, esp
  push byte 16
  push ecx
  push dword [handler]
  mov eax, SYS_SOCKETCALL
  mov ebx, SOCKET_BIND
  mov ecx, esp
  int 80h

_listen:
  push byte 1
  push dword [handler]
  mov eax, SYS_SOCKETCALL
  mov ebx, SOCKET_LISTEN
  mov ecx, esp
  int 80h

_accept:
  push byte 0
  push byte 0
  push dword [handler]
  mov eax, SYS_SOCKETCALL
  mov ebx, SOCKET_ACCEPT
  mov ecx, esp
  int 80h

_fork: ; Why do we have to fork?
  mov edi, eax
  mov eax, SYS_FORK
  int 80h

  cmp eax, 0
  jz _read
  jmp _accept

_read:
  mov eax, SYS_READ
  mov ebx, edi
  mov ecx, buffer
  mov edx, 255
  int 80h

_write:
  mov eax, SYS_WRITE
  mov ebx, edi
  mov ecx, response
  mov edx, 78
  int 80h

  call quit
