
.data
.equ image_width, 0
.equ image_height,4
.equ image_array, 8
.equ image_size, 16


.equ pixel_size, 8

.text
 
.global create_image
//
// void *create_image(int wid, int hit)
// Create an image ADT and return it.
//
create_image:
   stp x29, x30, [sp, #-16]!
   stp x19, x20, [sp, #-16]!
   stp x21, x22, [sp, #-16]!

   mov w19, w0                // width
   mov w20, w1                // height
   mov w0, #1
   mov w1, #image_size
   bl calloc

   // Se the data structure intial values
   str w19,[x0,#image_width]
   str w20,[x0,#image_height]

   // Allocate the image array
   mov x21, x0
   mul w0, w19, w20         // height * width 
   mov w1, #pixel_size
   bl calloc

   str x0,[x21,#image_array]
   mov x0, x21
create_image_done:
  ldp x21, x22, [sp], #16
  ldp x19, x20, [sp], #16
  ldp x29, x30, [sp], #16
  ret
    
.global destroy_image   
//
// void destroy_image(void *image)
// Destroy image, freeing memory
//
destroy_image:
    stp x29, x30, [sp,#-16]!
    stp x19, x20, [sp,#-16]!
    
    mov x21, x0
    ldr x0,[x21,#image_array]
    bl free
    mov x0, x21
    bl free

    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
.global get_width
//
// int get_width(void *image)
// Get the width of the image
//
get_width:
    ldr w0,[x0,#image_width]
    ret
    
.global get_height
//
// int get_height(void *image)
// Get the height of the image
//
get_height:
    ldr w0,[x0,#image_height]
    ret
    
        
.global set_pixel
//
// void set_pixel(void *image, int row, int col, double value)
//
set_pixel:
    stp x29, x30, [sp,#-16]!
    stp x19, x20, [sp,#-16]!
    
    ldr x5,[x0,#image_array]
    ldr w3,[x0,#image_width]
    mov w4, #pixel_size

    mul w1, w1, w3            // r*width
    add w1, w1, w2            // r*width + c
    mul w1, w1, w4            // (r*width + c) * pixel_size
    add x0, x5, w1, uxtw
    
    mov x1, #0
    str d0,[x0,x1]

    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
.global get_pixel
//
// double get_pixel(void *image, int row, int col)
//
get_pixel:
    ldr x5,[x0,#image_array]
    ldr w3,[x0,#image_width]
    mov w4, #pixel_size

    mul w1, w1, w3          // r * width
    add w1, w1, w2          // r*width + c
    mul w1, w1, w4          // (r*width + c) * pixel_size
    add x0, x5, w1, uxtw
    
    mov x1, #0
    ldr d0,[x0,x1]

    ret


.global image_index
//
// double *image_index(void *image, int row, int col)
// Get the address of a row and column in the image
image_index:
  ldr x5,[x0,#image_array]
  ldr w3,[x0,#image_width]
  mov w4, #pixel_size

  mul w1, w1, w3            // r * width
  add w1, w1, w2            // r*width + c
  mul w1, w1, w4            // (r*width + c) * pixel_size

  add x0, x5, w1, uxtw
  ret
