
org 100h
jmp start    
filename db "ex2.txt",0     
;filehandle db 2 dup(0)     
filebuffer db 10000 dup(0);文件缓冲区（ASCII码存储）
databuffer dw 1024 dup(0);数据缓冲区
length  dw 0        ;length of buffer
str db 10 dup(0)     ;store itoa(buffer[bx])
temp dw 0 
temp1 db 0
temp2 dw 0


start:  ;open the given file 
        ;and store the numbers in the memory labeled as buffer 
        mov dx, offset databuffer       
        mov dx, offset filename
        mov ah, 3dh      
        mov al, 0
        int 21h ;打开文件，文件代号在AX里 
        mov bx, ax
        mov dx, offset filebuffer   
        mov cx, 10000 
        mov ah, 3fh 
        int 21h ;读文件，10000个字节
        ; close file 
        mov ah, 3eh
        int 21h ;close file
        
        ;process data
        lea bx, filebuffer
        mov cx, 0       ;cx -- number of read data
loop6:  mov dx, 0
        mov dl, [bx]
        cmp dl, 0
        je exit_loop6   ;end of file
        cmp dl, -1
        je exit_loop6   ;end of file
        cmp dl, '0'
        jl not_a_number
        cmp dl, '9'
        jg not_a_number
        mov ax, 0       ; ax存放当前读取的数字
loop7:  mov temp, dx
        mov dx, 10
        mul dx     ; result = result*10
        mov dx, temp
        add ax, dx
        sub ax, '0'     ; result = result+[bx]-'0'
        inc bx          ; move to next char
        mov dl, [bx]
        cmp dl, '0'
        jl exit_loop7   ; 当前数字结束
        cmp dl,'9'
        jg exit_loop7   ; 当前数字结束
        jmp loop7
exit_loop7:
        mov temp, bx
        ;mov bx, offset databuffer
        mov bx, offset databuffer
        add bx, cx
        add bx, cx
        mov [bx], ax
        mov bx, temp
        inc cx
        jmp loop6               
                
not_a_number:
        inc bx
        jmp loop6        
exit_loop6:
        mov length, cx        
        
        
;for(ax=0;ax<length;ax++)
;for(bx=length-1;bx>ax;bx--)
;if(buffer[bx]<buffer[bx-1]) exchange(buffer[bx],buffer[bx-1]); 
sort:   lea ax, databuffer  
        mov bx, length
        lea cx, databuffer
        add cx, bx
        add cx, bx
loop1:  cmp ax, cx
        jge print 
        lea bx, databuffer
        add bx, length
        add bx, length
        sub bx, 2
loop2:  cmp bx, ax
        jle exit_loop2
        mov cx, [bx]  ;cx = buffer[bx]
        mov dx, [bx-2]
        mov temp, cx
        sbb cx, dx
        jnc if_false 
        mov cx, temp
        mov [bx-2], cx
        mov [bx], dx
if_false:
        sub bx, 2   ;bx--
        jmp loop2
exit_loop2:
        mov bx, length
        lea cx, databuffer
        add cx, bx
        add cx, bx
        add ax, 2
        jmp loop1 
;bx=buffer;    
;for(cx=length;cx>0;cx--)
;printf(bx++)        
print:  lea bx, databuffer
        mov cx, length
loop3:  cmp cx, 0
        je  exit    
        mov dx, [bx]  
        mov temp, bx
        mov ax, dx 
        mov bx, 0 
        mov dx, 0
        mov temp2, cx
        mov cx, 10
        ;itoa(ax)    
loop4:  div cx      ;商在ax，余数在dx
        add dx, '0'
        mov str[bx], dl; 
        inc bx
        mov dx, 0
        cmp ax, 0
        jne  loop4 
        ;print str
loop5:  dec bx
        cmp bx, 0
        jl  next
        mov dl, str[bx] 
        mov ah, 2
        int 21h
        jmp loop5
        
        
next:   mov dl, 10
        mov ah, 2
        int 21h 
        mov dl, 13
        mov ah, 2
        int 21h  
        
        mov bx, temp 
        mov cx, temp2
        dec cx
        add bx, 2  
        jmp loop3
exit:                 

ret




