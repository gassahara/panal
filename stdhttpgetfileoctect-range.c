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
  int leei, lee2, p, n;
  double bites, hasta;
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
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if(lea[0]=='&' || lea[0]=='?'  || lea[0] == '\r' || lea[0]=='\n' ) {
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
	if(lee[0]=='/') memcpy(archivo, lee+1, lee2-1);
	else memcpy(archivo, lee, lee2);
	fclose(filo);
      }
      if(!memcmp(lee, "Range", 5)) {
	n=6;
	p=0;
	bites=0;
	while(lee[n]!='=' && n<lee2 ) n++;
	n++;
	if(lee[n]>15) {
	  while(lee[n+p]>47 && lee[n+p]<58) p++;
	  p--;
	    while(p>=0) {
	      bites+=(lee[n]-48)*pow(10, p);
	      n++;
	      p--;
	    }
	    while(lee[n]>15 && lee[n]!='-') n++;
	    while(lee[n]==' ') n++;
	    p=0;
	    while(lee[n+p]>47 && lee[n+p]<57) p++;
	    p--;
	    while(p>=0) {
	      hasta+=(lee[n]-48)*pow(10, p);
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
  filo=fopen(archivo, "r");
  if (filo>0 && bites) {
	  fstat(fileno(filo), &statinfo);
	  if(!hasta) hasta=(double)statinfo.st_size;
	  printf("HTTP/1.1 206 OK\nAccept-Ranges: bytes\nContent-Range: bytes %6.0f-%06.0f/%6.0f\nContent-Length: %6.0f\nContent-Type: application/octet-stream; \r\n\r\n", bites, hasta, (double)statinfo.st_size, (double)statinfo.st_size-bites);
	  fseek(filo, (long)bites, 0);
	  while(fread( lea, 1, 1, filo)>0) fwrite(lea, 1, 1, stdout); //printf("%c", lea[0]);
	  fclose(filo);
  } else {
    printf("HTTP/1.1 404 OK\nContent-Length: 15\nContent-Type: text/plain; \r\n\r\nNO SE ENCUENTRA\n");
    exit(0);
  }
  free(lee);
  lee=calloc(1024, sizeof(char));
  return  0;
}
