.386
.model flat,stdcall
option casemap:none
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
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
MAIN :  
    MOV	AL,DATA1          
    MOV BL,DATA2 
    MOV CL,0
    LoopTag:  
        ADD CL,BL
        DEC	AL
    JNZ	LoopTag 
    MOV Multiply,CL  
END MAIN
CDSEG ENDS
END