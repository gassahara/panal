/*

Big number library - arithmetic on multiple-precision unsigned integers.

This library is an implementation of arithmetic on arbitrarily large integers.

The difference between this and other implementations, is that the data structure
has optimal memory utilization (i.e. a 1024 bit integer takes up 128 bytes RAM),
and all memory is allocated statically: no dynamic allocation for better or worse.

Primary goals are correctness, clarity of code and clean, portable implementation.
Secondary goal is a memory footprint small enough to make it suitable for use in
embedded applications.


The current state is correct functionality and adequate performance.
There may well be room for performance-optimizations and improvements.

*/

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

//#include "bn.h"

#ifndef WORD_SIZE
#define WORD_SIZE 2
#endif




/* Here comes the compile-time specialization for how large the underlying array size should be. */
/* The choices are 1, 2 and 4 bytes in size with uint32, uint64 for WORD_SIZE==4, as temporary. */
#ifndef WORD_SIZE
  #error Must define WORD_SIZE to be 1, 2, 4
#elif (WORD_SIZE == 1)
  /* Data type of array in structure */
  #define DTYPE                    uint8_t
  /* bitmask for getting MSB */
  #define DTYPE_MSB                ((DTYPE_TMP)(0x80))
  /* Data-type larger than DTYPE, for holding intermediate results of calculations */
  #define DTYPE_TMP                uint16_t
  /* Max value of integer type */
  #define MAX_VAL                  ((DTYPE_TMP)0xFF)
#elif (WORD_SIZE == 2)
  #define DTYPE                    uint16_t
  #define DTYPE_TMP                uint32_t
  #define DTYPE_MSB                ((DTYPE_TMP)(0x8000))
  #define MAX_VAL                  ((DTYPE_TMP)0xFFFF)
#elif (WORD_SIZE == 4)
  #define DTYPE                    uint32_t
  #define DTYPE_TMP                uint64_t
  #define DTYPE_MSB                ((DTYPE_TMP)(0x80000000))
  #define MAX_VAL                  ((DTYPE_TMP)0xFFFFFFFF)
#endif
#ifndef DTYPE
  #error DTYPE must be defined to uint8_t, uint16_t uint32_t or whatever
#endif


//#define MAX_VAL                  ((DTYPE_TMP)0xFFFFFFFF)

/* Size of big-numbers in bytes */
#define BN_ARRAY_SIZE    2 //(2048 / WORD_SIZE)
enum { SMALLER = -1, EQUAL = 0, LARGER = 1 };

/* Data-holding structure: array of DTYPEs */
struct bn {
  //DTYPE array[BN_ARRAY_SIZE];
  DTYPE *array;
  int len;
};

/* Functions for shifting number in-place. */
/* Public / Exported functions. */
void bignum_init(struct bn* n) {
  int i;
  i=0;
  n->array=calloc(BN_ARRAY_SIZE, WORD_SIZE);
  n->len=BN_ARRAY_SIZE;
  while(i < BN_ARRAY_SIZE) {
    n->array[i] = 0;
    i++;
  }
}

/* Public / Exported functions. */
void bignum_init_size(struct bn* n, int size) {
  int i;
  i=0;
  n->array=calloc(size, WORD_SIZE);
  n->len=size;
  while(i < size) {
    n->array[i] = 0;
    i++;
  }
}

#if (WORD_SIZE==4)
uint32_t potencias[]={1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304,8388608,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592};
#elif (WORD_SIZE==2)
uint16_t potencias[]={1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768};
#elif (WORD_SIZE==1)
uint8_t potencias[]={1,2,4,8,16,32,64,128};
#endif

