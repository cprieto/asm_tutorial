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

_bind:
  mov edi, [handler]
  push dword 0        ; IP ADDRESS
  push word 0x2923    ; Port 9001 = 2329h, in reverse order
  push word 2         ; AF_INET
  mov ecx, esp        ; Arguments
  push byte 16        ; Argument list, dword + word + word = 16
  push ecx            ; Pointer to parameters
  push byte [handler] ; handler
  mov ecx, esp        ; Pointer to arguments
  mov ebx, 2          ; Bind
  mov eax, 102        ; sys_socketcall
  int 80h

  call quit
