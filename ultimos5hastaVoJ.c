#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <math.h>
#include <unistd.h>


int main(int argc, char *argv[]) {
  int m=0;
  int i=0;
  int j=0;
  char palabra[6];
  char lea[2];
  bzero(palabra, 6);
  bzero(lea, 2);

  while(fread(lea, 1, 1, stdin)>0) {
    if (lea[0]=='\n' || lea[0]=='\r') {
      bzero(palabra, 6);
      m=0;
      j=0;
    }
    if (lea[0]=='V' || lea[0]=='J') {
      j=1;
      printf("%s\n", palabra);
    }
    if(!j && (lea[0]!='\n' && lea[0]!='\r') ) {
      i=0;
      while(i<6) {
	palabra[i]=palabra[i+1];
	i++;
      }
      palabra[5]=lea[0];
    }
  }
  return  0;
}
