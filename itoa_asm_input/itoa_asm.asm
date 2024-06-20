section .bss
    buffer resb 12   ; Reserve 12 bytes for the string buffer (sufficient for a 32-bit integer + null terminator)

section .data
    ten dd 10

section .text
    global _start

_start:
    mov eax, 4321           ; Define a number
    push eax                ; Save the numner to the stack

    call int_to_str         ; Call the function

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80


; Definition function. Receives a number as a parameter and 
; Transforms it into suitable text to print.
int_to_str:
    ; Now the state of the stack is as follows:
    ;   ,_________________,
    ;   |                 |  <-- esp points here
    ;   |       ret       |
    ;   |       eax       |
    ;   |_________________|

    mov eax, [esp + 8]

    ; Initialize buffer pointers
    mov edi, buffer + 11 ; Point to the end of the buffer
    mov byte [edi], 0    ; Null terminator
    dec edi              ; Move back to the last character position

    ; Handle zero explicitly
    test eax, eax
    jnz itoa_loop
    mov byte [edi], '0'
    dec edi
    jmp itoa_loop_done


itoa_loop:

    ; Convert each digit to a character
    xor edx, edx         ; Clear edx for division
    div dword [ten]      ; Divide eax by 10
    add dl, '0'          ; Convert remainder to ASCII
    mov [edi], dl        ; Store ASCII character
    dec edi              ; Move to the next character
    test eax, eax        ; Check if eax is zero
    jnz itoa_loop  ; Continue if not zero


itoa_loop_done:

    ; Adjust edi to point to the beginning of the string
    inc edi
    mov esi, edi         ; Copy pointer to esi (for example, for further use)

    ; Restore registers
    pop eax
    ret
