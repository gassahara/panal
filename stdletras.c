#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

static const unsigned char letras[52]="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
static const unsigned char letrasutf8[12]={0x81,0x89,0x8D,0x91,0x93,0x9A,0xA1,0xA9,0xAD,0xB1,0xB3,0xBA};

int main(int argc, char *argv[]) {
  unsigned char lea[2];
  long p, n;
  lea[0]=0;
  lea[1]=0;
  n=0;
  p=0;
  while(read(fileno(stdin), lea, 1)>0) {
    n++;
    if(lea[0]==0xC3) {
      read(fileno(stdin), lea, 1);
      n++;
      p=0;
      while(p<sizeof(letrasutf8)) {
	if(letrasutf8[p]==lea[0]) {
	  break;
	}
	p++;
      }
      if(p<sizeof(letrasutf8)) printf("%d ", n-1);
      continue;
    }
    p=0;
    while(p<sizeof(letras)) {
      if(letras[p]==lea[0]) {
	break;
      }
      p++;
    }
    if(p<sizeof(letras)) printf("%d ", n-1, p);
  }
  return  0;
}
