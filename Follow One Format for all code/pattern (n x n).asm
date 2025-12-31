.model small
.stack 100h

.data
    input db "Enter Number (0 to 9): $"

.code
main proc
    mov ax, @data
    mov ds, ax


    ; print prompt
    lea dx, input
    mov ah, 9
    int 21h

    ; read one digit (0..9)
    mov ah, 1
    int 21h
    sub al, '0'
    mov bl, al          ; store n in BL

; ---- newline at start ----
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    ; --------------------------    
xor ch , ch
mov cl , bl
outer_loop:
    push cx

mov cl , bl
inner_loop: 
    mov ah , 2
    mov dl , '*'
    int 21h
    
    dec cl
    jne inner_loop
    
    ; ---- newline at ----
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    ; --------------------------
    
    pop cx
    dec cl
    jne outer_loop            

    


exit:
    mov ah, 4Ch
    int 21h
main endp
end main
