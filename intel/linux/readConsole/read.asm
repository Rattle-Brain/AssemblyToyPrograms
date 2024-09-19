section .data
    msg db "Enter a value: "
    len equ $ - msg
	blen equ 128
    buffer times blen db 0

section .text
    global _start

_start:
    ; Print the message to console
    mov eax, 4 		; System call for writing to console
    mov ebx, 1 		; File descriptor for stdout
    mov ecx, msg 	; Address of message to print
    mov edx, len 	; Length of message
    int 0x80

    ; Read input from console
    mov eax, 3 		; System call for reading from console
    mov ebx, 0 		; File descriptor for stdin
    mov ecx, buffer ; Address of buffer to read into
    mov edx, blen 	; Maximum number of bytes to read
    int 0x80

    ; Print the input to console
    mov eax, 4 		; System call for writing to console
    mov ebx, 1 		; File descriptor for stdout
    mov ecx, buffer ; Address of buffer to print
    mov edx, blen	; Length of buffer
    int 0x80

    ; Exit program
    mov eax, 1 		; System call for exiting program
    xor ebx, ebx 	; Return value (0 for success)
    int 0x80