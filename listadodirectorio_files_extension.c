#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/dir.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  char *path,*name;
  DIR *pdyr;
  path=calloc(1,1024);
  int o=0;
  int p=0;
  int q=0;
  int r=0;
  while(o<1024) {
    path[o]=0;
    o++;
  }
  name=calloc(1,1024);
  o=0;
  while(o<1024) {
    name[o]=0;
    o++;
  }
  p=0;
  while(argv[1][p]!=0) p++;
  p--;
  struct dirent *pent = NULL;
  name[0]='.';
  getcwd(path, 1024);
  pdyr=opendir (name);
  if (pdyr != NULL) {
    while ( (pent = readdir (pdyr)) !=NULL) {
      if (pent->d_name[0]!='.' ){
	if (pent->d_type==8 || pent->d_type==DT_UNKNOWN){
	  o=0;
	  while(pent->d_name[o]!=0) o++;
	  o--;
	  if(o>p) {
	    r=0;
	    q=p;
	    while(r<=p) {
	      if(pent->d_name[o]==argv[1][q]) q--;
	      else break;
	      o--;
	      r++;
	    }
	    if(q==-1) printf("%s/%s\n", path, pent->d_name);
	  }
	}
      }
    }
  }
}
