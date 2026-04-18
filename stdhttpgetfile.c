#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>


int main(int argc, char *argv[]) {
  char lea[2];
  char *temporal, *lee, *tipo;
  int filo, leei, lee2;
  struct stat statinfo;
  tipo=calloc(5,sizeof(char));
  temporal=calloc(20,sizeof(char));
  memset(temporal, 0, sizeof(temporal));
  lee=calloc(1025, sizeof(char));
  leei=1025;
  lee=calloc(1025, sizeof(char));
  leei=1025;
  memset(lee, 0, leei);
  lee2=0;
  bzero(lea, 2);
  bzero(tipo, 5);
  filo=0;
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if(lea[0]=='&' || lea[0]=='?' || lea[0]==' ' || lea[0] == '\r' || lea[0]=='\n' ) {
      if(filo<2) {
	if(!strcmp(lee+strlen(lee)-4, ".jpg")) {
	  sprintf(tipo, "jpeg");
	}
	if(!strcmp(lee+strlen(lee)-4, ".png")) {
	  sprintf(tipo, "jpeg");
	}
	if (tipo[0]!=0) {
	  if(lee[0]=='/')  filo=open(lee+1, O_RDONLY);
	  else filo=open(lee, O_RDONLY);
	  if(filo>0) {
	    fstat(filo, &statinfo);
	    printf("HTTP/1.1 200 OK\nContent-Length: $i\nContent-Type: image/%s; \r\n\r\n", statinfo.st_size, tipo);
	    while(read(filo, lea, 1)>0) printf(lea);
	    close(filo);
	  }
	  filo=99;

	}
	break;
      }
      lee[lee2]=lea[0];
      if(lea[0]=='\r' || lea[0]=='\n') {
	free(lee);
	lee=calloc(1025, sizeof(char));
	leei=1025;
	free(temporal);
	temporal=calloc(leei, sizeof(char));
      }
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
    free(lee);
    lee=calloc(1024, sizeof(char));
    return  0;
  }
}
