#include <stdio.h>
#include <stdlib.h>

char planeta[10][9]={ {'S','O','L', 0} , "LUNA" , "MERCURIO" , "VENUS" , "MARTE" , "JUPITER" , "SATURNO" , "URANO" , "NEPTUNO" , "PLUTON"};
double posiciones[10]={ 331.38917224, 59.60376831, 308.03252271, 357.17139813, 356.59594825, 249.03541258, 214.37901170, 248.89420821, 268.80238518, 209.41979584};
char domicilios[12][10][2]={ {"Aries", "MARTE"}, {"Tauro", "VENUS"}, {"Geminis", "MERCURIO"}, {"Cancer","LUNA"}, {"Leo","SOL"}, {"Libra","VENUS"}, {"Scorpio","PLUTON"}, {"Sagitario", "JUPITER"}, {"Capricornio", "SATURNO"}, {"Acuario","URANO"}, {"Piscis","NEPTUNO"} };
char n=0;
char t=0;
int main(int argc, char *argv[]) {
  n=0;
  t=0;
  while(n<sizeof(planeta)/sizeof(planeta[0])) {
    planeta[n][sizeof(planeta[0])-1]=0;
    n++;
  }
  n=0;
  printf("\nchar domicilio[%d][2][12]={", sizeof(planeta)/sizeof(planeta[0]));
  while(n<sizeof(planeta)/sizeof(planeta[0])) {
    if ((planeta[n][0] == 'M' && planeta[n][1] == 'A' && planeta[n][2] == 'R' && planeta[n][3] == 'T') && posiciones[n] >=0 && posiciones[n] <=30) {if(t) printf(","); printf("{\"%s\", \"Domiciliado\"}", planeta[n]);t=1;}; //Aries
    if ((planeta[n][0] == 'V' && planeta[n][1] == 'E' && planeta[n][2] == 'N' && planeta[n][3] == 'U') && posiciones[n] >=0 && posiciones[n] <=30) { if(t) printf(","); printf("{\"%s\", \"Detrimento\"}", planeta[n]); t=1; }; //Aries
    if ((planeta[n][0] == 'S' && planeta[n][1]=='O' && planeta[n][2]=='L') && posiciones[n] >=0 && posiciones[n] <=30) { if(t) printf(","); printf("{\"%s\", \"Exaltado\"}", planeta[n]); t=1; } //Aries
    if ((planeta[n][0] == 'S' && planeta[n][1] == 'A' && planeta[n][2] == 'T' && planeta[n][3] == 'U') && posiciones[n] >=0 && posiciones[n] <=30) { if(t) printf(","); printf("{\"%s\", \"Caida\"}", planeta[n]); t=1; } //Aries
    if ((planeta[n][0] == 'V' && planeta[n][1] == 'E' && planeta[n][2] == 'N' && planeta[n][3] == 'U') && posiciones[n] >=30 && posiciones[n] <=60) {if(t) printf(","); printf("{\"%s\", \"Domiciliado\"}", planeta[n]);t=1;}; //Tauro
    if ((planeta[n][0] == 'P' && planeta[n][1] == 'L' && planeta[n][2] == 'U' && planeta[n][3] == 'T') && posiciones[n] >=30 && posiciones[n] <=60) { if(t) printf(","); printf("{\"%s\", \"Detrimento\"}", planeta[n]); t=1; }; //Tauro
    if ((planeta[n][0] == 'L' && planeta[n][1]=='U' && planeta[n][2]=='N' && planeta[n][3] == 'A') && posiciones[n] >=30 && posiciones[n] <=60) { if(t) printf(","); printf("{\"%s\", \"Exaltado\"}", planeta[n]); t=1; } //Tauro
    if ((planeta[n][0] == 'M' && planeta[n][1] == 'A' && planeta[n][2] == 'R' && planeta[n][3] == 'T') && posiciones[n] >=30 && posiciones[n] <=60) { if(t) printf(","); printf("{\"%s\", \"Caida\"}", planeta[n]); t=1; } //Tauro
    if ((planeta[n][0] == 'M' && planeta[n][1]=='E' && planeta[n][2]=='R' && planeta[n][3] == 'C' )  && posiciones[n] >=60 && posiciones[n] <=90) {if(t) printf(","); printf("{\"%s\", \"Domiciliado\"}", planeta[n]);t=1;}; //Gemini
    if ((planeta[n][0] == 'J' && planeta[n][1] == 'U' && planeta[n][2] == 'P' && planeta[n][3] == 'I')  && posiciones[n] >=60 && posiciones[n] <=90) { if(t) printf(","); printf("{\"%s\", \"Detrimento\"}", planeta[n]); t=1; }; //Gemini
    if (planeta[n] == "Nor"  && posiciones[n] >=60 && posiciones[n] <=90) { if(t) printf(","); printf("{\"%s\", \"Exaltado\"}", planeta[n]); t=1; } //Gemini
    if (planeta[n] == "Sur"  && posiciones[n] >=60 && posiciones[n] <=90) { if(t) printf(","); printf("{\"%s\", \"Caida\"}", planeta[n]); t=1; } //Gemini
    if ((planeta[n][0] == 'L' && planeta[n][1]=='U' && planeta[n][2]=='N' && planeta[n][3] == 'A')  && posiciones[n] >=90 && posiciones[n] <=120) {if(t) printf(","); printf("{\"%s\", \"Domiciliado\"}", planeta[n]);t=1;}; //cancer
    if ((planeta[n][0] == 'S' && planeta[n][1] == 'A' && planeta[n][2] == 'T' && planeta[n][3] == 'U')  && posiciones[n] >=90 && posiciones[n] <=120) { if(t) printf(","); printf("{\"%s\", \"Detrimento\"}", planeta[n]); t=1; }; //cancer
    if ( ((planeta[n][0] == 'J' && planeta[n][1] == 'U' && planeta[n][2] == 'P' && planeta[n][3] == 'I') || planeta[n]== "NEPTUNO")  && posiciones[n] >=90 && posiciones[n] <=120) { if(t) printf(","); printf("{\"%s\", \"Exaltado\"}", planeta[n]); t=1; } //cancer
    if (planeta[n] == "Caida"  && posiciones[n] >=90 && posiciones[n] <=120) { if(t) printf(","); printf("{\"%s\", \"Caida\"}", planeta[n]); t=1; } //cancer
    if ((planeta[n][0] == 'S' && planeta[n][1]=='O' && planeta[n][2]=='L')  && posiciones[n] >=120 && posiciones[n] <=150) {if(t) printf(","); printf("{\"%s\", \"Domiciliado\"}", planeta[n]);t=1;}; //leo
    if ((planeta[n][0] == 'U' && planeta[n][1] == 'R' && planeta[n][2] == 'A' && planeta[n][3] == 'N')  && posiciones[n] >=120 && posiciones[n] <=150) { if(t) printf(","); printf("{\"%s\", \"Detrimento\"}", planeta[n]); t=1; }; //leo
    if ((planeta[n][0] == 'P' && planeta[n][1] == 'L' && planeta[n][2] == 'U' && planeta[n][3] == 'T')  && posiciones[n] >=120 && posiciones[n] <=150) { if(t) printf(","); printf("{\"%s\", \"Exaltado\"}", planeta[n]); t=1; } //leo
    if ((planeta[n][0] == 'M' && planeta[n][1]=='E' && planeta[n][2]=='R' && planeta[n][3] == 'C' )  && posiciones[n] >=120 && posiciones[n] <=150) { if(t) printf(","); printf("{\"%s\", \"Caida\"}", planeta[n]); t=1; } //leo
    if ((planeta[n][0] == 'N' && planeta[n][1] == 'E' && planeta[n][2] == 'P' && planeta[n][3] == 'T')  && posiciones[n] >=150 && posiciones[n] <=180) { if(t) printf(","); printf("{\"%s\", \"Detrimento\"}", planeta[n]); t=1; }; //Virgo
    if ((planeta[n][0] == 'M' && planeta[n][1]=='E' && planeta[n][2]=='R' && planeta[n][3] == 'C' )  && posiciones[n] >=150 && posiciones[n] <=180) { if(t) printf(","); printf("{\"%s\", \"Exaltado\"}", planeta[n]); t=1; } //Virgo
    if ((planeta[n][0] == 'V' && planeta[n][1] == 'E' && planeta[n][2] == 'N' && planeta[n][3] == 'U')  && posiciones[n] >=150 && posiciones[n] <=180) { if(t) printf(","); printf("{\"%s\", \"Caida\"}", planeta[n]); t=1; } //Virgo
    if ((planeta[n][0] == 'V' && planeta[n][1] == 'E' && planeta[n][2] == 'N' && planeta[n][3] == 'U')  && posiciones[n] >=180 && posiciones[n] <=210) {if(t) printf(","); printf("{\"%s\", \"Domiciliado\"}", planeta[n]);t=1;}; //Libra
    if ((planeta[n][0] == 'M' && planeta[n][1] == 'A' && planeta[n][2] == 'R' && planeta[n][3] == 'T')  && posiciones[n] >=180 && posiciones[n] <=210) { if(t) printf(","); printf("{\"%s\", \"Detrimento\"}", planeta[n]); t=1; }; //Libra
    if ((planeta[n][0] == 'S' && planeta[n][1] == 'A' && planeta[n][2] == 'T' && planeta[n][3] == 'U')  && posiciones[n] >=180 && posiciones[n] <=210) { if(t) printf(","); printf("{\"%s\", \"Exaltado\"}", planeta[n]); t=1; } //Libra
    if ((planeta[n][0] == 'S' && planeta[n][1]=='O' && planeta[n][2]=='L')  && posiciones[n] >=180 && posiciones[n] <=210) { if(t) printf(","); printf("{\"%s\", \"Caida\"}", planeta[n]); t=1; } //Libra
    if ((planeta[n][0] == 'P' && planeta[n][1] == 'L' && planeta[n][2] == 'U' && planeta[n][3] == 'T')  && posiciones[n] >=210 && posiciones[n] <=240) {if(t) printf(","); printf("{\"%s\", \"Domiciliado\"}", planeta[n]);t=1;}; //Scorpio
    if ((planeta[n][0] == 'V' && planeta[n][1] == 'E' && planeta[n][2] == 'N' && planeta[n][3] == 'U')  && posiciones[n] >=210 && posiciones[n] <=240) { if(t) printf(","); printf("{\"%s\", \"Detrimento\"}", planeta[n]); t=1; }; //Scorpio
    if ((planeta[n][0] == 'U' && planeta[n][1] == 'R' && planeta[n][2] == 'A' && planeta[n][3] == 'N')  && posiciones[n] >=210 && posiciones[n] <=240) { if(t) printf(","); printf("{\"%s\", \"Exaltado\"}", planeta[n]); t=1; } //Scorpio
    if ((planeta[n][0] == 'L' && planeta[n][1]=='U' && planeta[n][2]=='N' && planeta[n][3] == 'A')  && posiciones[n] >=210 && posiciones[n] <=240) { if(t) printf(","); printf("{\"%s\", \"Caida\"}", planeta[n]); t=1; } //Scorpio
    if ((planeta[n][0] == 'J' && planeta[n][1] == 'U' && planeta[n][2] == 'P' && planeta[n][3] == 'I')  && posiciones[n] >=240 && posiciones[n] <=270) {if(t) printf(","); printf("{\"%s\", \"Domiciliado\"}", planeta[n]);t=1;}; //Sagitario
    if (planeta[n] == "Sur"  && posiciones[n] >=240 && posiciones[n] <=270) { if(t) printf(","); printf("{\"%s\", \"Exaltado\"}", planeta[n]); t=1; } //Sagitario
    if ((planeta[n][0] == 'M' && planeta[n][1]=='E' && planeta[n][2]=='R' && planeta[n][3] == 'C' )  && posiciones[n] >=240 && posiciones[n] <=270) { if(t) printf(","); printf("{\"%s\", \"Detrimento\"}", planeta[n]); t=1; }; //Sagitario
    if (planeta[n] == "Nor"  && posiciones[n] >=240 && posiciones[n] <=270) { if(t) printf(","); printf("{\"%s\", \"Caida\"}", planeta[n]); t=1; } //Sagitario
    if ((planeta[n][0] == 'S' && planeta[n][1] == 'A' && planeta[n][2] == 'T' && planeta[n][3] == 'U')  && posiciones[n] >=270 && posiciones[n] <=300) {if(t) printf(","); printf("{\"%s\", \"Domiciliado\"}", planeta[n]);t=1;}; //Capricornio
    if ((planeta[n][0] == 'L' && planeta[n][1]=='U' && planeta[n][2]=='N' && planeta[n][3] == 'A')  && posiciones[n] >=270 && posiciones[n] <=300) { if(t) printf(","); printf("{\"%s\", \"Detrimento\"}", planeta[n]); t=1; }; //Capricornio
    if ((planeta[n][0] == 'M' && planeta[n][1] == 'A' && planeta[n][2] == 'R' && planeta[n][3] == 'T')  && posiciones[n] >=270 && posiciones[n] <=300) { if(t) printf(","); printf("{\"%s\", \"Exaltado\"}", planeta[n]); t=1; } //Capricornio
    if ( ((planeta[n][0] == 'J' && planeta[n][1] == 'U' && planeta[n][2] == 'P' && planeta[n][3] == 'I') || (planeta[n][0] == 'N' && planeta[n][1] == 'E' && planeta[n][2] == 'P' && planeta[n][3] == 'T'))  && posiciones[n] >=270 && posiciones[n] <=300) { if(t) printf(","); printf("{\"%s\", \"Caida\"}", planeta[n]); t=1; } //Capricornio
    if ( (planeta[n][0] == 'U' && planeta[n][1] == 'R' && planeta[n][2] == 'A' && planeta[n][3] == 'N') && posiciones[n] >=300 && posiciones[n] <=330) {if(t) printf(","); printf("{\"%s\", \"Domiciliado\"}", planeta[n]);t=1;}; //Acuario
    if ( (planeta[n][0] == 'S' && planeta[n][1]=='O' && planeta[n][2]=='L') && posiciones[n] >=300 && posiciones[n] <=330) { if(t) printf(","); printf("{\"%s\", \"Detrimento\"}", planeta[n]); t=1; }; //Acuario
    if ( (planeta[n][0] == 'M' && planeta[n][1]=='E' && planeta[n][2]=='R' && planeta[n][3] == 'C' ) && posiciones[n] >=300 && posiciones[n] <=330) { if(t) printf(","); printf("{\"%s\", \"Exaltado\"}", planeta[n]); t=1; } //Acuario
    if ( (planeta[n][0] == 'P' && planeta[n][1] == 'L' && planeta[n][2] == 'U' && planeta[n][3] == 'T') && posiciones[n] >=300 && posiciones[n] <=330) { if(t) printf(","); printf("{\"%s\", \"Caida\"}", planeta[n]); t=1; } //Acuario
    if ( (planeta[n][0] == 'N' && planeta[n][1] == 'E' && planeta[n][2] == 'P' && planeta[n][3] == 'T') && posiciones[n] >=330 && posiciones[n] <=360) {if(t) printf(","); printf("{\"%s\", \"Domiciliado\"}", planeta[n]);t=1;}; //Piscis
    if ( (planeta[n][0] == 'M' && planeta[n][1]=='E' && planeta[n][2]=='R' && planeta[n][3] == 'C' ) && posiciones[n] >=330 && posiciones[n] <=360) { if(t) printf(","); printf("{\"%s\", \"Detrimento\"}", planeta[n]); t=1; }; //Piscis
    if ( (planeta[n][0] == 'V' && planeta[n][1] == 'E' && planeta[n][2] == 'N' && planeta[n][3] == 'U') && posiciones[n] >=330 && posiciones[n] <=360) { if(t) printf(","); printf("{\"%s\", \"Exaltado\"}", planeta[n]); t=1; } //Piscis
    if ( (planeta[n][0] == 'M' && planeta[n][1]=='E' && planeta[n][2]=='R' && planeta[n][3] == 'C' ) && posiciones[n] >=330 && posiciones[n] <=360) { if(t) printf(","); printf("{\"%s\", \"Caida\"}", planeta[n]); t=1; } //Piscis
    n++;
  }
  printf("};\n");
  return  0;
}
