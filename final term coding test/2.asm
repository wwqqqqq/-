
org 100h  
jmp start
filename db "Sample.txt",0
filebuffer db 1024 dup(0)
string db 1024 dup(0)   
temp dw 0
temp1 dw 0
temp2 dw 0   
temp3 dw 0 
out_string db 1024 dup(0)

start:  ;open the given file 
        ;and store the numbers in the memory labeled as buffer       
        mov dx, offset filename
        mov ah, 3dh      
        mov al, 0
        int 21h ;打开文件，文件代号在AX里 
        mov bx, ax
        mov dx, offset filebuffer   
        mov cx, 1024 
        mov ah, 3fh 
        int 21h ;读文件，10000个字节
        ; close file 
        mov ah, 3eh
        int 21h ;close file
        
        ; now the text of file is stored in filebuffer  
        
        ; 2.1 output the content of sample.txt
        lea si, filebuffer
loop1:  mov dl, [si]
        cmp dl, 0
        je exit_loop1
        cmp dl, -1
        je exit_loop1
        mov ah, 02h
        int 21h   
        
        inc si
        jmp loop1     
exit_loop1:                  
        ;2.2
        mov si, offset filebuffer  
        mov bx, offset string
        
  
loop2:  mov ch, [si]
        inc si
        cmp ch, '0'
        jl not_a_num
        cmp ch, '9'
        jg next1
        mov [bx],ch
        inc bx
        jmp loop2
next1:  cmp ch, 'A'
        jl not_a_num
        cmp ch, 'Z'
        jg next2
        mov [bx], ch
        inc bx
        jmp loop2
next2:  cmp ch, 'a'
        jl not_a_num
        cmp ch, 'z'
        jg not_a_num
        mov [bx], ch
        inc bx
        jmp loop2

not_a_num: 
        cmp ch, '-'
        jne next3
        dec bx
        jmp loop2
next3:  cmp ch, 13
        je process_data
        jmp loop2                  
                  
process_data:
        ;string complete
        ; process string   
        mov [bx], 0 ; mark the end of string
        ;mov bx, offset string 
        mov di, offset string  
        
        mov cx, 0
        mov dx, 0
        mov ax, 0       
        cmp di, bx
        jge exit_loop3
        ; use dx:ax to store the result
loop3:  cmp cx, 6
        jge exit_loop3
        mov bl, [di]
        cmp bl, 0
        je exit_loop3
        inc di
        inc cx
        mov temp, dx  
        mov temp1, ax
        mov dl, bl
        mov ah, 02h
        int 21h   
        ;dx:ax *= 36
        mov ax, temp1
        mov dx, 0
        mov temp3, 36
        mul temp3
        mov temp1, dx
        mov temp2, ax
        mov ax, temp
        mul temp3
        mov dx, ax
        add dx, temp1
        mov ax, temp2
        
        cmp bl,'0'
        jl next4
        cmp bl, '9'
        jg next4 
        sub bl, '0'  
        mov bh, 0
        add ax, bx
        adc dx, 0
        jmp loop3
        
next4:  cmp bl, 'a'
        jl next5
        cmp bl, 'z'
        jg next5
        sub bl, 'a'
        add bl, 10  
        mov bh, 0
        add ax, bx
        adc dx, 0
        jmp loop3        

next5:  cmp bl, 'A'
        jl loop3
        cmp bl, 'Z'
        jg loop3
        sub bl, 'A'
        add bl, 10  
        mov bh, 0
        add ax, bx
        adc dx, 0
        jmp loop3 
        
exit_loop3:  
        mov temp, ax
        mov temp1, dx
        cmp cx, 0
        jle exit_loop2
        mov dl, ' '
        mov ah, 02h
        int 21h  
        mov dl, '='
        mov ah, 02h
        int 21h
        mov dl, ' '
        mov ah, 02h
        int 21h   
        
        mov ax, temp
        mov dx, temp1
        
        ;output (dx:ax) 
        mov di, offset out_string  
loop4:  cmp ax, 0
        jne next6
        cmp dx, 0
        jne next6
        jmp exit_loop4 
next6:  mov cx, 0003h
        and cx, ax
        add cx, '0'
        mov [di], cx
        inc di
        shr ax, 2
        mov cx, 0003h
        and cx, dx
        shr dx, 2
        sal cx, 14
        add ax, cx       
        jmp loop4
exit_loop4:
loop5:  dec di
        mov dl, [di]
        mov ah, 02h
        int 21h
        cmp di, offset out_string
        je exit_loop5
        jmp loop5        
     
          
exit_loop5:          
          
        mov dl, 10
        mov ah, 02h
        int 21h   
        mov dl, 13
        mov ah, 02h
        int 21h 
        
        mov bx, offset string
        jmp loop2 
        
        
exit_loop2:

ret




