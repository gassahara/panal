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


//#define MAX_VAL                  ((DTYPE_TMP)0xFFFFFFFF)

/* Size of big-numbers in bytes */
#define BN_ARRAY_SIZE    (2 / WORD_SIZE)
/* Data-holding structure: array of DTYPEs */
struct bn {
  //DTYPE array[BN_ARRAY_SIZE];
  DTYPE *array;
  int len;
};

/* Functions for shifting number in-place. */
/* Public / Exported functions. */

void bignum_init(struct bn* n) {
 //require(n, "n is null");
  int i;
  i=0;
  n->array=calloc(BN_ARRAY_SIZE, sizeof(DTYPE));
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
  n->array=calloc(size, sizeof(DTYPE));
  n->len=size;
  while(i < size) {
    n->array[i] = 0;
    i++;
  }
}

void bignum_free(struct bn* n) {
 //require(n, "n is null");
  free(n->array);
}

void bignum_from_int(struct bn* n, DTYPE_TMP i) {
 //require(n, "n is null");
  //  bignum_init(n);
  bzero(n->array, n->len*sizeof(DTYPE));
  /* Endianness issue if machine is not little-endian? */
#ifdef WORD_SIZE
 #if (WORD_SIZE == 1)
  n->array[0] = (i & 0x000000ff);
  n->array[1] = (i & 0x0000ff00) >> 8;
  n->array[2] = (i & 0x00ff0000) >> 16;
  n->array[3] = (i & 0xff000000) >> 24;
 #elif (WORD_SIZE == 2)
  n->array[0] = (i & 0x0000ffff);
  n->array[1] = (i & 0xffff0000) >> 16;
 #elif (WORD_SIZE == 4)
  n->array[0] = i;
  DTYPE_TMP num_32 = 32;
  DTYPE_TMP tmp = i >> num_32; /* bit-shift with U64 operands to force 64-bit results */
  n->array[1] = tmp;
 #endif
#endif
}

void bignum_from_int_sin(struct bn* n, DTYPE_TMP i) {
 //require(n, "n is null");
  //  bignum_init(n);
  /* Endianness issue if machine is not little-endian? */
#ifdef WORD_SIZE
 #if (WORD_SIZE == 1)
  n->array[0] = (i & 0x000000ff);
  n->array[1] = (i & 0x0000ff00) >> 8;
  n->array[2] = (i & 0x00ff0000) >> 16;
  n->array[3] = (i & 0xff000000) >> 24;
 #elif (WORD_SIZE == 2)
  n->array[0] = (i & 0x0000ffff);
  n->array[1] = (i & 0xffff0000) >> 16;
 #elif (WORD_SIZE == 4)
  n->array[0] = i;
  DTYPE_TMP num_32 = 32;
  DTYPE_TMP tmp = i >> num_32; /* bit-shift with U64 operands to force 64-bit results */
  n->array[1] = tmp;
 #endif
#endif
}


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

void bignum_from_string(struct bn* n, char* str, int ll, int nbytes) {
  bignum_init(n);
  free(n->array);
  n->array=calloc(nbytes, sizeof(DTYPE));
  n->len=nbytes;
  memset(n->array, 0, nbytes*sizeof(DTYPE));
  char tmps[(2*WORD_SIZE)+1];
  DTYPE tmp;       
  int i = ll;// - (2 * WORD_SIZE); /* index into string */
  int j = 0;                        /* index into array */
  int k=0;
  int kk=0;
  int tmpd;
  char tmpc;
  int pasa=0;

  while(str[i]==0) i--;
  k=0;
  tmp=0;
  while (i >= 0) {
    if(k==(2*WORD_SIZE)) {
      k=0;
      j++;
      if(j>=n->len) {
	n->array=realloc(n->array, n->len*2);
	n->len=n->len*2;
      }
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
      tmp=tmp+HEX_VALS[k][tmpd]; //(tmpd*(pow(16,k)));
      n->array[j] = tmp;
      k++;
    } else {
      if(kk) break;
    }
    i--;    
  }
  n->len=j+1;
}

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


void bignum_add2(struct bn* a, struct bn* b) {
  DTYPE_TMP tmp;
  int carry = 0;
  int i;
  int ii=0;
  int jt=0;
  if( b->len == a->len) {
    if ( (b->array[b->len-1]+a->array[a->len-1]) < b->array[b->len-1] || (b->array[b->len-1]+a->array[a->len-1]) < a->array[a->len-1]) {
      DTYPE *temparray=malloc( (a->len+1)* WORD_SIZE);
      memset(temparray, 0, (a->len+1)*WORD_SIZE);
      jt=a->len;
      while(jt>=0) {
	temparray[jt]=a->array[jt];
	jt--;
      }
      free(a->array);
      a->array=calloc(b->len, WORD_SIZE);
      jt=a->len-1;
      while(jt>=0) {
	a->array[jt]=temparray[jt];
	jt--;
      }
      a->len=a->len+1;
      free(temparray);
    }
  }
  if(b->len > a->len) {
    DTYPE *temparray=malloc(b->len*WORD_SIZE);
    memset(temparray, 0, b->len*WORD_SIZE);
    jt=b->len;
    while(jt>=0) {
      temparray[jt]=a->array[jt];
      jt--;
    }
    a->len=b->len;
    free(a->array);
    a->array=calloc(b->len, WORD_SIZE);
    jt=b->len-1;
    while(jt>=0) {
      a->array[jt]=temparray[jt];
      jt--;
    }
    free(temparray);
  }
  i=0;
  ii=b->len;
  while(i<=b->len) {
    tmp = carry+(DTYPE_TMP)b->array[i]+(DTYPE_TMP)a->array[i];
    carry = (tmp > MAX_VAL);
    a->array[i] = (tmp & MAX_VAL);
    i++;
  }
  if(carry>0) {
    tmp = carry + (DTYPE_TMP)a->array[i];
    a->array[i]=a->array[i]+carry;
  }
}

