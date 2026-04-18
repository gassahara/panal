#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double highs[l3]={1};
double lows[l3]={1};
double S=0;
int main(int argc, char *argv[]) {
  int i=0;
  double media=0;
  while(i<sizeof(highs)/sizeof(double)) {
    media=media+((highs[i]+lows[i])/2);
    i++;
  }
  media=media/(i-1);
  i=0;
  while(i<sizeof(highs)/sizeof(double)) {
    S=S+(((highs[i]+lows[i])/2)-media)/(sizeof(highs)/sizeof(double));
    i++;
  }
  S=sqrt(S);
  printf("double standard_deviations=%08.8lf;\n", S);
}

