
msg: .ascii "Hello World in ARM64\n"

.text

.global _start
.align 4

_start: mov   X0, #1
        adr   X1, msg
        mov   X2, #20
        mov   X16, #4
        svc   #0x80

        mov   X0, #0    /*Status code = 0*/
        mov   X16, #1   /*exit syscall == 93*/
        svc   #0x80        /*INVOKE*/
