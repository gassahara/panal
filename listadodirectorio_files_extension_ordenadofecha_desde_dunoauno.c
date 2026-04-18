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

  char *buffer;
  buffer=calloc(1024, sizeof(char));
  char *temporal;
  temporal=calloc(1024, sizeof(char));
  bzero(buffer, 1024);
  bzero(temporal, 1024);
  char buff[2];
  int r=1;
  int rr=0;
  int rt=1024;
  
  while(r>0) {
    r=fread(buff, sizeof(char), 1, stdin);
    if(r<1) break;
    if(buff[0]=='\n' || buff[0]==13) break;
    buffer[rr]=buff[0];
    rr++;
    while(rr>rt-1) {
      free(temporal);
      temporal=calloc(rr, sizeof(char));
      memcpy(temporal, buffer, rr);
      free(buffer);
      buffer=calloc(rr+1024, sizeof(char));
      bzero(buffer, 1024);
      memcpy(buffer, temporal, rr);
      rt=rr+1024;
    }
  }
  buffer[rr]=0;

  time_t sba;
  struct stat sb, sc;
  char names[1024];
  stat(buffer, &sc);
  if (sc.st_mtime > 0) {
    if(strchr( buffer, '.') != NULL) {
      int c=0;
      int b=0;
      int d=0;
      int e=0;
      int f=0;
      memset(names, 0, 1024);
      sba=0;
      struct dirent *pent = NULL;
      struct dirent *pent2 = NULL;
      int uu=argc;
      name[0]='.';
      getcwd(path, 1024);
      pdyr=opendir (name);
      if (pdyr != NULL) {
	while ( (pent = readdir (pdyr)) !=NULL)
	  if (strcmp(pent->d_name,"..")!=0 && strcmp(pent->d_name,".") !=0 ){
	    if (pent->d_type==8) {
	      d=strlen(buffer);
	      e=strlen(pent->d_name);
	      f=0;
	      while(d > 0 && e > 0 && buffer[d] == pent->d_name[e] ) {
		if(buffer[d] == '.') {
		  f=1;
		  break;
		}
		d--;
		e--;
	      }
	      if (f) {
		stat(pent->d_name, &sb);
		if( difftime ( sc.st_mtime, sb.st_mtime ) > 0) {
		  if( sba == 0 ) {
		    sba=sb.st_mtime;
		    strcpy(names, pent->d_name);
		  } else {
		    if( difftime (sb.st_mtime, sba) >= 0) {
		      sba=sb.st_mtime;
		      strcpy(names, pent->d_name);
		    }
		  }
		}
	      }
	    }
	  }
      }
    }
    stat(names, &sb);
    printf("%s/%s\n", path, names);
  }
}

