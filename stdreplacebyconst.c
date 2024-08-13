#include <string.h>
#include <stdio.h>
#include <stdlib.h>

static unsigned char separador=0;
static const unsigned char search[7]={0, 0x5c,'n',0,'/', '/',0};
static unsigned int longitudes[3];
static unsigned int aciertos[3];
static const unsigned char prefix[8]={0, ':', '@','_',0, '#', '$', 0};
static unsigned int longitudes_prefix[3];
unsigned char prev;
unsigned int aciertos_mayor=0;

int main(int argc,char *argv[]) {
  unsigned int i=0;
  unsigned int j=0;
  unsigned char k=1; //indicador de imprimir
  i=0;
  j=sizeof(aciertos);
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

  i=0;
  j=0;
  longitudes_prefix[0]=0;
  while(i<sizeof(prefix)) {
    if(prefix[i]==separador) {
      longitudes_prefix[j]=i;
      j++;
    }
    i++;
  }  

  j=0;
  unsigned char lea[2];
  prev=0;
  aciertos_mayor=0;
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    i=0;
    j=0;
    k=1;
    while(j< (sizeof(longitudes)/sizeof(int))) {
      if(lea[0] != search[longitudes[j]+1+aciertos[j]]) {
	aciertos[j]=0;
	i=j;
	while(i<sizeof(aciertos)/sizeof(int)) {
	  if(aciertos[i]>aciertos[aciertos_mayor]) {
	    aciertos_mayor=i;
	  }
	  i++;
	}
      }
      if(lea[0] == search[longitudes[j]+1+aciertos[j]]) {
	aciertos[j]=aciertos[j]+1;
	if(aciertos[j]>aciertos[aciertos_mayor]) {
	  aciertos_mayor=j;
	}
	k=0;
	if(aciertos[j]==longitudes[j+1]-1-longitudes[j]) {
	  i=1;
	  while(i<longitudes_prefix[j+1]-longitudes[j] && prefix[longitudes_prefix[j]+i] != separador) {
	    fwrite(prefix+longitudes_prefix[j]+i,1,1, stdout);
	    i++;
	  }
	  aciertos[j]=0;
	  k=2;
	  break;
	}
      }
      j=j+1;
    }
    if(k==1||k==0) {
      i=0;
      j=0;
      while(i<sizeof(aciertos)/sizeof(int)) {
	if(aciertos[i]!=0) {
	  j++;
	}
	i++;
      }
      if(aciertos[aciertos_mayor]<=prev) {
	i=0;
	while(i<prev) {
	  printf("%c", search[longitudes[aciertos_mayor]+1+i]);
	  i++;
	}
      }
    }
    prev=aciertos[aciertos_mayor];
    if(k!=2 && !j) printf("%c", lea[0]);
    if(k==2) k=3;
  }
  return  0;
}
