#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int ssize=32;
  char buffer[ssize];
  char buff[2];
  int ar=1;
  int rr=0;
  

  while(ar>0) {
    ar=fread(buff, sizeof(char), 1, stdin);
    if(ar<1) break;
    if(rr>=ssize-1) break;
    if(buff[0]=='.' || ( buff[0]>=0x30 && buff[0]<=0x46 && !(buff[0]>0x3A && buff[0]<0x41)) ) {
      buffer[rr]=buff[0];
      rr++;
    }
  }
  buffer[rr]=0;

  int y=4716;
  int v=3;
  int j=1401;
  int u=5;
  int m=2;
  int s=153;
  int n=12;
  int w=2;
  int r=4;
  int B=274277;
  int p=1461;
  int C=-38;

  double J=atof(buffer);
  double  f = J + j + (((4 * J + B) / 146097) * 3) / 4 + C;
  double e = r * f + v;
  double g = fmod(e, p) / r;
  double h = u * g + w;
  int D = (fmod(h, s)) / u + 1;
  int M = fmod(h / s + m, n) + 1;
  int Y = (e / p) - y + (n + m - M) / n;
  printf("%d/%d/%d\n", D, M, Y);
}
