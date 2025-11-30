.model small
.stack 100h

.data
  
  logicAnd DB "AND Output: $"
  logicOr DB 13,10, "OR Output: $"  
  logicXor DB 13, 10, "X-OR Output: $"
  logicNot DB 13, 10, "Not Output: $"  
    
.code

main proc
    mov ax , @data
    mov ds , ax 
    
    lea dx,logicAnd; AND Output 
    mov ah, 9
    int 21h  
    
    ;AND Operation
    mov bl, 111b
    and bl, 110b 
    add bl, '0' ; Convert to ASCII
 
    
    ;Show Output ; '6' show korbe
    mov dl, bl
    mov ah , 2
    int 21h  
    
    OrSegment:
    
        lea dx, logicOr
        mov ah, 9
        int 21h
    
    ;OR Operation   
    mov bl, 111b
    or bl , 110b
    add bl, '0' 
 
    
    ;Show Output ; '7' show korbe
    mov dl, bl
    mov ah , 2
    int 21h  
    
    
    XorSegment:
        
        lea dx,logicXor
        mov ah, 9
        int 21h
         
    ;XOR Operation   
    mov bl, 111b
    Xor bl , 110b
    add bl, '0'
   
    
    ;Show Output ; '1' show korbe
    mov dl, bl
    mov ah , 2
    int 21h 
    
    NotSegment:
    
        lea dx, logicNot  
        mov ah , 9
        int 21h
        
    ;NOt Operation   
    mov bl, 110b
    not bl 
    and bl, 111b ; last 3 bit active thakbe
    add bl, '0' 
  
    ;Show Output ; '1' show korbe
    mov dl, bl
    mov ah , 2
    int 21h 
    
    mov ah , 4ch 
    int 21h

main endp
end main
    
    
    
