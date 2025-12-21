.model small
.stack 100h

.data
inputMsg db "Input: $"
hexMsg   db 13,10,"Hex number: $"
cntMsg   db 13,10,"Total digits: $"
digitCnt dw ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ---- Print input message ----
    lea dx, inputMsg
    mov ah, 9
    int 21h

    mov si, 0          ; SI will store decimal number

; ===== Take decimal input =====
take_input:
    mov ah, 1
    int 21h
    cmp al, 13         ; Enter key?
    je convert_hex

    sub al, 30h        ; ASCII → number
    mov bl, al
    mov ax, si
    mov cx, 10
    mul cx             ; SI = SI * 10
    add ax, bx         ; + digit
    mov si, ax
    jmp take_input

; ===== Convert decimal to hex =====
convert_hex:
    mov ax, si
    mov bx, 16
    xor cx, cx         ; CX = hex digit count

divide_hex:
    xor dx, dx
    div bx
    push dx            ; remainder
    inc cx
    cmp ax, 0
    jne divide_hex

    mov digitCnt, cx   ; save digit count

    ; ---- Print hex message ----
    lea dx, hexMsg
    mov ah, 9
    int 21h

; ===== Print hex digits =====
print_hex:
    pop dx
    cmp dl, 9
    jbe digit
    add dl, 7          ; A–F adjustment

digit:
    add dl, 30h
    mov ah, 2
    int 21h
    loop print_hex

    ; ---- Print count message ----
    lea dx, cntMsg
    mov ah, 9
    int 21h

    mov ax, digitCnt
    add al, 30h        ; single-digit count
    mov dl, al
    mov ah, 2
    int 21h

; ===== Exit =====
exit:
    mov ah, 4Ch
    int 21h

main endp
end main
