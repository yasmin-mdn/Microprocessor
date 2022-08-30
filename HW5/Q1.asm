org 100h  
;////////////////////////macros
print macro x, y, attrib, sdat
LOCAL   s_dcl, skip_dcl, s_dcl_end
    pusha
    mov dx, cs
    mov es, dx
    mov ah, 13h
    mov al, 1
    mov bh, 0
    mov bl, attrib
    mov cx, offset s_dcl_end - offset s_dcl
    mov dl, x
    mov dh, y
    mov bp, offset s_dcl
    int 10h
    popa
    jmp skip_dcl
    s_dcl DB sdat
    s_dcl_end DB 0
    skip_dcl:    
endm

print_space macro num
    pusha
    mov ah, 9
    mov al, ' '
    mov bl, 0000_1111b
    mov cx, num
    int 10h
    popa
endm

;////////////////////////////Start
jmp start

oldX dw -1
oldY dw 0
Counter dw 0

start:  
mov ah, 00
mov al, 13h       ; set screen to 256 colors, 320x200 pixels. 
int 10h

; reset mouse and get its status:
mov ax, 0
int 33h
cmp ax, 0




check_mouse_button:
mov ax, 3
int 33h
shr cx, 1       ; x/2 - in this mode the value of CX is doubled.
cmp bx, 1
jne check_mouse_button  
cmp  Counter,0
je RED 
cmp  Counter,1
je BLUE
cmp  Counter,2
je GREEN
RED:
mov al, 0100b 
mov Counter,1
jmp draw_pixel
BLUE:
mov al, 1001b  ; pixel color 
mov Counter,2
jmp draw_pixel
GREEN:
mov al, 1010b 
mov Counter,0
jmp draw_pixel


push cx
push dx
mov cx, oldX
mov dx, oldY
mov ah, 0dh     ; get pixel.
int 10h
xor al, 1111b   ; pixel color
mov ah, 0ch     ; set pixel
int 10h
pop dx
pop cx
draw_pixel:
mov ah, 0ch     ; set pixel
int 10h  

print_xy:
print 0,0,0000_1111b,"x="
mov ax, cx
call print_ax
print_space 4
print 0,1,0000_1111b,"y="
mov ax, dx
call print_ax
print_space 4
mov oldX, cx
mov oldY, dx 

check_esc_key:
mov dl, 255
mov ah, 6
int 21h
cmp al, 27      ; esc?
jne check_mouse_button  




stop: 
mov ax, 3 
int 10h
mov ah, 1
mov ch, 0
mov cl, 8
int 10h
mov dx, offset msg
mov ah, 9
int 21h
mov ah, 0
int 16h
ret   

print_ax proc
cmp ax, 0
jne print_ax_r
    push ax
    mov al, '0'
    mov ah, 0eh
    int 10h
    pop ax
    ret 
print_ax_r:
    pusha
    mov dx, 0
    cmp ax, 0
    je pn_done
    mov bx, 10
    div bx    
    call print_ax_r
    mov ax, dx
    add al, 30h
    mov ah, 0eh
    int 10h    
    jmp pn_done
pn_done:
    popa  
    ret  
endp

msg db " press any key....     $"

