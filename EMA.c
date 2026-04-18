#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double periodo=200.00;
double k=0.000;
int l3=1;
double highs[l3]={1};
double lows[l3]={1};
double closo[l3]={1};
double EMA=0;
int main(int argc, char *argv[]) {
  k=(double)2/(periodo+1);
  int i=0;
  EMA=((((highs[i]+lows[i]+closo[i])/3)-EMA)*k)+EMA;
  printf("double EMAi[%ld]={%08.6f", sizeof(highs)/sizeof(double)+1, EMA);
  while(i<sizeof(highs)/sizeof(double)) {
    EMA=((((highs[i]+lows[i]+closo[i])/3)-EMA)*k)+EMA;
    printf(",%08.6f", EMA);
    i++;
  }
  printf("};\n");
}

