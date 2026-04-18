#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

int main(int argc, char *argv[]) {
  char lea[2];
  char *patron, *temporal, *lee;
  int geto, geto2, leei, lee2, mi, m;
  temporal=calloc(20,sizeof(char));
  lee=calloc(1025, sizeof(char));
  leei=1025;
  lee=calloc(1025, sizeof(char));
  leei=1025;
  memset(lee, 0, leei);
  memset(temporal, 0, 20);
  lee2=0;geto=0;geto2=0;
  patron=calloc(2, sizeof(char));
  bzero(patron, 2);
  bzero(lea, 2);
  while(fread(lea, sizeof(char), 1, stdin)>0) {
    lee[lee2]=lea[0];
    if(lea[0]==';'||lea[0]=='\r'||lea[0]=='\n' ) {
      geto=1;
      if(lee2>1){
      mi=0;
      while(mi <= lee2) {
	if(lee[mi]==' '||lee[mi]=='\t') mi++;
	else break;
      }
      if ( (lee2-mi) >= 9 ) {
	free(patron);
	patron=calloc(9, sizeof(char));	
	memcpy(patron, "#include ", 9);
	m=0;
	while(m<=9) {
	  if(lee[m+mi] == patron[m]) {
	    m++;
	  } else {
	    break;
	  }
	}
	if(m==9) geto=0;
      }
	
      if ( (lee2-mi) >= 8 ) {
	free(patron);
	patron=calloc(7, sizeof(char));	
	memcpy(patron, "fwrite", 6);
	m=0;
	while(mi<(lee2-8)) {
	  if(lee[mi] != patron[m]) mi++;
	  else {
	    while(m<=6) {
	      if(lee[m+mi] == patron[m]) {
		m++;
	      } else {
		break;
	      } 
	    }
	    mi++;
	  }
	}
	if(m>=6) geto=0;
      }
      }
      fflush(stdout);
      if(geto) {
	m=0;
	while(m<=lee2) {
	  printf("%c", lee[m]);
	  m++;
	}
	fflush(stdout);
      }
      free(lee);
      lee=calloc(1025, sizeof(char));
      leei=1025;
      free(temporal);
      temporal=calloc(leei, sizeof(char));
      lee2=-1;
    }

    lee2+=1;
    while(lee2>leei-1) {
      free(temporal);
      temporal=calloc(leei, sizeof(char));
      memcpy(temporal, lee, leei);
      free(lee);
      lee=calloc(leei+1024, sizeof(char));
      memcpy(lee, temporal, leei);
      leei+=1024;
    }
  }
  free(lee);
  lee=calloc(1024, sizeof(char));
  printf("\n");
  return  0;
}
