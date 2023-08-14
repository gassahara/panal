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
  printf("- %s -", patron);
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    if(lea[0] == patron[m]) {
      printf("+++++++");
      m++;
    } else {
      while(m>=0) {
	if(m>=0) {
	  printf(">>%d <<  ", m);
	  if(lea[0] != patron[m]) {
	    m--;
	  } else {
	    printf("-------------------------");
	    break;
	  }
	}
      }
      if(m<0) m=0;
      printf("\nMM %d||", m);
      printf(" %d", lea[0]);
      printf("\n %d[%d]\n", patron[m],  m);
      printf("\n<%d>\n", m);
    } 
   
    if(m==strlen(patron)) {
      printf("***");
      cadena=1;
      m=0;
      name=0;
      fclose(fd);
    }

    if(cadena==1) {
      if(lea[0]!='\r' && lea[0]!='\n') {
	printf(">>>>");
	cabecera[bien]=lea[0];
	printf("< %s : %d::%d;\n", cabecera, bien, fin);
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
	printf("&&&&");
	if (memcmp(cabecera+(bien-6), "name=\"", 6)==0) {
	  name=1;
	  printf("#$#$");
	}
	printf("()()");
      }
      if(name==4) {
	fwrite(lea, 1, 1, fd);
	size++;
	printf("%s, -%c_\n", filename, lea[0]);
      }
      printf("\n[%d))\n", name);

      if(name==3) {
	printf("HACIENDO cabecera");
	free(cabecera);
	cabecera=calloc(1025, sizeof(char));
	memset(cabecera, 0, leei);
	name++;
	printf("\n[%s}}\n", filename);
	fd=fopen(filename, "a");
      }
      if(name==2) {
	printf("###");
	printf("%s(%d)[%d](%d) >>>>>\n", cabecera, bien, fin, lea[0]);
	if(lea[0]==34) {
	  printf("filename: %s %d\n", filename, fn);
	  fd=fopen(filename, "w+");
	  fclose(fd);
	  fn=0;
	  name=0;
	} else {
	  filename[fn]=lea[0];
	  filename[fn+1]=0;
	  fn++;
	  if(fn==fni-1) {
	    printf("HACIENDO FILENAME");
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
      printf("\n[%d] %d\n", m, bien);
    }
    if(bien>=leei) {
      printf("------------------");
      free(temporal);
      temporal=calloc(leei, sizeof(char));
      memcpy(temporal, cabecera, leei);
      free(cabecera);
      cabecera=calloc(leei+1024, sizeof(char));
      memcpy(cabecera, temporal, leei);
      leei+=1024;
    }
  }
  printf("LISTO!!!");
  free(lee);
  lee=calloc(1024, sizeof(char));
  return  0;
}
