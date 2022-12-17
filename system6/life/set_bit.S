.text
.global set_bit
set_bit:
    // x0: pointer to an array of integers
    // w1: width of array in bits
    // w2: desired bit to change
    // w3: value to set to
    
    cmp w2, #0
    blt done
    cmp w2, w1
    bge done 
    
    lsr w4, w2, #5     // Determine the word -> w4
    and w5, w2, #0x1f  // Bit index        -> w5
    
    lsl w4, w4, #2       // i * 4 -> w7
    ldr w6, [x0, w4, uxtw] // contains desired word
    
    mov w7, #31
    sub w5, w7, w5       // 31 - bit
    
    mov w7, #1
    lsl w7, w7, w5
    
    cmp w3, #0
    beq setzero
    
    orr w6, w6, w7
    
    str w6, [x0, w4, uxtw]
    b done
    
setzero:
    bic w6, w6, w7
    str w6, [x0, w4, uxtw]  
    
    b done
done:
    ret
     