char* bignum_to_string(struct bn* n) {
  char *str=malloc(n->len*(WORD_SIZE*2)+1);
  bzero(str, n->len*(WORD_SIZE*2)+1);
  int j=0;
  DTYPE nj;
  int jj=0;
  int jjj=0;
  int jjjj=n->len*(WORD_SIZE*2)-1;
  int tmpc=0;
  while (j<n->len) {
    nj=n->array[j];
    while(jj<(WORD_SIZE*8)) {
      if( (nj & 1)==1 ) {
	tmpc=tmpc+potencias[jjj]; //pow(2,jjj);
      }
      jjj++;
      if(jjj==4) {
	if(tmpc>9) tmpc=tmpc+7;
	fflush(stdout);
	str[jjjj]=(char)(tmpc+0x30);
	jjjj--;
	if(jjjj<0) return str;
	tmpc=0;
	jjj=0;
      }
      nj=nj>>1;
      jj++;
    }
    jj=0;
    j++;
  }
  return str;
}


int bignum_UV_from_binstring(struct bn n[], char *str, int longitud_pedazos) {
  int offset=strlen(str); //-longitud_pedazos;
  char s1[longitud_pedazos+1];
  int indexU=0;
  int nbytes;
  DTYPE tmp;
  int j = 0;
  int k=0;
  char tmpc;
  int ll;
  nbytes=(longitud_pedazos/(WORD_SIZE*8))+1;
  if(nbytes==0) nbytes=1;
  while(offset>=0) {
    offset-=longitud_pedazos;
    bzero(s1, longitud_pedazos+1);
    if(offset<0){
      memcpy(s1, str, longitud_pedazos+offset);      
    }else {
      memcpy(s1, str+offset, longitud_pedazos);
    }
    bignum_init_size(&n[indexU], nbytes);
    k=0;
    tmp=0;
    j=0;
    ll=strlen(s1);
    while (ll>=0 ) {
      if(k==(WORD_SIZE*8)) {
	n[indexU].array[j] = tmp;
	k=0;
	j++;
	tmp=0;
      }
      tmpc=s1[ll];
      if(tmpc==49) {
	tmp=tmp+potencias[k];
	k++;
	if(k>=strlen(str)) break;
      }
      if(tmpc==48) {
	k++;
	if(k>=strlen(str)) break;
      }
      ll=ll-1;    
    }
    if(k>0) n[indexU].array[j] = tmp;
    indexU++;
  }
  return indexU-1;
}


void bignum_from_binstring(struct bn* n, char *str) {
  int i = 0; //ll;// - (2 * WORD_SIZE); /* index into string */
  while(str[i]=='0') i++;
  int nbytes=((strlen(str)-i)/(WORD_SIZE*8))+1;
  bignum_init_size(n, nbytes);
  DTYPE tmp;       
  int j = 0;                        /* index into array */
  int k=0;
  int kk=0;
  char tmpc;
  int pasa=0;

  k=0;
  tmp=0;
  int ll=nbytes*(WORD_SIZE*8);
  while (ll>=i) {
    if(k==(WORD_SIZE*8)) {
      n->array[j] = tmp;
      k=0;
      j++;
      tmp=0;
    }
    tmpc=str[ll];
    pasa=0;
    kk=0;
    if(tmpc==49) {
      tmp=tmp+potencias[k]; //pow(2,k);
      k++;
    }
    if(tmpc==48) {
      k++;
    }
    ll--;    
  }
  if(k>0) n->array[j] = tmp;
}


