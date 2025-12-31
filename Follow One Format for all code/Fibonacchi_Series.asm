.model small
.stack 100h

.data
     
     input db "Enter Number (0 to 9): $"
     output db 13,10, "Fibonacchi Series: $"
     
     n dw ?   ; user input
     n1 dw 0  ; 1st number 0
     n2 dw 1  ; 2nd numbre 1   
     
     buffer db 6 dup(?) ; series will store in buffer
     
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
    
      
    lea dx, output
    mov ah, 9
    int 21h  
             
    mov cx , n ; total counnt
    
     fib_loop:
        mov ax , n1 ; 1st number print
        
        lea si , buffer + 5 ; load buffer
        mov di , 0 ; for counting digit
        
        cmp ax , 0  ; 0 na hole convert hobe
        jne convert
        
        ;else print
        dec si
        mov [si] , '0' 
        inc di
        jmp print_num   
     
     convert:
        xor dx, dx ; garbage value clear at first
        mov bp , 10 ; 10 diye vag
        
        do_div:
            div bp
        add dl , '0'
        dec si
        mov [si] , dl
        inc di
        
        xor dx , dx ; before division we always have to clear
        cmp ax , 0 ; tell the number come to 0
        jne do_div
        
    print_num:
        mov ah , 2
    
    print_out:
        mov dl , [si]
        int 21h
        inc si
        dec di ; counting  
        jne print_out    
        
    ; print space
    mov dl , ' '
    mov ah , 2
    int 21h
    
    ; fibonacchi conditio
    mov ax , n1
    add ax , n2
    
    mov dx , n2
    mov n1 , dx
    mov n2 , ax
    
    loop fib_loop   
    
    
    exit:
    mov ah,4ch
    int 21h

main endp
end main