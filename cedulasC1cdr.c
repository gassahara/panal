#include <string.h>
#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {
  char lea[2];
  char *lee, *patron;
  int leei, lee2, geto, p, n;
  FILE *fd=fopen("data/cedulas", "r");
  lee=calloc(1025, sizeof(char));
  patron=calloc(strlen(argv[1])+3, sizeof(char));
  leei=1025;
  memset(lee, 0, leei);
  lee2=0;
  bzero(lea, 2);
  geto=0;
  int m=1;
  int i=0;
  bzero(patron, sizeof(patron));
  (void)memcpy(patron+1, argv[1], strlen(argv[1]) );
  patron[strlen(argv[1])+1]='\n';
  patron[0]='\n';
  patron[strlen(argv[1])+2]=0;
  while(fread(lea, sizeof(char), 1, fd)>0) {
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
