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
  int m=0;
  int i=0;
  int j=0;
  int bien=-3;
  char palabra[1024];
  char lea[2];
  char prev=0;
  bzero(palabra, 1024);

  while(fread(lea, 1, 1, stdin)>0) {
    if (bien<1 && lea[0]=='&' && bien!=-3) {
      bien=-2;
    }
    if (lea[0]=='<' ) {
      bien=1;
    }
    if (bien>0) {
      palabra[bien-1]=lea[0];
      palabra[bien]=0;
      bien++;
    } else {
      if(bien==0) {
	if(lea[0]==' ') i++;
	else i=0;
	if(lea[0] !='\n' && lea[0] !='\t' && lea[0] !='\r' && i<2 ) {
	  printf("%c", lea[0]);prev=lea[0];
	  
	}
      }
    }
    if (bien==-2 && lea[0]==';') {
      bien=0;
    }
    if (lea[0]=='>' && bien) {
      if(j>0) bien=0;
      if (!strcmp(palabra,"<tr>") && j) {
	printf("\n");
	m=0;
      }
      if (!strncmp(palabra,"<tr ", 4) && j) {
	printf("\n");
	m=0;
      }
      if (!strcmp(palabra,"<td>") && m>0) printf(";");
      if (!strncmp(palabra,"<td ", 4)&&m>0) printf(";");
      if (!strcmp(palabra,"</table>") && bien !=-1 ) bien=-1;
      if (!strcmp(palabra,"<table>") ) {bien=0;j=1;}
      if (!strncmp(palabra,"<table ", 7)) {bien=0;j=1;}
    }
  }   
  return  0;
}
