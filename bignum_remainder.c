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
  #define DTYPE_TMP                uint32_t
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
#define BN_ARRAY_SIZE    (2048 / WORD_SIZE)
enum { SMALLER = -1, EQUAL = 0, LARGER = 1 };

/* Data-holding structure: array of DTYPEs */
struct bn {
  //DTYPE array[BN_ARRAY_SIZE];
  DTYPE *array;
  int len;
};

/* Functions for shifting number in-place. */
static void _lshift_one_bit(struct bn* a);
static void _rshift_one_bit(struct bn* a);
static void _lshift_word(struct bn* a, int nwords);
static void _rshift_word(struct bn* a, int nwords);

/* Public / Exported functions. */
void bignum_init(struct bn* n) {
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
  free(n->array);
  n->len=0;
}

void bignum_assign(struct bn* dst, struct bn* src) {
  int i;
  free(dst->array);
  dst->len=src->len-1;
  while(src->array[dst->len]==0) dst->len=dst->len-1;
  dst->len++;
  dst->array=calloc(dst->len+1, sizeof(DTYPE));
  i= dst->len;
  while(src->array[i]==0) i--;
  while(i >= 0) {
    dst->array[i] = src->array[i];
    i--;
  }
}

void bignum_from_int(struct bn* n, DTYPE_TMP i) {
 //require(n, "n is null");
  bignum_init(n);
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


int bignum_to_int(struct bn* n) {
 //require(n, "n is null");
  int ret = 0;
  /* Endianness issue if machine is not little-endian? */
#if (WORD_SIZE == 1)
  ret += n->array[0];
  ret += n->array[1] << 8;
  ret += n->array[2] << 16;
  ret += n->array[3] << 24;  
#elif (WORD_SIZE == 2)
  ret += n->array[0];
  ret += n->array[1] << 16;
#elif (WORD_SIZE == 4)
  ret += n->array[0];
#endif
  return ret;
}



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
      tmp=tmp+(tmpd*(pow(16,k)));
      n->array[j] = tmp;
      k++;
    } else {
      if(kk) break;
    }
    i--;    
  }
  n->len=j+1;
}

void bignum_to_string(struct bn* n, char* str,  int nbytes) {
  int j = n->len-1; //BN_ARRAY_SIZE; /* index into array - reading "MSB" first -> big-endian */
  int jj=0;
  int bsi = 0;                 /* index into string representation. */
  char strscanf[5];
  sprintf(strscanf, "%c%.02dX", '%', (2*WORD_SIZE));
  /* reading last array-element "MSB" first -> big endian */
  while(n->array[j]==0) {
    j--;
  }
  //j++;
  while (j >= 0) { //&& (nbytes > (i + 1))) {
    sprintf(&str[bsi], strscanf, n->array[j]);
    /*printf("en %d %s (j %d) [len %d] (%.08x)>\n", bsi, &str[bsi], j, strlen(str), n->array[j] );
      fflush(stdout);*/
    bsi+=(2*WORD_SIZE);
    //    if(bsi>nbytes-(2*WORD_SIZE) ) break;
    j -= 1;               /* step one element back in the array. */
  }
  /* Count leading zeros: */
  j = 0;
  while (str[j] == '0' && j<=strlen(str) ) {
    j += 1;
  }
  /*
  // Move string j places ahead, effectively skipping leading zeros
  if(j>0){
    bsi=0;
    while(bsi<=j){
      str[bsi] = str[bsi + j];
      bsi++;
    }
    str[bsi] = 0;
  } else str[bsi+1] = 0;
  // Zero-terminate string 
  */
}

int bignum_is_zero(struct bn* n) {
 //require(n, "n is null");
  int i;
  for (i = 0; i < n->len; ++i) {
    if (n->array[i]) {
      return 0;
    }
  }
  return 1;
}


void bignum_or(struct bn* a, struct bn* b) {
  int i;
  DTYPE tmp;
  for (i = 0; i < a->len; ++i) {
    tmp = (a->array[i] | b->array[i]);
    a->array[i]=tmp;
  }
}

int bignum_cmp(struct bn* a, struct bn* b) {
  int i = a->len-1;
  if(b->len<a->len) return LARGER;
  while(a->array[i] == 0 && b->array[i] == 0) {
    i--;
  }
  do {
    if (a->array[i] > b->array[i]) {
      return LARGER;
    } else if (a->array[i] < b->array[i]) {
      return SMALLER;
    }
    i--;
  }  while (i >= 0 /*!= 0*/ );
  return EQUAL;
}



