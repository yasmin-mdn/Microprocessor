
.386
.model flat,stdcall
option casemap:none
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
message db "Task Done!" , 0
array db 15h,20h,5h,19h,12h,4h,5h,0h,0h,0h  
sumValue db 0
min db 0
max db 0
avg db 0
.code
Write :
invoke StdOut,addr message
invoke ExitProcess, 0
END Write
main:
mov si,0    
mov bl,array[si] ;assuming the first element as max
add si,1
find_max:
    mov al,array[si]
    add si,1
    cmp bl,al
    jb change_max
    return1:
    cmp si,10
    jnz find_max
    jz end1
    
    
change_max:
    mov bl,al
    mov max,bl
    jmp return1
    

end1:
;///////////////////////////////////////
;find minimum                   
mov si,0    
mov bl,array[si] ;assuming the first element as min
add si,1
find_min:
    mov al,array[si]
    add si,1
    cmp bl,al
    ja change_min
    return2:
    cmp si,10
    jnz find_min
    jz end2
    
    
change_min:
    mov bl,al 
    mov min,bl
    jmp return2
    
end2:
;//////////////////////////////////
;average
mov si,00
mov ax,00
mov bx,10

;sum of the array 
sum:
    add al,array[si]
    inc si
    cmp si,10
    jnz sum
mov sumValue,al  
;average = sum/(length) ---> (dx,ax)/bx   
div bx
mov avg,al                       


MOV al,min
MOV bl,max
MOV cl, sumValue
MOV dl,avg
CALL Write
end main