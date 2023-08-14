#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

long num_from_string(char* str, int nbytes) {
  int i = nbytes;// - (2 * WORD_SIZE); /* index into string */
  int j = 0;                        /* index into array */
  int k=0;
  int kk=0;
  int tmpd;
  char tmpc;
  int pasa=0;

  k=0;
  long tmp=0;
  while (i >= 0) {
    if(k==nbytes) {
      k=0;
      j++;
      tmp=0;
    }
    tmpc=str[i];
    pasa=0;
    kk=0;
    if(tmpc>=48 && tmpc<=57) {
      tmpd=(int)tmpc-48;
      pasa=1;
      kk=1;
    }
    if(pasa) {
      tmp=tmp+(tmpd*(pow(10,k)));
      k++;
    } else {
      if(kk) break;
    }
    i--;    
  }
  return tmp;
}

int main(int argc, char *argv[]) {
  char lea[2];
  long n;
  lea[1]=0;
  FILE *fd=fopen("comp/sphinx/cmusphinx-es-5.2/etc/voxforge_es_sphinx.dic", "r");
  n=num_from_string(argv[1], strlen(argv[1]) );
  (void) fseek(fd, n, 0);
  while(read(fileno(fd), lea, 1)>0) {
    printf("%c", lea[0]);
  }
  return  0;
}
