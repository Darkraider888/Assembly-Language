.model small
.stack 100h

.data
prompt      db 'Book Title: $'

msgTitle    db 13,10,13,10,'Formatted Title: $'
msgVowel    db 13,10,'Vowels:',13,10,'$'
msgCons     db 13,10,'Consonants:',13,10,'$'
msgCount    db 13,10,'Total Vowels = $'

; ---------- Input Buffer (50 chars) ----------
inputStr    db 50
len         db ?
str         db 50 dup(0)

vowels      db 100 dup('$')
cons        db 100 dup('$')
vCount      db 0

.code
main proc
    mov ax, @data
    mov ds, ax

; ---- Prompt ----
    lea dx, prompt
    mov ah, 09h
    int 21h

; ---- Input ----
    lea dx, inputStr
    mov ah, 0Ah
    int 21h

; ---- Print formatted title ----
    lea dx, msgTitle
    mov ah, 09h
    int 21h

    lea si, str
    mov cl, len
    mov ch, 0           ; Clear high byte
    cmp cl, 0
    je end_process
    
    lea di, vowels
    lea bx, cons
    mov vCount, 0       ; reset vowel counter

process:
    mov al, [si]
    cmp al, 0Dh         ; Check for carriage return
    je end_process
    
    ; Store original for printing
    mov dl, al
    
    ; Check if it's a space - print as is
    cmp al, ' '
    je print_char
    
    ; Check if it's a digit - print as is
    cmp al, '0'
    jb not_digit1
    cmp al, '9'
    jbe print_char
    
not_digit1:
    ; Check if lowercase
    cmp al, 'a'
    jb check_upper
    cmp al, 'z'
    ja check_upper
    
    ; Convert lowercase to uppercase
    sub al, 32
    mov dl, al          ; Update DL with uppercase
    
check_upper:
    ; Check if already uppercase
    cmp al, 'A'
    jb not_letter
    cmp al, 'Z'
    ja not_letter
    
    ; Now AL contains uppercase letter for checking
    ; Check for vowel
    cmp al, 'A'
    je is_vowel
    cmp al, 'E'
    je is_vowel
    cmp al, 'I'
    je is_vowel
    cmp al, 'O'
    je is_vowel
    cmp al, 'U'
    je is_vowel
    
    ; It's a consonant
    mov [bx], al
    inc bx
    mov byte ptr [bx], ' '
    inc bx
    jmp print_char

is_vowel:
    ; Store vowel
    mov [di], al
    inc di
    mov byte ptr [di], ' '
    inc di
    inc vCount
    jmp print_char

not_letter:
    ; For non-letters, just print original character
    mov dl, [si]

print_char:
    ; Print the character
    mov ah, 02h
    int 21h
    
next_char:
    inc si
    loop process

end_process:
    ; ---- terminate strings ----
    mov byte ptr [di], '$'
    mov byte ptr [bx], '$'

; ---- print vowels ----
    lea dx, msgVowel
    mov ah, 09h
    int 21h
    lea dx, vowels
    int 21h

; ---- print consonants ----
    lea dx, msgCons
    mov ah, 09h
    int 21h
    lea dx, cons
    int 21h

; ---- print vowel count ----
    lea dx, msgCount
    mov ah, 09h
    int 21h

    ; Convert vCount to ASCII and print
    mov al, vCount
    xor ah, ah          ; Clear AH
    
    ; Check if count is 0
    cmp al, 0
    je print_zero
    
    ; Divide by 10 to get tens and units
    mov bl, 10
    div bl              ; AL = quotient (tens), AH = remainder (units)
    
    ; Print tens digit (if any)
    cmp al, 0
    je print_units_only
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h
    
    ; Print units digit
print_units_only:
    mov al, ah
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h
    jmp exit_program
    
print_zero:
    mov dl, '0'
    mov ah, 02h
    int 21h

exit_program:
    ; ---- exit ----
    mov ah, 4Ch
    int 21h
main endp
end main