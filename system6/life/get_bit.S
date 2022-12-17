.text
.global get_bit


//
// Get a bit from an array of words.
// x0 - Array of integers
// w1 - Width of the array in bits
// w2 - Desired bit
//
get_bit:
  stp x29, x30, [sp, #-16]!   // Push fp and lr onto the stack
  cmp w2, #0
  blt invalid
  cmp w2, w1
  bge invalid

  lsr w3, w2, #5   // Determine the word -> w3
  and w4, w2, #0x1f  // Bit index        -> w4

  lsl w7, w3, #2       // i * 4 -> w7
  ldr w0, [x0, w7, uxtw] // 

  mov w7, #31
  sub w5, w7, w4       // 31 - bit
  lsr w0, w0, w5      // Shift bit to lowest bit

  and w0, w0, #1      // And with 1 and return value
  b get_bit_done

invalid:
  mov w0, #0
  b get_bit_done

get_bit_done:
  ldp x29, x30, [sp], #16     // Restore fp and lr from the stack
  ret
