// 
// My first assembly language program
// Name: Sid Bhattacharya
//
.text
.global first
.global second
.global min
.global bit_counter
first:
  mov x1, x0
  add x0, x0 ,x1
  add x0, x0, x1
  ret
second:
  add x0, x0, x1
  ret
min:
  subs x2, x0, x1
  bge b_is_minimum //if a>=b
  // In this case a is the min
  b after_block
  ret

b_is_minimum:
  // In this case b is the min
  mov x0, x1

after_block:
  ret

bit_counter:
  mov x1, #0        //cnt = 0

  //for loop initialization
  mov x2, #0        // i = 0

forloop:
  //for loop test: i!=64
  subs x3, x2, #64  // x3 = i - 64
  beq loopend       // if i - 64 == 0 (i==64)
  
  ands x3, x0, #1   // x0 & 1
  beq after_inc

  add x1, x1, #1    //cnt++


  //increment / i++
  add x2, x2, #1
  b forloop
after_inc:
  lsr x0, x0, #1    // value >>=1
loopend:
  mov x0, x1
  ret
