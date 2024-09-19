section .bss
  buffer_input resb 12   ; Reserve 12 bytes for the string buffer (sufficient for a 32-bit integer + null terminator)

section .data
  ten dd 10
  newline db 10

section .text
  global _start

_start:
  mov eax, 4321           ; Define a number
  push eax                ; Save the numner to the stack

  call int_to_str         ; Call the function

  add esp, 4              ; Remove eax from stack (no pop)

  ; Print the number 4321
  mov eax, 4              ; Syscall write
  mov ebx, 1              ; Stdout
  mov ecx, buffer_input         ; Msg to print in ecx
  mov edx, 12             ; Len of buffer
  int 0x80                ; Execute interruption

  ; Print a newline char
  mov eax, 4
  mov ebx, 1
  mov ecx, newline
  mov edx, 1
  int 0x80

  ; Exit program
  mov eax, 1
  xor ebx, ebx
  int 0x80


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
  mov edi, buffer_input + 11 ; Point to the end of the buffer
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
  ; You can clear the stack values here, altough
  ; in my opinion that should be done outside the
  ; function.

  ; Before the ret you should make sure the values
  ; you want to return are accesible and stored
  ; in the registers you want or have documente or have documented.

  ret
