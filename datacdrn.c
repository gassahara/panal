#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

int main(int argc, char *argv[]) {
  char lea[2];
  long skip=1;
  lea[1]=0;
  FILE *fd=fopen("datas/posts", "r");
  (void) fseek(fd, skip, 0);
  while(read(fileno(fd), lea, 1)>0) {
    printf("%c", lea[0]);
  }
  fclose(fd);
  return  0;
}
