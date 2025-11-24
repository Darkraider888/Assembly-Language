.model small
.stack 100h

.data
    number db "Enter Three Numbers (without space): $"
    result db 13, 10,"The largest number is : $"
    
    n1 db ?
    n2 db ?
    n3 db ?
    max db ?
       
.code

main proc
    mov ax , @data
    mov ds, ax
    
    ;------take input------
    
    lea dx, number
    mov ah, 9
    int 21h
    
    mov ah , 1  ; for taking input
    int 21h
    
    mov n1 , al
    int 21h
    
    mov n2 , al
    int 21h
    
    mov n3 , al
    
    ;------let n1 is the max
    mov al , n1
    mov max , al
    
    ;-------compare n2 with max if less or equal then skip else n2 is max
    mov al , n2
    cmp al, max
    
    jle skip_n2 ; if less then skip
    mov max , al ; else n2 is max
    
    ;-------compare n3 with max if less or equal then skip else n3 is max
    mov al , n3
    cmp al, max
    
    jle skip_n3 ; if less then skip and print
    mov max , al ; else n3 is max 
    
    
    skip_n2:
        mov al , n3;
        cmp al, max
        jle skip_n3
        mov max, al
    
    skip_n3:
        lea dx, result      ; print
        mov ah , 9
        int 21h
        
        mov ah , 2
        mov dl, max
        int 21h 
    
    exit:
        mov ah, 4ch
        int 21h 
       
main endp
end main