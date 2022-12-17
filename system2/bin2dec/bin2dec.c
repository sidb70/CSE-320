#include "bin2dec.h"
#include <stdio.h>
/**
 * Convert a binary representation of a 
 * number to an unsigned integer. 
 * 
 * For this function, the values Y and N represent 
 * true (1) and false (0) respectfully. So, the string:
 * 
 * YYNY is equal to 1101 binary, which is equal to 13.
 *
 * Unexpected characters are ignored. Only Y's and N's are
 * considered to be valid. Stop converting when you get
 * to a space character or the end of the string. The 
 * representation is case-sensitive (only Y/N are valid 
 * true and false values).
 *
 * 'aYNcY YY' should convert to 5
 * 'NYNYny' should convert to 5
 *
 * @param binary Binary number as a string of 'Y's and 'N's
 * and other characters.
 * @returns unsigned int result
 */
unsigned int bin2dec(const char *binary)
{
  char bin_clean[sizeof(binary)];
  int i=0, j=0;
  for(i=0;i<sizeof(binary)-1;i++){
    if(binary[i]==' ') break;
    else if(binary[i]=='Y' || binary[i]=='N'){
      bin_clean[j]=binary[i];
      j++;
    }
  }
  unsigned int dec =0;
  int pow=1;
  for(i=sizeof(bin_clean)-1;i>=0;i--){
    if(bin_clean[i]=='Y' || bin_clean[i]=='N'){
      if(bin_clean[i]=='Y')
        dec+=pow;
      pow*=2;
    }
  }
  return dec;
}
