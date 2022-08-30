.stack
db 64 dup (0)
.data
dseg segment 'data'
a dw '1'
b dw '2'
c dw '3'
n dw 10
t db " WAS SENT TO ",'$'
;------------ code ------------------------------
.code

macro SOLVE 
    mov ah,13h
mov al,0
mov cx,0000h
int 10h
mov ch,0
call h
mov ah,8
int 21h
   endm
;////////////////////// MAIN 
main proc far
mov ax,dseg
mov ds,ax
SOLVE
mov ax,4c00h
int 21h
main endp
;////////////////////////////////  




;--------- print ---------------------------------
print proc
inc ch
mov ah,2
mov dl,1
mov dh,ch
mov bh,0
int 10h
mov ah,2
mov dx,a
int 21h
mov ah,9
mov dx,offset t
int 21h
mov ah,2
mov dx,c
int 21h
ret
print endp



;////////////////////////////////////////
h proc near
cmp n,1
jne else1
call print
jmp exit
else1:
;------------------
push n
push a
push b
push c

;/////////////////////////////////////// firstcall
push b
push c
pop b
pop c
dec n
call h
;/////////////////////printstuff
pop c
pop b
pop a
pop n
call print

;/////////////////////////////////////// secondcall
push a
push b
pop a
pop b
dec n
call h

exit:
ret
h endp

end main