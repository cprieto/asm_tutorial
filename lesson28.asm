%include 'functions.asm'

section .data
name	db	'readme.txt',0

section .text
  global _start

_start:
  mov ebx, name		; filename
	mov eax, 10			; sys_unlink
	int 80h

	call quit

