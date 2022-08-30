;FULL SEGMENT DEFINITION
STSEG SEGMENT
        DB 64 DUP (?)
STSEG ENDS
;////////////////////////////           
DTSEG SEGMENT 
     
array: db 15h,20h,5h,19h,12h,4h,5h,0h,0h,0h  
sumValue db 0
min db 0
max db 0
avg db 0
     
     
     
    
DTSEG ENDS
;////////////////////////////
CDSEG SEGMENT   
    MAIN PROC FAR  
    ASSUME CS:CDSEG,DS:DTSEG,SS:STSEG 
    MOV AX,DTSEG 
    MOV DS,AX
            
            
   MOV si,0    
   MOV bl,array[si] ;assuming the first element as max
   ADD si,1
find_max:
    MOV al,array[si]
    ADD si,1
    CMP bl,al
    JB change_max
    return1:
        CMP si,10
        JNZ find_max
        JZ end1
    
    
change_max:
    MOV bl,al
    MOV max,bl
    JMP return1
    

end1:
;///////////////////////////////////////
;find minimum                   
MOV si,0    
MOV bl,array[si] ;assuming the first element as min
ADD si,1
find_min:
    MOV al,array[si]
    ADD si,1
    CMP bl,al
    JA change_min
    return2:
    CMP si,10
    JNZ find_min
    JZ end2
    
    
change_min:
    MOV bl,al 
    MOV min,bl
    JMP return2
    
end2:
;//////////////////////////////////
;average
MOV si,00
MOV ax,00
MOV bx,10

;sum of the array 
sum:
    ADD al,array[si]
    INC si
    CMP si,10
    JNZ sum
MOV sumValue,al  
;average = sum/(length) ---> (dx,ax)/bx   
DIV bx
MOV avg,al 

MOV al,min
MOV bl,max
MOV cl, sumValue
MOV dl,avg
 
        
    MAIN ENDP  
CDSEG ENDS
END MAIN



