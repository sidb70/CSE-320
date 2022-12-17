
.text

.global cypher

/*
 * Compute the length of a  string
 * x0 - Address of the string in memory
 * x1 - Address of a substitution cypher in memory
 */
cypher:
  // x0 - address in string
  // x1 - address of the cypher
  // w2 - character from the string
  // x3 - computed address in the cypher
  // w4 - cyphered character

  ldrb w2, [x0]
  cmp w2, #0
  beq done

  // Ensure a character is not negative:
  bmi skip


  add x3, x1, w2, uxtw  // x3 = address of encoding
  ldrb w4, [x3]
  strb w4, [x0]

  add x0, x0, #1
  b cypher
skip:
  add x0, x0, #1
  b cypher
done:
  ret
