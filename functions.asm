; Gets the length of a string
; @param EAX = address of the string to get
; @result EAX length of the string
strlen:
    ; Address of message in eax
    push ebx          ; Add ebx to the stack
    mov ebx, eax      ; Copy eax to ebx
.nextchar:
    cmp byte [eax], 0 ; Compare value at address of eax to 0
    jz ._end_strlen     ; Jump to finished if they are equal
    inc eax           ; Increment eax
    jmp .nextchar      ; Jump to nextchar

._end_strlen:
    sub eax, ebx      ; Substract ebx to eax
    ; Length will be in eax
    pop ebx           ; Return ebx to the stack
    ret               ; Return to caller

; Prints a string to standard output
; @param EAX address of the string to print
sprint:
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

; Prints a string and return carriage to standard output
; @param EAX address of the string to print
sprintn:
    call sprint     ; print the string
    push eax        ; We will use eax, so preserve it
    mov eax, 0Ah    ; Put return carriage in eax
    push eax        ; Put eax in the stack
    mov eax, esp    ; set eax to the pointer to the current stack
    call sprint
    ; Everything back to normal
    pop eax
    pop eax
    ret

; Ends a program normally
end:
    mov eax, 1
    mov ebx, 0
    int 80h
    ret

quit:
    mov eax, 1
    mov ebx, 0
    int 80h
    ret

; Print an integer number (itoa)
; @param eax the integer number to print
iprint:
    push eax
    push ecx
    push edx
    push esi
    mov ecx, 0      ; counter how many bytes we print at the end
.divloop:
    inc ecx
    mov edx, 0      ; empty edx
    mov esi, 10     ; 10 to esi
    div esi         ; Divide eax by esi
    add edx, 48     ; edx has the remainder, convert to ascii adding 48
    push edx        ; push that string repr into the stack
    cmp eax, 0      ; Can the quotient be divided?
    jnz .divloop     ; Continue dividing the quotient

.printloop:
    dec ecx         ; We are going in reverse
    mov eax, esp    ; Move the stack pointer to eax
    call sprint     ; Print the string
    pop eax         ; Get the next value in the stack
    cmp ecx, 0      ; Is this the last digit?
    jnz .printloop   ; Continue the printing

    ; Turn everything back to where it was
    pop esi
    pop edx
    pop ecx
    pop eax
    ret

; Print an integer number with a carriage return (itoa)
iprintn:
    call iprint     ; Call the normal iprint function
    push eax        ; We are going to use eax, save the value
    mov eax, 0Ah    ; Put carriage return in eax
    push eax        ; Save the eax in the stack
    mov eax, esp    ; Put the pointer to the stack in eax
    call sprint     ; Call sprint with the carriage return
    ; Everything is back to normal
    pop eax
    pop eax
    ret

; Convert ascii into an integer (atoi)
; @param eax Pointer to number to convert
; @return eax Converted integer
atoi:
    push ebx
    push ecx
    push edx
    push esi
    mov esi, eax    ; eax has the number to convert, copy to esi
    mov eax, 0      ; Current number
    mov ecx, 0      ; Counter of numbers

.multiplyLoop:
    xor ebx, ebx
    mov bl, [esi+ecx]
    cmp bl, 48
    jl .atoi_finished
    cmp bl, 57
    jg .atoi_finished
    sub bl, 48
    add eax, ebx
    mov ebx, 10
    mul ebx
    inc ecx
    jmp .multiplyLoop

.atoi_finished:
    cmp ecx, 0
    je .restore
    mov ebx, 10
    div ebx

.restore:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
