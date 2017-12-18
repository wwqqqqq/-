; calculate N!
org 100h
jmp start 
data1   dw 1 ; lowest 16 bits 
data2   dw 0 
data3   dw 0
data4   dw 0 ; highest 16 bits

temp    dw 0   
N       dw 0 ;0<N<20
str     db 20 dup(0)

;input N from keyboard
start:  mov dx, 0
loop1:  mov ah, 01h
        int 21h     ; al stores the input character
        cmp al, '9'
        jg exit_loop1
        cmp al, '0'
        jl exit_loop1
        mov ah, 0 
        mov temp, ax
        mov ax, dx
        mov dx, 10
        mul dx
        mov dx, ax  ; dx = dx*10
        add dx, temp
        sub dx, '0' ; dl = dl+al-'0'  
        jmp loop1
exit_loop1:
        mov N, dx
        mov cx, dx
        cmp cx, 0
        je print
;calculate N!
loop2:  mov ax, data1
        mul cx      ; result_low = result_low * N   
        ; result = CX*AX, 乘积存放在DX:AX
        mov data1, ax 
        mov ax, data2
        mov temp, dx        
        mul cx      ; result_high = reuslt_high * N 
        add ax, temp ; result_high = result_high + carry
        mov data2, ax
        mov ax, data3 
        mov temp, dx       
        mul cx 
        add ax, temp 
        mov data3, ax
        mov ax, data4 
        mov temp, dx      
        mul cx  
        add ax, temp
        mov data4, ax
        dec cx      ; N--
        jle print   ; if N<=0 break
        jmp loop2
;print        
print:  lea bx, str
loop3:  ;divide data by 10 
        mov dx, 0
        mov ax, data4
        mov cx, 10
        div cx      ; DX:AX除以10， 商在AX，余数在DX
        mov data4, ax
        mov ax, data3
        div cx
        mov data3, ax
        mov ax, data2
        div cx
        mov data2, ax
        mov ax, data1
        div cx
        mov data1, ax
        add dl, '0'
        mov [bx], dl
        inc bx
        cmp ax, 0
        jne loop3
        mov ax, data2 
        cmp ax, 0
        jne loop3
        mov ax, data3
        cmp ax, 0
        jne loop3
        mov ax, data4
        cmp ax, 0
        jne loop3    
        
                        
        lea cx, str
loop4:  dec bx
        cmp bx, cx
        jl exit_loop4
        mov dl, [bx]
        mov ah, 2
        int 21h
        jmp loop4
        
exit_loop4:           ; putchar('\n')
        mov dl, 10
        mov ah, 2
        int 21h
        mov dl, 13
        mov ah, 2
        int 21h                
        
                         
        
        

ret




