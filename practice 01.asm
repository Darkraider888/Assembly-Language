; A research satellite sends back its status code as a decimal integer (base-10). 
; However, the ground station’s new console only accepts the code in 
; hexadecimal (base-16) and must know how many hex digits the code 
; contains to allocate memory for each message packet.  
; Write an x86 Assembly program that: 
 
; a. Read a positive decimal integer N (0 ≤ N ≤ 65535). 
; b. Convert N to hexadecimal (using digits 0–9 and A–F). 
; c. Print the hexadecimal value (no 0x prefix). 
; d. Count and print the number of hex digits used to represent N. 
 
; Input: 
; A single decimal integer N (0 ≤ N ≤ 65535).  
; Output: 
; a. The hexadecimal representation of N (uppercase A–F). 
; b. The number of hexadecimal digits.  
 
; Test Case: 
; Input: 255 
; Output: FF 
;                2 
; Explanation: 255 decimal, FF hex, which has 2 hex digits. 

.model small
.stack 100h

.data
inputMsg db "Input: $"
hexMsg   db 13,10,"Hex number: $"
cntMsg   db 13,10,"Total digits: $"
digitCnt dw 0

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ---- Print input message ----
    lea dx, inputMsg
    mov ah, 9
    int 21h

    mov si, 0          ; SI will store decimal number
    mov bx, 10         ; For multiplication

; ===== Take decimal input =====
take_input:
    mov ah, 1
    int 21h
    cmp al, 13         ; Enter key?
    je convert_hex

    sub al, 30h        ; ASCII → number
    mov cl, al         ; Store digit
    mov ax, si
    mul bx             ; AX = SI * 10
    mov si, ax
    add si, cx         ; Add new digit
    jmp take_input

; ===== Convert decimal to hex =====
convert_hex:
    mov ax, si
    mov bx, 16
    xor cx, cx         ; CX = hex digit count

divide_hex:
    xor dx, dx
    div bx
    push dx            ; remainder (0-15)
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
    add dl, 7          ; A–F adjustment (10->'A')
    
digit:
    add dl, 30h        ; Convert to ASCII
    mov ah, 2
    int 21h
    loop print_hex

    ; ---- Print count message ----
    lea dx, cntMsg
    mov ah, 9
    int 21h

    ; Convert digit count to ASCII and print
    mov ax, digitCnt
    cmp ax, 10
    jb single_digit
    
    ; Two-digit count (for 16-bit numbers, max 4 digits)
    mov bl, 10
    div bl            ; AH=remainder, AL=quotient
    add al, '0'
    mov dl, al
    mov ah, 2
    int 21h
    mov dl, ah
    add dl, '0'
    mov ah, 2
    int 21h
    jmp exit
    
single_digit:
    add al, '0'
    mov dl, al
    mov ah, 2
    int 21h

; ===== Exit =====
exit:
    mov ah, 4Ch
    int 21h

main endp
end main
