.data


.text

.global life

//
// life iteration calculator
// x0 - int *cells
// w1 - int width in words
// w2 - int height in rows
//
life: 
	stp x29, x30, [sp, #-16]!   // Push fp and lr onto the stack
  stp x19, x20, [sp, #-16]!   // Push x19 and x20 onto the stack 
  stp x21, x22, [sp, #-16]!   // Push x21 and x22 onto the stack
  stp x23, x24, [sp, #-16]!   // ...
  stp x25, x26, [sp, #-16]!   // ...
  stp x27, x28, [sp, #-16]!   // ...

  cells .req x19              // Use x19 for original cells arr
  width_32 .req w20           // Use w20 for width*32
  height .req w21             // Use w21 for height
  cells2 .req x22             // Use x22 for cells2
  i .req w23                  // Use w23 for i counter

  mov cells, x0                 
  mov width_32, w1              
  lsl width_32, width_32, #5            // width *=32
  mov height, w2
  mov i, #0

  
  mul w0, w1, w2             // w1 <- width*height
  mov w1, #4                  // size of int
  bl calloc
  mov cells2, x0            

  b loop
loop:
  mul w0, width_32,height  // i<width*height*32 ?
  cmp i, w0
  beq life_return
  
  mov w28, #0                  // Use w28 to count live neighbors
  
  mov x0, cells
  mul w1, width_32, height
  sub w2, i, width_32
  sub w2, w2, #1
  bl get_bit                  // get upper-left
  add w28, w28, w0

  mov x0, cells
  mul w1, width_32, height
  sub w2, i, width_32
  bl get_bit                  // get above
  add w28, w28, w0

  mov x0, cells
  mul w1, width_32, height
  sub w2, i, width_32
  add w2, w2, #1
  bl get_bit
  add w28, w28, w0            // get upper-right


  mov x0, cells
  mul w1, width_32, height
  sub w2, i, #1
  bl get_bit                  // get left
  add w28, w28, w0
  
  
  mov x0, cells
  mul w1, width_32, height  
  add w2, i, #1
  bl get_bit                  // get right
  add w28, w28, w0

  mov x0, cells
  mul w1, width_32, height
  add w2, i, width_32
  sub w2, w2, #1
  bl get_bit                  // get lower-left
  add w28, w28, w0

  mov x0, cells
  mul w1, width_32, height
  add w2, i, width_32
  bl get_bit                  // get below
  add w28, w28, w0

  mov x0, cells
  mul w1, width_32, height
  add w2, i, width_32
  add w2, w2, #1
  bl get_bit                  // get lower-right
  add w28, w28, w0
  
  
  cmp w28, #2
  blt die
  cmp w28, #3
  beq procreate
  cmp w28, #3
  bgt die
  

  mov x0, cells
  mul w1, width_32, height
  mov w2, i
  bl get_bit
  mov w3, w0               // bit in cells will be set to bit in cells2

  mov x0, cells2
  mul w1, width_32, height
  mov w2, i
  bl set_bit

  add i, i, #1
  b loop

die:
  mov w3, #0
  mov x0, cells2
  mul w1, width_32, height
  mov w2, i
  bl set_bit
  
  add i, i, #1
  b loop
procreate:
  mov w3, #1
  mov x0, cells2
  mul w1, width_32, height
  mov w2, i
  bl set_bit
  
  add i, i, #1
  b loop
life_return:
  mov w25, #0
  mul w26, width_32, height
   
copy_loop:
  cmp w25, w26
  beq life_return_final
  
  mov x0, cells2
  mov w1, w26
  mov w2, w25
  bl get_bit
  mov w3, w0

  mov x0, cells
  mov w1, w26
  mov w2, w25
  bl set_bit

  add w25, w25, #1
  b copy_loop
  
   

life_return_final:
  mov x0, cells2
  bl free
  mov x0, cells
  ldp x27, x28, [sp], #16     // Restore x27 and x28 from the stack
  ldp x25, x26, [sp], #16     // Restore x25 and x26 from the stack
  ldp x23, x24, [sp], #16     // Restore x23 and x24 from the stack
  ldp x21, x22, [sp], #16     // ...
  ldp x19, x20, [sp], #16     // ...
  ldp x29, x30, [sp], #16     // ...
  ret
	.unreq cells
  .unreq width_32
  .unreq height
  .unreq cells2
  .unreq i
