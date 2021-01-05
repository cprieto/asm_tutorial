%include 'functions.asm'

section .text
  global _start

_start:
  xor eax, eax
  xor ebx, ebx
  xor edi, edi
  xor esi, esi

_socket:
  ; create socket
  push byte 6
  push byte 1
  push byte 2
  mov eax, 102      ; sys_socketcall
  mov ebx, 1        ; open socket
  mov ecx, esp      ; parameters
  int 80h

  ; file handler for socket is in edi
  mov edi, eax

  ; Bind to socket port 9001
_bind:
  mov edi, eax
  push dword 0
  push word 0x2923
  push word 2
  mov ecx, esp
  push byte 16
  push ecx
  push edi
  mov ecx, esp
  mov ebx, 2
  mov eax, 102
  int 80h

_listen:
  push byte 1         ; padding
  push edi            ; socket handler
  mov ecx, esp        ; parameters
  mov ebx, 4          ; listen
  mov eax, 102        ; sys_socketcall
  int 80h

  call quit
