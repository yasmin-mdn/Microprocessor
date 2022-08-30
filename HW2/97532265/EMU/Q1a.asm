org 100h
.model small
.stack 64
.code 
; without change in data   
;result stores in cl
MOV	AL,3          
MOV BL,2 
MOV CL,AL
Mov DL,1
LoopTag:  
ADD CL,AL 
INC DL
CMP DL,BL
JNZ LoopTag 
      
          
;//////////////////Data changes
 ;MOV	AL,3          
 ;MOV BL,2 
 ;MOV CL,0
 ;LoopTag:  
 ;ADD CL,BL
 ;DEC	AL
 ;JNZ	LoopTag 

