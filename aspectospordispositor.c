#include <stdio.h>
#include <stdlib.h>
#include <math.h>
char dispositor[12][2][12]={{{'S','O','L', 0}, {'N','E','P','T','U','N','O',0} },{{'L','U','N','A',0}, {'V','E','N','U','S',0} },{{'M','E','R','C','U','R','I','O',0}, {'U','R','A','N','O',0} }, {{'V','E','N','U','S',0}, {'N','E','P','T','U','N','O',0} },{{'M','A','R','T','E',0}, {'N','E','P','T','U','N','O',0} },{{'J','U','P','I','T','E','R',0}, {'J','U','P','I','T','E','R',0} },{{'S','A','T','U','R','N','O',0}, {'P','L','U','T','O','N'} },{{'U','R','A','N','O',0}, {'J','U','P','I','T','E','R',0} },{{'N','E','P','T','U','N','O',0}, {'J','U','P','I','T','E','R',0} },{{'P','L','U','T','O','N'}, {'V','E','N','U','S'} }};
char ascencional_planets[14][2][10]={{{'S','O','L',0}, {'P','L','U','T','O',0}},{{'L','U','N','A',0}, {'N','E','P','T','U','N','O',0}},{{'L','U','N','A',0}, {'P','L','U','T','O',0}},{{'M','E','R','C','U','R','I','O',0}, {'N','E','P','T','U','N','O',0}},{{'V','E','N','U','S',0}, {'M','A','R','T','E',0}},{{'V','E','N','U','S',0}, {'U','R','A','N','O',0}},{{'M','A','R','T','E',0}, {'U','R','A','N','O',0}},{{'J','U','P','I','T','E','R',0}, {'M','E','R','C','U','R','I','O',0}},{{'S','A','T','U','R','N','O',0}, {'M','E','R','C','U','R','I','O',0}},{{'S','A','T','U','R','N','O',0}, {'V','E','N','U','S',0}},{{'U','R','A','N','O',0}, {'M','A','R','T','E',0}},{{'N','E','P','T','U','N','O',0}, {'M','E','R','C','U','R','I','O',0}},{{'N','E','P','T','U','N','O',0}, {'J','U','P','I','T','E','R',0}},{{'N','E','P','T','U','N','O',0}, {'S','A','T','U','R','N','O',0}}};
char ecliptico_planets[14][2][10]={{{'S','O','L',0}, {'M','A','R','T','E',0}},{{'S','O','L',0}, {'U','R','A','N','O',0}},{{'L','U','N','A',0}, {'U','R','A','N','O',0}},{{'L','U','N','A',0}, {'P','L','U','T','O','N',0}},{{'M','E','R','C','U','R','I','O',0}, {'N','E','P','T','U','N','O',0}},{{'V','E','N','U','S',0}, {'N','E','P','T','U','N','O',0}},{{'V','E','N','U','S',0}, {'P','L','U','T','O','N',0}},{{'M','A','R','T','E',0}, {'U','R','A','N','O',0}},{{'J','U','P','I','T','E','R',0}, {'V','E','N','U','S',0}},{{'S','A','T','U','R','N','O',0}, {'L','U','N','A',0}},{{'S','A','T','U','R','N','O',0}, {'V','E','N','U','S',0}},{{'U','R','A','N','O',0}, {'M','A','R','T','E',0}},{{'N','E','P','T','U','N','O',0}, {'V','E','N','U','S',0}},{{'N','E','P','T','U','N','O',0}, {'J','U','P','I','T','E','R',0}}};
char ascencional_aspects[8]={0,120,0,120,0,0,120,90};
char ecliptico_aspects[14]={60,60,90,90,120,180,120,0,90,120,90,0,180,90};
unsigned char i=0;
unsigned char j=0;
unsigned char k=0;
unsigned char n=0;
unsigned char o[sizeof(ecliptico_planets[0])/sizeof(ecliptico_planets[0][0])][2]; //contiene el par de indices en la lista dispositor de cada para de planetas en la lista de aspectos eclip
unsigned char l=0;
int main(int argc, char *argv[]) {
  char dispositores_aspectos[sizeof(ecliptico_aspects)*2];
  char dispositores_planets[sizeof(dispositores_aspectos)][2];
  char ecliptico_origen[sizeof(dispositores_aspectos)];
  i=0;
  while(i<sizeof(ecliptico_planets[0])/sizeof(ecliptico_planets[0][0])) {
    o[i][0]=0;
    o[i][1]=0;
    i++;
  }
  fprintf(stdout, "int main( int argc, char *argv[] ) {\n");
  i=0;
  while (i<sizeof(ecliptico_planets)/sizeof(ecliptico_planets[0])) {
    n=0;
    while (n<2) {
      j=0;
      while(j<sizeof(dispositor)/sizeof(dispositor[0])) {
	k=0;
	while(k<sizeof(dispositor[0][0]) && k<3) {
	  if(dispositor[j][0][k]!=ecliptico_planets[i][n][k]) break;
	  k++;
	}
	if(k==3) {
	  o[i][n]=j;
	  break;
	}
	j++;
      }
      n++;
    }
    i++;
  }
  i=0;
  while (i<sizeof(ecliptico_planets)/sizeof(ecliptico_planets[0])) {  
    k=0;
    //                                B                  disp de      A     disp
    while(k<sizeof(ecliptico_planets[i][1]) && k<sizeof(dispositor[o[i][0]][1]) && k<3) {
      //                      B           es el disp de A
      if(ecliptico_planets[i][1][k]!=dispositor[ o[i][0] ][1][k]) break;
      k++;
    }
    if(k==3) {
      dispositores_aspectos[l]=0;
      dispositores_planets[l][0]=o[i][0];
      dispositores_planets[l][1]=o[i][0];
      ecliptico_origen[l]=i;
      
      /////////////////////////////
      //      printf("    %d::    %s/%s (%d>) \n", l, ecliptico_planets[i][0],ecliptico_planets[i][1],j);
      
      l++;
    } else {
      j=0;
      while(j<sizeof(ascencional_planets)/sizeof(ascencional_planets[0])) {
	k=0;
	while(k<sizeof(ascencional_planets[j][0]) && k<sizeof(dispositor[o[i][0]][1]) && k<3) {
	  if(ascencional_planets[j][0][k]!=dispositor[o[i][0]][1][k]) break;
	  k++;
	}
	if(k==3) {
	  n=0;
	  while(n<sizeof(dispositor)/sizeof(dispositor[0])) {
	    k=0;
	    while(k<sizeof(dispositor[0][1]) && k<3) {
	      if(dispositor[n][1][k]!=ascencional_planets[j][1][k]) break;
	      k++;
	    }
	    if(k==3) {
	      ecliptico_origen[l]=i;
	      dispositores_aspectos[l]=ascencional_aspects[j];
	      dispositores_planets[l][0]=o[i][0];
	      dispositores_planets[l][1]=n;

	      //////////////////////////////////////////////////
	      //	      printf("    %d:  %s/%s (%d,>, %d - %d ) \n", l, ecliptico_planets[i][0],ecliptico_planets[i][1],j, ascencional_aspects[j], dispositores_aspectos[l]);
	      
	      l++;
	      n=254;
	      j=254;
	    }
	    n++;
	  }
	}
	if(j<254) {
	  k=0;
	  while(k<sizeof(ascencional_planets[j][1]) && k<sizeof(dispositor[o[i][0]][1]) && k<3) {
	    if(ascencional_planets[j][1][k]!=dispositor[o[i][0]][1][k]) break;
	    k++;
	  }
	  if(k==3) {
	    n=0;
	    while(n<sizeof(dispositor)/sizeof(dispositor[0])) {
	      k=0;
	      while(k<sizeof(dispositor[0][1]) && k<3) {
		if(dispositor[n][1][k]!=ascencional_planets[j][0][k]) break;
		k++;
	      }
	      if(k==3) {
		ecliptico_origen[l]=i;
		dispositores_aspectos[l]=ascencional_aspects[j];
		dispositores_planets[l][0]=o[i][0];
		dispositores_planets[l][1]=n;

		//////////////////////////////////////////////////
		//	      printf("    %d:  %s/%s (%d:>. %d - %d ) \n", l, ecliptico_planets[i][0],ecliptico_planets[i][1],j, ascencional_aspects[j], dispositores_aspectos[l]);
	      
		l++;
		n=254;
		j=254;
	      }
	      n++;
	    }
	  }
	}
	j++;
      }
    }
    i++;
  }



  i=0;
  while (i<sizeof(ecliptico_planets)/sizeof(ecliptico_planets[0])) {  
    k=0;
    //                                A                  disp de      B     disp
    while(k<sizeof(ecliptico_planets[i][0]) && k<sizeof(dispositor[o[i][1]][1]) && k<3) {
      //                      A           es el disp de B
      if(ecliptico_planets[i][0][k]!=dispositor[ o[i][1] ][1][k]) break;
      k++;
    }
    if(k==3) {
      dispositores_aspectos[l]=0;
      dispositores_planets[l][0]=o[i][1];
      dispositores_planets[l][1]=o[i][1];
      ecliptico_origen[l]=i;
      
      /////////////////////////////
      //      printf("    %d::    %s/%s (%d|>_) \n", l, ecliptico_planets[i][0],ecliptico_planets[i][1],j);
      
      l++;
    } else {
      j=0;
      while(j<sizeof(ascencional_planets)/sizeof(ascencional_planets[0])) {
	k=0;
	while(k<sizeof(ascencional_planets[j][0]) && k<sizeof(dispositor[o[i][1]][1]) && k<3) {
	  if(ascencional_planets[j][0][k]!=dispositor[o[i][1]][1][k]) break;
	  k++;
	}
	if(k==3) {
	  n=0;
	  while(n<sizeof(dispositor)/sizeof(dispositor[0])) {
	    k=0;
	    while(k<sizeof(dispositor[1][1]) && k<3) {
	      if(dispositor[n][1][k]!=ascencional_planets[j][1][k]) break;
	      k++;
	    }
	    if(k==3) {
	      ecliptico_origen[l]=i;
	      dispositores_aspectos[l]=ascencional_aspects[j];
	      dispositores_planets[l][0]=o[i][1];
	      dispositores_planets[l][1]=n;

	      //////////////////////////////////////////////////
	      //	      printf("    %d:  %s/%s (%d.>. %d - %d ) \n", l, ecliptico_planets[i][0],ecliptico_planets[i][1],j, ascencional_aspects[j], dispositores_aspectos[l]);
	      
	      l++;
	      n=254;
	      j=254;
	    }
	    n++;
	  }
	}
	if(j<254) {
	  k=0;
	  while(k<sizeof(ascencional_planets[j][1]) && k<sizeof(dispositor[o[i][1]][1]) && k<3) {
	    if(ascencional_planets[j][1][k]!=dispositor[o[i][1]][1][k]) break;
	    k++;
	  }
	  if(k==3) {
	    n=0;
	    while(n<sizeof(dispositor)/sizeof(dispositor[0])) {
	      k=0;
	      while(k<sizeof(dispositor[0][1]) && k<3) {
		if(dispositor[n][1][k]!=ascencional_planets[j][1][k]) break;
		k++;
	      }
	      if(k==3) {
		ecliptico_origen[l]=i;
		dispositores_aspectos[l]=ascencional_aspects[j];
		dispositores_planets[l][0]=o[i][0];
		dispositores_planets[l][1]=n;

		//////////////////////////////////////////////////
		//	      printf("    %d:  %s/%s (%d_>- %d - %d ) \n", l, ecliptico_planets[i][0],ecliptico_planets[i][1],j, ascencional_aspects[j], dispositores_aspectos[l]);
	      
		l++;
		n=254;
		j=254;
	      }
	      n++;
	    }
	  }
	}
	j++;
      }
    }
    i++;
  }

  
  
  printf("char dispositores_aspects[%d]={", l);
  k=0;
  while(k<l) {
    printf("%d", dispositores_aspectos[k]);
    k++;
    if(k<l) printf(",");
  }
  printf("};\n");
  printf("char dispositores_planets[%d][2][10]={", l);
  k=0;
  while(k<l) {
    printf("{\"%s\", \"%s\"}", dispositor[dispositores_planets[k][0]][1], dispositor[dispositores_planets[k][1]][1]);
    k++;
    if(k<l) printf(",");
  }
  printf("};\n};");

  printf("char ecliptico_origen[%d][2][10]={", l);
  k=0;
  while(k<l) {
    printf("{\"%s\", \"%s\"}", ecliptico_planets[ ecliptico_origen[k]][0], ecliptico_planets[ ecliptico_origen[k]][1]);
    k++;
    if(k<l) printf(",");
  }
  printf("};\n};");
  return  0;
}
 
