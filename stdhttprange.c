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
      free(lee);
      lee=calloc(1025, sizeof(char));
      leei=1025;
      free(temporal);
      temporal=calloc(leei, sizeof(char));
      geto=0;
      lee2=-1;
      if(geto) break;
    }
    if(lee2==13 && !geto) {
      if(!memcmp(lee, "Range: bytes", 12)) {
	geto=1;
	printf("Range: bytes=");
      }
      if(!memcmp(lee, "Range = bytes", 13)) {
	geto=1;
	printf("Range: bytes=");
      }
    }
    if(geto==1) {
      printf("%c", lea[0]);
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
