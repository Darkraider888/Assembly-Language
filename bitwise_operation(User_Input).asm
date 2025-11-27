.model small
.stack 100h

.data
  
  logicAnd DB 13,10,"AND Output: $"
  logicOr DB 13,10,"OR Output: $"  
  logicXor DB 13,10,"X-OR Output: $"
  logicNot DB 13,10,"Not Output (Number 1): $"  
  msg1 DB 13,10, "Enter 1st Number  : $"
  msg2 DB 13,10, "Enter 2nd Number  : $"

.code

main proc
    mov ax , @data
    mov ds , ax 

    ;--------------- 
    ; Read Number 1
    ;---------------
    lea dx, msg1
    mov ah, 9
    int 21h

    mov ah,1
    int 21h
    sub al,'0'
    mov bl,al; user input sob smy al a ashe..tai bl a rakhsi karon pore
                ;arekta input ache

    ;--------------- 
    ; Read Number 2
    ;---------------
    lea dx, msg2
    mov ah, 9
    int 21h

    mov ah,1
    int 21h
    sub al,'0'
    mov bh,al  ; store num2



    ;=============== AND ===============
    lea dx, logicAnd
    mov ah, 9
    int 21h

    mov al, bl
    and al, bh
    add al, '0'

    mov dl, al
    mov ah, 2
    int 21h


    ;=============== OR ===============
    lea dx, logicOr
    mov ah, 9
    int 21h

    mov al, bl
    or al, bh
    add al, '0'

    mov dl, al
    mov ah, 2
    int 21h


    ;=============== XOR ===============
    lea dx, logicXor
    mov ah, 9
    int 21h

    mov al, bl
    xor al, bh
    add al, '0'

    mov dl, al
    mov ah, 2
    int 21h


    ;=============== NOT ( number 1) ===============
    lea dx, logicNot
    mov ah, 9
    int 21h

    mov al, bl
    not al
    and al, 1b
    add al, '0'

    mov dl, al
    mov ah, 2
    int 21h


    mov ah , 4ch 
    int 21h

main endp
end main