#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>

//disena el experto
int berenjena(double suelo, double pH, double LUZ, double temp_suelo, double HUMEDAD) {
  if(pH >= 5.5) printf("POR PH NO ES");
  if(pH <= 7 && LUZ >= 10 && LUZ >= 10 && LUZ <= 12 && HUMEDAD >= 50 && HUMEDAD <= 60) printf("1");
  else printf("0");
  suelo=suelo*suelo;
  suelo=(suelo/1.5)*suelo;
  return suelo;
}

void main() {
//de la lista de recursos
  double LUZ=23;
  double temp_suelo=300;
  double pH=5;
  double HUMEDAD = 100; 
  double suelo=100; //Cantidad de suelo disponible en m2
//del diseno del modelo
  berenjena(suelo, pH, LUZ, temp_suelo, HUMEDAD);
}
