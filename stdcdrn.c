#include <stdio.h>
#include <unistd.h>
#include <math.h>
#include <errno.h>

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
  long p, n;
  lea[0]=0;
  lea[1]=0;
  p=0;
  if (argc==2) {
    p=0;
    while(p<argv[1][p]!=0) p++;
    n=num_from_string(argv[1], p);
    p=0;
    while(p<n) {
      read(fileno(stdin), lea, 1);
      p++;
    }
    while(read(fileno(stdin), lea, 1)>0) {
      fwrite(lea, 1, 1, stdout);
    }
    return  0;
  } return 1;
}
