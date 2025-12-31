.model small
.stack 100h

.data

    str1 dB "Welcome to$"
    str2 dB  "Assembly$"
    str3 dB "Language Programming$"
    
.code


main proc
    mov ax, @data
    mov ds , ax
    
    lea dx, str1
    mov ah, 9
    int 21h 
    call enter
    
    lea dx, str2
    mov ah, 9
    int 21h  
    call enter
   
    lea dx, str3
    mov ah, 9
    int 21h  
    
    exit:
        mov ah, 4ch
        int 21h
   
main endp  

enter proc
    mov ah, 2
    mov dl,13
    int 21h
    mov dl, 10
    int 21h 
    
    ret

enter endp 

end main
