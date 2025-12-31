.model small
.stack 100h

.data
     
     input db "Enter Number: $"
     output db 13,10, "Output: $"
     n dw ?
     
.code

main proc
    mov ax, @data
    mov ds, ax
    
    lea dx, input
    mov ah, 9
    int 21h
    
    mov ah,1
    int 21h
    sub al, '0'
    
    xor ah , ah ; make higher bit clear , bcz we will work with ax
    mov n , ax
    
    
    ; global conditiom
    mov ax , n  ; let n = 5 
    mov cx, n
    dec cx      ; cx will count total times
    
    factorial: 
         dec n  ; n-1 = 4 , so 5 * 4 * 3 going on
         mul n
         
         dec cx
         cmp cx, 0
         jne factorial
     
     
     xor cx , cx  ; garbage value clear of cx
     div_loop:
        xor dx , dx
        mov si , 10
        div si 
     
        push dx  ; the remainder dx is pushing to stack
        inc cx
        cmp ax , 0
        jne div_loop
      
    lea dx, output
    mov ah, 9
    int 21h  
    
    print_out:
        pop dx
        add dl, '0'
        mov ah , 2
        int 21h
        loop print_out    
        
        
    
    
    exit:
    mov ah,4ch
    int 21h

main endp
end main