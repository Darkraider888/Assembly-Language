.model small
.stack 100h
.data
    n DW ? ; 
    result DB 13,10, "The Factorial Result is : $" 
    
    ; to store multi digit output we create buffer
    buffer db 6 dup(?) ; 6 byte buffer ..like array
    input DB "Enter a number : $"

.code
main proc
    mov ax, @data
    mov ds, ax
    
    
    lea dx, input
    mov ah, 9
    int 21h

    
    mov ah, 1
    int 21h 
    sub al, '0'
    mov ah , 0    
    mov n, ax       
    
    ;====load output message====
    lea dx, result
    mov ah, 9
    int 21h 
    
    ;factorial count global condition
    mov ax, n
    mov cx, n ; for counting
    dec cx
    
    factorial:
         dec n  ; n = n-1
         mul n  ; ax = ax * n
         
         dec cx  
         cmp cx , 0
         jne factorial
    
    ;======now to print result convert to ASCII======
    
    mov cx, 0
    lea si, buffer + 5 ; load buffer (0 to last index- buffer[5])
    
    ans: 
        xor dx, dx ;let dx = remainder. bcz we all show it to output.
                    ;clear dx or make it 0
        
        mov bx, 10 ; bx = divisor , dividend is ax = factorial result
        div bx ; ax will be auto quotient
        add dl ,'0'; convert to ascii
        
        dec si ; index one decreemnt from result array
        mov [si] , dl ; store result in buffer array in address. 
                        ;[] = memory address
        
        inc cx   ; count how many digits we stored for printing
       
        cmp ax , 0  ; untill become 0
        jne ans
        
        
        ;===print result
        
    mov ah, 2
    print_result:
        mov dl, [si]  ;buffer er si address
        int 21h
        inc si  ; result er si
        loop print_result  ; stop after CX digits
        
         
    exit:
    mov ah, 4ch
    int 21h

main endp
end main


;=========================Conversion Loop==================================

;        | Step | AX   | DX (rem) | DL (ASCII) | SI | Buffer[SI] | CX |
;        | ---- | ---- | -------- | ---------- | -- | ---------- | -- |
;        | 1    | 5040 | 0        | '0'        | 4  | '0'        | 1  |
;        | 2    | 504  | 4        | '4'        | 3  | '4'        | 2  |
;        | 3    | 50   | 0        | '0'        | 2  | '0'        | 3  |
;        | 4    | 5    | 5        | '5'        | 1  | '5'        | 4  |
;        | Done | 0    | -        | -          | 1  | -          | 4  |

;==========================================================================


;   CX is a counter: During conversion, inc cx for each digit stored? 
;   now CX = number of digits.

;   In the print loop, `loop print_result` automatically 
;   decrements CX each time
;   and stops when CX = 0.

;   So CX controls how many digits are printed