static void _lshift_word(struct bn* a, int nwords)
{
  int i=a->len-1;
  while(i>=nwords){
    a->array[i] = a->array[i - nwords];
    i--;
  }
  for (; i >= 0; --i)
  {
    a->array[i] = 0;
    }  
}


void bignum_mul(struct bn* a, struct bn* b, struct bn* c) {
  struct bn row;
  struct bn bnmtmp;
  int mmi, j;
  DTYPE_TMP intermediate ;
  int ii=a->len-1;
  int iij=b->len-1;
  
  if(a->array[ii]==(DTYPE)0) {
    while(a->array[ii]==(DTYPE)0 && ii>=0) ii--;
    ii++;
  }
  if(b->array[iij]==(DTYPE)0) {
    while(b->array[iij]==(DTYPE)0 && iij>=0) iij--;
    iij++;
  }
  mmi=0;
  j=( (ii+1)+(iij+1) )+1; //a->len+b->len)+1;
  bignum_init_size(c, j);
  bignum_init_size(&row, j);
  bignum_init_size(&bnmtmp, j); //( (mmi+1) + (j+1) )+1);
  int ik=0;
  while(mmi<=ii) {
    j=0;
    ik=0;
    while(ik<row.len) {
      row.array[ik]=0;
      ik++;
    }
    while(j<=iij){
      intermediate = ((DTYPE_TMP)a->array[mmi] * (DTYPE_TMP)b->array[j]);
      ik=1;
      while(ik<bnmtmp.len) {
	bnmtmp.array[ik]=0;
	ik++;
      }
      bignum_from_int_sin(&bnmtmp, intermediate);
      _lshift_word(&bnmtmp, mmi + j);
      bignum_add2(&row, &bnmtmp);
      j=j+1;
    }
    bignum_add2(c, &row);
    mmi=mmi+1;
  }
  //bignum_free(&row);
  //bignum_free(&bnmtmp);
}

int main(int argc, char *argv[] ) {
  struct bn Anum;
  struct bn Bnum;
  struct bn resulta;
  char *buffer;
  int ssize=32;
  buffer=calloc(ssize, sizeof(char));
  char *temporal;
  temporal=calloc(ssize, sizeof(char));
  memset(buffer, 0, ssize);
  memset(temporal, 0, ssize);
  int zerostart=0;
  char buff[2];
  int r=1;
  int rr=0;
  int rt=ssize;
  

  while(r>0) {
    r=fread(buff, sizeof(char), 1, stdin);
    if(buff[0] == '*') break;
    if(r<1) break;
    if(!zerostart && buff[0]!='0') zerostart=1;
    if(zerostart) buffer[rr]=buff[0];
    rr++;
    while(rr>rt-1) {
      free(temporal);
      temporal=calloc(rr, sizeof(char));
      memcpy(temporal, buffer, rr);
      free(buffer);
      buffer=calloc(rr+ssize, sizeof(char));
      memset(buffer, 0, ssize);
      memcpy(buffer, temporal, rr);
      rt=rr+ssize;
    }
  }
  buffer[rr]=0;
  if(rr<1) {
    buffer[0]='0';
    buffer[1]=0;
  }
  if(buff[0]!='*') {
    exit(1);
  }
  bignum_from_string(&Anum, buffer, rr, (rr/8)+1 );
  bzero(buffer, rr);
  r=1;
  rr=0;
  while(r>0) {
    r=fread(buff, sizeof(char), 1, stdin);
    if(r<1) break;
    buffer[rr]=buff[0];
    rr++;
    while(rr>rt-1) {
      free(temporal);
      temporal=calloc(rr, sizeof(char));
      memcpy(temporal, buffer, rr);
      free(buffer);
      buffer=calloc(rr+ssize, sizeof(char));
      memset(buffer, 0, ssize);
      memcpy(buffer, temporal, rr);
      rt=rr+ssize;
    }
  }
  buffer[rr]=0;
  if(rr<1) {
    buffer[0]='0';
    buffer[1]=0;
  }
  r=0;
  bignum_from_string(&Bnum, buffer, rr, (rr/8)+1 );

  bignum_mul(&Bnum, &Anum, &resulta);
  printf("%s", bignum_to_string(&resulta));
}
