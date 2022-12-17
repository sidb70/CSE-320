


    .balign 8
    
max: .double 200     // Maximum allowed value
min: .double 0       // Minimum allowed value
  
.text

.global steam

//
// double steam(double *data, int size)
//
steam:
    stp x29, x30, [sp, #-16]!
    
    ldr d0,=0
    mov w2,#0           // cnt=0;
  
loop_start:
    cmp w1,#0           // Are we done?
    ble loop_end        // Yes
    
    ldr d1,[x0]         // d1 = data[i]

    ldr x3,=max
    ldr d3,[x3]         // d3 = max
    fcmp d1,d3          // Compare data[i] to max
    bgt skip
    
    ldr x3,=min 
    ldr d3,[x3]         // d3 = min    
    fcmp d1,d3          // Comapre data[i] to min
    blt skip
    
    fadd d0,d0,d1       // d0 += data[i]
    add w2,w2,#1        // cnt++
  
skip:
    // End of loop body
    add x0, x0, #8      // Next double value
    sub w1, w1, #1      // Decrease size
    b loop_start  

loop_end:
    ucvtf s4, w2        // s4 = cnt (as a float)
    fcvt  d2, s4        // Convert to double
    fdiv  d0, d0, d2    // Divide
    
steam_done:
    ldp x29, x30, [sp], #16
    ret             // return
