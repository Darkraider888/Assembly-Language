.model small
.stack 100h
.data 
.code
main proc 
    
    mov ax , @data  ; activate data segement
    mov ds, ax
    
    ;multiplication of two numbers
    mov dx , 3
    mov ax, 2
    
    mul dx  ; dx = multiplier , ax = multiplicand , reuslt store hobe ax a 
    mov dx , ax  
    add dx , 48 ; ascii te convert
    
 
    mov ah , 2 ; for print character use 2
    int 21h
    
    mov ah, 4ch  ;terminate like return 0
    int 21h
    
main endp
end main
