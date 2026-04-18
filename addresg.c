#include <string.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
  char lea[2];
  int filo,lee2;
  lee2=0;
  memset(lea, 0, 2);
  filo=0;
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    
