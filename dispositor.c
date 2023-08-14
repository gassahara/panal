#include <stdio.h>
#include <stdlib.h>
#include <math.h>
char planeta[10][9]={ {'S','O','L', 0} , "LUNA" , "MERCURIO" , "VENUS" , "MARTE" , "JUPITER" , "SATURNO" , "URANO" , "NEPTUNO" , "PLUTON"};
double posiciones[10]={ 331.38917224, 59.60376831, 308.03252271, 357.17139813, 356.59594825, 249.03541258, 214.37901170, 248.89420821, 268.80238518, 209.41979584};
char domicilios[12][2][12]={ {"Aries", "MARTE"}, {"Tauro", "VENUS"}, {"Geminis", "MERCURIO"}, {"Cancer","LUNA"}, {"Leo","SOL"}, {"Virgo", "Mercurio"}, {"Libra","VENUS"}, {"Scorpio","PLUTON"}, {"Sagitario", "JUPITER"}, {"Capricornio", "SATURNO"}, {"Acuario","URANO"}, {"Piscis","NEPTUNO"} };
char n=0;
char t=0;
int main(int argc, char *argv[]) {
  fprintf(stdout, "int main( int argc, char *argv[] ) {\n");
  n=0;
  t=0;
  while(n<sizeof(planeta)/sizeof(planeta[0])) {
    planeta[n][sizeof(planeta[0])-1]=0;
    n++;
  }
  n=0;
  printf("\nchar dispositor[12][2][12]={");
  while(n<sizeof(planeta)/sizeof(planeta[0])) {
    printf("{\"%s\", \"%s\" }", planeta[n], domicilios[(int)(floor)(posiciones[n]/(30))][1]);
    n++;
    if(n<sizeof(planeta)/sizeof(planeta[0])) printf(",");
  }
  printf("};\n};");
  return  0;
}
