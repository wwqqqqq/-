org 100h      
jmp start    
string  db 1024 dup(0)
output  db "result = $" 
data    db 20 dup(0) 
result  dw 0
; add your code here
                       
start:    
main_loop1:     
        call func
        cmp dx, 0
        jne main_next1
        jmp main_loop1
main_next1:          
        mov dl, 10
        mov ah, 2
        int 21h
        mov dx, offset output 
        mov ah, 09h
        int 21h      
        mov ax, cx  
        mov result, cx
        mov dx, 0  
        mov bx, 0   
        mov cx, 10
        cmp ax, 0 
        jg main_loop2 
        jl main_minus_result  
        mov dl, '0'
        mov ah, 2
        int 21h   
        mov dl, 10
        mov ah, 2
        int 21h
        mov dl, 13
        mov ah, 2
        int 21h
        jmp main_loop1
main_minus_result:        
        mov ax, 0
        sub ax, result

main_loop2:  
        div cx      ;商在ax，余数在dx
        add dx, '0'
        mov data[bx], dl; 
        inc bx
        mov dx, 0
        cmp ax, 0
        jne  main_loop2
        ;print str 
        
        mov ax, result
        cmp ax, 0
        jge main_loop3
        mov dl, '-'
        mov ah, 2
        int 21h
        
main_loop3:  
        dec bx
        cmp bx, 0                                                                                    
        jl  main_next
        mov dl, data[bx] 
        mov ah, 2
        int 21h
        jmp main_loop3
main_next:
        mov ah, 2
        mov dl, 10
        int 21h
        mov ah, 2
        mov dl, 13
        int 21h    
        
        jmp main_loop1    
                    
ret
                 
                 
func    proc         ; 将结果放入cx，下一个字符（设置为' '）放入dx   
    
        push ax
        push bx            
        
        call getop                      
        
        
        
        mov bx, cx  ; bx = op1
func_loop1:

        mov ax, dx
        cmp al, ' '
        jne func_test
func_loop2:        
        mov ah, 01h
        int 21h ; 输入字符在al 
        ; al = getchar()
        ; while(al==' ');
        cmp al, ' '
        je func_loop2 
        ; if(al == '\n' || al == ')') break;
func_test:
        cmp al, 10
        je func_loop1_exit
        cmp al, 13
        je func_loop1_exit
        cmp al, ')'
        je func_loop1_exit 
        call getop  ; cx = op2  
        cmp dx, 0
        je func_exit ;若出现invalid expression错误，直接返回
        cmp al, '+'
        je func_add_operation
        ; if operation == '-'
        sub bx, cx 
        jmp func_loop1
func_add_operation:
        add bx, cx
        jmp func_loop1        
func_loop1_exit:
        mov dx, ' '
        mov cx, bx 
        cmp al, ')' 
        jne func_exit
        mov dx, ')'           
func_exit:        
        pop bx
        pop ax                  
        ret 
        endp

temp    dw 0 
error   db "Invalid expression$"

getop   proc          ; 将结果放入cx，下一个字符（设置为' '）放入dx       
        push ax
        push bx 
        
        
        
getop_loop1:
        ;al = getchar()
        mov ah, 01h
        int 21h 
        cmp al, ' '
        je getop_loop1
        cmp al, '+'  
        je getop_unaryop_plus
        cmp al, '-'
        je getop_unaryop_minus
        cmp al, '('
        je getop_callfunc
        cmp al, '0'
        jl getop_default
        cmp al, '9'
        jg getop_default
        ; if ch>='0' && ch<='9'
        mov bx, 0
getop_loop2:
        mov ah, 0
        mov temp, ax
        mov ax, bx
        mov bx, 10
        imul bx ; result in DX:AX
        add ax, temp
        sub ax, '0' ; op += ch-'0'
        mov bx, ax                
        mov ah, 1
        int 21h
        cmp al, '9'
        jg getop_loop2_exit
        cmp al, '0'
        jl getop_loop2_exit
        jmp getop_loop2
getop_loop2_exit:
        mov ah, 0
        mov dx, ax
        mov cx, bx
        jmp getop_next        
getop_unaryop_plus:
        call getop
        jmp getop_next 
getop_unaryop_minus:
        call getop
        mov ax, 0
        sub ax, cx
        mov cx, ax
        jmp getop_next
getop_callfunc:
        call func  
        cmp dx, ')'
        jne getop_default
        mov dx, ' '
        jmp getop_next
getop_default: 
getop_loop3:
        mov ah, 1
        int 21h
        cmp al, 10
        je getop_error_message
        cmp al, 13
        je getop_error_message  
        jmp getop_loop3
        
getop_error_message:  
        mov dl, 10
        mov ah, 2
        int 21h      
        mov dx, offset error
        mov ah, 09h
        int 21h   
        mov dl, 10
        mov ah, 2
        int 21h
        mov dl, 13
        mov ah, 2
        int 21h
        mov cx, 0
        mov dx, 0
        
getop_next:    
        pop bx
        pop ax
        ret
        endp                               
                               