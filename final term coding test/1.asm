data segment
num db 0
char db 0
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:  mov ah, 01h
        int 21h
        ; al: input character
        sub al, '0'
        mov num, al ;num: lines
        mov ah, 01h
        int 21h
        mov char, al ; ah: character   
        ;get '\n'
        mov ah, 01h
        int 21h
        ;mov ah, 01h
        ;int 21h   
        
        ;1.1   
        
        mov dl, 10
        mov ah, 02h
        int 21h
        mov dl, 13
        mov ah, 02h
        int 21h  
        mov dl, 10
        mov ah, 02h
        int 21h
        mov dl, 13
        mov ah, 02h
        int 21h 
        
        mov cx, 0
loop1:  cmp cl, num
        jge exit_loop1
        
        mov bx, cx
loop2:  cmp bx, 0
        jl exit_loop2  
        mov dl, char
        mov ah, 02h
        int 21h
        ; output dl  
        
        dec bx
        jmp loop2
        
exit_loop2:
        mov dl, 10
        mov ah, 02h
        int 21h
        mov dl, 13
        mov ah, 02h
        int 21h
        
        inc cx
        jmp loop1

exit_loop1:    

        ;1.2
        
        mov dl, 10
        mov ah, 02h
        int 21h
        mov dl, 13
        mov ah, 02h
        int 21h  
        
        mov cx, 0
loop3:  cmp cl, num
        jge exit_loop3
        
        mov bl, num
        sub bl, cl  
        sub bl, 1
        ; bl = num - cl - 1
loop4:  cmp bl, 0
        jle exit_loop4
        
        mov dl, ' '
        mov ah, 02h
        int 21h
        ; output ' '
        
        dec bl
        jmp loop4
        
exit_loop4:
        mov bx, cx
        add bx, bx     
        ; bx = 2*c
loop5:  cmp bx, 0
        jl exit_loop5
        mov dl, char
        mov ah, 02h
        int 21h
        
        dec bx
        jmp loop5

exit_loop5:
        mov dl, 10
        mov ah, 02h
        int 21h
        mov dl, 13
        mov ah, 02h
        int 21h 
        
        inc cx
        jmp loop3 
               
exit_loop3:                        
        


mov ax, 4c00h
int 21h  

ends

end start
