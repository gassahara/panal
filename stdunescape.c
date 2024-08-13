#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  char lea[2];
  char *carac;
  int leei, lee2, geto, n;
  leei=1025;
  lee2=0;
  geto=0;
  int m=0;
  int i=1;
  int imprime=1;
  int caracter;
  int van=0;
  bzero(lea, 2);
  m=0;
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if(lea[0] == '%') {
      imprime=0;
      caracter=0;
      van=0;
    }
    if(imprime) {
      printf("%c", lea[0]);
    } else {
      if(van==1) {
	if((int)lea[0]>96 && (int)lea[0]<=102) {
	  caracter=(int)lea[0]-87;
	}
	if((int)lea[0]>64 && (int)lea[0]<71) {
	  caracter=(int)lea[0]-55;
	}
	if((int)lea[0]>=48 && (int)lea[0]<=57) {
	  caracter=(int)lea[0]-48;
	}
	caracter=caracter*16;
      }
      if(van==2) {
	if((int)lea[0]>96 && (int)lea[0]<=102) {
	  caracter=caracter+((int)lea[0]-87);
	}
	if((int)lea[0]>64 && (int)lea[0]<71) {
	  caracter=caracter+((int)lea[0]-55);
	}
	if((int)lea[0]>=48 && (int)lea[0]<=57) {
	  caracter=caracter+((int)lea[0]-48);
	}
	imprime=1;
	printf("%c", caracter);
      }
      van++;
    }
  }
  return  0;
}
