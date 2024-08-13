#include <stdio.h>
#include <stdlib.h>
#include <sys/dir.h>

int main(int argc, char *argv[]) {
  //  char *path,*name;
  DIR *pdyr,*pdyr2;

  struct dirent *pent = NULL;
  static unsigned char *buffer;
  int ssize=256;
  buffer=calloc(ssize, sizeof(char));
  char *temporal;
  int m=0;
  while(m<ssize) {
    buffer[m]= 0;
    m++;
  }
  static unsigned char buff[2];
  int r=1;
  int rr=0;
  int rt=ssize;
  int offset=0;
  

  while(r>0) {
    r=fread(buff, sizeof(char), 1, stdin);
    if(buff[0] == '\n' || buff[0] == 0) break;
    if(r<1) break;
    buffer[rr]=buff[0];
    rr++;
    while(rr>rt-1) {
      temporal=calloc(rr, sizeof(char));
      m=0;
      while(m<rr) {
	temporal[m]=buffer[m];
      }
      free(buffer);
      buffer=calloc(rr+ssize, sizeof(char));
      r=0;
      while(r<rr+ssize) {
	buffer[r]=0;
	r++;
      }
      m=0;
      while(m<rr+ssize) {
	buffer[m]=0;
	m++;
      }
      m=0;
      while(m<rr) {
	buffer[m]=temporal[m];
      }
      free(temporal);
      rt=rr+ssize;
    }
  }
  buffer[rr]=0;
  pdyr=opendir (buffer);
  if (pdyr != NULL) {
    while ( (pent = readdir (pdyr)) !=NULL) {
      if ( !(pent->d_name[0]=='.' && pent->d_name[1]=='.' && pent->d_name[2]==0) && !(pent->d_name[0]=='.' && pent->d_name[1]==0) ){
	if (pent->d_type==8 || pent->d_type==DT_UNKNOWN){
	  m=0;
	  while(pent->d_name[m]!=0) m++;
	  m--;
	  
	  if( (pent->d_name[m-1]=='.' && pent->d_name[m]=='c') ||(pent->d_name[m-2]=='.' && pent->d_name[m-1]=='s'&& pent->d_name[m]=='h')) {
	    printf("%s/%s\n", buffer, pent->d_name);
	  }
	}
      }
    }
  }
}
