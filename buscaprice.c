#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]) {
  int l3=1;
  double opentimes[l3]={1};
  double highs[l3]={1};
  double lows[l3]={1};
  double openo[l3]={1};
  double closeo[l3]={1};
  double price=0;
  double priceh=0;
  double priceporencimadecincoatras=0;
  double priceporencimadecincoadelante=0;
  double pricel=0;
  double pricepordebajodecincoadelante=0;
  double pricepordebajodecincoatras=0;
  double pivot=0;
  double resistance=0;
  double support=0;
  double resistanceatras=0;
  double supportatras=0;
  double resistanceadelante=0;
  double supportadelante=0;
  double pivotatras=0;
  double pivotadelante=0;
  long porencimadecincoatras=0;
  long pordebajodecincoatras=0;
  long porencimadecincoadelante=0;
  long pordebajodecincoadelante=0;
  double timestart=0;
  int i=1;
  int j=0;
  int k=0;
  pricel=price-(price*0.05);
  priceh=price+(price*0.05);
  while(i<l3) {
    if(opentimes[i]>=timestart) break;
    i++;
  }
  k=i;
  j=i;
  while(j<sizeof(opentimes)/sizeof(double)) {
    if (porencimadecincoadelante>0 && pordebajodecincoadelante>0) break;
    if (porencimadecincoadelante<(double)1 && highs[j]>=priceh) {
      porencimadecincoadelante=(long)(opentimes[j]/1000);
      priceporencimadecincoadelante=highs[j];
    }
    if (pordebajodecincoadelante<(double)1 && lows[j]<=pricel) {
      pordebajodecincoadelante=(long)(opentimes[j]/1000);
      pricepordebajodecincoadelante=lows[j];
    }
    j++;
  }
  j=i;
  while(j<sizeof(opentimes)/sizeof(double)) {
    pivot=(openo[j]+closeo[j]+closeo[j]+highs[j]+lows[j])/5;
    resistance=(2*pivot)-lows[j];
    if(resistance>resistanceadelante)resistanceadelante=resistance; 
    support=(2*pivot)-lows[j];
    if(support>supportadelante)supportadelante=support; 
    j++;
  }
  while(k>0) {
    pivot=(openo[i]+closeo[i]+closeo[i]+highs[i]+lows[i])/5;
    resistance=(2*pivot)-lows[i];
    if(resistance>resistanceatras)resistanceatras=resistance; 
    support=(2*pivot)-lows[i];
    if(support>supportatras)supportatras=support;     
    k=k-1;
  }
  while(i>0) {
    if (porencimadecincoatras>0 && pordebajodecincoatras>0) break;
    if (porencimadecincoatras<(double)1 && highs[i]>=priceh) {
      porencimadecincoatras=(long)(opentimes[i]/1000);
      priceporencimadecincoatras=highs[i];
    }
    if (pordebajodecincoatras<(double)1 && lows[i]<=pricel) {
      pordebajodecincoatras=(long)(opentimes[i]/1000);
      pricepordebajodecincoatras=lows[i];
    }
    i--;
  }
  printf("long porencimadecincoadelante=%08ld;\n double priceporencimadecincoadelante=%08lf;\n", porencimadecincoadelante, priceporencimadecincoadelante);
  printf("long pordebajodecincoadelante=%08ld;\n double pricepordebajodecincoadelante=%08lf;\n", pordebajodecincoadelante, pricepordebajodecincoadelante);
  printf("long porencimadecincoatras=%08ld;\n double priceporencimadecincoatras=%08lf;\n", porencimadecincoatras, priceporencimadecincoatras);
  printf("long pordebajodecincoatras=%08ld;\n double pricepordebajodecincoatras=%08lf;\n", pordebajodecincoatras, pricepordebajodecincoatras);
  printf("double supportatras=%08lf;\n double supportadelante=%08lf;\n", supportatras, supportadelante);
  printf("double resistanceatras=%08lf;\n double resistanceadelante=%08lf;\n", resistanceatras, resistanceadelante);
}
