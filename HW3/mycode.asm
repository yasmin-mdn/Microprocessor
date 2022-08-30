org 100h

.data          
array db   17h,17h,15h,12h,17h,17h,10h,14h,10h,16h,15h,15h,18h,18h,13h,16h,12h,17h,11h,10h
convertedArray db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
withExtraPointArray db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
sumValueBefor dw 0 
sumValueAfter dw 0 
max db 0  
median db 0
final_max db 0   
diff db 0  
avgBefor dw 0
avgAfter dw 0

;//////////////////////////////////////////////////////////
.code 
Sort: 
MOV BX, 20                   ; set BX=20
LEA SI, array                ; set SI=offset address of the ARRAY
PUSH AX                        ; push AX onto the STACK  
PUSH BX                        ; push BX onto the STACK
PUSH CX                        ; push CX onto the STACK
PUSH DX                        ; push DX onto the STACK
PUSH DI                        ; push DI onto the STACK
MOV AX, SI                     ; set AX=SI
MOV CX, BX                     ; set CX=BX
DEC CX                         ; set CX=CX-1

   OUTER_LOOP:                   ; loop label
     MOV BX, CX                   ; set BX=CX

     MOV SI, AX                   ; set SI=AX
     MOV DI, AX                   ; set DI=AX
     INC DI                       ; set DI=DI+1

     INNER_LOOP:                 ; loop label 
       MOV DL, [SI]               ; set DL=[SI]

       CMP DL, [DI]               ; compare DL with [DI]
       JNG SKIP_EXCHANGE         ; jump to label @SKIP_EXCHANGE if DL<[DI]

       XCHG DL, [DI]              ; set DL=[DI], [DI]=DL
       MOV [SI], DL               ; set [SI]=DL

       SKIP_EXCHANGE:            ; jump label
       INC SI                     ; set SI=SI+1
       INC DI                     ; set DI=DI+1

       DEC BX                     ; set BX=BX-1
     JNZ INNER_LOOP              ; jump to label @INNER_LOOP if BX!=0
   LOOP OUTER_LOOP               ; jump to label @OUTER_LOOP while CX!=0

POP DI                         ; pop a value from STACK into DI
POP DX                         ; pop a value from STACK into DX
POP CX                         ; pop a value from STACK into CX
POP BX                         ; pop a value from STACK into BX
POP AX                         ; pop a value from STACK into AX
    
   


;//////////////////////////find max            
mov si,0    
mov bl,array[si] ;assuming the first element as max
add si,1
find_max:
    mov al,array[si]
    add si,1
    cmp bl,al
    jb change_max
    return1:
    cmp si,20
    jnz find_max
    jz end1
    
    
change_max:
    mov bl,al
    mov max,bl
    jmp return1
    

end1:   
mov final_max,bl 
mov AL ,20h ;20
sub AL, final_max 
DAS 
mov diff,AL 


;////////////////Convert bcd to hex
mov si,00
mov ax,00 
mov cx,00
mov bx,00
convert:
         Mov AL,array[si]
         Mov BL,array[si]   
         AND BL,0Fh
         AND AL,0F0h
         mov CL,04
         ROR AL,CL
         mov DL,0Ah
         mul DL
         ADD AL,BL
         mov convertedArray[si],AL
         inc si
         cmp si,20
         JNZ convert
         

;///////////////////  sum befor change

mov si,00
mov ax,00
mov bx,20
;sum of the array 
sum:
    add al,convertedArray[si]
    inc si
    cmp si,20
    jnz sum
mov sumValueBefor,ax
div bx
mov avgBefor,ax 
                   
;//////////////////////median
mov cl,convertedArray[10]
mov  median,cl                
                   
;////////////////add extra point 
mov si,00
mov ax,00 
mov cx,00
mov bx,00
Point: 
    
 MOV al,convertedArray[si] 
 cmp al,median
 JG ExtraADD
 
 
  ExtraADD: 
        ADD al,diff
        
        
 MOV withExtraPointArray[si],al 
 inc si
 cmp si,20
 jnz Point



;///////////////////  sum after change
mov si,00
mov ax,00
mov bx,20
;sum of the array 
sumAfter:
    add al,withExtraPointArray[si]
    inc si
    cmp si,20
    jnz sumAfter
mov sumValueAfter,ax
div bx
mov avgAfter,ax 
 
 







