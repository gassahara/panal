#include <string.h>
#include <stdio.h>
#include <stdlib.h>

static unsigned char separador=0;
static const unsigned char search[7]={0, 0x5c,'n',0,'/', '/',0};
static unsigned int longitudes[3];
static unsigned int aciertos[3];

int main(int argc,char *argv[]) {
  unsigned int i=0;
  unsigned int j=0;
  unsigned long l=0;
  unsigned char k=1; //indicador de imprimir
  i=0;
  j=sizeof(aciertos)/sizeof(int);
  while(i<j) {
    aciertos[i]=0;
    i++;
  }

  i=0;
  j=0;
  longitudes[0]=0;
  while(i<sizeof(search)) {
    if(search[i]==separador) {
      longitudes[j]=i;
      j++;
    }
    i++;
  }

  j=0;
  unsigned char lea[2];
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    i=0;
    j=0;
    k=1;
    while(j< (sizeof(longitudes)/sizeof(int))) {
      if(lea[0] != search[longitudes[j]+1+aciertos[j]]) {
	aciertos[j]=0;
      }
      if(lea[0] == search[longitudes[j]+1+aciertos[j]]) {
	aciertos[j]=aciertos[j]+1;
	k=0;
	if(aciertos[j]==longitudes[j+1]-1-longitudes[j]) {
	  k=2;
	  if(l>aciertos[j]) {
	    printf("%ld", l-aciertos[j]);
	  } else printf("0");
	  break;
	}
      }
      j=j+1;
    }
    if(k==2) {
      break;
    }
    l=l+1;
  }
  return  0;
}
