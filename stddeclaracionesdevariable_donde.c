#include <string.h>
#include <stdio.h>
#include <stdlib.h>

static const char types[238]=" signed char ;unsigned char ;char ;short int ;unsigned short int ;unsigned int ;unsigned long int ;long int ;long long int ;unsigned long long int ;int ;float ;double ;long double ;uint8_t ;uint16_t ;uint32_t ;enum ;union ;struct ;FILE ;";
static const char finde[1]=";";
static const char findf[2]="{}";
static const char ignores[12]="\";\';//;#;/*;";
static const char espacios[3]=" \t\n";
static const char cadena[1]={'"'};
int main(int argc,char *argv[]) {
  int i=0;
  int j=0;
  while(i<sizeof(types)) {
    if(types[i]==';') j++;
    i++;
  }
  int longitudes[j+1];
  int aciertos[j];  
  i=0;
  while(i<j) {
    aciertos[i]=0;
    i++;
  }
  i=0;
  j=0;
  longitudes[0]=0;
  while(i<sizeof(types)) {
    if(types[i]==';') {
      longitudes[j]=i;
      j++;
    }
    i++;
  }
  j=0;
  int k=0; //indicador de imprimir
  int l=1; //indicador de nuevalinea 1=linea nueva con caracteres a ignorar 2=linea sin caracteres a ignorar
  unsigned char m=0; //indicador de comentario 1-3 o comillas 4-7 parentesis 8-10 presencia de funcion 11-13 presencia de array 14-15 presencia de igual
  int n=0; //indice del stream
  char lea[2];
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    //comparacion de comentarios
    n++;
    if( m==0 && lea[0]=='/') m=1;
    if(m==1) {
      if(lea[0]=='/') {
	while(fread(lea, sizeof(char), 1, stdin)>0) {
	  n++;
	  if(lea[0]=='\n') break;
	}
	m=0;
      }
      if(m==1 && lea[0]=='*') {
	while(fread(lea, sizeof(char), 1, stdin)>0) {
	  n++;
	  if(m==3) {
	    if(lea[0]=='/') {
	      m=0;
	      break;
	    } else m=2;
	  }
	  if(lea[0]=='*') m=3;
	}
      }
      m=0;
    }
    //si estamos al inicio de la linea (l=1) y no estamos imprimiendo (!k)
    if(l==1 && !k) {
      i=0;
      l=2;
      while(i<sizeof(espacios)) {
	if(lea[0]==espacios[i]) l=1;
	i++;
      }
      i=0;
      while(i<sizeof(ignores)) {
	if(lea[0]==ignores[i]) l=3;
	i++;
      }
    }

    //si hemos encontrado el inicio de parentesis estamos en presencia de funcion, el final de la linea se encuentra en findf
    if(m==8) {
      i=0;
      while(i<sizeof(findf)) {
	if(lea[0]==findf[i]) {
	  i=0;
	  while(i<sizeof(aciertos)/sizeof(int)) {
	    aciertos[i]=0;
	    i++;
	  }
	  if(k) printf("%d>", n);
	  l=1;
	  k=0;
	  m=0;
	  break;
	}
	i++;
      }
      continue;
    }

    //comparacion de caracteres de fin de linea (finde)
    i=0;
    while(i<sizeof(finde) && (m==0 || m==13) ) {
      if(lea[0]==finde[i]) {
	i=0;
	while(i<sizeof(aciertos)/sizeof(int)) {
	  aciertos[i]=0;
	  i++;
	}
	if(k) printf("%d>", n);
	l=1;
	k=0;
	m=0;
	break;
      }
      i++;
    }    

    //si estamos en presencia de cadena (m=4 se asigna al encontrar el caracter de cadena
    if(m==4) {
      if(lea[0]=='\\') {
	fread(lea, sizeof(char), 1, stdin);
	n++;
      }
    }

    //revisar la presencia del indicador de cadena
    i=0;
    while(i<sizeof(cadena)) {
      if(lea[0]==cadena[i]) {
	//m=4 cadena iniciada, termina la cadena
	if(m==4) {
	  m=0;
	  continue;
	}
	//en presencia del caracter de cadena si m=0, la cadena no ha sido iniciada, iniciar
	if(m==0||m==13) m=4;
      }
      i++;
    }
    if((lea[0]=='[' || lea[0]=='=' ) && m<7) {
      m=11;
    }
    if(lea[0]==']' && m==11) {
      m=13;
    }
    if(lea[0]=='(' && m<7) {
      m=8;
      continue;
    }
    if(l==2) {
      i=0;
      j=0;
      while(!k && j< (sizeof(longitudes)/sizeof(int))-1) {
	if(aciertos[j]!=-1) {
	  if(lea[0] == types[longitudes[j]+1+aciertos[j]]) {
	    aciertos[j]=aciertos[j]+1;
	    if(aciertos[j]==longitudes[j+1]-1-longitudes[j]) {
	      printf("<%d:", n-(longitudes[j+1]-1-longitudes[j]));
	      k=1;
	      break;
	    }
	  } else aciertos[j]=-1;
	}
	j++;
      }
    }
  }
  return  0;
}
