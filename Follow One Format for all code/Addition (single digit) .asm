.model small
.stack 100h

.data
    num1   db "Enter 1st number: $"
    num2   db 13,10,"Enter 2nd number: $"
    result db 13,10,"Sum: $"  
    
    n1 db ?
    n2 db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; print prompt 1
    lea dx, num1
    mov ah, 9
    int 21h

    ; read digit 1
    mov ah, 1
    int 21h
    sub al, '0'
    mov n1, al

    ; print prompt 2
    lea dx, num2
    mov ah, 9
    int 21h

    ; read digit 2
    mov ah, 1
    int 21h
    sub al, '0'
    mov n2 , al

    ;sum
    mov bl, n1
    add bl , n2         

    ; print "Sum: "
    lea dx, result
    mov ah, 9
    int 21h

    ; print digit  
    
    mov dl , bl
    add dl , '0'
    mov ah, 2
    int 21h

    mov ah, 4Ch
    int 21h
main endp
end main
