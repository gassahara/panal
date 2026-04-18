#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  char lea[2];
  char *patron, *lee;
  int leei, lee2, geto, n;
  lee=calloc(strlen(argv[1])+2, sizeof(char));
  patron=calloc(strlen(argv[1])+2, sizeof(char));
  leei=1025;
  lee2=0;
  geto=0;
  int m=0;
  int i=1;
  int p=0;
  int o=0;
  int nn=strlen(argv[1]);
  bzero(lea, 2);
  bzero(lee, nn+1);
  (void)strncpy(patron, argv[1], strlen(argv[1]));
  patron[nn] = 0;
  m=0;
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if(lea[0] == patron[m]) {
      m++;
    } else {
      if(!p){
      i=0;
      while(i<m) {
	printf( "%c", patron[i]);
	i++;
      }
      printf( "%c", lea[0]);
      m=0;
      }
    }

    if(p==1 && (lea[0]==0x0a||lea[0]==0x0d)) {
      m=0;
      p=0;
    }
    if(m==nn) {
      p=1;
    }
  }
  return  0;
}
