.data
//
// Game description data structure
//
.equ  game_rows, 0
.equ  game_cols, 4
.equ game_array, 8
.equ game_size, 16

//
// Game cell data structure
// This is the contents of a location in the array
//
.equ  cell_expected,0
.equ  cell_actual, 4
.equ  cell_size, 8

item: .asciz " %c"
nums: .asciz " %d"
newline: .asciz "\n"

.text

.global create_game

//
// Create the game abstract data type
// void *create_game(int rows, int cols)
//
create_game:
	stp x29, x30, [sp, #-16]!
	stp x19, x20, [sp, #-16]!
	stp x21, x22, [sp, #-16]!
    
  mov w19, w0       // rows
  mov w20, w1       // cols
  mov w0, #1
  mov w1, #game_size
  bl calloc
  
  // Set the data structure initial values
  str w19,[x0,#game_rows]
  str w20,[x0,#game_cols]

  mov x21, x0           // game pointer
  
  // Allocate the game array
  mul w0, w19, w20      // row * cells
  mov w1, #cell_size    // cell size
  bl calloc

  str x0,[x21,#game_array]
  mov x0, x21

create_game_done:
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
    
    
.global destroy_game
//
// void destroy_game(void *game)
// Destroy the game, freeing all memory
//
destroy_game:
	  stp x29, x30, [sp, #-16]!
  	stp x19, x20, [sp, #-16]!
  
    mov x21, x0
    ldr x0,[x21,#game_array]
    bl free
    mov x0, x21
    bl free
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret 
    
.global get_rows

//
// Get the number of rows in the game
// int get_rows(void *game)
//
get_rows:
    ldr x0,[x0,#game_rows]
    ret

.global get_cols

//
// Get the number of columns in the game
// int get_cols(void *game)
//
get_cols:
    ldr x0,[x0,#game_cols]
    ret

    
    
.global display_game

//
// Display the game
//
display_game:
    stp x29, x30, [sp, #-16]!
    mov x19, x0               // store game in x19
    ldr x0,=item
    bl printf
    ldr x0,=item
    bl printf

    mov w20, #1                // print top row
    mov w21, #0               // row counter
    mov w22, #0               // col counter
top_row:
    ldr w0,[x19,#game_cols]
    cmp w20,w0
    bgt row_loop
   
    ldr x0,=nums
    mov w1, w20 
    bl printf
    
    
    add w20, w20, #1 
    b top_row   
row_loop:
    ldr x0,=newline
    bl printf
    ldr w0,[x19,#game_rows]           // number of rows in game
    cmp w0, w21                       // row counter == game_rows?
    beq display_game_done

    add w1, w21, #1                   // + 1 to print row number
    ldr x0,=nums
    bl printf
    b print_inner_loop

print_inner_loop:
    ldr w0,[x19,#game_cols]
    cmp w22, w0                       // col counter == game_cols?
    beq inner_end
    
    mov x0, x19                       // game -> x0
    add w1, w21, #1
    add w2, w22, #1
    bl game_index                     // game_index(game,row,col)
    
    mov x1, #0
    ldr w1,[x0,#cell_actual]
    ldr x0,=item
    bl printf 

    add w22, w22, #1
    b print_inner_loop


inner_end:
    add w21, w21, #1                  // row++
    mov w22, #0                       // col = 0
    b row_loop
    
display_game_done:
    ldp x29, x30, [sp], #16
    ret
    
.global set_cell_actual

//
// int set_cell_actual(void *game, int row, int col, char ch);
// Returns: 1 if the answer value is correct
//
set_cell_actual:
	stp x29, x30, [sp, #-16]!
	stp x19, x20, [sp, #-16]!

  mov w19, w3             // save ch in w19
  bl game_index

  ldr w1, [x0,#cell_expected]
  str w19, [x0,#cell_actual]
  
  mov x0, #0
  cmp w1, w19
  beq correct
  b set_cell_actual_done
correct:
  mov x0, #1
set_cell_actual_done:
	ldp x19, x20, [sp], #16
	ldp x29, x30, [sp], #16
    ret

.global set_cell_expected

//
// void set_cell_expected(void *game, int row, int col, char ch);
//
set_cell_expected:
	stp x29, x30, [sp, #-16]!
	stp x19, x20, [sp, #-16]!
    
  mov w19, w3               // save ch in w19
  bl game_index

  str w19, [x0, #cell_expected]   // save ch into game

	ldp x19, x20, [sp], #16
	ldp x29, x30, [sp], #16
    ret



.global game_win

//
// int game_win(void *game)
// Returns true when the game is done/won
//
game_win:
  stp x29, x30, [sp,#-16]!
  stp x19, x20, [sp,#-16]!
  
  mov x19, x0                 // store game in x19
  mov x20, #0                 // row counter
  mov x21, #0                 // col counter
  mov w22, #1                 // game won? set to 0 if any cell not correct
game_win_rows:
  ldr w0,[x19,#game_rows]
  cmp w20, w0                 // row counter == game_rows?
  beq game_win_done

game_win_cols:
  ldr w0,[x19,game_cols]
  cmp w21, w0                 // col counter == game_cols?
  beq win_col_done

  mov x0, x19                 // game -> x0
  add w1, w20, #1             // numerical row -> w1
  add w2, w21, #1             // numerical col -> w2
  bl game_index
  
  ldr w1,[x0,#cell_expected]
  ldr w2,[x0,#cell_actual]
  cmp w1, w2
  bne wrong

  add w21, w21, #1
  b game_win_cols

win_col_done:
  add w20, w20, #1            // row++
  mov w21, #0
  b game_win_rows

wrong:
  mov w22, #0
  b game_win_done
game_win_done:
  mov w0, w22
  ldp x19, x20,[sp],#16
  ldp x29, x30,[sp],#16
  ret

.global game_index
//
// int *game_index(void *game, int row, int col)
// Get the address of a row and column in the cells
//   
game_index:
  sub w2, w2, #1            // c
  sub w1, w1, #1            // r
 
  ldr x5, [x0,#game_array] 
  ldr w3,[x0,#game_cols]    // cols
  mov w4, #cell_size

  mul w1, w1, w3            // r*cols
  add w1, w1, w2            // r*cols + c
  mul w1, w1, w4            // (r*cols + c) * cell_size
  add x0, x5, w1, uxtw
  ret
	

