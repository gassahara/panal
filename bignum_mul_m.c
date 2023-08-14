#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

//#include "bn.h"

#ifndef WORD_SIZE
#define WORD_SIZE 4
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



#if (WORD_SIZE==4)
uint32_t potencias[]={1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304,8388608,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648};
uint32_t HEX_VALS[][16]={{0x0,0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9,0xA,0xB,0xC,0xD,0xE,0xF},{0,0x10,0x20,0x30,0x40,0x50,0x60,0x70,0x80,0x90,0xA0,0xB0,0xC0,0xD0,0xE0,0xF0},{0,0x100,0x200,0x300,0x400,0x500,0x600,0x700,0x800,0x900,0xA00,0xB00,0xC00,0xD00,0xE00,0xF00},{0,0x1000,0x2000,0x3000,0x4000,0x5000,0x6000,0x7000,0x8000,0x9000,0xA000,0xB000,0xC000,0xD000,0xE000,0xF000},{0,0x10000,0x20000,0x30000,0x40000,0x50000,0x60000,0x70000,0x80000,0x90000,0xA0000,0xB0000,0xC0000,0xD0000,0xE0000,0xF0000},{0,0x100000,0x200000,0x300000,0x400000,0x500000,0x600000,0x700000,0x800000,0x900000,0xA00000,0xB00000,0xC00000,0xD00000,0xE00000,0xF00000},{0,0x1000000,0x2000000,0x3000000,0x4000000,0x5000000,0x6000000,0x7000000,0x8000000,0x9000000,0xA000000,0xB000000,0xC000000,0xD000000,0xE000000,0xF000000},{0,0x10000000,0x20000000,0x30000000,0x40000000,0x50000000,0x60000000,0x70000000,0x80000000,0x90000000,0xA0000000,0xB0000000,0xC0000000,0xD0000000,0xE0000000,0xF0000000}};
#elif (WORD_SIZE==2)
uint16_t potencias[]={1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768};
uint16_t HEX_VALS[][16]={{0x0,0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9,0xA,0xB,0xC,0xD,0xE,0xF},{0,0x10,0x20,0x30,0x40,0x50,0x60,0x70,0x80,0x90,0xA0,0xB0,0xC0,0xD0,0xE0,0xF0},{0,0x100,0x200,0x300,0x400,0x500,0x600,0x700,0x800,0x900,0xA00,0xB00,0xC00,0xD00,0xE00,0xF00},{0,0x1000,0x2000,0x3000,0x4000,0x5000,0x6000,0x7000,0x8000,0x9000,0xA000,0xB000,0xC000,0xD000,0xE000,0xF000}};
#elif (WORD_SIZE==1)
uint8_t potencias[]={1,2,4,8,16,32,64,128};
uint8_t HEX_VALS[][16]={{0x0,0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9,0xA,0xB,0xC,0xD,0xE,0xF},{0,0x10,0x20,0x30,0x40,0x50,0x60,0x70,0x80,0x90,0xA0,0xB0,0xC0,0xD0,0xE0,0xF0}};
#endif

void bignum_from_string(DTYPE *n, char* str, int ll, int nbytes) {
  memset(n, 0, nbytes);
  DTYPE tmp;       
  int i = ll;
  int j = 0;
  int k=0;
  int kk=0;
  int tmpd;
  char tmpc;
  int pasa=0;

  //  while(str[i]==0) i--;
  k=0;
  tmp=0;
  while (i >= 0) {
    if(k==(2*sizeof(DTYPE))) {
      k=0;
      j++;
      tmp=0;
    }
    tmpc=str[i];
    pasa=0;
    kk=0;
    if((int)tmpc>96 && (int)tmpc<=102) {
      tmpd=(int)tmpc-87;
      pasa=1;
      kk=1;
    }
    if((int)tmpc>64 && (int)tmpc<71) {
      tmpd=(int)tmpc-55;
      pasa=1;
      kk=1;
    }
    if(tmpc>=48 && tmpc<=57) {
      tmpd=(int)tmpc-48;
      pasa=1;
      kk=1;
    }
    if(pasa) {
      tmp=tmp+HEX_VALS[k][tmpd];
      n[j] = tmp;
      k++;
    } else {
      if(kk) break;
    }
    i--;
  }
}

void bignum_to_string(DTYPE *n, int lenn, char *str) {
  int j=0;
  DTYPE nj;
  int jj=sizeof(DTYPE)*8;
  int jjj=(sizeof(DTYPE)*lenn)*2;
  while (j<lenn-1) {
    jj=sizeof(DTYPE)*8;
    while(jj>0 && jjj>0) {
      nj=n[j];
      jj=jj-4;
      nj<<=jj;
      nj>>=(sizeof(DTYPE)*8)-4;
      if(nj>9) nj+=7;
      nj+=0x30;
      str[jjj]=nj;
      jjj--;
    }
    j++;
  }
}


void bignum_add2(DTYPE *a, DTYPE *b, int lena, int lenb) {
  DTYPE_TMP tmp;
  int carry = 0;
  int i;
  i=0;
  while(i<=lenb) {
    tmp=0;
    tmp+=carry;
    tmp+=b[i];
    tmp+=a[i];
    //    tmp = carry+(DTYPE_TMP)b[i]+(DTYPE_TMP)a[i];
    carry = (tmp >> sizeof(DTYPE)*8 );
    a[i] = (tmp & MAX_VAL);
    i++;
  }
  if(carry>0) {
    //    tmp = carry + (DTYPE_TMP)a[i];
    a[i]=a[i]+carry;
  }
}

static void _lshift_word(DTYPE *a, int lena, int nwords) {
  int i=lena-1;
  while(i>=nwords){
    a[i] = a[i - nwords];
    i--;
  }
  for (; i >= 0; --i)  {
    a[i] = 0;
  }  
}


