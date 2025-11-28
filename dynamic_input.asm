.model small
.stack 100h
.data
    msg db "Enter your name: $"
    buffer db 50        ; max length
           db ?         ; actual length
           db 50 dup('$') ; to store user input
    greet db 13,10,'Hello, $'
.code
main proc
    mov ax, @data
    mov ds, ax   
    
    ; Display message
    lea dx, msg
    mov ah, 9
    int 21h
    
    ; Take input
    lea dx, buffer
    mov ah, 0Ah
    int 21h
    
    ; Print greeting
    lea dx, greet
    mov ah, 9
    int 21h
    
    ; Print entered name (skip 2 bytes: maxlen + actual length)
    lea dx, buffer + 2
    mov ah, 9
    int 21h
    
    mov ah, 4Ch
    int 21h
main endp
end main