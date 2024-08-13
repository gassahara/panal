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
	  if ( strstr(pent->d_name, argv[1] ) ){
	    if (strcmp(strstr(pent->d_name, argv[1] ), argv[1]) ==0 ) {
	      stat(pent->d_name, &sb);
	      b=0;
	      while(b < 10) {
		if( sba[b] == 0 ) {
		  sba[b]=sb.st_mtime;
		  strcpy(names[b], pent->d_name);
		  break;
		} else {
		  if( difftime (sb.st_mtime, sba[b]) >= 0) {
		    c=5;
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
      c=0;
      while(names[b][c]!=0) {
	printf("%02X ", names[b][c]);
	c++;
      }
      if(c>0) printf("0A ");
      b++;
    }
  }
}
