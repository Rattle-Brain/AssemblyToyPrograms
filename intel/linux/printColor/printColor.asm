section .data    
    ; Prompt message
    msg db "Enter a value: "
    len equ $ - msg
	blen equ 128
    buffer times blen db 0

    ; Color prompt
    colorPrompt db "Enter a color:", 0xD, 0xA, " 1. Green", 0xD, 0xA, " 2. Red", 0xD, 0xA, " 3. Yellow", 0xD, 0xA, " 4. Blue", 0xD, 0xA, " 5. Magenta", 0xD, 0xA, " 6. Cyan", 0xD, 0xA, " 7. White", 0xD, 0xA, ""
    colorPromptLen equ $ - colorPrompt

    ; Color buffer
    colorBuffer times 1 db 0
    colorBufferLen equ 1


    ; Colors
    red db 0x1B, "[0;31m", 0
    redLen equ $ - red

    green db 0x1B, "[0;32m", 0
    greenLen equ $ - green

    yellow db 0x1B, "[0;33m", 0
    yellowLen equ $ - yellow

    blue db 0x1B, "[0;34m", 0
    blueLen equ $ - blue

    magenta db 0x1B, "[0;35m", 0
    magentaLen equ $ - magenta

    cyan db 0x1B, "[0;36m", 0
    cyanLen equ $ - cyan

    white db 0x1B, "[0;37m", 0
    whiteLen equ $ - white

    reset db 0x1B, "[0m", 0
    resetLen equ $ - reset

section .text
    global _start

_start:
    ; Print the message to console
    mov eax, 4 		            ; System call for writing to console
    mov ebx, 1 		            ; File descriptor for stdout
    mov ecx, msg 	            ; Address of message to print
    mov edx, len 	            ; Length of message
    int 0x80

    ; Read text input from console
    mov eax, 3 		            ; System call for reading from console
    mov ebx, 0 		            ; File descriptor for stdin
    mov ecx, buffer             ; Address of buffer to read into
    mov edx, blen 	            ; Maximum number of bytes to read
    int 0x80

colorSelectionPrompt:
    ; Print the color prompt to console
    mov eax, 4 		            ; System call for writing to console
    mov ebx, 1 		            ; File descriptor for stdout
    mov ecx, colorPrompt        ; Address of color prompt to print
    mov edx, colorPromptLen     ; Length of color prompt
    int 0x80

    ; Read the color to print from console
    mov eax, 3 		            ; System call for reading from console
    mov ebx, 0 		            ; File descriptor for stdin
    mov ecx, colorBuffer        ; Address of buffer to read into
    mov edx, colorBufferLen 	; Maximum number of bytes to read
    int 0x80

    ; Routine to select the color
    jmp selectPrintColor

printInput:
    ; Print the input to console
    mov eax, 4 		            ; System call for writing to console
    mov ebx, 1 		            ; File descriptor for stdout
    int 0x80

    ; Print the message to console
    mov eax, 4 		            ; System call for writing to console
    mov ecx, buffer
    mov edx, eax           ; Length of input
    int 0x80

    ; Print the color to console
    mov eax, 4 		            ; System call for writing to console
    mov ebx, 1 		            ; File descriptor for stdout
    mov ecx, reset              ; Address of buffer to print
    mov edx, 4
    int 0x80

    jmp _start

terminate:
    ; Exit program
    mov eax, 1 		            ; System call for exiting program
    xor ebx, ebx 	            ; Return value (0 for success)
    int 0x80

selectPrintColor:
    mov bl, byte [colorBuffer]
    sub bl, '0'          ; Convert ASCII to digit

    cmp bl, 1
    je setRed
    cmp bl, 2
    je setGreen
    cmp bl, 3
    je setYellow
    cmp bl, 4
    je setBlue
    cmp bl, 5
    je setMagenta
    cmp bl, 6
    je setCyan
    cmp bl, 7
    je setWhite

    jmp terminate

setRed:
    mov ecx, red
    mov edx, redLen
    jmp printInput

setGreen:
    mov ecx, green
    mov edx, greenLen
    jmp printInput

setYellow:
    mov ecx, yellow
    mov edx, yellowLen
    jmp printInput

setBlue:
    mov ecx, blue
    mov edx, blueLen
    jmp printInput

setMagenta:
    mov ecx, magenta
    mov edx, magentaLen
    jmp printInput

setCyan:
    mov ecx, cyan
    mov edx, cyanLen
    jmp printInput

setWhite:
    mov ecx, white
    mov edx, whiteLen
    jmp printInput

    