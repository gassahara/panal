#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>


int main(int argc, char *argv[]) {
  char lea[2];
  char *temporal, *lee, *tipo;
  int leei, lee2;
  struct stat statinfo;
  FILE *filo;
  tipo=    calloc(5,sizeof(char));
  temporal=calloc(20,sizeof(char));
  lee=     calloc(1025, sizeof(char));
  leei=1025;
  leei=1025;
  memset(lee, 0, leei);
  memset(temporal, 0, 20);
  lee2=0;
  bzero(lea, 2);
  bzero(tipo, 5);
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if(lea[0] == '\r' || lea[0]=='\n' ) {
	if(lee[0]=='/')  {
	  int g=lee2+1;
	  while(g>=0) {
	    lee[g]=lee[g-1];
	    g--;
	  }
	  lee[0]='.';
	  lee[lee2+1]=0;
	  filo=fopen(lee, "r");
	}
	else filo=fopen(lee, "r");
	if(filo>0) {
	  fstat(fileno(filo), &statinfo);
	  printf("%lu", (long)statinfo.st_size);
	  fclose(filo);
	}
    }
    lee[lee2]=lea[0];
    if(lea[0]=='\r' || lea[0]=='\n') {
      free(lee);
      lee=calloc(1025, sizeof(char));
      leei=1025;
      free(temporal);
      temporal=calloc(20, sizeof(char));
      memset(lee, 0, 1025);
      memset(temporal, 0, 20);
      lee2=-1;
    }
    lee2+=1;
    while(lee2>leei-1) {
      free(temporal);
      temporal=calloc(leei, sizeof(char));
      memcpy(temporal, lee, leei);
      free(lee);
      lee=calloc(leei+1024, sizeof(char));
      memcpy(lee, temporal, leei);
      leei+=1024;
    }
  }
  free(lee);
  lee=calloc(1024, sizeof(char));
  return  0;
}
