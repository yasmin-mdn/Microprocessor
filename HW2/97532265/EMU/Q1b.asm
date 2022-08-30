;FULL SEGMENT DEFINITION
STSEG SEGMENT
        DB 64 DUP (?)
STSEG ENDS
;////////////////////////////           
DTSEG SEGMENT 
     
     DATA1 DB 3h
     DATA2 DB 2h
     Multiply DB ?
     
     
     
    
DTSEG ENDS
;////////////////////////////
CDSEG SEGMENT   
    MAIN PROC FAR  
    ASSUME CS:CDSEG,DS:DTSEG,SS:STSEG 
    MOV AX,DTSEG 
    MOV DS,AX
    
    MOV	AL,DATA1          
    MOV BL,DATA2 
    MOV CL,0
    LoopTag:  
        ADD CL,BL
        DEC	AL
    JNZ	LoopTag 
    MOV Multiply,CL  
        
    MAIN ENDP  
CDSEG ENDS
END MAIN

