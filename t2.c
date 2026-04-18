#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>  

int main(int argc, char *argv[]) {
  errno=0;
  FILE *y=fopen("noexiste","r");
  printf("%02d %04d ", errno, y);
  errno=0;
  FILE *x=fopen("test1.c","r");
  printf("%02d %04d ", errno, fileno(x));
  return  0;
}
