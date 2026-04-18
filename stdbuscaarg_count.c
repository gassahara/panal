#include <string.h>
#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {
  int lon=0;
  int k=0;
  int cadena=0;
  if(argc<2) exit(1);
  while ( argv[1][k]!=0 )k++;
  lon=k;

  k=0;
  char patron[lon];
  while (k<lon ) {
    patron[k]=argv[1][k];
    k++;
  }
  patron[k]=0;

  char lea[2];
  int m=0;
  int i=0;
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    i++;
    m++;
    if(lea[0] != patron[m]) {
      while(m>0 && lea[0] != patron[m-1]) m--;
      //      if(m>0) fprintf(stderr, "m=%d ", m);
      if(m<0) m=0;
    }

    if(m==lon) {
      m=0;
      cadena++;
    }
  }
  printf("%d", cadena);
  return  0;
}
