#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/dir.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  char *path,*name;
   DIR *pdyr,*pdyr2;
  path=calloc(1,1024);
  memset(path, 0, 1024);
  name=calloc(1024, sizeof(char));
  memset(name, 0, 1024);
  struct dirent *pent = NULL;
  struct dirent *pent2 = NULL;

  char lea[2];
  char *temporal, *lee;
  int leei, lee2, geto, p, n;
  temporal=calloc(20,sizeof(char));
  lee=calloc(1025, sizeof(char));
  leei=1025;
  memset(lee, 0, leei);
  memset(temporal, 0, 20);
  lee2=0;
  bzero(lea, 2);
  geto=0;


  while(fread(lea, 1, 1, stdin)>0) {
    if(lea[0]!=0xa && lea[0]!=0xd) {
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
    } else {
      lee2=0;
      if(lee[0]>0) {
      if(leei>1024) {
	free(name);
	name=calloc(leei, sizeof(char));
	memset(name, 0, leei);
      }
      bzero(name, leei);
      memcpy(name, lee, strlen(lee));
      pdyr=opendir (name);
      if (pdyr != NULL) {
	while ( (pent = readdir (pdyr)) !=NULL) {
	  if (strcmp(pent->d_name,"..")!=0 && strcmp(pent->d_name,".") !=0 ){
	    if (pent->d_type==8){ 
	      printf("%s/%s\n", name, pent->d_name);
	    }
	  }
	}
      }
      }
      bzero(lee, leei);
    }
  }
}
