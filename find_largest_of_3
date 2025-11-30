.model small
.stack 100h
.data

    number db "input three number:$"
    result db 13,10,"largest number:$"

    n1 db ?
    n2 db ?
    n3 db ?

.code

main proc

    mov ax, @data
    mov ds, ax

    lea dx, number
    mov ah, 9
    int 21h
    
    mov ah, 1
    int 21h
    mov n1, al     
    
    int 21h
    mov n2, al    
    
    int 21h
    mov n3, al     

    ; ---------- compare n1 vs n2 ----------
    mov al, n1
    cmp al, n2
    jge large1    ; jump greater or equal.  if n1 >= n2, go large1
    jmp large2    ; else go large2

    ; ---------- n1 >= n2, now compare n1 with n3 ----------
    large1:
        mov al, n1
        cmp al, n3
        jge print_n1   ; if n1 >= n3, n1 is largest
        jmp print_n3   ; else n3 is largest

    ; ---------- n2 > n1, compare n2 with n3 ----------
    large2:
        mov al, n2
        cmp al, n3
        jge print_n2   ; if n2 >= n3, n2 is largest
        jmp print_n3   ; else n3 is largest

    ; ---------- n1 is largest ----------
    print_n1:
        lea dx, result
        mov ah, 9
        int 21h
        mov dl, n1
        mov ah, 2
        int 21h
        jmp exit

    ; ---------- n2 is largest ----------
    print_n2:
        lea dx, result
        mov ah, 9
        int 21h
        mov dl, n2
        mov ah, 2
        int 21h
        jmp exit

    ; ---------- n3 is largest ----------
    print_n3:
        lea dx, result
        mov ah, 9
        int 21h
        mov dl, n3
        mov ah, 2
        int 21h

exit:
    mov ah, 4ch
    int 21h

main endp
end main
