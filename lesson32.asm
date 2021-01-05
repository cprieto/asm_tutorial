%include 'functions.asm'

section .bss
  handler resd  1   ; Socket handlers are double word

section .text
  global _start

_start:
  ; create socket
  push byte 6
  push byte 1
  push byte 2
  mov eax, 102      ; sys_socketcall
  mov ebx, 1        ; open socket
  mov ecx, esp      ; parameters
  int 80h

  mov [handler], eax

  ; Bind to socket port 9001
_bind:
  push dword 0
  push word 0x2923
  push word 2
  mov ecx, esp
  push byte 16
  push ecx
  push dword [handler]
  mov ecx, esp
  mov ebx, 2
  mov eax, 102
  int 80h

_listen:
  push byte 1         
  push dword [handler]
  mov ecx, esp        
  mov ebx, 4          ; listen
  mov eax, 102        ; sys_socketcall
  int 80h

_accept:
  push byte 0         ; address length
  push byte 0         ; address argument
  push dword [handler] ; file descriptor (socket handler)
  mov ecx, esp
  mov ebx, 5          ; accept
  mov eax, 102        ; sys_socketcall
  int 80h

  call quit
