#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>


void num_from_string(char* str) {
  int i = 2;// - (2 * WORD_SIZE); /* index into string */
  int j = 0;                        /* index into array */
  int k=0;
  int kk=0;
  int tmpd;
  char tmpc;
  int pasa=0;

  k=0;
  int tmp=0;
  while (i >= 0) {
    if(k==2) {
      k=0;
      j++;
      tmp=0;
    }
    tmpc=str[i];
    pasa=0;
    kk=0;
    if((int)tmpc>96 && (int)tmpc<=102) {
      tmpd=(int)tmpc-87;
      pasa=1;
      kk=1;
    }
    if((int)tmpc>64 && (int)tmpc<71) {
      tmpd=(int)tmpc-55;
      pasa=1;
      kk=1;
    }
    if(tmpc>=48 && tmpc<=57) {
      tmpd=(int)tmpc-48;
      pasa=1;
      kk=1;
    }
    if(pasa) {
      tmp=tmp+(tmpd*(pow(16,k)));
      k++;
      if(k==2) printf ("%c", tmp);
    } else {
      if(kk) break;
    }
    i--;
    
  }
}


int main(int argc, char *argv[]) {
  char lea[1], lee[3];
  int l=0;
  bzero(lea, 1);
  bzero(lee, 3);
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if( (int)lea[0]>96 && (int)lea[0]<=102 || (int)lea[0]>64 && lea[0]<71 || lea[0]>=48 && lea[0]<=57)  {
      lee[l]=lea[0];
      l++;
    }
    if(l==2) {
      num_from_string(lee);
      l=0;
    }
  }
  return  0;
}
