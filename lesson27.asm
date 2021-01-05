%include 'functions.asm'
section .data
name    db  'readme.txt',0
content db  '-updated-',0

section .bss
handler resd  1

section .text
  global _start

_start:
  mov eax, 5          ; sys_open
  mov ebx, name
  mov ecx, 1
  int 80h

  mov [handler], eax  ; handler now has the value of the file handler

  mov eax, 19         ; sys_lseek
  mov ebx, [handler]  ; eax has the file handler
  mov ecx, 0          ; move 0 bytes...
  mov edx, 1          ; from the end (SEEK_END)
  int 80h

  mov eax, content
  call strlen

  mov edx, eax        ; eax has length of content
  mov ecx, content
  mov ebx, [handler]  
  mov eax, 4          ; sys_write
  int 80h

  mov ebx, [handler]  ; file handler
  mov eax, 6          ; sys_close
  int 80h

  call quit
