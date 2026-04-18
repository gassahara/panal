int main() { 
double  pH   = 5.800000;

double  temp_suelo   = 20.000000;

double  LUZ   = 12.000000;

double  HUMEDAD   = 55.000000;


int main() { /************* UDP CLIENT CODE *******************/
#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>

//disena el experto
void berenjena(double pH, double LUZ, double temp_suelo, double HUMEDAD) {
  if(pH >= 5.5) printf("POR PH NO ES");
  if(pH <= 7 && LUZ >= 10 && LUZ >= 10 && LUZ <= 12 && HUMEDAD >= 50 && HUMEDAD <= 60) printf("1");
  else printf("0");
}  berenjena( pH,  LUZ,  temp_suelo,  HUMEDAD) ; return 0; }
