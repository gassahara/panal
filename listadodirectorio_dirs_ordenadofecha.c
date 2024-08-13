#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
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
  time_t sba[10];
  struct stat sb;
  char names[10][1024];
  int b=0;
  int c=0;
  int d=0;
  while (b<10) {
    //names[b]=calloc(1,1024);
    memset(names[b], 0, 1024);
    sba[b]=0;
    b++;
  }
  struct dirent *pent = NULL;
  struct dirent *pent2 = NULL;
  int uu=argc;
  name[0]='.';
  getcwd(path, 1024);
  pdyr=opendir (name);
  if (pdyr != NULL) {
    while ( (pent = readdir (pdyr)) !=NULL) {
      if (strcmp(pent->d_name,"..")!=0 && strcmp(pent->d_name,".") !=0 ){
	if (pent->d_type==DT_DIR  ) {
	  stat(pent->d_name, &sb);
	  /* printf("%s %s\n", pent->d_name, ctime(&sb.st_ctime) ); */
	  fflush(stdout);
	  b=0;
	  while(b < 10) {
	    if( sba[b] == 0 ) {
	      sba[b]=sb.st_ctime;
	      strcpy(names[b], pent->d_name);
	      break;
	    } else {
	      if( difftime (sb.st_ctime, sba[b]) >= 0) {
		c=9;
		while(c>b && c>0) {
		  sba[c]=sba[c-1];
		  memcpy(names[c], names[c-1], 1024);
		  /* printf("[%02d] %s %08d\n", c, names[c], sba[c] ); */
		  c--;
 		}
		sba[b]=sb.st_ctime;
		strcpy(names[b], pent->d_name);
		/* printf("<%02d> %s %08f\n", c, names[b], difftime (sb.st_ctime, sba[b]) ); */
		break;
	      }

	    }
	    b++;
	  }
	}
      }
    }
  }
  uu--;
  path=name;

  b=0;
  while(b < 10) {
    stat(names[b], &sb);
    printf("%s/%s\n", path, names[b]);
    b++;
  }
}
