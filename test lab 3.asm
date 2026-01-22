.model small
.stack 100h

.data
prompt      db 'Input: $'
msgOdd      db 13,10,'Odd Number$'
msgEven     db 13,10,'Even Number$'
msgZero     db 13,10,'All is Well$'
newline     db 13,10,'$'
input       db ?
counter     db ?
result      dw ?
multiplier  db ?

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
    
    ; For odd: table from 1 to 5
    mov counter, 1
    
odd_loop:
    ; Check if counter > 5
    mov al, counter
    cmp al, 5
    jg exit_program
    
    ; Print N x i = format
    ; Print N
    mov dl, input
    add dl, '0'
    mov ah, 02h
    int 21h
    
    ; Print " x "
    mov dl, ' '
    int 21h
    mov dl, 'x'
    int 21h
    mov dl, ' '
    int 21h
    
    ; Print i (counter)
    mov dl, counter
    add dl, '0'
    int 21h
    
    ; Print " = "
    mov dl, ' '
    int 21h
    mov dl, '='
    int 21h
    mov dl, ' '
    int 21h
    
    ; Calculate result: input * counter
    mov al, input
    mov bl, counter
    mul bl          ; Result in AX
    
    ; Check if result is single or double digit
    cmp al, 10
    jae double_digit_odd
    
    ; Single digit result
    mov dl, al
    add dl, '0'
    mov ah, 02h
    int 21h
    
    ; Print newline
    mov ah, 09h
    lea dx, newline
    int 21h
    
    ; Increment counter
    inc counter
    jmp odd_loop
    
double_digit_odd:
    ; Result is two digits (10-45 for odd numbers)
    mov bl, 10
    div bl          ; AL = tens, AH = units
    
    ; Save units
    mov cl, ah
    
    ; Print tens digit
    mov dl, al
    add dl, '0'
    mov ah, 02h
    int 21h
    
    ; Print units digit
    mov dl, cl
    add dl, '0'
    int 21h
    
    ; Print newline
    mov ah, 09h
    lea dx, newline
    int 21h
    
    ; Increment counter
    inc counter
    jmp odd_loop
    
even_case:
    ; Print Even message
    mov ah, 09h
    lea dx, msgEven
    int 21h
    
    ; Print newline
    lea dx, newline
    int 21h
    
    ; For even: table from 1 to 10
    mov counter, 1
    
even_loop:
    ; Check if counter > 10
    mov al, counter
    cmp al, 10
    jg exit_program
    
    ; Print N x i = format
    ; Print N
    mov dl, input
    add dl, '0'
    mov ah, 02h
    int 21h
    
    ; Print " x "
    mov dl, ' '
    int 21h
    mov dl, 'x'
    int 21h
    mov dl, ' '
    int 21h
    
    ; Print i (counter)
    ; Check if counter is 10 (two digits)
    mov al, counter
    cmp al, 10
    je counter_is_10
    
    ; Counter is 1-9 (single digit)
    mov dl, al
    add dl, '0'
    mov ah, 02h
    int 21h
    jmp after_counter_print
    
counter_is_10:
    ; Print "10"
    mov dl, '1'
    int 21h
    mov dl, '0'
    int 21h
    
after_counter_print:
    ; Print " = "
    mov dl, ' '
    int 21h
    mov dl, '='
    int 21h
    mov dl, ' '
    int 21h
    
    ; Calculate result: input * counter
    mov al, input
    mov bl, counter
    mul bl          ; Result in AX
    
    ; Check if result is single or double digit
    cmp al, 10
    jae double_digit_even
    
    ; Single digit result
    mov dl, al
    add dl, '0'
    mov ah, 02h
    int 21h
    
    ; Print newline
    mov ah, 09h
    lea dx, newline
    int 21h
    
    ; Increment counter
    inc counter
    jmp even_loop
    
double_digit_even:
    ; Result is two digits (10-90 for even numbers)
    mov bl, 10
    div bl          ; AL = tens, AH = units
    
    ; Save units
    mov cl, ah
    
    ; Print tens digit
    mov dl, al
    add dl, '0'
    mov ah, 02h
    int 21h
    
    ; Print units digit
    mov dl, cl
    add dl, '0'
    int 21h
    
    ; Print newline
    mov ah, 09h
    lea dx, newline
    int 21h
    
    ; Increment counter
    inc counter
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