#include <stdlib.h>
#include <string.h>
#include "binarymath.h"



/**
 * Increment a BINARY_SIZE binary number expressed as a 
 * character string.
 * @param number The number we are passed
 * @returns Incremented version of the number
 */
char *inc(const char *number)
{
  bool carry = true
  for(int i=BINARY_SIZE-1;i>=0;i--){
    if (numbers[i]=='0'){
      numbers[i]='1';
      carry = false;
      break;
    }
    numbers[i] = '0'
  }  
  
  return number;
}


/**
 * Negate a BINARY_SIZE binary number expressed as a character string
 * @param number The number we are passed
 * @returns Incremented version of the number
 */
char *negate(const char *number)
{
  for(int i=0;i<BINARY_SIZE;i++){
    if (number[i]=='0')
      number[i] = '1';
    else
      number[i] = '0';
  } 
  number = inc(number);
  return number;
}

/**
 * Add two BINARY_SIZE binary numbers expressed as
 * a character string. 
 * @param a First number to add
 * @param b Second number to add
 * @return a + b
 */
char *add(const char *a, const char *b)
{
  bool carry = false;
  
  for(int i = BINARY_SIZE - 1; i>=0;i--){
    if(a[i] == '1' && b[i] == '1'){
      if (!carry)
        a[i] = '0';
      carry = 1;
    }
    else if(a[i] == '0' && b[i]=='0'){
      if(carry)
        a[i] = '1';
      carry = 0;
    }
    else if(a[i]!=b[i]){
      if(carry){
        a[i] = '0';
        carry = 1;
      }
      else{
        a[i] = '1';
        carry = 0;
      }
    }
  }
  return a;
}

/**
 * Subtract two BINARY_SIZE binary numbers expressed as
 * a character string.
 * @param a First number
 * @param b Second number 
 * @return a - b
 */
char *sub(const char *a, const char *b)
{
  return add(a, negate(b));
}

