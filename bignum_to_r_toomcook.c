/*

Big number library - arithmetic on multiple-precision unsigned integers.

This library is an implementation of arithmetic on arbitrarily large integers.

The difference between this and other implementations, is that the data structure
has optimal memory utilization (i.e. a 1024 bit integer takes up 128 bytes RAM),
and all memory is allocated statically: no dynamic allocation for better or worse.

Primary goals are correctness, clarity of code and clean, portable implementation.
Secondary goal is a memory footprint small enough to make it suitable for use in
embedded applications.


The current state is correct functionality and adequate performance.
There may well be room for performance-optimizations and improvements.

*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int to_r (char* binaz) {
  int r1=0;
  int r2=0;
  while(r2<1) {
    if(r2<1) if(binaz[r1]==0) r2++;
    r1++;
  }
  int k=1;
  int q[32], r[32], qq=4, RR=2;
  q[0]=4;q[1]=4;r[0]=4,r[1]=4;
  while ( (q[k-1]+q[k]) < r1) {
    if ( pow(RR+1,2) <= qq) RR++;
    k++;
    qq=qq+RR;
    q[k]=pow(2, qq);
    r[k]=pow(2,RR);
  }
  int rf=0;
  printf("%04d", r[k]);
  fflush(stdout);
  return 0;
} 



int main(int argc, char *argv[] ) {
  char *buf;
  int rt=512;
  buf=calloc(2, sizeof(char));
  char *bufferA;
  bufferA=calloc(rt, sizeof(char));
  char *temporal;
  temporal=calloc(rt, sizeof(char));
  bzero(bufferA, rt);
  bzero(temporal,rt);
  char buff[2];
  int r=1;
  int rr=0;
  

  while(r>0) {
    r=fread(buff, sizeof(char), 1, stdin);
    if(r<1) break;
    bufferA[rr]=buff[0];
    rr++;
    while(rr>rt-1) {
      free(temporal);
      temporal=calloc(rr, sizeof(char));
      memcpy(temporal, bufferA, rr);
      free(bufferA);
      bufferA=calloc(rr+1024, sizeof(char));
      buf=calloc(rr+1024, sizeof(char));
      bzero(bufferA, 1024);
      memcpy(bufferA, temporal, rr);
      rt=rr+1024;
    }
  }
  bufferA[rr]=0;
  if(rr<=1) {
    bufferA[0]='0';
    bufferA[1]=0;
  }
  r=0;
  to_r(bufferA);
}
