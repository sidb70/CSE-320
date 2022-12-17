//
// Data section
//
.data

usage: .asciz "Usage: sieve <size>\n";
test: .asciz "%d\n"
min_size: .asciz "Sieve size must be at least 2\n"
primes_msg: .asciz "Primes:"
endl: .asciz "\n"
number: .asciz "%d\n"


//
// Text section
//

.text

.global main

//
// main(argc, argv)
// w0: The number of arguments
// x1: Pointer to an array of string pointers
// 
main: 
    stp x29, x30, [sp, #-16]!   // Push fp and lr onto the stack
    stp x19, x20, [sp, #-16]!   // Push x19 and x20 onto the stack
    stp x21, x22, [sp, #-16]!   // Push x21 and x22 onto the stack
    
  cmp w0, #2      // Compare argc to 2
  bge args_ok     // Branch if argc >= 2

  ldr x0,=usage   // Get address of message
  bl printf       // printf

	mov w0, #1      // return value: 1
  b main_return   // return  
args_ok:
  ldr x0,[x1,#8]    // Get argv[1]
  bl atoi
  
  cmp w0, #2
  bge size_ok
  
  ldr x0,=min_size
  bl printf

  mov w0, #1        // Return val: 1
  b main_return     // return
size_ok:
  size .req w19     // use w19 for size
  mov size, w0      // size
  
  add w0, size, #1  // w0 <- size+1
  mov w1, #4        // size of an int
  bl calloc

  sieve .req x20
  mov sieve, x0     // Save the result
  
  mov x0, sieve
  mov w1, size
  bl initialize
  
  mov x0, sieve
  mov w1, size
  bl sieve_it

  mov x0, sieve
  mov w1, size
  bl display
  
  
  mov x0, sieve
  bl free
main_return:
    ldp x21, x22, [sp], #16     // Restore x21 and x22 from the stack
    ldp x19, x20, [sp], #16     // Restore x19 and x20 from the stack
    ldp x29, x30, [sp], #16     // Restore fp and lr from the stack
    ret

    .unreq size
//
// sieve_it(int *sieve, int size)
// x0: pointer to array of ints
// w1: size of arr
sieve_it:
  stp x29, x30, [sp, #-16]!   // Push fp and lr onto the stack
  stp x19, x20, [sp, #-16]!   // Push x19 and x20 onto the stack
  stp x21, x22, [sp, #-16]!   // Push x21 and x22 onto the stack
  size .req w19               // Use w19 for size
  sieve .req x20              // Use x20 for sieve arr
  i .req w21                  // use w21 for i counter
  mov size, w1
  mov sieve, x0
  mov i, #2
  lsr  w22, w19, #1           // w22 <- size/2

  b sieve_loop
sieve_loop:
  cmp i, w22                  // cmp i, size/2
  bge sieve_it_return
  
  add w1, i, i                // j = 2*i
  lsl w1,w1, #2                  // j * 4
  mov w0, #0
  str w0, [x20, w1, uxtw]

  add i, i, #1
  b sieve_loop
sieve_it_return:
  ldp x21, x22, [sp], #16     // Restore x21 and x22 from the stack
  ldp x19, x20, [sp], #16     // Restore x19 and x20 from the stack
  ldp x29, x30, [sp], #16     // Restore fp and lr from the stack
  ret
  .unreq size
  .unreq sieve
  .unreq i
//
// display(int *sieve, int size)
// x0: pointer to an array of integers
// w1: size of array
display:
  stp x29, x30, [sp, #-16]!   // Push fp and lr onto the stack
  stp x19, x20, [sp, #-16]!   // Push x19 and x20 onto the stack
  stp x21, x22, [sp, #-16]!   // Push x21 and x22 onto the stack

  size .req w19               // Use w19 for size
  sieve .req x20              // Use x20 for the array
  mov size, w1
  mov sieve, x0  
  
  ldr x0,=primes_msg
  bl printf

  ldr x0,=endl
  bl printf
 
  i .req w21                  // use w21 for the loop counter
  mov i, #2
display_loop:
  cmp i, size
  bgt display_loop_end
  
  lsl w1, i, #2               // i * 4
  ldr w0, [sieve, w1, uxtw]   // sieve[i]
  
  cmp w0, #0                  // sieve[i]==0?
  beq display_skip            // If yes, skip

  ldr x0,=number
  mov w1, i
  bl printf
  

  add i, i, #1
  b display_loop
display_skip:
  add i, i, #1
  b display_loop
display_loop_end:
  ldr x0,=endl
  bl printf
display_return:
  ldp x21, x22, [sp], #16     // Restore x21 and x22 from the stack
  ldp x19, x20, [sp], #16     // Restore x19 and x20 from the stack
  ldp x29, x30, [sp], #16     // Restore x29 and x30 from the stack
  ret
  .unreq size
  .unreq sieve 
  .unreq i

//
// initialize(int *sieve, int size)
// x0: pointer to an array of ints
// w1: size of arr
//
initialize:
  stp x29, x30, [sp, #-16]!   // Push fp and lr onto the stack
  stp x19, x20, [sp, #-16]!   // Push x19 and x20 onto the stack
  stp x21, x22, [sp, #-16]!   // Push x21 and x22 onto the stack
  size .req w19
  sieve .req x20
  i .req w21
  mov sieve, x0
  mov size, w1
  mov i, #2
  mov w0, #1
  b init_loop
init_loop:
  cmp i, size
  bgt initialize_return
  
  lsl w1,i, #2                // i * 4
  str w0, [sieve, w1, uxtw] 
  add i, i, #1
  b init_loop  
initialize_return:
  ldp x21, x22, [sp], #16     // Restore x21 and x22 from the stack
  ldp x19, x20, [sp], #16     // Restore x19 and x20 from the stack
  ldp x29, x30, [sp], #16     // Restore x29 and x30 from the stack
  ret
  .unreq size
  .unreq sieve
  .unreq i

