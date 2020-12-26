%include 'functions.asm'
section .data
fizz    db  'Fizz',0h
buzz    db  'Buzz',0h

section .text
global _start

_start:
    mov esi, 0
    mov edi, 0
    mov ecx, 0
.nextNumber:
    inc ecx             ; Increment the counter
.checkFix
    mov edx, 0
    mov eax, ecx        ; Put counter in eax
    mov ebx, 3
    div ebx             ; Divide by 3
    mov edi, edx        ; Put remainder in edi
    cmp edi, 0          ; Is the remainder different than 0?
    jne .checkBuzz      ; If so go to checkBuzz
    mov eax, fizz
    call sprint         ; If not, print the fizz message
.checkBuzz
    mov edx, 0          ; Clean edx
    mov eax, ecx        ; Put the counter to eax, again
    mov ebx, 5
    div ebx             ; Divide eax by 5
    mov esi, edx        ; Put the remainder in edi
    cmp esi, 0
    jne .checkNumber    ; If the remainder is NOT 0, go to checkNumber
    mov eax, buzz
    call sprint         ; If it is 0 print buzz
.checkNumber:
    cmp edi, 0          ; Again, is the remainder of division by 3, 0?
    je .continue        ; If so, go to continue
    cmp esi, 0          ; Is the remainder of division by 5, 0?
    je .continue        ; If so go to continue
    mov eax, ecx        ; Put the current counter into ecx
    call iprint         ; Print the number
.continue:
    mov eax, 0Ah        ; Put a return carriage in eax
    push eax
    mov eax, esp
    call sprint         ; Print it
    pop eax
    cmp ecx, 100
    jne .nextNumber     ; Loop

    call quit
