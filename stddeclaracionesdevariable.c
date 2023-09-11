#include <string.h>
#include <stdio.h>
#include <stdlib.h>

//static const unsigned char types[148]=";char ;signed ;unsigned ;static ;const ;short int ;short ;int ;long ;float ;double ;uint8_t ;uint16_t ;uint32_t ;enum ;union ;struct ;FILE ;time_t ;";
//static const unsigned char types[668]=";static const unsigned int ;static const int ;static unsigned int ;const unsigned int ;unsigned int ;int ;static const unsigned char ;static const char ;static unsigned char ;const unsigned char ;unsigned char ;char ;static const unsigned double ;static const double ;static unsigned double ;const unsigned double ;unsigned double ;double ;static const unsigned long;static const unsigned long ;static const long ;static unsigned long ;const unsigned long ;unsigned long ;long ;static const unsigned float ;static const float ;float ;int ;static const unsigned time_t ;static const time_t ;static unsigned time_t ;const unsigned time_t ;unsigned time_t ;time_t ;FILE ;";
static const unsigned char types[2317]=";char ;signed char ;unsigned char ;short ;short int ;signed short ;signed short int ;unsigned short ;unsigned short int ;int ;signed ;signed int ;unsigned int ;long ;long int ;signed long ;signed long int ;unsigned long ;unsigned long int ;long long ;long long int ;signed long long ;signed long long int ;unsigned long long ;unsigned long long int ;float ;double ;long double ;static char ;static signed char ;static unsigned char ;static short ;static short int ;static signed short ;static signed short int ;static unsigned short ;static unsigned short int ;static int ;static signed ;static signed int ;static unsigned int ;static long ;static long int ;static signed long ;static signed long int ;static unsigned long ;static unsigned long int ;static long long ;static long long int ;static signed long long ;static signed long long int ;static unsigned long long ;static unsigned long long int ;static float ;static double ;static long double ;const char ;const signed char ;const unsigned char ;const short ;const short int ;const signed short ;const signed short int ;const unsigned short ;const unsigned short int ;const int ;const signed ;const signed int ;const unsigned int ;const long ;const long int ;const signed long ;const signed long int ;const unsigned long ;const unsigned long int ;const long long ;const long long int ;const signed long long ;const signed long long int ;const unsigned long long ;const unsigned long long int ;const float ;const double ;const long double ;static const char ;static const signed char ;static const unsigned char ;static const short ;static const short int ;static const signed short ;static const signed short int ;static const unsigned short ;static const unsigned short int ;static const int ;static const signed ;static const signed int ;static const unsigned int ;static const long ;static const long int ;static const signed long ;static const signed long int ;static const unsigned long ;static const unsigned long int ;static const long long ;static const long long int ;static const signed long long ;static const signed long long int ;static const unsigned long long ;static const unsigned long long int ;static const float ;static const double ;static const long double ;time_t ;FILE ;";
static const unsigned char finde[1]=";";
static const unsigned char asignacion[1]="=";
static const unsigned char findf[2]={'{', '}' };
static const unsigned char ignores[3][2][2]={ {{'/', '*'},{'*', '/'}}, {{'/', '/'},{'\n', 0}}, {{'#',0}, {'\n', 0}}};
static const unsigned char espacios[3]={' ','\t','\n'};
static const unsigned char cadena[2]={'"', 27/*'*/};
static const unsigned char prefix[8]={'p','r','e','f','i','x','_',0};
unsigned char prev;
int main(int argc,char *argv[]) {
  unsigned char ignoresm[sizeof(ignores)/sizeof(ignores[0])+1];
  int i=0;
  int j=0;
  int counter=0;
  while(i<sizeof(types)) {
    if(types[i]==';') j++;
    i++;
  }
  int longitudes[116];
  int aciertos[116];

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
  unsigned char k=0; //indicador de imprimir
  unsigned char l=1; //indicador de nuevalinea 1=linea nueva con caracteres a ignorar 2=linea sin caracteres a ignorar
  unsigned char m=0; //indicador de comentario 1-3 o comillas 4-7 parentesis 8-10 presencia de funcion 11-13 presencia de array 14-15 presencia de igual 18 poner prefijo
  int n=0;
  int o=0; //indicador de indice del array de tipos q se esta imprimiendo
  char lea[2];
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    //si estamos al inicio de la linea (l=1) y no estamos imprimiendo (!k)
    if(l==1 && !k) {
  i=0;
  while(i<(sizeof(aciertos)/sizeof(int))) {
    aciertos[i]=0;
    i++;
  }

  i=0;
      l=2;
      while(i<sizeof(espacios)) {
	if(lea[0]==espacios[i]) {
	  l=1;
	}
	i++;
      }
    }


    if(l>1 && !k ) {
      i=0;
      while(i<sizeof(espacios)) {
	while(lea[0]==espacios[i] && prev==lea[0]) {
	  if(fread(lea, sizeof(char), 1, stdin)<0) {
	    break;
	  }
	}
	i++;
      }
    }


    if(k && m==0) {
      i=0;
      while(i<sizeof(espacios)) {
	if(lea[0]==espacios[i]) printf("%c", lea[0]);
	while(lea[0]==espacios[i]) {
	  if(fread(lea, sizeof(char), 1, stdin)<0) break;
	}
	i++;
      }
      m=0;
    }
    if(!m) {
      i=0;
      j=0;
      while(i<sizeof(ignoresm)-1) {
	counter=0;
	while(counter<sizeof(ignoresm)) {
	  ignoresm[counter]=0;
	  counter++;
	}
	counter=0;
	while(counter < sizeof(ignores[i][0])) {
	  if(lea[0]==ignores[i][j][counter]) {
	    ignoresm[counter]=lea[0];
	    counter++;
	    if(counter< sizeof(ignores[i][0]) && ignores[i][0][counter]==0) counter=sizeof(ignores[i][0]);
	  } else {
	    i++;
	    if(i>=sizeof(ignoresm)-1) {
	      break;
	    }
	    continue;
	  }
	      if(fread(lea, sizeof(char), 1, stdin)<1) {
		fflush(stdout);
		exit(0);
	      }
	  if(!j && counter==sizeof(ignores[i][0])) {	    
	    j=1;
	    counter=0;
	    while(counter < sizeof(ignores[i][0])) {
	      if(lea[0]==ignores[i][j][counter]) {
		counter++;
		if(ignores[i][j][counter]==0 || counter==sizeof(ignores[i][0]) ) {
		  counter=254;
		  i=254;
		  break;
		}
	      } else {
		counter=0;
	      }
	      if(fread(lea, sizeof(char), 1, stdin)<1) {
		fflush(stdout);
		exit(0);
	      }
	    }
	  }
	}
      	if(!counter) i++;
      }
      if(counter==254) {
	l=1;
	counter=0;
	continue;
      }
    }

    //si hemos encontrado el inicio de parentesis estamos en presencia de funcion, el final de la linea se encuentra en findf
    if(m==8) {
      i=0;
      counter=0;
      while(i<sizeof(findf)) {
	if(lea[0]==findf[i]) {
	  if(m==8) {
	    if(k) printf(";\n");
	    k=0;
	    l=1;
	    m=0;
	    break;
	  }
	  if(k) printf("%c\n", lea[0]);
	  i=0;
	  while(i<sizeof(aciertos)/sizeof(int)) {
	    aciertos[i]=0;
	    i++;
	  }
	  counter=1;
	  l=1;
	  m=0;
	  break;
	}
	i++;
      }
      if(counter||m) continue;
    }


    //comparacion de caracteres de fin de linea (finde)
    i=0;
    while(i<sizeof(finde) && (m==0 || m==13 || m==11) ) {
      if(lea[0]==finde[i]) {
	if(k) printf("%c\n", lea[0]);
	i=0;
	while(i<sizeof(aciertos)/sizeof(int)) {
	  aciertos[i]=0;
	  i++;
	}
	l=1;
	k=0;
	m=0;
	break;
      }
      i++;
    }    

    //revisar la presencia del indicador de cadena
    i=0;
    while(i<sizeof(cadena)) {
      if(lea[0]==cadena[i]) {
	//m=4 cadena iniciada, termina la cadena
	if(m==4) {
	  m=0;
	  i++;
	  continue;
	}
	//en presencia del caracter de cadena si m=0, la cadena no ha sido iniciada, iniciar
	if(m==0||m==13) {
	  m=4;
	}
      }
      i++;
    }
    if((lea[0]=='[' || lea[0]=='=' ) && m<7 && m!= 4) {
      m=11;
    }
    if(lea[0]==']' && m==11 && m!=4) {
      m=13;
    }
    if(lea[0]=='(' && m<7 && m!=4) {
      m=8;
      continue;
    }
    if(m==18 && k) {

	      prev=lea[0];
	      i=0;
	      while(i<sizeof(espacios)) {
		while(lea[0]==espacios[i]) {
		  if(fread(lea, sizeof(char), 1, stdin)<0) break;
		}
		i++;
	      }
	      if(lea[0]!=prev) printf("%c", lea[0]);

      if(lea[0]!='*')  {
	fwrite(prefix,1,sizeof(prefix), stdout);
	m=0;
      }
    }
    if(k) printf("%c", lea[0]);
    if(l==2) {
      i=0;
      j=0;
      while(!k && j< (sizeof(longitudes)/sizeof(int))-1) {
	if(aciertos[j]!=-1) {
	  if(lea[0] == types[longitudes[j]+1+aciertos[j]]) {
	    aciertos[j]=aciertos[j]+1;
	    if(aciertos[j]==longitudes[j+1]-1-longitudes[j]) {
	      o=j;
	      i=longitudes[j]+1;
	      while(i<longitudes[j+1]) {
		printf("%c", types[i]);
		i++;
	      }
	      m=18;
	      k=1;
	      break;
	    }
	  } else aciertos[j]=-1;
	}
	j=j+1;
      }
    }
    n++;
    prev=lea[0];
  }
  fflush(stdout);
  return 0;
}
