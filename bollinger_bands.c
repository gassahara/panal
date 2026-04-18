#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int l3=2;
double periodo=20.00;
double k=0.000;
double highs[l3]={1};
double lows[l3]={1};
double closo[l3]={1};
double EMA[l3];
double standard_deviations=2;
double standard_deviation[l3];
double media[l3];
int main(int argc, char *argv[]) {
  int i=1;
  media[0]=((highs[i]+lows[i]+closo[i])/3);
  while(i<sizeof(highs)/sizeof(double)) {
    media[i]=(media[i-1]+((highs[i]+lows[i]+closo[i])/3))/(double)i;
    i++;
  }
  standard_deviation[0]=sqrt(abs((((highs[i]+lows[i]+closo[i])/3)-media[0]))/(double)i);
  i=1;
  printf("double sd[%ld]={0", sizeof(highs)/sizeof(double)+1);
  while(i<sizeof(highs)/sizeof(double)) {
    standard_deviation[i]=sqrt(abs(standard_deviation[i-1]+(((highs[i]+lows[i]+closo[i])/3)-media[i]))/(double)i);
    printf(",%08.8lf", standard_deviation[i]);
    i++;
  }
  printf("};\n");

  EMA[0]=((((highs[i]+lows[i]+closo[i])/3))*k);
  while(i<sizeof(highs)/sizeof(double)) {
    EMA[i]=((((highs[i]+lows[i]+closo[i])/3)-EMA[i-1])*k)+EMA[i-1];
    i++;
  }

  printf("double BOLU[%ld]={0", sizeof(EMA)/sizeof(double)+1);
  i=0;
  while(i<sizeof(EMA)/sizeof(double)) {
    printf(", %08.8lf", EMA[i]+(standard_deviations*standard_deviation[i]));
    i++;
  }
  printf("};\n");
  printf("double BOLD[%ld]={0", sizeof(EMA)/sizeof(double)+1);
  i=0;
  while(i<sizeof(EMA)/sizeof(double)) {
    printf(", %08.8lf", EMA[i]-(standard_deviations*standard_deviation[i]));
    i++;
  }
  printf("};\n");
}

