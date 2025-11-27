.model small
.stack 100h

.data
    
    number db "Enter four numbers : $"
    result db 13, 10, "The Largest number is : $"
    
    n1 db ?
    n2 db ?
    n3 db ?
    n4 db ? 
    max db ?

.code

main proc
    
    mov ax, @data
    mov ds , ax
    
    ;-------take input-------
    lea dx, number
    mov ah, 9
    int 21h

    mov ah, 1        ; read first digit
    int 21h
    mov n1, al

    mov ah, 1        ; read space
    int 21h

    mov ah, 1        ; read second digit
    int 21h
    mov n2, al

    mov ah, 1        ; read space
    int 21h

    mov ah, 1        ; read third digit
    int 21h
    mov n3, al

    mov ah, 1        ; read space
    int 21h

    mov ah, 1        ; read fourth digit
    int 21h
    mov n4, al
    int 21h
    
    ;-----assume n1 is the max number
    mov al, n1
    mov max , al  ; cannot move memory to memory directly, so use register
    
    ; compare n2 with max
    mov al, n2
    cmp al, max
    jle skip2 ; using jle makes code shorter (Jump if less or equal)
                ; n2 is smaller, skip & compare n3  
     
    mov max, al ; else n2 is max
    
    skip2:
        mov al, n3
        cmp al, max
        jle skip3 ; if small then skip
        
        mov max, al ; else n3 is is max
   
   
    skip3:
        mov al, n4
        cmp al, max
        jle skip4  ; if less then just print
    
        mov max, al ; else n4 is max
    
    skip4:
        ;----------PRINT-----------
        lea dx , result
        mov ah , 9
        int 21h
    
        mov dl, max
        mov ah , 2
        int 21h 
    
    exit:             
        mov ah , 4ch
        int 21h

main endp
end main