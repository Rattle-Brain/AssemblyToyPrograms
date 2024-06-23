section .bss
    buffer_input resb 10    		; Reserve 10 bytes for input
    buffer_output resb 11           ; And 11 bytes to output

section .data
    msg db "Enter a number: "
	msg_len db $-msg
    newline db 10, 0

section .text
    global _start

_start:
    ; Print the message
    mov edx, msg_len  		; Message length
    mov ecx, msg      		; Message to write
    mov ebx, 1        		; File descriptor (stdout)
    mov eax, 4        		; System call number (sys_write)
    int 0x80          		; Call kernel

    ; Read input
    mov eax, 3        		; System call number (sys_read)
    mov ebx, 0        		; File descriptor (stdin)
    mov ecx, buffer_input   		; Buffer to store input
    mov edx, 10       		; Number of bytes to read
    int 0x80          		; Call kernel

    ; Convert string to integer
    mov ecx, buffer_input   		; Pointer to buffer
    xor eax, eax      		; Clear EAX (accumulator for result)
    xor ebx, ebx      		; Clear EBX (multiplier)

atoi_loop:
    mov bl, byte [ecx]		; Get the current byte
    cmp bl, 10        		; Check if it's the newline character
    je atoi_done      		; If newline, we are done
    sub bl, '0'       		; Convert ASCII to digit
    imul eax, eax, 10 		; Multiply the current result by 10
    add eax, ebx      		; Add the new digit
    inc ecx           		; Move to the next byte
    jmp atoi_loop     		; Repeat

atoi_done:
    ; EAX now contains the integer
    mov ecx, eax      		; Store number in ECX (loop counter)
    mov edx, 0				; Init counter to print

loop_start:
    ; Print iteration number (EAX contains iteration)
    push ecx          		; Save loop counter
    push ecx                ; Push twice. One as param to func, the other as index of loop

    call int_to_str         ; Transform number into char[]
        
    add esp, 4              ; Delete top of stack
    
    ; Print buffer
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer_output
    mov edx, 11
    int 0x80

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    pop ecx                 ; Retrieve counter value
    dec ecx                 ; Decrement
    test ecx, ecx
    jnz loop_start

    ; Exit
    mov eax, 1        		; System call number (sys_exit)
    xor ebx, ebx      		; Exit code 0
    int 0x80          		; Call kernel

; Definition function. Receives a number as a parameter and 
; Transforms it into suitable text to print.
int_to_str:
    ; Now the state of the stack is as follows:
    ;   ,_________________,
    ;   |_________________|  
    ;   |_______ret_______|  <-- esp points here
    ;   |_______eax_______|
    ;   |_________________|

    mov eax, [esp + 4]

    ; Initialize buffer pointers
    mov edi, buffer_output + 10 ; Point to the end of the buffer

    ; Clear buffer
clear_buffer_loop:
    mov ebx, buffer_output
    dec edi
    mov byte[edi], 0
    cmp edi, ebx
    jne clear_buffer_loop


    mov edi, buffer_output + 10 ; Restore edi to the end of the buffer
    mov byte [edi], 0    ; Null terminator

    ; Handle zero explicitly
    test eax, eax
    jnz itoa_loop
    mov byte [edi], '0'
    jmp itoa_loop_done


itoa_loop:

    ; Convert each digit to a character
    xor edx, edx         ; Clear edx for division
    mov esi, 10
    div esi              ; Divide eax by 10
    add dl, '0'          ; Convert remainder to ASCII
    mov [edi], dl        ; Store ASCII character
    dec edi              ; Move to the next character
    test eax, eax        ; Check if eax is zero
    jnz itoa_loop        ; Continue if not zero


itoa_loop_done:
    ; Maybe I need to do something here.

    ret