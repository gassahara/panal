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
  char patron[1024];
  (void)strncpy(patron, argv[1], sizeof(patron) - 1);
  patron[sizeof(patron) - 1] = '\0';

  //patron=argv[1];
  printf("<HTML><BODY>");
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if(lea[0] == patron[m]) {
      m++;
    } else {
      while(m>=0) {
	if(m>=0) {
	  if(lea[0] != patron[m]) {
	    m--;
	  } else {
	    break;
	  }
	}
      }
      if(m<0) m=0;
    } 
   
    if(m==strlen(patron)) {
      cadena=1;
      m=0;
      name=0;
      fclose(fd);
    }

    if(cadena==1) {
      if(lea[0]!='\r' && lea[0]!='\n') {
	cabecera[bien]=lea[0];
	bien++;
	fin=0;
      } else {
	if(fin==0 && lea[0]=='\r') fin=1;
	if(fin==1 && lea[0]=='\n') fin=2;
	if(fin==2 && lea[0]=='\r') fin=3;
	if(fin==3 && lea[0]=='\n') fin=4;
      }
      if(fin==4) {
	fin=0;
	if (strlen(filename)>1) name=3;
	bien=0;
      }
      if (bien > 5 && name<1) {
	if (memcmp(cabecera+(bien-6), "name=\"", 6)==0) {
	  name=1;
	}
      }
      if(name==4) {
	printf("%c", lea[0]);
	size++;
      }

      if(name==3) {
	free(cabecera);
	cabecera=calloc(1025, sizeof(char));
	memset(cabecera, 0, leei);
	name++;
      }
      if(name==2) {
	if(lea[0]==34) {
	  printf("</td></tr><table id=\"%s\"><tr><td>%s</td><td>", filename, filename);
	  fn=0;
	  name=0;
	} else {
	  filename[fn]=lea[0];
	  filename[fn+1]=0;
	  fn++;
	  if(fn==fni-1) {
	    free(temporal);
	    temporal=calloc(fni, sizeof(char));
	    memcpy(temporal, filename, fni);
	    free(filename);
	    cabecera=calloc(fni+256, sizeof(char));
	    memcpy(filename, temporal, fni);
	    fni+=256;
	  }
	}
      }
      if(name==1) name++;
    }
    if(bien>=leei) {
      free(temporal);
      temporal=calloc(leei, sizeof(char));
      memcpy(temporal, cabecera, leei);
      free(cabecera);
      cabecera=calloc(leei+1024, sizeof(char));
      memcpy(cabecera, temporal, leei);
      leei+=1024;
    }
  }
    printf("</BODY></HTML>");
  free(lee);
  lee=calloc(1024, sizeof(char));
  return  0;
}