void bignum_sub(struct bn* a, struct bn* b) {
  DTYPE_TMP res;
  DTYPE_TMP tmp1;
  DTYPE_TMP tmp2;
  int borrow = 0;
  int di=0;

  int ii;
  if(a->len > b->len) ii=b->len-1;
  else ii=a->len-1;
  while(di<a->len) {
    tmp1 = a->array[di] + (MAX_VAL + 1); /* + number_base */
    tmp2 = b->array[di] + borrow;;
    res = (tmp1 - tmp2);
    a->array[di] = (DTYPE)(res & MAX_VAL);
    borrow=0;
    borrow = (res <= MAX_VAL);
    di=di+1;
  }
}


void bignum_div(struct bn* a, struct bn* b, struct bn* c, struct bn* rem) {
  struct bn current;
  struct bn denom;
  struct bn tmp;
  struct bn tmp2;
  bignum_init_size(&denom, a->len);
  int a1=0;
  while(a1<b->len) {
    denom.array[a1]=b->array[a1];
    a1++;
  }
  bignum_init_size(&tmp, 1);
  bignum_assign(&tmp, a);                     // tmp   = a

  if(a->len > b->len) {
    bignum_init_size(c, a->len);
  }  else {
    bignum_init_size(c, b->len);
  }
  bignum_init_size(&current, c->len);
  current.array[0]=1;
  bignum_init_size(&tmp2, c->len);

  const DTYPE_TMP half_max = 1 + (DTYPE_TMP)(MAX_VAL / 2);
  int overflow = 0;
  while (bignum_cmp(&denom, a) != LARGER) {    // while (denom <= a) {
    if (denom.array[denom.len -1 ] >= half_max) {
      overflow = 1;
      break;
    }
    _lshift_one_bit(&current);                //   current <<= 1;
    _lshift_one_bit(&denom);                  //   denom <<= 1;
  }
  
  if (!overflow) {
    _rshift_one_bit(&denom);                  // denom >>= 1;
    _rshift_one_bit(&current);                // current >>= 1;
  }
  while (!bignum_is_zero(&current)) {          // while (current != 0)
    if (bignum_cmp(&tmp, &denom) != SMALLER) { //   if (dividend >= denom)
      bignum_sub(&tmp, &denom);         //     dividend -= denom;
      bignum_or(c, &current);              //     answer |= current;
    }
    _rshift_one_bit(&current);                //   current >>= 1;
    _rshift_one_bit(&denom);                  //   denom >>= 1;
  }                                           // return answer;
  bignum_init_size(rem, denom.len);
  bignum_assign(rem, &tmp);                     // tmp   = a
  bignum_free(&current);
  bignum_free(&denom);
  bignum_free(&tmp);
}


static void _lshift_one_bit(struct bn* a) {
  int i;
  for (i = (a->len - 1); i > 0; --i) {
    a->array[i] = (a->array[i] << 1) | (a->array[i - 1] >> ((8 * WORD_SIZE) - 1));
  }
  a->array[0] <<= 1;
}

static void _rshift_one_bit(struct bn* a) {
  int i=0;
  while (i < a->len-1) {
    a->array[i] = (a->array[i] >> 1) | (a->array[i + 1] << ((8 * WORD_SIZE) - 1));
    i++;
  }
  a->array[a->len - 1] >>= 1;
}

int main( int argc, char *argv[] ) {
  struct bn Anum;
  struct bn Bnum;
  struct bn numero;
  struct bn resulta;
  struct bn remainder;
  char *buf;
  buf=calloc(1024, sizeof(char));
  char *buffer;
  buffer=calloc(1024, sizeof(char));
  char *temporal;
  temporal=calloc(1024, sizeof(char));
  bzero(buf, 1024);
  bzero(buffer, 1024);
  bzero(temporal, 1024);
  char buff[2];
  int r=1;
  int rr=0;
  int rt=1024;
  
  if(argc>1) bignum_from_string(&Anum, argv[1], strlen(argv[1]), (strlen(argv[1])/8)+1 );
  else bignum_from_string(&Anum, "01", 2, 2 );

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
      buffer=calloc(rr+1024, sizeof(char));
      buf=calloc(rr+1024, sizeof(char));
      bzero(buffer, 1024);
      memcpy(buffer, temporal, rr);
      rt=rr+1024;
    }
  }
  buffer[rr]=0;
  if(rr<=1) {
    buffer[0]='0';
    buffer[1]=0;
  }
  r=0;
  bignum_from_string(&Bnum, buffer, rr, (rr/8)+1 );
  bignum_div(&Bnum, &Anum, &resulta, &remainder);
  bignum_to_string(&remainder, buf, sizeof(buf));
  printf("%s", buf);
}
