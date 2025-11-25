; Pattern_Decreasing_Vertically
.model small
.stack 100h

.data
    


.code

main proc
    mov ax , @data
    mov ds, ax  
    
    mov cx , 9 ; loop 9 bar cholbe
    
    outer_loop:    ;line count korbe
         mov bx , cx ; bcz eta arekta kaj inner loop er  * count korbe
    
    
    inner_loop:    ;star (*) count korbe
        mov ah , 2 ; * print hobe
        
        mov dl, '*'
        int 21h
        mov ah,2 ; new line print
        mov dl, 13
        int 21h
        mov dl , 10
        int 21h 
        
        loop inner_loop ; for loop. by default decresing to cx = 0 and stop  
        
        mov ah,2 ; new line print
        mov dl, 13
        int 21h
        mov dl , 10
        int 21h  
        
        mov cx, bx ; now again copy for counitng line
        loop outer_loop
        
    
    exit:
        mov ah, 4ch
        int 21h    

main endp
end main