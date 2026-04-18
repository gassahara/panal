#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {
  char lea[2]={0, 0};
  int lee;
  while(fread(lea, 1, 1, stdin)>0) {
  if ((int)lea[0]< 0) {
    lee=(int)lea[0]+256;
    printf("%02X ", lee);
  } else {
    lee=lea[0];
    printf("%02X ", lee);
  }
  }
  return  0;
}