int toom (char* binaz, char* binbz) {
  int r1=0;
  int r2=0;
  while(r2<3) {
    if(r2<1) if(binaz[r1]==0) r2=r2+1;
    if(r2>0) if(binbz[r1]==0) r2=r2+2;
    r1++;
  }
  int k=1;
  int q[32], r[32], qq=4, RR=2;
  q[0]=4;q[1]=4;r[0]=4,r[1]=4;
  while ( (q[k-1]+q[k]) < r1) {
    if ( pow(RR+1,2) <= qq) RR++;
    k++;
    qq=qq+RR;
    q[k]=pow(2, qq);
    r[k]=pow(2,RR);
  }
  int rf=0;
  int qf=0;
  int pf=0;
  int k4=0;
  int coder=k;
  rf=0;
  while(coder>=0) {
    rf+=(2*r[coder])+1;
    coder--;
  }
  //  while (k>0) {
    k--;
    if(k>0) {
      rf=r[k];
      qf=q[k];
      pf=q[k-1]+q[k];
    } 
      
  struct bn U[ rf+1 ]; //(int)ceil(r1/(WORD_SIZE*8))+1];
  struct bn V[ rf+1 ]; //(int)ceil(r1/(WORD_SIZE*8))+1];
  //    int pedazos=(q[k]+q[k+1])/(rf+1);
  int pedazos=( ceil(r1/(rf+1)) );
  //  int pedazos=qf;
    char bina1[ pedazos +1 ];
    bzero(bina1, pedazos +1 );
    int rrr=0;//(rf+1);
    int rrin=r1;
    int rrrp=0;
    int erre=bignum_UV_from_binstring(U, binaz, pedazos);
    int err2=bignum_UV_from_binstring(V, binbz, pedazos);
    int erri=rf;
    int errj=0;
    while(erre>=0) {
      //      printf("U[%04d]=", erre);
      if(erre==err2) {
	printf("U[%04d]=%s\nV[%04d]=%s\n", erre, bignum_to_string(&U[erre]), erre,bignum_to_string(&V[erre]));
	erre--;
	err2--;
      }
      if(erre>err2) {
	printf("U[%04d]=%s\nV[%04d]=0\n", erre, bignum_to_string(&U[erre]),erre);
	erre--;
      }
      if(err2>erre) {
	printf("U[%04d]=0\nV[%04d]=%s\n", err2, bignum_to_string(&V[erre]), err2);
	err2--;
      }
      fflush(stdout);
    }
    /*    
    erri=rf;
    errj=0;
    while(erri>err2) {
      errj=0;
      printf("V[%04d]=", erri);
      while(errj<=(pedazos/4)) {
	printf("0");
	errj++;
      }
      printf(";\n");
      erri--;
    }
    while(err2>=0) {
      printf("V[%04d]=", err2);
      printf("%s;\n", bignum_to_string(&V[err2]));
      fflush(stdout);
      err2--;
    }
    //  }*/
  return 0;
} 



int main(int argc, char *argv[] ) {
  char *buf;
  int rt=512;
  buf=calloc(2, sizeof(char));
  char *bufferA;
  bufferA=calloc(rt, sizeof(char));
  char *bufferB;
  bufferB=calloc(rt, sizeof(char));
  char *temporal;
  temporal=calloc(rt, sizeof(char));
  bzero(bufferA, rt);
  bzero(bufferB, rt);
  bzero(temporal,rt);
  char buff[2];
  int r=1;
  int rr=0;
  

  while(r>0) {
    r=fread(buff, sizeof(char), 1, stdin);
    if(buff[0] == '*') break;
    if(r<1) break;
    bufferA[rr]=buff[0];
    rr++;
    while(rr>rt-1) {
      free(temporal);
      temporal=calloc(rr, sizeof(char));
      memcpy(temporal, bufferA, rr);
      free(bufferA);
      bufferA=calloc(rr+1024, sizeof(char));
      buf=calloc(rr+1024, sizeof(char));
      bzero(bufferA, 1024);
      memcpy(bufferA, temporal, rr);
      rt=rr+1024;
    }
  }
  bufferA[rr]=0;
  if(rr<=1) {
    bufferA[0]='0';
    bufferA[1]=0;
  }
  if(buff[0]!='*') {
    exit(1);
  }
  r=1;
  rr=0;
  while(r>0) {
    r=fread(buff, sizeof(char), 1, stdin);
    if(r<1) break;
    bufferB[rr]=buff[0];
    rr++;
    while(rr>rt-1) {
      free(temporal);
      temporal=calloc(rr, sizeof(char));
      memcpy(temporal, bufferB, rr);
      free(bufferB);
      bufferB=calloc(rr+1024, sizeof(char));
      buf=calloc(rr+1024, sizeof(char));
      bzero(bufferB, 1024);
      memcpy(bufferB, temporal, rr);
      rt=rr+1024;
    }
  }
  bufferB[rr]=0;
  if(rr<=1) {
    bufferB[0]='0';
    bufferB[1]=0;
  }
  r=0;
  toom(bufferA, bufferB);
}
