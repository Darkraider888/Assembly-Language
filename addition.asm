.model small
.stack 100h

.data
 
 
 
.code


main proc 
    
    mov ax , @data  ; activate data segement
    mov ds, ax
    
    ;sum of two numbers
    mov dx , 4
    mov ax, 5
    add dx, ax
    add dx, 48
          
    mov ah , 2 ; for print character use 2
    int 21h
    
    mov ah, 4ch  ;terminate like return 0
    int 21h
    
main endp
end main