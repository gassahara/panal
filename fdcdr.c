#include <string.h>
#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {
  char lea[2];
  char *lee, *patron;
  int leei, lee2, geto, p, n;

  lee=calloc(1025, sizeof(char));
  patron=calloc(strlen(argv[1])+1, sizeof(char));
  leei=1025;
  memset(lee, 0, leei);
  lee2=0;
  bzero(lea, 2);
  geto=0;
  int m=0;
  int i=0;
  bzero(patron, sizeof(patron));
  (void)memcpy(patron, argv[1], strlen(argv[1]) );
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if(geto == 1) printf("%c", lea[0]);
    if(lea[0] == patron[m]) {
      m++;
    } else {
      while(m>=0) {
	m--;
	if(lea[0] == patron[m] && m>=0) {
	  break;
	}
      }
      m++;
      if(m<0) m=0;
    } 
   
    if(m==strlen(patron)) {
      geto=1;
    }
  }
  return  0;
}
