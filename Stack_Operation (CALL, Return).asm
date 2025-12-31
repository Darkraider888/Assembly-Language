.model small
.stack 100h

.data
.code

;1st procedure
main proc
    mov ax, @data
    mov ds , ax
    
    mov ax, 2
    call call_ret
    mov bx , 4  
    call call_ret1
    
   
    
    exit:
    mov ah, 4ch
    int 21h

main endp 


;2nd procedure

call_ret proc
    mov ax , 3
    mov bx, 5 
    
    ;call call_ret1
    ret     ; return

call_ret endp


;3rd for nested procedure

call_ret1 proc
    mov ax , 7 
    mov bx, 8  
    ret
call_ret1 endp   


end main
