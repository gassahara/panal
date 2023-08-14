#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <math.h>
#include <unistd.h>


int main(int argc, char *argv[]) {
  int m=0;
  int i=0;
  int j=0;
  int bien=-3;
  char palabra[1024];
  char lea[2];
  char prev=1;
  bzero(palabra, 1024);

  while(fread(lea, 1, 1, stdin)>0) {
    if(j==3) j=1;
    if(j==1 && lea[0]!='\n' && lea[0]!='\t' && lea[0]!='\r' && lea[0]!=' ' ) {
      if(prev==' ') {
	printf(" ");
      }
      printf("%c", lea[0]);
    } else {
      if(!j){
	palabra[bien-1]=lea[0];
	palabra[bien]=0;
	bien++;
      }
    }
    if(j && lea[0]==' ' && (prev==' ' || prev=='\n' || prev=='\r'  || prev=='\t' ) ) {
      j=3;
      prev=0;
    }
    if (lea[0]=='\n' || lea[0]=='\r') {
      bien=1;
      if(j==1) {
	printf("\";");
	j=0;
      }
      if (strstr(palabra,"Nombre(s)") ) {
	printf("\n");
	printf("nombre=\"");
	j=1;
      }
      if (strstr(palabra,"Apellido(s)") ) {
	printf("apellido=\"");
	j=1;
      }
      if (strstr(palabra,"Forma de Pago") ) {
	printf("forma_de_pago=\"");
	j=1;
      }
      if (strstr(palabra,"Fecha de Pago") ) {
	printf("fecha_de_pago=\"");
	j=1;
      }
      if (strstr(palabra,"Monto del Pago") ) {
	printf("monto_de_pago=\"");
	j=1;
      }
      if (strstr(palabra,"Banco Emisor") ) {
	printf("banco_emisor=\"");
	j=1;
      }
      if (strstr(palabra,"Banco Receptor") ) {
	printf("banco_receptor=\"");
	j=1;
      }
      if (strstr(palabra,"Transacc")) {
	printf("nro_transaccion=\"");
	j=1;
      }
      if (strstr(palabra,"/RIF")) {
	printf("cedula=\"");
	j=1;
      }
      //      printf(">>%d %s \n", j, palabra);
      //bzero(palabra, 1024);
    bzero(palabra, 1024);
    }
    if(j!=3) prev=lea[0];
  }
  if(j) printf("\";\n");
  return  0;
}
