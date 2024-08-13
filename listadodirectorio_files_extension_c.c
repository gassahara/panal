#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <dirent.h>
#include <string.h>
//#include <unistd.h>

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
  int m=0;
  name[0]='.';
  getcwd(path, 1024);
  pdyr=opendir (name);
  if (pdyr != NULL) {
    while ( (pent = readdir (pdyr)) !=NULL) {
      if (strcmp(pent->d_name,"..")!=0 && strcmp(pent->d_name,".") !=0 ){
	if (pent->d_type==8 || pent->d_type==DT_UNKNOWN){
	  m=0;
	  while(pent->d_name[m]!=0) m++;
	  m--;
	  
	  if( (pent->d_name[m-1]=='.' && pent->d_name[m]=='c') ||(pent->d_name[m-2]=='.' && pent->d_name[m-1]=='s'&& pent->d_name[m]=='h')) {
	    printf("%s/%s\n", path, pent->d_name);
	  }
	}
      }
    }
  }
}
