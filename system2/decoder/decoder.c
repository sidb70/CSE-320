#include "decoder.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
/**
 * Sets bits in decoded string
 * @param decoded The char array being assigned to
 * @param maxLen The maximum size for decoded
 * @param bit The bit within decoded being toggled
 */
void setBit(char *bits, int maxLen, int bit)
{
  if(bit<maxLen-1)
  {
    bits[bit] = 1;
  }
}


/**
 * Decode an encoded string into a character stream.
 * @param encoded The input string we are decoding
 * @param decoded The output string we produce
 * @param maxLen The maximum size for decoded
 */
void decoder(const char *encoded, char *decoded, int maxLen)
{
    //bits array is the intermediate array that will hold the binary derived
    //from the encrypted message
    char bits[maxLen];
    strncpy(bits, encoded, maxLen);
    int i=0;
    for (i=0; i < maxLen; i++)
    {
      bits[i] = 0;
    }
    int bit =0;
    for(i=0;i<maxLen-1;i++){
      char c = encoded[i];
      switch(c)
      {
        case 'O':
          bit++;
          bit++;
          bit++;
          break;
        case '6':
          bit++;
          bit++;
          setBit(bits, maxLen, bit++);
          break;
        case 'q':
          bit++;
          setBit(bits, maxLen, bit++);
          bit++;
          break;
        case 'a':
          bit++;
          setBit(bits, maxLen, bit++);
          setBit(bits, maxLen, bit++);
          break;
        case 'k':
          setBit(bits, maxLen, bit++);
          bit++;
          bit++;
          break;
        case 'p':
          setBit(bits, maxLen, bit++);
          bit++;
          setBit(bits, maxLen, bit++);
          break;
        case 'f':
          setBit(bits, maxLen, bit++);
          setBit(bits, maxLen, bit++);
          bit++;
          break;
        case 'Q':
          setBit(bits, maxLen, bit++);
          setBit(bits, maxLen, bit++);
          setBit(bits, maxLen, bit++);
          break;
        case '2':
          bit++;
          bit++;
          break;
        case 's':
          bit++;
          setBit(bits, maxLen, bit++);
          break;
        case 'N':
          setBit(bits, maxLen, bit++);
          bit++;
          break;
        case 'm':
          setBit(bits, maxLen, bit++);
          setBit(bits, maxLen, bit++);
          break;
        default:
          break;
      }
    }
  int byte =0;
  int j=0, dec=0;
  char bin[9] = {0};
  for(j=0;j<maxLen-1;j++){
    bin[j%8]=bits[j];
    if((j+1)%8==0){
      int i=0, pow=1;
      for(i=7; i>=0;i--){
        dec+=(pow*bin[i]);
        pow*=2;
      }
      
      decoded[byte] = (char)dec;
      byte++;
      dec=0;
      }
  }
}
