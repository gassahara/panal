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
  int leei, lee2, geto;
  long p, n;
  static const unsigned char *filo="datas/C1";

  leei=1025;
  lea[0]=0;
  lea[1]=0;
  geto=0;
  p=0;
  p=0;
  while(argv[1][p]!=0) p++;
  n=num_from_string(argv[1], p);
  FILE *fd=fopen(filo, "r");
  p=0;
  if(n>1024) {
    (void) fseek(fd, 1024, SEEK_SET);
    p+=1024;
  }
  while(p<n-1024) {
    if(!fseek(fd, 1024, SEEK_CUR))p+=1024;
    else {
      printf("ERROR");
      break;
    }
  }
  //  printf(">.>.>.>.>.>.    %ld   %ld\n", p, ftell(fd));
  p=n-p;
  (void) fseek(fd, p, SEEK_CUR);
  //  printf("**** %ld ..  %ld   ..  %ld****\n\n\n", p, n, ftell(fd));
  while(/*read(fileno(fd), lea, 1)>0*/fread(lea, 1, 1, fd)) {
    printf("%c", lea[0]);
  }
  return  0;
}
