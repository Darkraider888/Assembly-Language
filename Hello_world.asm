.model small ;single cs + single ds, model size small
.stack 100h ; stack er size, memory te jayga nibe 256 bytes 

.data ; data segment k declare kora.      
        ; input, output,variable sob smy data segment er under a korte hoy,
        ; variable name + size + msg&
        ;db = 8 bit- defined bit
    
    variable db "Hellow World",13,10, "2nd line$" ; msg sesh hobe dollar sign diye
    ;newline db 13,10,"Hello 2nd line$" ; new line er jonno (13 = Carriage Return, 10 = Line Feed)  
    
.code   

main proc ;starting of procedure...int main er moto
    mov ax , @data ; load address of data segment
    mov ds, ax ; activate data segment
    
   ; msg print korar jonno
   lea dx, variable;lea diye load korte hoy,load effective address (msg store kora er kaj)  
   mov ah , 9 ; msg print kora eta diye
   int 21h ; 1ta kaj sesh hole interrupt korte hobe. (pause->end of task)  
   
   ;lea dx, newline
   ;mov ah , 9
   ;int 21h
    
   mov ah,4ch ; terminate the instructions
   int 21h  ;interrupt (dos interrupt). keyboard er interrupt "int 16h"   

main endp ; end of procedure
end main ; end of program