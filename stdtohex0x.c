#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {
  unsigned char lea[2]={0, 0};
  int lee;
  if(fread(lea, 1, 1, stdin)>0) printf("0x%02X", lea[0]);
  while(fread(lea, 1, 1, stdin)>0) {
    printf(",0x%02X", lea[0]);
  }
  return  0;
}
