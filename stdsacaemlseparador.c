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
  char lea[2], filename[1024], archivo[1024];
  char *temporal, *lee;
  int leei, lee2, geto, p, n;
  double bites;
  struct stat statinfo;
  FILE *fd;
  temporal=calloc(20,sizeof(char));
  lee=calloc(1025, sizeof(char));
  leei=1025;
  memset(lee, 0, leei);
  memset(temporal, 0, 20);
  lee2=0;
  bzero(lea, 2);
  bzero(archivo, 1024);
  geto=0;
  int m=0;
  int i=0;
  int name=0;
  int named=0;
  off_t size;
  char patron[1024];
  (void)strncpy(patron, argv[1], sizeof(patron) - 1);
  patron[sizeof(patron) - 1] = '\0';

  //patron=argv[1];
  printf("- %s -", patron);
  sprintf(filename, "0x%d", name);
  fd=fopen(filename, "w+");
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    fwrite(lea, 1, 1, fd);
    printf("%s %s\n", lea, filename);
    if(lea[0] == patron[m]) {
      printf("+++++++");
      m++;
    } else {
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
      while(m>=0) {
	if(m>=0) {
	  if(lea[0] != patron[m]) {
	    m--;
	  } else {
	    printf("-------------------------");
	    break;
	  }
	}
      }
      if(m<0) m=0;
    } 
   
    if(m==strlen(patron)) {
      printf("***");
      m=0;
      fclose(fd);
      bzero(filename, 1024);
      name++;
      sprintf(filename, "0x%x", name);
      printf("%s\n", filename);
      fd=fopen(filename, "w+");
      fwrite(patron, 1, strlen(patron), fd);
    }
  }
  printf("LISTO!!!");
  free(lee);
  lee=calloc(1024, sizeof(char));
  return  0;
}
