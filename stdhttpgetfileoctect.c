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
  int leei, lee2;
  struct stat statinfo;
  FILE *filo;
  tipo=    calloc(5,sizeof(char));
  temporal=calloc(20,sizeof(char));
  lee=     calloc(1025, sizeof(char));
  leei=1025;
  leei=1025;
  memset(lee, 0, leei);
  memset(temporal, 0, 20);
  lee2=0;
  bzero(lea, 2);
  bzero(tipo, 5);
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if(lea[0]=='&' || lea[0]=='?' || lea[0] == '\r' || lea[0]=='\n' ) {
      if(lee[0]=='/')  {
	int l2=lee2+1;
	while(l2>0) {
	  lee[l2]=lee[l2-1];
	  l2--;
	}
	lee[0]='.';
      }
      filo=fopen(lee, "r");
      fprintf(stderr, "\n%s\n", lee);
      fflush(stderr);
      if(filo>0) {
	fstat(fileno(filo), &statinfo);
	printf("HTTP/1.1 200 OK\nContent-Length: %ld\nContent-Type: application/octet-stream; \r\n\r\n", (long)statinfo.st_size);
	while(fread( lea, 1, 1, filo)>0) fwrite(lea, 1, 1, stdout); //printf("%c", lea[0]);
	fclose(filo);
      } else printf("HTTP/1.1 404 OK\nContent-Length: 15\nContent-Type: text/plain; \r\n\r\nNO SE ENCUENTRA\n");
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
  lee=calloc(1024, sizeof(char));
  return  0;
}
