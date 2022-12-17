.data
reversed: .asciz ""
empty: .asciz ""
.text
.global reverse_str

reverse_str:
  mov w2, #0
  ldr x1, =reversed
  b count
count:
  ldrb w3, [x0]
  cmp w3, #0
  beq stop

  add w2, w2, #1
  add x0, x0, #1
  b count
stop:
  cmp w2, #2
  blt end
  sub x0, x0, #1
  sub w2, w2, #1
  b reverse
reverse:
  ldrb w3, [x0]
  strb w3, [x1]

  cmp w2, #0
  beq done

  sub w2, w2, #1
  sub x0, x0, #1
  add x1, x1, #1
  b reverse
done:
  add x1, x1, #1
  mov w3, #0
  strb w3, [x1]

  ldr x1,=reversed
  ldr x1, [x1]
  str x1, [x0]
  ret
end:
  ret
