#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

int main(int argc, char *argv[]) {
  char lea[2];
  char *temporal, *lee;
  int geto, geto2, leei, lee2;
  temporal=calloc(20,sizeof(char));
  lee=calloc(1025, sizeof(char));
  leei=1025;
  lee=calloc(1025, sizeof(char));
  leei=1025;
  memset(lee, 0, leei);
  memset(temporal, 0, 20);
  lee2=0;geto=0;geto2=0;
  bzero(lea, 2);
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    lee[lee2]=lea[0];
    if(lea[0]=='\r' || lea[0]=='\n') {
      if(!memcmp(lee, "Content-Type: ", 12)) {
	printf("%s", lee);
	break;
      }
      free(lee);
      lee=calloc(1025, sizeof(char));
      leei=1025;
      free(temporal);
      temporal=calloc(leei, sizeof(char));
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
  printf("\n");
  return  0;
}
