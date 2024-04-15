section .data
	prompt db "Loop iterations: ", 0 
	plen equ $ - prompt
	blen equ 8
	buffer times blen db 0

	msg db "Number: "
	mlen equ $ - msg

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
	jmp _end

; We start the loop here
loop:
	; Let's print the message "Number: " 
	mov eax, 4			; System Write
	mov ebx, 1			; Standard output
	mov ecx, msg		; Address of msg
	mov edx, mlen		; Msg length
	int 0x80			; System call

	; Remember the 0 we stored into de stack? Let's use it
	mov ecx, esp		; Initialize the counter to 0
	mov eax, 4			; System Write
	mov ebx, 1			; Standard output
	mov edx, 1			; Lenght in bytes of the number
	int 0x80

	; Now we have to transform the number into text and save it

	jmp _end
	


_end:
	; Exit the program
	mov eax, 1			; System Exit
	xor ebx, ebx		; EBX is now 0
	int 0x80
