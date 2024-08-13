#include <string.h>
#include <stdio.h>
#include <stdlib.h>

//static const unsigned char types[148]=";static const unsigned int ;static const int ;static unsigned int ;const unsigned int ;unsigned int ;int ;";
static const unsigned        char       types[148]=";static const unsigned char ;static const char ;static unsigned char ;const unsigned char ;unsigned char ;char ;";
static const unsigned char finde[1]=";";
static const unsigned char asignacion[1]="=";
static const unsigned char findf[2]={'{', '}' };
static const unsigned char ignores[3][2][2]={ {{'/', '*'},{'*', '/'}}, {{'/', '/'},{'\n', 0}}, {{'#',0}, {'\n', 0}}};
static const unsigned char espacios[3]=" \t\n";
static const unsigned char cadena[2]={'"', 27/*'*/};
static const unsigned char prefix[8]={'p','r','e','f','i','x','_',0};
int main(int argc,char *argv[]) {
  unsigned char ignoresm[sizeof(ignores)/sizeof(ignores[0])+1];
  int i=0;
  int j=0;
  int counter=0;
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
  unsigned char k=0; //indicador de imprimir
  unsigned char l=1; //indicador de nuevalinea 1=linea nueva con caracteres a ignorar 2=linea sin caracteres a ignorar
  unsigned char m=0; //indicador de comentario 1-3 o comillas 4-7 parentesis 8-10 presencia de funcion 11-13 presencia de array 14-15 presencia de igual
  int n=0;
  int o=0; //indicador de indice del array de tipos q se esta imprimiendo
  char lea[2];
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    //si estamos al inicio de la linea (l=1) y no estamos imprimiendo (!k)
    if(l==1 && !k) {
      i=0;
      l=2;
      while(i<sizeof(espacios)) {
	if(lea[0]==espacios[i]) l=1;
	i++;
      }
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
	  fread(lea, sizeof(char), 1, stdin);
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
	      fread(lea, sizeof(char), 1, stdin);
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
    if(m==8||m==0) {
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
	      k=1;
	      printf("%s", prefix);
	      break;
	    }
	  } else aciertos[j]=-1;
	}
	j++;
      }
    }
    n++;
  }
  return  0;
}
