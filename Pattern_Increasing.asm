;*
;**
;***
;**** 
;*****

.model small
.stack 100h

.data
.code

main proc
    mov ax, @data
    mov ds, ax

    mov bx, 1     

outer_loop:
    mov cx, bx    

inner_loop:
    mov ah, 2
    mov dl, '*'
    int 21h
    loop inner_loop

    ; print new line
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

    inc bx         
    cmp bx, 9    
    jl outer_loop

    exit: 
        mov ah, 4Ch
        int 21h

main endp
end main