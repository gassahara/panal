#include <stdio.h>
#include <math.h>

int main( int argc, char *argv[] ) {
  double radius=450;
  double grados=0;
  double grados2=10;
  char mensaje[15]="30g_Pi_30'_40''";
  mensaje[15]=0;
  double a=(M_PI * 2)/360;
  while(grados<360) {
    grados+=10;
    grados2=grados;
    if(grados2>90) {
      while(grados2>90 && grados<270) grados2-=90;
      if(grados<=180) grados2=90-grados2;
      else grados2=grados2-(grados2*2);
    } else {
      grados2=grados2-(grados2*2);
    }
    double x=ceil(radius * sin(a*(grados+270)));
    double y=ceil(radius * cos(a*(grados+270)));
    printf(" \\( -gravity center -background none caption:\"%s\"   -geometry +%04.f+%04.f  -rotate %02.f \\) -compose over -composite ", mensaje, round(x), round(y), grados2);
  }
}
