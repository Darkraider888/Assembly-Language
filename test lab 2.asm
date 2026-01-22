.model small
.stack 100h

.data
prompt      db 'Input: $'
msgOdd      db 13,10,'Odd Load Detected$'
msgEven     db 13,10,'Even Load Detected$'
msgZero     db 13,10,'All Are Stars Here$'
star        db '*$'
newline     db 13,10,'$'
input       db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Display prompt
    mov ah, 09h
    lea dx, prompt
    int 21h

    ; Read single digit input
    mov ah, 01h
    int 21h
    
    ; Convert ASCII to number
    sub al, '0'
    mov input, al
    
    ; Check if zero
    cmp al, 0
    je zero_case
    
    ; Check odd/even using bit test
    test al, 1
    jz even_case
    
odd_case:
    ; Print Odd message
    mov ah, 09h
    lea dx, msgOdd
    int 21h
    
    ; Print newline
    lea dx, newline
    int 21h
    
    ; For odd: increasing stars from 1 to N
    mov cl, 1          ; Start with 1 star
odd_loop:
    cmp cl, input
    jg exit_program
    
    ; Print cl stars
    mov ch, 0
    mov dl, '*'
odd_star_loop:
    mov ah, 02h
    int 21h
    inc ch
    cmp ch, cl
    jl odd_star_loop
    
    ; Print newline
    mov ah, 09h
    lea dx, newline
    int 21h
    
    inc cl
    jmp odd_loop
    
even_case:
    ; Print Even message
    mov ah, 09h
    lea dx, msgEven
    int 21h
    
    ; Print newline
    lea dx, newline
    int 21h
    
    ; For even: decreasing stars from N down to 1
    mov cl, input      ; Start with N stars
even_loop:
    cmp cl, 0
    jle exit_program
    
    ; Print cl stars
    mov ch, 0
    mov dl, '*'
even_star_loop:
    mov ah, 02h
    int 21h
    inc ch
    cmp ch, cl
    jl even_star_loop
    
    ; Print newline
    mov ah, 09h
    lea dx, newline
    int 21h
    
    dec cl
    jmp even_loop
    
zero_case:
    ; Print zero message
    mov ah, 09h
    lea dx, msgZero
    int 21h
    
exit_program:
    ; Exit program
    mov ah, 4Ch
    int 21h
    
main endp
end main