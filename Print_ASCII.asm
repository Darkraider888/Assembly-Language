.model small
.stack 100h

.data
    


.code

main proc
    mov ax , @data
    mov ds, ax  
    
    mov cx, 0  ;global condition for outer loop
    outer_loop:
        mov bx, cx
    
    
    mov cx, 10 ; karon inner loop a 10 ta kore print hobe
    inner_loop: 
        mov ah,2 
        mov dl , bl ; karon ASCII / jekono base value nile eta 'bl' a jabe
        int 21h
        
        inc bl ; increment bl
        cmp bl , 255
        je exit
        
        ;else print hobe
        loop inner_loop 
    
    ;10 er pore newline hobe
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h 
    
    mov cx, bx 
    loop outer_loop 
    
    exit:
        mov ah, 4ch
        int 21h    

main endp
end main