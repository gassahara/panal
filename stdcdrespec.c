#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <math.h>
#include <unistd.h>


int main(int argc, char *argv[]) {
  char lea[2],  archivo[1024];
  char *temporal, *lee, *patron;
  int leei, lee2, geto, p, n;
  temporal=calloc(20,sizeof(char));
  lee=calloc(1025, sizeof(char));
  patron=calloc(strlen(argv[1])+1, sizeof(char));
  leei=1025;
  memset(lee, 0, leei);
  memset(temporal, 0, 20);
  lee2=0;
  bzero(lea, 2);
  bzero(archivo, 1024);
  geto=0;
  int m=0;
  int i=0;
  (void)strncpy(patron, argv[1], strlen(argv[1]));
  patron[strlen(argv[1])] = '\0';
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if(geto == 1) {
      printf("%c", lea[0]);
      if (lea[0] == ' ' || lea[0] == '\t' || lea[0] == '\n' || lea[0] == '\r' || lea[0] == '"' || lea[0] == '\'' ) geto=0;
    }
    if(lea[0] == patron[m]) {
      m++;
    } else {
      while(m>=0) {
	if(m>=0) {
	  if(lea[0] != patron[m]) {
	    m--;
	  } else {
	    break;
	  }
	}
      }
      if(m<0) m=0;
    } 
   
    if(m==strlen(patron)) {
      geto=1;
    }
  }
  return  0;
}
