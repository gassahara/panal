#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>


int main(int argc, char *argv[]) {
  char lea[2];
  FILE *filo;
  bzero(lea, 2);
  filo=fopen(argv[1], "w+");
  while(fread(lea, sizeof(char), 1, stdin)>0) {
	fwrite(lea, 1, 1, filo);
  }
  fclose(filo);
  return  0;
}
