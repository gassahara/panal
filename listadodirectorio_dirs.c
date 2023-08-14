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
  struct dirent *pent = NULL;
  name[0]='.';
  getcwd(path, 1024);
  pdyr=opendir (name);
  if (pdyr != NULL) {
    while ( (pent = readdir (pdyr)) !=NULL) {
      o=0;
      while(pent->d_name[o]!=0) o++;
      o--;
      if (o<2) {
	if(o==0 && pent->d_name[0]=='.' && pent->d_name[1]==0 ) continue;
	if(o==1 && pent->d_name[0]=='.' && pent->d_name[1]=='.' && pent->d_name[2]==0) continue;
      }
      if (pent->d_type==DT_DIR){
	printf("%s/%s\n", path, pent->d_name);
      }
    }
  }
}
