.model small
.stack 100h
.data 
   input db "Enter Decimal NUmber: $"
   output db 13,10, "Binary : $"
   buffer db 6 dup(?)  ; buffer hisebe SI k neya hoy
.code
main proc 
       mov ax, @data
       mov ds, ax 
       
       
       mov ah, 9
       lea dx, input
       int 21h
       
       mov si, 0 ; input store korar jonno
       read_digit:
            mov ah,1
            int 21h
            cmp al, 13 ; 1tar pore jodi enter click kore tahole r nibena
            je convert_binary
            
            sub al , '0'
            mov bl , al
            mov ax , si ; 10 diye goon korar jonno
            
            cmp ax, 0
            jne add_digit    ; jodi 2nd hoy add korbo
            
            ;else
            mov ax , bx ; noile etai first  digit
            mov si , ax
            jmp read_digit
       
       
       
       add_digit:
            mov ax, si
            mov cx, 10
            mul cx    ; ax = multiplicand , cx = multiplier
            add ax, bx  ; porer digit jog kore
            mov si, ax  ; puro number store kora sesh
            jmp read_digit 
       
       convert_binary:
            mov ax, si
            mov bx, 2 ; binary te base er value 2
            mov cx , 0 ; vag kotokkhn cholbe
            
            divide_binary:
                xor dx , dx ; clear korar jonno
                div bx ; div = divisior, bx = dividend
                push dx
                inc cx
                cmp ax, 0 ; jotokkhn na dividend 0 na hoy
                jne divide_binary
       
        lea dx, output 
        mov ah, 9
        int 21h

       print_binary:
            pop dx
            add dl, '0'
            mov ah, 2
            int 21h
            loop print_binary

       exit:
          mov ah, 4ch
          int 21h


main endp
end main
