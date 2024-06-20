section .bss
    buffer resb 10         ; Reserve 10 bytes for input

section .data
    msg db "Enter a number: "
	msg_len db $-msg
    newline db 10, 0

section .text
    global _start

_start:
    ; Print the message
    mov edx, msg_len       ; Message length
    mov ecx, msg           ; Message to write
    mov ebx, 1             ; File descriptor (stdout)
    mov eax, 4             ; System call number (sys_write)
    int 0x80               ; Call kernel

    ; Read input
    mov eax, 3             ; System call number (sys_read)
    mov ebx, 0             ; File descriptor (stdin)
    mov ecx, buffer        ; Buffer to store input
    mov edx, 10            ; Number of bytes to read
    int 0x80               ; Call kernel

    ; Convert string to integer
    mov ecx, buffer        ; Pointer to buffer
    xor eax, eax           ; Clear EAX (accumulator for result)
    xor ebx, ebx           ; Clear EBX (multiplier)

atoi_loop:
    mov bl, byte [ecx]     ; Get the current byte
    cmp bl, 10             ; Check if it's the newline character
    je atoi_done           ; If newline, we are done
    sub bl, '0'            ; Convert ASCII to digit
    imul eax, eax, 10      ; Multiply the current result by 10
    add eax, ebx           ; Add the new digit
    inc ecx                ; Move to the next byte
    jmp atoi_loop          ; Repeat

atoi_done:
    ; EAX now contains the integer
    mov ecx, eax           ; Store number in ECX (loop counter)

loop_start:
    ; Print iteration number (EAX contains iteration)
    push ecx               ; Save loop counter
    push ecx               ; We need ECX twice for conversion

    mov eax, 4             ; System call number (sys_write)
    mov ebx, 1             ; File descriptor (stdout)

    ; Convert ECX to string
    mov edx, ecx
    add dl, '0'
    sub ecx, ecx
    mov ecx, buffer
    mov byte [ecx], dl
    mov edx, 1
    int 0x80

    ; Print newline
    mov edx, 1             ; Length of newline
    mov ecx, newline       ; Newline character
    mov ebx, 1             ; File descriptor (stdout)
    mov eax, 4             ; System call number (sys_write)
    int 0x80

    pop ecx                ; Restore loop counter
    loop loop_start        ; Decrement ECX and loop if not zero

    ; Exit
    mov eax, 1             ; System call number (sys_exit)
    xor ebx, ebx           ; Exit code 0
    int 0x80               ; Call kernel