#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]) {
  int l3=1;
  double opentimes[1]={1};
  double highs[1]={1};
  double lows[1]={1};
  double price=1.1;
  double priceh=1.1;
  double pricel=1.1;
  long porencimadecinco=0;
  long pordebajodecinco=0;
  int i=2;
  double ups=0;
  double downs=0;
  double upsa=0;
  double downsa=0;
  double promedio=0;
  double rs=0;
  double rsi=0;
  printf("double rsi[%d]={0", l3);
  priceh=(double)price+(price*0.05);
  pricel=(double)price-(price*0.05);
  while(i<l3) {
    promedio=(highs[i]+lows[i])/2;
    if( ((highs[i]+lows[i])/2-(highs[i-1]+lows[i-1])/2)>0) ups+=((highs[i]+lows[i])/2-(highs[i-1]+lows[i-1])/2);
    else {
      downs+=(highs[i-1]+lows[i-1])/2-(highs[i]+lows[i])/2;
      upsa=ups/i;
      downsa=downs/i;
    }
    if(downsa>0.0) {
      rs=upsa/downsa;
      rsi=100-(100/(1+rs));
    }
    printf(", %08lf", rsi);
    i++;
  }
  printf("};\n");
}
