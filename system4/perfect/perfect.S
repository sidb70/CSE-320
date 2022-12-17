.text
.global perfect_sqr


/**
 * Determine if a number is a perfect square.
 * x0 - Passed in value: num
 * Returns 1 if num is a perfect square.
*/
perfect_sqr:
  mov x1, #1    // n used in forloop
  mov x2, #1    // n_sqr
  mov x3, #1    // max

  lsl x3, x3, #32  // max <<= 32
  
  b forloop

forloop:

  cmp x2, x0
  beq end_perf
 
  mov x4, x0
  add x4, x4,#1 
  cmp x2, x4
  bpl end_false

  mov x4, x1      // x4 = n
  add x4, x4, x4  // x4 = n*2
  add x4, x4, #1  // x4 = n*2 + 1
  add x2, x2, x4  // n_sqr += n*2 +2 
 
  add x1, x1, #1  // n++
  b forloop
end_false:
  mov x0, #0
  ret
end_perf:
  mov x0, #1
  ret

