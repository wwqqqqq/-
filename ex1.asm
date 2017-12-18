
org 100h
jmp start

table   db 36 dup(0)
temp    dw 0  
temp1   db 0

start:  lea bx, table
        mov cl, 1    
        ; while cl<=36
        ;   [bx] = cl
        ;   bx++  
        ;   cx++
write:  cmp cl, 36
        jg print
        mov [bx], cl
        add bx, 1
        inc cl
        jmp write  
        ; print the required table
print:  lea bx, table
        mov cx, 0   
        ;cx -- line number (0 to 5)
        ;bx -- address of the data to be printed
loop1:  cmp cx, 6
        je exit
        mov ax, 0 
        ;ax -- column number (0 to cx)
        ;bx -- offset table + cx*6 + ax
loop2:  cmp ax, cx
        jg addoffset
        mov temp, ax
        mov al, [bx]
        mov ah, 0
        mov dl, 10
        idiv dl         ; get the quotient and reminder of ah/10
                        ; ah stores the ones digit of [bx]
                        ; al stores the tens digit of [bx]
        mov temp1, ah
        mov dl, al      ; print the tens digit of [bx]
        mov ah, 2
        cmp dl, 0       
        je next         
        add dl, '0'
        int 21h
next:   mov dl, temp1   ; print the ones digit of [bx]
        add dl, '0'
        int 21h 
        mov dl, '#'
        int 21h
        mov ax, temp
        inc bx           ; bx++
        inc ax           ; ax++
        jmp loop2
addoffset:        
        ; print('\n')
        mov dl, 10
        mov temp, ax
        mov ah, 2
        int 21h   
        mov dl, 13
        int 21h
        mov ax, temp  
        ; add offset to access next line of the table
        ; bx = bx+5-cx
        add bx, 5
        sub bx, cx 
        inc cx            ; cx++
        jmp loop1         
exit:          
ret




