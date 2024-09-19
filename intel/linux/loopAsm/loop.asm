section .data
    message db "Number: "
    len equ $-message

section .text
    global _start

_start:
    ; initialize counter to 0
    mov ecx, 0
.loop:
    ; First we printthe message
    push ecx			; We save the numeric value of ecx
	mov eax, 4			; System Write
    mov ebx, 1			; File descriptor of Standard output
    mov ecx, message	; We move the address of the msg to ecx
    mov edx, len		; And it's length to edx
    int 0x80			; Execute the call
    
    ; Print the current number
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
	xor eax, eax		; Remove trash, not necessary
	mov [esp], eax
	add esp, 4			; Restore the orginal value of esp (ABSOLUTELY NECESSARY)

    ; print a newline
    mov eax, 4			; Same procedure to print a newline character
    mov ebx, 1
    mov ecx, newline	; Code 0xA or 10
    mov edx, 1
    int 0x80
	pop ecx				; Restore numerical value of ecx
    
    ; increment the counter
   	add ecx, 1 			; Increment count in one (Avoid infinite loop)
    
    ; check if we've printed 10 numbers yet
    cmp ecx, 10 		; Compare
    jne .loop			; while (ecx != 10){... code ...}
    
	; exit the program
    mov eax, 1			; System Exit
    xor ebx, ebx		; Exit Status (Success = 0)
    int 0x80			; Execute call
    
section .data
    newline db 10
