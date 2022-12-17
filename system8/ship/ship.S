.data
.balign 8
zero: .double 0
cond1: .double 4
.text

.global ship

/*
  int ship(double xn0, double yn0)

  d0: xn0
  d1: yn0
*/

ship:
    stp x29, x30, [sp, #-16]!

    x .req d2
    y .req d3
    iteration .req w4

    ldr x2,=zero
    ldr d2,[x2]
    fmov y,x              // initialize x and y to 0
  
    mov iteration, #0            // initalize iteration to 0

while:
    fmul d5, x, x         // d5 = x*x          
    fmul d6, y, y         // d6 = y*y
    
    ldr x7,=cond1
    ldr d7,[x7]           // d7 = 4
    fadd d8, d5, d6       // d8 = x*x + y*y
    fcmp d8, d7           // (x*x + y*y) < 4?
    bge ship_done
    
    cmp iteration, #255
    bge ship_done
    
    fabs x, x
    fabs y, y

    fmul y, x, y          // y = x*y
    fadd y, y, y          // y = 2xy
    fadd y, y, d1         // y = 2xy + yn0
    
    fsub d5, d5, d6       // d5 = x*x - y*y
    fadd x, d5, d0        // x = x*x - y*y + xn0   

    add iteration, iteration, #1
    b while

 
ship_done:
    mov w0, iteration

    ldp x29, x30, [sp], #16
    ret
    .unreq x 
    .unreq y
    .unreq iteration
