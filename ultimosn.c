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
  int cuanto=atoi(argv[1])-1;
  char palabra[cuanto];
  char lea[2];
  bzero(palabra, cuanto);
  bzero(lea, 2);

  while(fread(lea, 1, 1, stdin)>0) {
    if (lea[0]=='\n' || lea[0]=='\r') {
      printf("%s\n", palabra);
      bzero(palabra, cuanto);
      m=0;
    } else {
      i=0;
      while(i<cuanto) {
	palabra[i]=palabra[i+1];
	i++;
      }
      palabra[cuanto]=lea[0];
    }
  }
  return  0;
}
