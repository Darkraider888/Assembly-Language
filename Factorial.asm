.model small
.stack 100h
.data
    n DW 7 ;result max 2^16 bit = 65536
    result DB "The Factorial Result is : $" 
    
    ; to store multi digit output we create buffer
    buffer db 6 dup(?) ; 6 byte buffer ..like array

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ;====load output message====
    lea dx, result
    mov ah, 9
    int 21h 
    
    ;factorial count global condition
    mov ax, n
    mov cx, n ; for counting
    dec cx
    
    factorial:
         dec n  ; n = 6 
         mul n  ; since ax = 7. ax = 6 * 7 . so ax = 42 now
         
         dec cx  ; cx = 6 now
         cmp cx , 0
         jne factorial
    
    ;======now to print result convert to ASCII======
    
    mov cx, 0
    lea si, buffer + 5 ; load buffer (0 to last index- buffer[5])
    
    ans: 
        xor dx, dx ;let dx = remainder. bcz we all show it to output.
                    ;clear dx or make it 0
        
        mov bx, 10 ; bx = divisor , dividend is ax = 7! = 5040
                    
        
        div bx ; ax will be auto quotient...ax = 5040/10 = 504
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
             
            loop print_result  ; stop when [si] address is null
        
         
    
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