void bignum_mul(DTYPE *a, DTYPE *b, DTYPE *c, int lena, int lenb) {
  int mmi, j;
  DTYPE_TMP intermediate ;
  int ii=lena-1;
  int iij=lenb-1;
  DTYPE_TMP tmp = 0;
  mmi=0;
  int lenj=( lena+lenb) +2;
  DTYPE row[lenj];
  DTYPE bnmtmp[lenj];
  int ik=0;
  while(mmi<=ii) {
    j=0;
    ik=0;
    while(ik<lenj) {
      row[ik]=0;
      ik++;
    }
    while(j<=iij){
      intermediate=0x0;
      intermediate+=a[mmi];
      intermediate*=b[j];
      //      intermediate = intermediate_a*intermediate_b;
      ik=0;
      while(ik<lenj) {
	bnmtmp[ik]=0;
	ik++;
      }
#ifdef WORD_SIZE
#if (WORD_SIZE == 1)
      bnmtmp[0] = (intermediate & 0x000000ff);
      bnmtmp[1] = (intermediate & 0x0000ff00) >> 8;
      bnmtmp[2] = (intermediate & 0x00ff0000) >> 16;
      bnmtmp[3] = (intermediate & 0xff000000) >> 24;
#elif (WORD_SIZE == 2)
      bnmtmp[0] = (intermediate & 0x0000ffff);
      bnmtmp[1] = (intermediate & 0xffff0000) >> 16;
#elif (WORD_SIZE == 4)
      bnmtmp[0] = intermediate;
      tmp = intermediate >> (sizeof(DTYPE)*8);
      bnmtmp[1] = tmp;
#endif
#endif
      _lshift_word(bnmtmp, lenj, mmi + j);
      bignum_add2(row, bnmtmp, lenj, lenj);
      j=j+1;
    }
    bignum_add2(c, row, lenj, lenj);
    mmi=mmi+1;
  }
  fflush(stdout);
}

int main(int argc, char *argv[] ) {
  char *buffer;
  int ssize=256;
  buffer=calloc(ssize, sizeof(char));
  char *temporal;
  memset(buffer, 0, ssize);
  char buff[2];
  int r=1;
  int rr=0;
  int rt=ssize;
  int offset=0;
  

  while(r>0) {
    r=fread(buff, sizeof(char), 1, stdin);
    if(buff[0] == '*') break;
    if(r<1) break;
    if(buff[0]>=0x30 && buff[0]<=0x46 && !(buff[0]>0x3A && buff[0]<0x41)) {
      buffer[rr]=buff[0];
      rr++;
    }
    while(rr>rt-1) {
      temporal=calloc(rr, sizeof(char));
      memcpy(temporal, buffer, rr);
      free(buffer);
      buffer=calloc(rr+ssize, sizeof(char));
      r=0;
      while(r<rr+ssize) {
	buffer[r]=0;
	r++;
      }
      memset(buffer, 0, rr+ssize);
      memcpy(buffer, temporal, rr);
      free(temporal);
      rt=rr+ssize;
    }
  }
  buffer[rr]=0;
  if(buff[0]!='*') {
    exit(1);
  }
  while(buffer[offset]=='0' && offset<rr-1) offset++;
  rr-=offset;
  int lena=rr/(sizeof(DTYPE)*2)+1;
  DTYPE Anum[lena];
  bignum_from_string(Anum, buffer+offset, rr, lena );
  r=0;
  while(r<rt) {
    buffer[r]=0;
    r++;
  }
  r=1;
  rr=0;
  while(r>0) {
    r=fread(buff, sizeof(char), 1, stdin);
    if(r<1) break;
    if(buff[0]>=0x30 && buff[0]<=0x46 && !(buff[0]>0x3A && buff[0]<0x41)) {
      buffer[rr]=buff[0];
      rr++;
    }
    while(rr>rt-1) {
      temporal=calloc(rr, sizeof(char));
      memcpy(temporal, buffer, rr);
      free(buffer);
      buffer=calloc(rr+ssize, sizeof(char));
      r=0;
      while(r<rr+ssize) {
	buffer[r]=0;
	r++;
      }
      memcpy(buffer, temporal, rr);
      free(temporal);
      rt=rr+ssize;
    }
  }
  buffer[rr]=0;
  if(rr<=1) {
    buffer[0]='0';
    buffer[1]=0;
  }
  r=0;
  offset=0;
  while(buffer[offset]=='0' && offset<rr-1) offset++;
  rr-=offset;
  int lenb=rr/(sizeof(DTYPE)*2)+1;
  DTYPE Bnum[lenb];
  bignum_from_string(Bnum, buffer+offset, rr, lenb);
  DTYPE resulta[lena+lenb+1];
  int l=0;
  while(l<sizeof(resulta)/sizeof(DTYPE)) {
    resulta[l]=0;
    l++;
  }
  /* l=0; */
  /* while(l<lena) { */
  /*   printf("%08X ", Anum[l]); */
  /*   l++; */
  /* } */
  /* printf("\n"); */
  /* l=0; */
  /* while(l<lenb) { */
  /*   printf("%08X ", Bnum[l]); */
  /*   l++; */
  /* } */
  bignum_mul(Anum, Bnum, resulta, lena, lenb);
  /* printf("\n"); */
  /* l=0; */
  /* while(l<lena+lenb) { */
  /*   printf("%08X ", resulta[l]); */
  /*   l++; */
  /* } */
  /* printf("\n"); */
  int lens=(sizeof(resulta)*2)+2;
  char str[lens];
  memset(str, 0, lens);
  bignum_to_string(resulta, sizeof(resulta)/sizeof(DTYPE), str);
  fwrite(str, 1, lens, stdout);
}
