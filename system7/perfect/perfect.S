.data
msg1: .asciz "\nAll Perfect numbers from 1 to 10000:\n"

msg2: .asciz "Perfect=%d\n"


.text

.global perfect

perfect:
  fp .req x29
  lr .req x30

  .equ number, 16       // dword, Must start at 16 (after fp, lr)
  .equ divisor, 24      // dword
  .equ sum, 32          // dword
  .equ size, 48

  //Store fp and lr and make space on the stack
  stp fp, lr, [sp, #-size]!
  mov fp, sp
 
  // Initialize number and divisor to 1 
  mov x0, #1
  str x0, [fp,#number]
  
  
  ldr x0,=msg1 
  bl printf

outer_loop:
  ldr x0,[fp,#number]
  mov x1, #10000
  bl ldiv
  cmp x0, #1
  beq perfect_done

  mov x0, #0
  str x0, [fp,#sum]

  mov x0, #1
  str x0, [fp,#divisor]
inner_loop:
  ldr x0, [fp,#divisor]
  ldr x1, [fp,#number]
  cmp x0, x1
  beq end_inner
  ldr x0, [fp, #number]
  ldr x1, [fp, #divisor]
  bl ldiv
  cmp x1, #0
  beq add_sum
  ldr x0, [fp, #divisor]
  add x0, x0, #1
  str x0, [fp, #divisor]
  b inner_loop
add_sum:
  ldr x0, [fp,#sum]
  ldr x1,[fp,#divisor]
  add x0, x0, x1
  str x0, [fp, #sum]
  
  add x1, x1, #1
  str x1, [fp, #divisor]
  b inner_loop
end_inner:
  ldr x0, [fp, #number]
  ldr x1, [fp, #sum]
  cmp x0, x1
  beq is_perfect
  add x0, x0, #1
  str x0, [fp, #number]
  b outer_loop
is_perfect:
  ldr x0,=msg2
  ldr x1,[fp,#number]
  bl printf
  ldr x0, [fp, #number]
  add x0, x0, #1
  str x0, [fp, #number]
  b outer_loop
perfect_done:
  
  // Pop lr and fp and free stack space
  ldp x29, x30, [sp], #size
  ret
  
