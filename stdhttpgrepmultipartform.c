#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <math.h>


int main(int argc, char *argv[]) {
  char lea[2], archivo[1024];
  char *temporal, *lee;
  int leei, lee2, geto, p, n;
  double bites;
  struct stat statinfo;
  FILE *filo;
  temporal=calloc(20,sizeof(char));
  lee=     calloc(1025, sizeof(char));
  leei=1025;
  memset(lee, 0, leei);
  memset(temporal, 0, 20);
  lee2=0;
  bzero(lea, 2);
  bzero(archivo, 1024);
  geto=0;
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if(geto<4) {
      printf("%c", lea[0]);
      if(lea[0] == '\r' || lea[0]=='\n' ) {
	if(lea[0] == '\r' ) {
	  if(geto==0 || geto==2){
	    geto++;
	  } else geto=0;
	}
	if(lea[0] == '\n') {
	  if(geto==1 || geto==3){
	    geto++;
	  } else geto=0;
	}
	if(!memcmp(lee, "Content-Length: ", 16)) {
	  n=16;
	  p=0;
	  bites=0;
	  while(lee[n]==' ' && n<lee2 ) n++;
	  if(lee[n]>15) {
	    while(lee[n+p]>47 && lee[n+p]<58) p++;
	    p--;
	    while(p>=0) {
	      bites+=(lee[n]-48)*pow(10, p);
	      n++;
	      p--;
	    }
	  }
	}
	free(lee);
	lee=calloc(1025, sizeof(char));
	leei=1025;
	free(temporal);
	temporal=calloc(20, sizeof(char));
	memset(lee, 0, 1025);
	memset(temporal, 0, 20);
	lee2=-1;
      } else geto=0;
    }
    else {
      if(bites>0) {
	if(geto>3){
	  fwrite(lea, 1, 1, stdout);
	  bites=bites-1;
	}
      }
    }
    lee[lee2]=lea[0];
    lee2+=1;
    while(lee2>leei-1) {
      free(temporal);
      temporal=calloc(leei, sizeof(char));
      memcpy(temporal, lee, leei);
      free(lee);
      lee=calloc(leei+1024, sizeof(char));
      memcpy(lee, temporal, leei);
      leei+=1024;
    }
  }
  if(bites>3) {
    sprintf(lee, "\nAun no %6.0f \n\n", bites);
    fwrite(lee, 1, 15, stderr);
    exit(1);
  }else{
    exit(0);
  }
  free(lee);
  lee=calloc(1024, sizeof(char));
  return  0;
}
