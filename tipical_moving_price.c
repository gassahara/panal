#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double highs[l3]={1};
double lows[l3]={1};
double closo[l3]={1};
int main(int argc, char *argv[]) {
  int i=0;
  printf("double TP={"
  while(i<sizeof(highs)/sizeof(double)) {
    printf("%08.8lf", (highs[i]+lows[i]+closo[i])/3);
    i++;
  }
  printf("};\n");
}

