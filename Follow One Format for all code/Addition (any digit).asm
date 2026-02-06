.model small
.stack 100h

.data
    num1 db "Enter 1st number: $" 
    num2 db 13, 10, "Enter 2nd number: $"
    result db 13, 10, "Sum: $" 
    
    n1 dw ?
    n2 dw ?
    

.code

main proc
    mov ax, @data
    mov ds, ax

    
    lea dx, num1
    mov ah, 9
    int 21h
    
    xor bx , bx  ; karon bx a rakhbo
    read1:
        mov ah, 1
        int 21h
        cmp al, 13
        je store1 ; enter dile done
        
        sub al , '0'
        xor ah , ah ; karon bx a rakhbo tai puro ta clear
        
        mov cx, ax ; save  input
        mov ax , bx
        mov si , 10
        mul si
        
        add ax , cx  
        mov bx, ax
        jmp read1
        
     
     
     store1:
        mov n1, bx
        
        ;====inpu 2nd number
        lea dx, num2
        mov ah, 9
        int 21h    
        
        xor bx, bx
        read2:
           mov ah, 1
           int 21h
           cmp al, 13
           je store2
           
           sub al , '0'
           xor ah , ah
           
           mov cx, ax
           mov ax , bx
           
           mov si , 10
           mul si
           
           add ax, cx
           mov bx, ax
           jmp read2
    
    store2:
        mov n2 , bx
        
        ; =====sum======
        mov bx, n1
        add bx , n2
        
        lea dx, result
        mov ah, 9
        int 21h
        
        mov ax, bx
        xor cx, cx ; count with cx
        convert:
            xor dx, dx
            mov si, 10
            div si
            push dx
            inc cx
            cmp ax, 0
            jne convert
         
         print:
            pop dx
            add dl, '0'
            mov ah , 2
            int 21h
            loop print 
         

        exit:
            mov ah, 4Ch
            int 21h
main endp
end main
