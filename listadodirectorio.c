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
  name=calloc(1,1024);
  memset(name, 0, 1024);
  struct dirent *pent = NULL;
  struct dirent *pent2 = NULL;
  int uu=argc;
  if(uu<2)  {
    uu=1;
    name[0]='.';
    getwd(path);
  } else {
    name=argv[1];
    path=name;
    uu=argc;
  }
  while(uu>0) {
    pdyr=opendir (name);
    if (pdyr != NULL) {
    while ( (pent = readdir (pdyr)) !=NULL) {
      if (strcmp(pent->d_name,"..")!=0 && strcmp(pent->d_name,".") !=0 ){
	if (pent->d_type==4){ 
	  printf("%s/%s\n", path, pent->d_name);
	}
      }
    }
    }
    uu--;
    name=argv[uu];
    path=name;
    }
}
