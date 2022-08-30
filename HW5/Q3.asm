
;first num 48-bit  ffff,ffff,ffff
W1 dw  1111h  
W2 dw  1111h 
W3 dw  1111h 

;second num  48-bit   ffff,ffff,ffff
X1 dw    1111h
X2 dw    1111h
X3 dw    1111h

;result    96-bit
R1 dw  0
R2 dw  0
R3 dw  0
R4 dw  0
;///////////
T1 dw  0
T2 dw  0
T3 dw  0
T4 dw  0
;////////// 
S_1 dw 0 
S0 dw  0
S1 dw  0
S2 dw  0
S3 dw  0
S4 dw  0 









;w3w2w1 * x1
MOV AX,W1
MUL X1
MOV R1,AX
MOV R2,DX  
MOV AX,W2
MUL X1
ADD R2,AX
ADC DX,0
MOV R3,DX
MOV AX,W3
MUL X1 
ADD R3,AX
ADC DX,0
MOV R4,DX


;w3w2w1 * x2
MOV AX,W1
MUL X2
MOV T1,AX
MOV T2,DX  
MOV AX,W2
MUL X2
ADD T2,AX
ADC DX,0
MOV T3,DX
MOV AX,W3
MUL X2 
ADD T3,AX
ADC DX,0
MOV T4,DX

;w3w2w1 * x3
MOV AX,W1
MUL X3
MOV S1,AX
MOV S2,DX  
MOV AX,W2
MUL X3
ADD S2,AX
ADC DX,0
MOV S3,DX
MOV AX,W3
MUL X3 
ADD S3,AX
ADC DX,0
MOV S4,DX


;Sum up 
MOV AX,R1
ADC S_1,AX 

MOV AX,R2
ADC AX,S0
ADC AX,T1
MOV S0,AX


MOV AX,R3
ADC AX,S1
ADC AX,T2 
MOV S1,AX 


MOV AX,R4
ADC AX,S2
ADC AX,T3
MOV S2,AX 


MOV AX,T4
ADC AX,S3 
MOV S3,AX

MOV AX,0
ADC S4,AX




