.386
.model flat,stdcall
option casemap:none
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
message db "Task Done!" , 0
.code
Write :
invoke StdOut,addr message
invoke ExitProcess, 0
END Write
main:
MOV	AL,3H       
MOV BL,2H 
MOV CL,AL
Mov DL,1
LoopTag:  
ADD CL,AL 
INC DL
CMP DL,BL
JNZ LoopTag 
CALL Write
invoke ExitProcess, 0
end main

