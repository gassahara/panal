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
  char lea[2], archivo[1024];
  int leb;
  char *temporal, *lee, *cabecera, *filename;
  int leei, lee2, geto, p, n;
  double bites;
  struct stat statinfo;
  FILE *fd;
  temporal=calloc(20,sizeof(char));
  lee=calloc(1025, sizeof(char));
  cabecera=calloc(1025, sizeof(char));
  filename=calloc(256, sizeof(char));
  leei=1025;
  memset(lee, 0, leei);
  memset(temporal, 0, 20);
  memset(cabecera, 0, leei);
  lee2=0;
  bzero(lea, 2);
  bzero(archivo, 1024);
  geto=0;
  int m=0;
  int i=0;
  int bien=0;
  int cadena=0;
  int name=0;
  int fn=0;
  int fni=255;
  int fin=0;
  off_t size;
  char palabra[1024];
  bzero(palabra, 1024);
  int crlf=0;


  while(fread(lea, 1, 1, stdin)>0) {
      if((int)lea[0]==0xffffffc3) {
	fread(lea, 1, 1, stdin);
	if((int)lea[0]>0xffffff7f && (int)lea[0]<0xffffff87 )lea[0]='A';
	if((int)lea[0]>0xffffff87 && (int)lea[0]<0xffffff8c )lea[0]='E';
	if((int)lea[0]>0xffffff8b && (int)lea[0]<0xffffff90 )lea[0]='I';
	if((int)lea[0]>0xffffff91 && (int)lea[0]<0xffffff97 )lea[0]='O';
	if((int)lea[0]>0xffffff98 && (int)lea[0]<0xffffff9d )lea[0]='U';

	if((int)lea[0]>0xffffff9f && (int)lea[0]<0xffffffa7 )lea[0]='a';
	if((int)lea[0]>0xffffffa7 && (int)lea[0]<0xffffffac )lea[0]='e';
	if((int)lea[0]>0xffffffac && (int)lea[0]<0xffffffb0 )lea[0]='i';
	if((int)lea[0]>0xffffffb1 && (int)lea[0]<0xffffffb7 )lea[0]='o';
	if((int)lea[0]>0xffffffb8 && (int)lea[0]<0xffffffbd )lea[0]='u';
      }
    if( (lea[0] > 0x2f && lea[0] < 0x3a) || (lea[0] > 0x40 && lea[0] < 0x5b) || (lea[0] > 0x60 && lea[0] < 0x7b)  ) {
      printf("%c", lea[0]);
      crlf=0;
    } else {
      if(crlf==0) printf("\n");
      crlf=1;
    } 
  }   
  free(lee);
  lee=calloc(1024, sizeof(char));
  return  0;
}
