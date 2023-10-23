#include <stdio.h>
#include <stdlib.h>
#include <sys/dir.h>

int main(int argc, char *argv[]) {
  //  char *path,*name;
  DIR *pdyr,*pdyr2;

  struct dirent *pent = NULL;
  static unsigned char buffer[37]="/root/panal/users/input/unencrypted";
  static unsigned char compare[28]="/root/panal/users/processed";
  int m=0;
  buffer[sizeof(buffer)-1]= 0;
  long biggest_m=sizeof(buffer);
  int l=0;
  int n=0;
  unsigned char *temp;
  pdyr=opendir (buffer);
  if (pdyr != NULL) {
    while ( (pent = readdir (pdyr)) !=NULL) {
      if ( !(pent->d_name[0]=='.' && pent->d_name[1]=='.' && pent->d_name[2]==0) && !(pent->d_name[0]=='.' && pent->d_name[1]==0) ){
	if (pent->d_type==8 || pent->d_type==DT_UNKNOWN){
	  m=0;
	  while(pent->d_name[m]!=0) m++;
	  if(biggest_m<m) biggest_m=m;
	  m--;
	  if( (pent->d_name[m-1]=='.' && pent->d_name[m]=='c') ||(pent->d_name[m-2]=='.' && pent->d_name[m-1]=='s'&& pent->d_name[m]=='h')) l++;
	}
      }
    }
    pdyr=opendir (buffer);
    printf("int main() {\nunsigned char files[%d][2][%ld]={", l+1, biggest_m+1);
    while ( (pent = readdir (pdyr)) !=NULL) {
      if ( !(pent->d_name[0]=='.' && pent->d_name[1]=='.' && pent->d_name[2]==0) && !(pent->d_name[0]=='.' && pent->d_name[1]==0) ){
	if (pent->d_type==8 || pent->d_type==DT_UNKNOWN){
	  m=0;
	  while(pent->d_name[m]!=0) m++;
	  m--;
	  if( (pent->d_name[m-1]=='.' && pent->d_name[m]=='c') ||(pent->d_name[m-2]=='.' && pent->d_name[m-1]=='s'&& pent->d_name[m]=='h')) {
	    sprintf(temp, "\"%s/%s\",", compare, pent->d_name);
	    FILE *file = fopen(temp, "r");
	    if (file) {
	      fclose(file);
	    } else {
	      printf("{\"%s\",\"%s\"},", buffer, pent->d_name);
	    }
	  }
	}
      }
    }
    printf("\"END\"};};");
  }
}
