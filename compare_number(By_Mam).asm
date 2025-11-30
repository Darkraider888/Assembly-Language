.model small
.stack 100h
.data

number db "input three number:$"
result db 13,10,"largest number:$"

.code

main proc

mov ax, @data
mov ds, ax

lea dx, number
mov ah, 9
int 21h

mov ah, 1
int 21h
mov bl, al      ; 1st

int 21h
mov bh, al      ; 2nd

int 21h
mov cl, al      ; 3rd

; ---------- compare bl vs bh ----------
cmp bl, bh
jge large1      ; jump if greater or equal. if bl >= bh check bl with cl

; ---------- bh is bigger than bl ? compare bh with cl ---------- 

large2:
    cmp bh, cl
    jge large3 ; bh is largest

    ; otherwise cl is largest
    lea dx, result
    mov ah, 9
    int 21h

    mov dl, cl
    mov ah, 2
    int 21h
    jmp exit

; ---------- bl >= bh, now compare bl with cl ----------
large1:
    cmp bl, cl
    jge print_bl        ; bl is largest

    ; otherwise cl is largest
    lea dx, result
    mov ah, 9
    int 21h

    mov dl, cl
    mov ah, 2
    int 21h
    jmp exit

; ---------- print bh ----------
large3:
    lea dx, result
    mov ah, 9
    int 21h

    mov dl, bh
    mov ah, 2
    int 21h
    jmp exit

; ---------- print bl ----------  

print_bl:
    lea dx, result
    mov ah, 9
    int 21h

    mov dl, bl
    mov ah, 2
    int 21h

exit:
    mov ah, 4ch
    int 21h

main endp
end main
