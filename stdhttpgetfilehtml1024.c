#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>


int main(int argc, char *argv[]) {
  char lea[1024];
  char *temporal, *lee, *tipo;
  int leei, lee2;
  FILE *filo;
  struct stat statinfo;
  tipo=calloc(5,sizeof(char));
  temporal=calloc(20,sizeof(char));
  lee=calloc(1025, sizeof(char));
  leei=1025;
  memset(lee, 0, leei);
  memset(temporal, 0, 20);
  lee2=0;
  bzero(lea, 2);
  bzero(tipo, 5);
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if(lea[0]=='&' || lea[0]=='?' || lea[0]==' ' || lea[0] == '\r' || lea[0]=='\n' ) {
      if(!strcmp(lee+strlen(lee)-4, ".htm")) {
	sprintf(tipo, "html");
      }
      if(!strcmp(lee+strlen(lee)-5, ".html")) {
	sprintf(tipo, "html");
      }
      if(!strcmp(lee+strlen(lee)-4, ".css")) {
	sprintf(tipo, "html");
      }
      if(!strcmp(lee+strlen(lee)-3, ".js")) {
	sprintf(tipo, "plain");
      }
      if (tipo[0]!=0) {
	if(lee[0]=='/')  {
	  int l2=lee2+1;
	  while(l2>0) {
	    lee[l2]=lee[l2-1];
	    l2--;
	  }
	  lee[0]='.';
	}
	filo=fopen(lee, "r");
	if(filo>0) {
	  fstat(fileno(filo), &statinfo);
	  printf("HTTP/1.1 200 OK\nContent-Length: %i\nContent-Type: text/%s; \r\n\r\n", (int)statinfo.st_size, tipo);
	  while(fread(lea, 1, 1, filo)>0) fwrite(lea, 1, 1, stdout); //printf(lea);
	  fclose(filo);
	} else 	  printf("HTTP/1.1 404 OK\nContent-Length: 15\nContent-Type: text/plain; \r\n\r\nNO SE ENCUENTRA\n");
      }
    }
    lee[lee2]=lea[0];
    if(lea[0]=='\r' || lea[0]=='\n') {
      free(lee);
      lee=calloc(1025, sizeof(char));
      leei=1025;
      free(temporal);
      temporal=calloc(20, sizeof(char));
      memset(lee, 0, 1025);
      memset(temporal, 0, 20);
      lee2=-1;
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
  free(temporal);
  return  0;
}
