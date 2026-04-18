#include <stdio.h>
int main(int argc, char *argv[]) {
  int D=25;
  int M=7;
  int Y=1963;
  double H=04;
  double N=56;
  double S=0;

  double JDN = (1461 * (Y + 4800 + (M - 14)/12))/4 +(367 * (M - 2 - 12 * ((M - 14)/12)))/12 - (3 * ((Y + 4900 + (M - 14)/12)/100))/4 + D - 32075;
  JDN+=H/24;
  JDN+=(N/60)/24;
  JDN+=(S/60)/60/24;
  JDN-=0.5;
  printf("%08.8f", JDN);
}
