; Gets the length of a string
; @param EAX = address of the string to get
; @result EAX length of the string
strlen:
    ; Address of message in eax
    push ebx          ; Add ebx to the stack
    mov ebx, eax      ; Copy eax to ebx
nextchar:
    cmp byte [eax], 0 ; Compare value at address of eax to 0
    jz end_strlen     ; Jump to finished if they are equal
    inc eax           ; Increment eax
    jmp nextchar      ; Jump to nextchar
end_strlen:
    sub eax, ebx      ; Substract ebx to eax
    ; Length will be in eax
    pop ebx           ; Return ebx to the stack
    ret               ; Return to caller

; Prints a string to standard output
; @param EAX address of the string to print
print:
    ; All three registers to the stack, we will use them here
    push ecx
    push ebx
    push edx
    mov ebx, 1        ; Print output
    mov ecx, eax      ; Remember, eax has the string address, put it in ecx
    call strlen       ; Calculate the lenght of the string
    mov edx, eax      ; Length was in eax, put it in edx
    mov eax, 4        ; sys_print
    int 80h
    ; Return things to as they were
    pop edx
    pop ebx
    pop ecx
    ret

; Ends a program normally
end:
    mov eax, 1
    mov ebx, 0
    int 80h
    ret