.model small          ; memory model: one code + one data segment
.stack 100h           ; reserve stack space (256 bytes)

.data                 ; data section ? variables, messages
    msg db "Hello" , 10, 13 , 'world$'

.code
                 ; code section ? actual instructions
main proc
    mov ax, @data     ; load address of data segment
    mov ds, ax        ; activate data segment

    lea dx, msg       ; load message address
    mov ah, 9         ; DOS print function
    int 21h           ; interrupt call to print

    mov ah, 4Ch       ; exit program
    int 21h

main endp
end main