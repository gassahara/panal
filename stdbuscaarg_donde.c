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
  static long int i=0;
  static long int j=0;
  static long int l=0;
  static long int o=0;
  static long int p=0;
  static long int q=0;
  static long int r=0;
  unsigned char imprime=0;
  while(fread(lea, sizeof(char), 1, stdin)>0 && m<lon-1) {
    patronv[m]=lea[0];
    i=i+1;
    m++;
  }
  if(m<lon-1) exit(0);
  patronv[m]=lea[0];
  while(!imprime) {
    while(r>0) {
      if(fread(lea, sizeof(char), 1, stdin)<=0) {
	exit(0);
      }
      i=i+1;
      m=m+1;
      if(m==lon) {
	m=0;
      }
      patronv[m]=lea[0];
      r--;
    }
    o=m+1;
    if(o==lon) o=0;
    j=0;
    k=o;
    l=0;
    while(j<lon) {
      if(patronv[k]==patron[j]) {
	l++;
	if(l==lon) {
	  //imprime=1;
	  printf("%d ", i);
	  l=0;
	  r=1;
	  break;
	}
      } else {
	r=1;
	while(r<=lon) {
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
	l=0;
	break;
      }
      k++;
      if(k==lon) k=0;
      j++;
    }

  }
  return  0;
}
