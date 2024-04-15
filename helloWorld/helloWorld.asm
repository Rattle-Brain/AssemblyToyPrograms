section .data
    msg db 'Hello, world!', 0xA  ; Message to write to console

section .text
    global _start

_start:
    ; Prepare parameters for write system call
    mov eax, 0x4    ; System call number for write
    mov ebx, 1      ; File descriptor for console output
    mov ecx, msg    ; Pointer to message to write
    mov edx, 14     ; Length of message

    ; Invoke write system call
    int 0x80        ; Interrupt to trigger system call

    ; Terminate program
    mov eax, 0x1    ; System call number for exit
    xor ebx, ebx    ; Return value
    int 0x80        ; Interrupt to trigger system call
