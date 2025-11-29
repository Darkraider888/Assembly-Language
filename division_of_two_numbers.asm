.model small
.stack 100h
.data
    dividend db "Enter Dividend (0 to 9): $"
    divisor db 13,10,"Enter Divisor(0 to 9): $"
    quotient db 13,10,"Quotient: $"
    remainder db 13,10,"Remainder: $"
    error db 13,10,"0 diye kono number k vag kora jayna :)$"
    
    num1 db ?
    num2 db ?
    q db ?
    r db ? 
      
  ;? is used because their values aren’t known until the program runs.
;They let us keep inputs and outputs separate from strings like "Enter Dividend: $".

.code 

main proc
    mov ax,@data
    mov ds,ax
    ;--- Input Dividend ---
    lea dx, dividend
    mov ah, 9
    int 21h

    mov ah, 1        ; read char from keyboard
    int 21h
    sub al, '0'        ; convert ASCII to number
    mov num1, al     
    
    ;The character typed is stored in AL, but as ASCII code, not the number itself.

    ;--- Input Divisor ---
    lea dx, divisor
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, '0'
    mov num2, al

    ;--- Check division by zero ---
    cmp num2, 0
    je div_error

    ;--- Division ---
    mov al, num1       ;dividend = AL
    xor ah, ah         ; ager garbage data thakle seta clear kora
    
    mov bl, num2       ;divisor = BL
    div bl             ; AL / BL -> quotient in AL, remainder in AH

    mov q, al
    mov r, ah

    ;--- Print Quotient ---
    lea dx, quotient
    mov ah, 9
    int 21h
    
    mov al, q       ; load quotient from memory into AL
    add al, '0'     ; convert number to ASCII character
    mov dl, al      ; move character to DL for printing
    mov ah, 2     ; DOS function: print character
    int 21h         ; call DOS interrupt

    ;after division:
    ;AL no longer has the dividend
    ;AL now has the quotient;
    ;AH now has the remainder
    
    ;--- Print Remainder ---
    lea dx, remainder
    mov ah, 9
    int 21h
    
    mov al, r
    add al, '0'
    mov dl, al
    mov ah, 2
    int 21h

    jmp exit:

div_error:
    lea dx, error
    mov ah, 9
    int 21h

exit:
    mov ah, 4Ch
    int 21h
main endp
end main
