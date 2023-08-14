#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>


int num_from_string(char* str) {
  int i = 3;// - (2 * WORD_SIZE); /* index into string */
  int j = 0;                        /* index into array */
  int k=0;
  int kk=0;
  int tmpd;
  char tmpc;
  int pasa=0;

  k=0;
  int tmp=0;
  while (i >= 0) {
    if(k==3) {
      k=0;
      j++;
      tmp=0;
    }
    tmpc=str[i];
    pasa=0;
    kk=0;
    if(tmpc>=48 && tmpc<=57) {
      tmpd=(int)tmpc-48;
      pasa=1;
      kk=1;
    }
    if(pasa) {
      tmp=tmp+(tmpd*(pow(10,k)));
      k++;
    } else {
      if(kk) break;
    }
    i--;   
  }
  if(tmp) return tmp;
  else return 0;
}


int main(int argc, char *argv[]) {
  char lea[1], lee[4];
  long divisor=0;
  long dividendo=0;
  int l=0;
  int m=0;
  lea[0]=0;
  lee[0]=0;
  lee[1]=0;
  lee[2]=0;
  lee[3]=0;
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if( lea[0]>=48 && lea[0]<=57 && l<3)  {
      lee[l]=lea[0];
      l++;
    } else {
      //printf("%d", ceil(num_from_string(lee)/divisor));
      printf("%06d %s\n", m, lee);
      if(l>=3) 	m++;
      if(!dividendo) {
	l=0;
	if(lea[0]=='/') {
	  m++;
	  if (!m) dividendo=num_from_string(lee);
	  else dividendo=dividendo+(num_from_string(lee)*pow(10, 3*m));
	}
	lee[0]=0;
	lee[1]=0;
	lee[2]=0;
	lee[3]=0;
      } else break;
    }
  }
  divisor=num_from_string(lee);
  double divi=(double)dividendo/(double)divisor;
  printf("d=%06d %06d", (long)dividendo, (long)ceil(divi));
  return  0;
}
