#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

static const unsigned char letrasl[26]="abcdefghijklmnopqrstuvwxyz";
static const unsigned char letrasu[26]="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
static const unsigned char simbolos[8]="/?!,.:; ";
static const unsigned char letrasutf8[12]={0x81,0x89,0x8D,0x91,0x93,0x9A,0xA1,0xA9,0xAD,0xB1,0xB3,0xBA};
static const unsigned char letrasutf8caracteresconvierte[12]={'A','E','I','N','O','U','A','E','I','N','O','U'};
static const unsigned char slashes[4]={'n','t','r','d'};

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
      if(p<sizeof(letrasutf8)) printf("%c", letrasutf8caracteresconvierte[p]);
      continue;
    }
    if(lea[0]=='\\') {
      read(fileno(stdin), lea, 1);
      n++;
      p=0;
      while(p<sizeof(slashes)) {
	if(slashes[p]==lea[0]) {
	  break;
	}
	p++;
      }
      if(p<sizeof(slashes)) printf("%c", ';');
      else printf("%c%c", '\\', lea[0]);
      continue;
    }
    p=0;
    while(p<sizeof(simbolos)) {
      if(simbolos[p]==lea[0]||simbolos[p]==lea[0]) {
	break;
      }
      p++;
    }
    if(p<sizeof(simbolos)) printf("%c", lea[0]);
    p=0;
    while(p<sizeof(letrasl)) {
      if(letrasl[p]==lea[0]||letrasu[p]==lea[0]) {
	break;
      }
      p++;
    }
    if(p<sizeof(letrasl)) printf("%c", letrasu[p]);
  }
  return  0;
}
