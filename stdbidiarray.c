#include <stdio.h>
#include <stdlib.h>
#include <math.h>


int main(int argc, char *argv[]) {
  unsigned char array[217]={0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0, 1, 2, 3,0};
  int i=0;
  int j=0;
  int k=0;
  int l=0;
  int siz=128;
  int sizarr=sizeof(array);
  j=ceil(sizarr/siz);
  while((j*siz)<sizarr) j++;
  printf("[%d][%d]={{", j+1, siz);
  k=0;
  while(i<sizarr) {
    k++;
    if(k==siz-1 && i<sizarr-1) {
      printf("},{0x%02X,", array[i]);
      k=0;
    } else printf("0x%02X", array[i]);
    if(k<siz-1 && k>0) printf(",");
    i++;
  }
  if(i==(j*siz)-1) {
    printf("';',");
    k++;
    i++;
  }
  //  if(i<(j*siz)-2) {
  if(k<siz-2) {
    printf("'/', '/'");
    if(k<siz-3) printf(",");
    k=k+2;
  }
  //  while(i<(j*siz)) {
  while(k<siz-1) {
    unsigned char aleatorio[10]={0,0};
    FILE *ff=fopen("/dev/urandom", "r");
    while(aleatorio[9]=='/' || aleatorio[9]==0 || aleatorio[9]== '*'  || aleatorio[9]=='\t' ||  aleatorio[9]=='\n'|| aleatorio[9]=='\r'|| aleatorio[9]==10) fread(aleatorio, 1, 10, ff);
    printf("0x%02X", aleatorio[9]);
    //    if(i<(j*siz)-1) printf(",");
    if(k<siz-2) printf(",");
    k++;
    i++;
  }
  printf("}};");
  return  0;
}
