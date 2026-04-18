#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/dir.h>
#include <unistd.h>
#include <stdint.h>

int main(int argc, char *argv[]) {
  char *path,*name, *nane;
  DIR *pdyr,*pdyr2;
  path=calloc(1,1024);
  memset(path, 0, 1024);
  name=calloc(1,1024);
  memset(name, 0, 1024);
  nane=calloc(1,1024);
  memset(nane, 0, 1024);
  if (argc < 2) {
    printf("argumento\n");
    exit(0);
  } else {
    time_t sba[10];
    struct stat sb, sc;
    char names[10][1024];
    stat(argv[1], &sc);
    if (sc.st_ctime > 0) {
      if(strchr( argv[1], '.') != NULL) {
	int c=0;
	int b=0;
	int d=0;
	int e=0;
	int f=0;
	while (b<10) {
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
	      if (pent->d_type==8) {
		d=strlen(argv[1]);
		e=strlen(pent->d_name);
		f=0;
		while(d > 0 && e > 0 && argv[1][d] == pent->d_name[e] ) {
		  if(argv[1][d] == '.') {
		    f=1;
		    break;
		  }
		  d--;
		  e--;
		}
		if (f) {
		  stat(pent->d_name, &sb);
		  if( difftime ( sc.st_mtime, sb.st_mtime) > 0) {
		    b=0;
		    while(b < 10) {
		      if( sba[b] == 0 ) {
			sba[b]=sb.st_mtime;
			strcpy(names[b], pent->d_name);
			break;
		      } else {
			if( difftime (sb.st_mtime, sba[b]) >= 0) {
			  c=9;
			  while(c>b && c>0) {
			    sba[c]=sba[c-1];
			    memcpy(names[c], names[c-1], 1024);
			    c--;
			  }
			  sba[b]=sb.st_mtime;
			  strcpy(names[b], pent->d_name);
			  break;
			}
		      }
		      b++;
		    }
		  }
		}
	      }
	    }
	  }
	  b=0;
	  while(b < 10) {
	    stat(names[b], &sb);
	    printf("%s/%s\n", path, names[b]);
	    b++;
	  }
	}
      }
    }
  }
}
