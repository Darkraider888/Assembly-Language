;2.   Your city is preparing for the annual festival of lights. The event organizers 
;test their decorative lights in a special pattern on the main stage.  
 
;a. At first, the lights decrease row by row until only one bulb shines. 
;b. Then, the lights increase row by row back to full brightness.  
 
;You are asked to simulate this light pattern using a star (*) symbol on the 
;screen. 
 
;Input: 
 
;A single integer N (1 ≤ N ≤ 9), representing the maximum number of lights in 
 
;Page 2 of 2  
 
;the first row.  
;Output: 
;A star pattern that decreases from N down to 1, then increases from 1 back to 
;N. 
;Test case: 
;Input: 3 
;Output: *** 
;        ** 
;        * 
;        ** 

.model small
.stack 100h

.data
inputMsg db "Enter N (1-9): $"
star     db "*$"
newline  db 13,10,"$"
N        db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ---- Print input message ----
    lea dx, inputMsg
    mov ah, 9
    int 21h

    ; ---- Read N ----
    mov ah, 1
    int 21h
    sub al, '0'
    mov N, al
    
    ; ---- Clear screen (optional) ----
    mov ax, 3
    int 10h

    ; ===== Decreasing part =====
    mov cl, N
    mov ch, 0
    
dec_loop:
    cmp cl, 0
    je inc_part
    
    ; Print cl stars
    mov bl, cl
print_stars_dec:
    push bx
    lea dx, star
    mov ah, 9
    int 21h
    pop bx
    dec bl
    jnz print_stars_dec
    
    ; Print newline
    lea dx, newline
    mov ah, 9
    int 21h
    
    dec cl
    jmp dec_loop

; ===== Increasing part =====
inc_part:
    mov cl, 2          ; Start from 2 stars
    mov ch, 0
    
inc_loop:
    mov bl, N
    inc bl
    cmp cl, bl
    je exit_prog
    
    ; Print cl stars
    mov dl, cl
print_stars_inc:
    push dx
    lea dx, star
    mov ah, 9
    int 21h
    pop dx
    dec dl
    jnz print_stars_inc
    
    ; Print newline
    lea dx, newline
    mov ah, 9
    int 21h
    
    inc cl
    jmp inc_loop

; ===== Exit =====
exit_prog:
    mov ah, 4Ch
    int 21h

main endp
end main
