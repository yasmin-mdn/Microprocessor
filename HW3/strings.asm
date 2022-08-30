.data 

    names db "ali$", "raha$", "sama$", "sama$", "sana$", "ali$", "arya$", "ali$", "ali$", "mohsen$", "saam$", "bahar$", "yasi$", "yasi$", "bahar$", "ali$", "mohsen$", "ali$", "yasi$", "ali$"
    size equ $-names
    counts db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
;

main:
    mov ax, @data
    mov ds, ax 
    
    mov bx, 0
    mov bp, 0
    
    for: 
        
        cmp bx, size
        jge the_end
        
        mov di, 0
        mov si, bx
        
        compare:
        
            cmp di, size
            jge next
            
            mov al, names[si] 
            cmp al, names[di]
            jne different
        
            cmp al, '$'
            je same
            
            inc si
            inc di
            jmp compare
        
            same:
        
                inc counts[bp]
                inc di
                
                mov si, bx
                jmp compare
            
            different:
            
                inc di
                cmp names[di-1], '$'
                jne different
                
                mov si, bx
                jmp compare
            
        next:
        
            inc bx
            cmp names[bx-1], '$'
            jne next
            inc bp
            jmp for
            
    the_end: 
                          
end main