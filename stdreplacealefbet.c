#include <string.h>
#include <stdio.h>
#include <stdlib.h>

static unsigned char separador=';';
static const unsigned char search[417]=";@A;@B;@G;@D;@H;@W;@Z;@J;@t;@Y;@K;@L;@M;@N;@c;@P;@s;@z;@Q;@R;@S;@T;@ ;<img src='ALEFBET/blank.png'></img><img src='ALEFBET/KOP.png'></img>;<img src='ALEFBET/blank.png'></img><img src='ALEFBET/MEM.png'></img>;<img src='ALEFBET/blank.png'></img><img src='ALEFBET/PE.png'></img>;<img src='ALEFBET/blank.png'></img><img src='ALEFBET/NUN.png'></img>;<img src='ALEFBET/blank.png'></img><img src='ALEFBET/TSADE.png'></img>;";
static unsigned int longitudes[29];
static unsigned int aciertos[29];
static const unsigned char prefix[1163]=";<img src='ALEFBET/ALEF.png'></img>;<img src='ALEFBET/bet.png'></img>;<img src='ALEFBET/gimmel.png'></img>;<img src='ALEFBET/DALET.png'></img>;<img src='ALEFBET/HE.png'></img>;<img src='ALEFBET/WAW.png'></img>;<img src='ALEFBET/ZAYIN.png'></img>;<img src='ALEFBET/HET.png'></img>;<img src='ALEFBET/THET.png'></img>;<img src='ALEFBET/YOD.png'></img>;<img src='ALEFBET/KOP.png'></img>;<img src='ALEFBET/LAMED.png'></img>;<img src='ALEFBET/MEM.png'></img>;<img src='ALEFBET/NUN.png'></img>;<img src='ALEFBET/AYIN.png'></img>;<img src='ALEFBET/PE.png'></img>;<img src='ALEFBET/SAMEQ.png'></img>;<img src='ALEFBET/TSADE.png'></img>;<img src='ALEFBET/QOP.png'></img>;<img src='ALEFBET/RESH.png'></img>;<img src='ALEFBET/SHIN.png'></img>;<img src='ALEFBET/TAU.png'></img>;<img src='ALEFBET/blank.png'></img>;<img src='ALEFBET/blank.png'> </img><img src='ALEFBET/KOP_F.png'></img>;<img src='ALEFBET/blank.png'> </img><img src='ALEFBET/MEM_F.png'></img>;<img src='ALEFBET/blank.png'> </img><img src='ALEFBET/PE_F.png'></img>;<img src='ALEFBET/blank.png'> </img><img src='ALEFBET/NUN_F.png'></img>;<img src='ALEFBET/blank.png'> </img><img src='ALEFBET/TSADE_F.png'></img>;";
static unsigned int longitudes_prefix[29];
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
	  while(i<longitudes_prefix[j+1]-longitudes[j] && prefix[longitudes_prefix[j]+i] != separador && aciertos[j]>0) {
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
