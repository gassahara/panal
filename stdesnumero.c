#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

int main(int argc, char *argv[]) {
  unsigned char lea[2];
  long p, n;
  lea[0]=0;
  lea[1]=0;
  n=0;
  p=0;
  while(read(fileno(stdin), lea, 1)>0) {
    if((lea[0]<48 || lea[0]>57) && lea[0]!=46) {
      printf("*");
      break;
    }
    if(lea[0]==46) {
      n++;
      p=1;
    }
    else {
      if(p==1) p++;
    }
    if(n>1) {
      printf("*");
      break;
    }
  }
  if(n==1 && p==1) {
    printf("*");
  }
  return  0;
}
