#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {
  int lon=0;
  int k=0;
  if(argc<2) exit(1);
  while ( argv[1][k]!=0 )k++;
  lon=k;

  k=0;
  unsigned char patron[lon];
  unsigned char patronv[lon];
  while (k<lon ) {
    patron[k]=argv[1][k];
    patronv[k]=0;
    k++;
  }
  patron[k]=0;

  static unsigned char lea[2];
  static long int m=0;
  int i=0;
  static long int j=0;
  static long int l=0;
  static long int o=0;
  static long int p=0;
  static long int q=0;
  long int r=lon;
  unsigned char imprime=1;
  while(1) {
    l=0;
    if(!imprime) {
      while(l<r && o<lon) {
	fwrite(patronv+o, 1, 1, stdout);
	o++;
	l++;
      }
      if(l<r) o=0;
      while(l<r) {
	fwrite(patronv+o, 1, 1, stdout);
	o++;
	l++;
      }
    }
    if(o==lon) o=0;
    
    p=r;
    while(r>0) {
      imprime=0;
      if(fread(lea, sizeof(char), 1, stdin)<=0) {
	exit(0);
      }
      patronv[m]=lea[0];
      m=m+1;
      if(m==lon) {
	m=0;
      }
      r--;
    }
    j=0;
    k=o;
    l=0;
    while(j<lon) {
      if(patronv[k]==patron[j]) {
	l++;
	if(l==lon) {
	  exit(0);
	}
      } else {
	r=1;
	while(r<lon) {
	  p=0;
	  q=o+r;
	  if(q>=lon) q-=lon;
	  l=r;
	  while(patronv[q]==patron[p] && l<lon) {
	    p++;
	    q++;
	    if(q==lon) q=0;
	    l=l+1;
	  }
	  fflush(stdout);
	  if(l==lon) {
	    break;
	  }
	  r++;
	}
	break;
      }
      k++;
      if(k==lon) k=0;
      j++;
    }

  }
  return  0;
}
