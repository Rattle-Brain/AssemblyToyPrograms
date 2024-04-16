section .data
	prompt db "Loop iterations: ", 0 
	plen equ $ - prompt
	blen equ 8
	buffer times blen db 0

	msg db "Number: "
	mlen equ $ - msg

	newline db 10, 0

	temp dd 0

section .text
	global _start

_start:
	; First we print the prompt
	mov eax, 4			; System Write
	mov ebx, 1			; Standard output
	mov ecx, prompt 	; The address of the message
	mov edx, plen		; Prompt lenght
	int 0x80			; System Call
	
	; Then we need to read the user input
	mov eax, 3			; System Read
	mov ebx, 0			; Standard input
	mov ecx, buffer		; Buffer's address
	mov edx, blen		; Buffer's length
	int 0x80

	; Now we transform the value introduced into a number
	mov eax, 0
	lea esi, buffer
	call atoi			; Call to atoi function

    ; Iterate and print "Iteration: n" in each iteration
	mov esi, eax 		; eax contains integer of iterations
	mov ecx, 0			; Index for loop ("Number: %d", ecx)
    mov ebx, 1   		; Set ebx to standard output

; We start the printing loop here
loop_print:
	push ecx

	; Let's print the message "Number: " 
	mov eax, 4			; System Write
	mov ecx, msg		; Address of msg
	mov edx, mlen		; Msg length
	int 0x80			; System call

    ; Print the iteration number (ebx)
	pop ecx				; Retrieve from stack ecx
	mov eax, ecx		; We move the value to eax (to keep ecx as number)
	add eax, '0'		; Convert the number to ASCII char (0x48 = '0', 0x49 = '1'...)
	push ecx			; Now we save the value to the stack
	sub esp, 4			; Since esp points to the last taken address in the stack, we need to make it point to the next
	mov [esp], eax		; We save the value of eax onto the stack
    mov eax, 4			; System Write...
    mov ebx, 1
	mov ecx, esp		; We move the MEMORY ADDRESS, not the actual value to be printed
    mov edx, 1			; Length
    int 0x80
	mov [esp], eax
	add esp, 4			; Restore the orginal value of esp (ABSOLUTELY NECESSARY)

	; Print a newline (\r\n) char
	mov eax, 4
    mov ecx, newline
    mov edx, 1
    int 0x80

	; Update indexes
	pop ecx
	inc ecx				; Value to print ++
	dec esi				; Number of iterations --

	jnz loop_print		; If not, go back and loop again
	jmp _end			; If bx == 0 { break }

; Function to convert char* into integer. Unsafe
atoi:
    ; Initialize registers
    xor eax, eax       ; Clear eax (will store the result)

convert_loop:
    ; Load the next character into al
    lodsb

    ; Check for the null terminator (end of string)
    cmp al, 0
    je done_convert

    ; Convert character to integer
    sub al, '0'

    ; Multiply current result by 10 (shift left by one decimal place)
    imul eax, eax, 10

    ; Add the value of the current character to the result
    add eax, eax
	movzx ecx, al
    add eax, ecx

    ; Repeat the loop for the next character
    jmp convert_loop

done_convert:
    ret

_end:
	; Exit the program
	mov eax, 1			; System Exit
	xor ebx, ebx		; EBX is now 0
	int 0x80
