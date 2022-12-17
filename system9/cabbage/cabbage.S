

    //
    // Definition of the cabbage data structure
    //
    .equ cabbage_name_size,100  // 100 bytes for the cabbage name
    
    .equ cabbage_name,0
    .equ cabbage_age,100
    
    // Must be careful to ensure these values are on 8 byte boundaries
    .equ cabbage_x1, 104
    .equ cabbage_y1, cabbage_x1+8
    .equ cabbage_x2, cabbage_y1+8
    .equ cabbage_y2, cabbage_x2+8
    .equ cabbage_x3, cabbage_y2+8
    .equ cabbage_y3, cabbage_x3+8
    .equ cabbage_size, cabbage_y3+8

    .equ cabbage_vertices, cabbage_x1
    
    .equ vertex_x, 0
    .equ vertex_y, 8
    .equ vertex_size, 16
    
    .balign 8

half:   .double 0.5

.text

.global make_cabbage
//
// Allocate a cabbage ADT
//
make_cabbage:
    stp x29, x30, [sp, #-16]!

    mov w0, #1              // 1 to allocate
    mov w1, #cabbage_size   // How large?
    bl calloc               // Allocate!
    
    ldp x29, x30, [sp], #16
    ret

.global shred_cabbage
//
// Deallocate cabbage ADT
//
shred_cabbage:
    stp x29, x30, [sp, #-16]!
    
    bl free     // Free it
    
    ldp x29, x30, [sp], #16
    ret
    
.global set_age
//
// void set_age(void *cabbage, int age);
//
set_age:
    stp x29, x30, [sp, #-16]!
    
    str w1,[x0,#cabbage_age]
    
    ldp x29, x30, [sp], #16
    ret

.global get_age
//
// int get_age(void *cabbage);
//
get_age:
    stp x29, x30, [sp, #-16]!
    
    ldr w0,[x0,#cabbage_age]
    
    ldp x29, x30, [sp], #16
    ret



.global set_name
//
// void set_name(void *cabbage, const char *name);
//
set_name:
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    
    mov x19, x0
    
    add x0, x0, #cabbage_name
    // x1 is already the name
    mov w2,#(cabbage_name_size-1)
    bl strncpy
    
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
    
.global get_name
//
// const char *get_name(void *cabbage);
//
get_name:
    stp x29, x30, [sp, #-16]!
    
    add x0, x0, #cabbage_name
    
    ldp x29, x30, [sp], #16
    ret


.global set_vertex
//
// void set_vertex(void *cabbage, int i, double x, double y);
//
set_vertex:
    stp x29, x30, [sp, #-16]!

    sub w1, w1, #1          // Make zero offset
    
    // Point to beginning of the vertices
    add x0, x0, #cabbage_vertices
    
    mov w4, #vertex_size    // Size of a vertex
    mul w1, w1, w4          // Now a multiple of 16
    add x1, x0, w1, uxtw    // Address of item in memory
    
    str d0, [x1, #vertex_x] // Save x
    str d1, [x1, #vertex_y] // Save y
    
    ldp x29, x30, [sp], #16
    ret

.global get_vertex_x    
//
// double get_vertex_x(void *cabbage, int i);
//
get_vertex_x:
    stp x29, x30, [sp, #-16]!
     
    sub w1, w1, #1          // Make zero offset
    
    // Point to beginning of the vertices
    add x0, x0, #cabbage_vertices
    
    mov w4, #vertex_size    // Size of a vertex
    mul w1, w1, w4          // Now a multiple of 16
    add x1, x0, w1, uxtw    // Address of item in memory
    
    ldr d0, [x1, #vertex_x]
    
    ldp x29, x30, [sp], #16
    ret
    
    
.global get_vertex_y    
//
// double get_vertex_y(void *cabbage, int i);
//
get_vertex_y:
    stp x29, x30, [sp, #-16]!
     
    sub w1, w1, #1          // Make zero offset
    
    // Point to beginning of the vertices
    add x0, x0, #cabbage_vertices
    
    mov w4, #vertex_size    // Size of a vertex
    mul w1, w1, w4          // Now a multiple of 16
    add x1, x0, w1, uxtw    // Address of item in memory
    
    ldr d0, [x1, #vertex_y]
    
    ldp x29, x30, [sp], #16
    ret

.global area
//
// double area(void *cabbage)
//
area:
    stp x29, x30, [sp, #-16]!
    
x_1 .req d0
y_1 .req d1
x_2 .req d2
y_2 .req d3
x_3 .req d4
y_3 .req d5

    ldr x_1, [x0, #cabbage_x1]
    ldr y_1, [x0, #cabbage_y1]
    ldr x_2, [x0, #cabbage_x2]
    ldr y_2, [x0, #cabbage_y2]
    ldr x_3, [x0, #cabbage_x3]
    ldr y_3, [x0, #cabbage_y3]
    
    // 
    // Shoelace formula for triangle area
    //
    fmul d6,x_1,y_2   // x_1y_2
    fmul d7,x_2,y_3   // x_2y_3
    fadd d6,d6,d7   // x_1y_2 + x_2y_3
    fmul d7,x_3,y_1   // x_3y_1
    fadd d6,d6,d7   // x_1y_2 + x_2y_3 + x_3y_1
    
    fmul d7,x_2,y_1   // x_2y_1
    fsub d6,d6,d7   // x_1y_2 + x_2y_3 + x_3y_1 - x_2y_1
    fmul d7,x_3,y_2   // x_3y_2
    fsub d6,d6,d7   // x_1y_2 + x_2y_3 + x_3y_1 - x_2y_1 - x_3y_2
    fmul d7,x_1,y_3   // x_1y_3
    fsub d6,d6,d7   // x_1y_2 + x_2y_3 + x_3y_1 - x_2y_1 - x_3y_2 - x_1y_3
    
    ldr x1,=half
    ldr d7, [x1]
    fmul d0,d6,d7   // 0.5 * (x_1y_2 + x_2y_3 + x_3y_1 - x_2y_1 - x_3y_2 - x_1y_3)
    
    ldr d6, =0
    fcmp d0,d6
    bpl area_done
    
    fsub d0,d6,d0       // negate
    
area_done:
    ldp x29, x30, [sp], #16
    ret
    
.unreq  x_1
.unreq  y_1
.unreq  x_2
.unreq  y_2
.unreq  x_3
.unreq  y_3
