#include <string.h>
#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {
  char lea[2];
  char *lee, *patron;
  int leei, lee2, geto, p, n;

  lee=calloc(1025, sizeof(char));
  leei=1025;
  memset(lee, 0, leei);
  lee2=0;
  bzero(lea, 2);
  geto=0;
  int m=0;
  int llaves=0;
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    printf("%c", lea[0]);
    if(lea[0] == '{') {
      llaves++;
      m=1;
    }
    if(lea[0] == '}' && m==1) {
      llaves--;
      if(llaves==0) break;
    }
  }
  return  0;
}
