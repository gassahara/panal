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


#define ciL    (sizeof(DTYPE))         /* chars in limb  */
#define biL    (ciL << 3)               /* bits  in limb  */
#define biH    (ciL << 2)               /* half limb size */


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
static void _lshift_word(struct bn* a, int nwords);
static void _rshift_word(struct bn* a, int nwords);

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

void bignum_free(struct bn* n) {
 //require(n, "n is null");
  free(n->array);
}

void bignum_assign(struct bn* dst, struct bn* src) {
  int i;
  free(dst->array);
  dst->array=calloc(src->len, sizeof(DTYPE));
  dst->len=src->len;
  for (i = 0; i <= dst->len; ++i) {
    dst->array[i] = src->array[i];
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



void bignum_from_string(struct bn* n, char* str, int nbytes) {
  bignum_init(n);
  char tmps[(2*WORD_SIZE)+1];
  DTYPE tmp;       
  int i = nbytes;// - (2 * WORD_SIZE); /* index into string */
  int j = 0;                        /* index into array */
  char strscanf[5];
  int ntmps, ntmps2;
  int pasa=0;
  
  bzero(tmps, (2*WORD_SIZE)+1);
  bzero(strscanf, 5);
  sprintf(strscanf, "%c%.02dx", '%', (2*WORD_SIZE));
  while (i > 0) {
    pasa=0;
    tmp = 0;
    /*
    if(nbytes<(2*WORD_SIZE)) ntmps=2*WORD_SIZE-1;
    else ntmps=2*WORD_SIZE+1;*/
    ntmps=2*WORD_SIZE;
    ntmps2=1;
    while(ntmps>=0 && ntmps2<=nbytes && (i-ntmps) >=0) {
      tmps[ntmps]=str[i-ntmps2];
      ntmps--;
      ntmps2++;
      pasa=1;
    }
    while(ntmps>=0) {
      tmps[ntmps]='0';
      ntmps--;
    }
    if(pasa>0) {
      sscanf(tmps, strscanf, &tmp);
      //      printf("\n c1 %c c2 %c s (%s) d %d x %x \n", str[i-1], str[i], tmps, tmp, tmp);
      n->array[j] = tmp;
      j=j+1;               /* step one element forward in the array. */
      if(j>=n->len) {
	n->array=realloc(n->array, n->len*2);
	n->len=n->len*2;
      }
    }
    i=i-(2*WORD_SIZE);
  }
  if(i<0) {
    i=i+(2*WORD_SIZE);
    ntmps=(2*WORD_SIZE);
    bzero(tmps, (2*WORD_SIZE)+1);
    while(i>=0) {
      tmps[ntmps]=str[i];
      ntmps--;
      i--;
    }
    while(ntmps>=0) {
      tmps[ntmps]='0';
      ntmps--;
    }      
    sscanf(tmps, strscanf, &tmp);
    n->array[j] = tmp;
  }
  //printf("--------- %d %d /n", i, j);
}



void bignum_to_string(struct bn* n, char* str, int nbytes)
{
  int j = n->len; //BN_ARRAY_SIZE; /* index into array - reading "MSB" first -> big-endian */
  int jj=0;
  int bsi = 0;                 /* index into string representation. */
  char strscanf[5];
  sprintf(strscanf, "%c%.02dx", '%', (2*WORD_SIZE));
  /* reading last array-element "MSB" first -> big endian */
  while(n->array[j]==0) {
    j--;
  }
  while ((j >= 0) && j>=jj) { //&& (nbytes > (i + 1))) {
    sprintf(&str[bsi], strscanf, n->array[j]);    
    //    printf("en %d %s (%d) [%d]> ", bsi, &str[bsi], j, strlen(str) );
    //    fflush(stdout);
    bsi+=(2*WORD_SIZE);
    if(bsi>nbytes-(2*WORD_SIZE) ) break;
    j -= 1;               /* step one element back in the array. */
  }
  /* Count leading zeros: */
  j = 0;
  while (str[j] == '0' && j<=nbytes) {
    j += 1;
  }
   
  // Move string j places ahead, effectively skipping leading zeros 
  if(j>0){
    bsi=0;
    while(bsi<nbytes){
      str[bsi] = str[bsi + j];
      bsi++;
    }
  }
  // Zero-terminate string 
  str[bsi] = 0;
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


void bignum_or(struct bn* a, struct bn* b, struct bn* c) {
  int i;
  for (i = 0; i < c->len; ++i) {
    c->array[i] = (a->array[i] | b->array[i]);
  }
}

int bignum_cmp(struct bn* a, struct bn* b) {
  int i = a->len-1;
  while(a->array[i] < 1 && b->array[i]<1) {
    i--;
  }
  do {
    if (a->array[i] > b->array[i]) {
      return LARGER;
    } else if (a->array[i] < b->array[i]) {
      return SMALLER;
    }
    i--;
  }  while (i > 0 /*!= 0*/ );
  return EQUAL;
}



void bignum_sub(struct bn* a, struct bn* b, struct bn* c) {
 //require(a, "a is null");
 //require(b, "b is null");
 //require(c, "c is null");
  DTYPE_TMP res;
  DTYPE_TMP tmp1;
  DTYPE_TMP tmp2;
  int borrow = 0;
  int di=0;
  int ti=0;
  while (ti<c->len) {
    c->array[ti]=0;
    ti++;
  }

  int ii;
  if(a->len > b->len) ii=b->len-1;
  else ii=a->len-1;
  while(di<=ii) {
  // for (i = 0; i < BN_ARRAY_SIZE; ++i) {
  // for (i = BN_ARRAY_SIZE-1; i>=0; --i) {
    tmp1 = a->array[di] + (MAX_VAL + 1); /* + number_base */
    tmp2 = b->array[di] + borrow;;
    res = (tmp1 - tmp2);
    c->array[di] = (DTYPE)(res & MAX_VAL); /* "modulo number_base" == "% (number_base - 1)" if number_base is 2^N */
    //    printf("A%xB%x a %x b %08x i %x bo %d", a->array[di], b->array[di], tmp1, tmp2, di, borrow);
    //    printf(">> %x <<<\n", res);
    borrow=0;
    borrow = (res <= MAX_VAL);
    di=di+1;
  }
}


/*
 * Return the number of less significant zero-bits
 */
int bignum_lsb( struct bn *X ) {
    int i, j, count = 0;
    for( i = 0; i < X->len; i++ )
        for( j = 0; j < biL; j++, count++ )
            if( ( ( X->array[i] >> j ) & 1 ) != 0 )
                return( count );
    return( 0 );
}


void bignum_lshift(struct bn* a, struct bn* b, int nbits) {
  bignum_assign(b, a);
  if(nbits>0){
  /* Handle shift in multiples of word-size */
  const int nbits_pr_word = (WORD_SIZE * 8);
  int nwords = nbits / nbits_pr_word;
  if (nwords != 0)
  {
    _lshift_word(b, nwords);
    nbits -= (nwords * nbits_pr_word);
  }

  if (nbits != 0)
  {
    int i;
    for (i = (b->len - 1); i >= 0; --i)
    {
      b->array[i] = (b->array[i] << nbits) | (b->array[i - 1] >> ((8 * WORD_SIZE) - nbits));
    }
    b->array[i] <<= nbits;
  }
  }
}


void bignum_rshift(struct bn* a, struct bn* b, int nbits)
{
  //require(a, "a is null");
  //require(b, "b is null");
  //require(nbits >= 0, "no negative shifts");
    bignum_assign(b, a);
  if(nbits>0) {  
    /* Handle shift in multiples of word-size */
    const int nbits_pr_word = (WORD_SIZE * 8);
    int nwords = nbits / nbits_pr_word;
    if (nwords != 0) {
      _rshift_word(b, nwords);
      nbits -= (nwords * nbits_pr_word);
    }

    if (nbits != 0) {
      int i;
      for (i = 0; i < (b->len - 1); ++i)
	{
	  b->array[i] = (b->array[i] >> nbits) | (b->array[i + 1] << ((8 * WORD_SIZE) - nbits));
	}
      b->array[i] >>= nbits;
    }
  }
}

/* Private / Static functions. */

static void _rshift_word(struct bn* a, int nwords)
{
  // Naive method: 
 //require(a, "a is null");
 //require(nwords >= 0, "no negative shifts");

  int i;
  if (nwords >= a->len)
  {
    for (i = 0; i < BN_ARRAY_SIZE; ++i)
    {
      a->array[i] = 0;
    }
    return;
  }

  for (i = 0; i < BN_ARRAY_SIZE - nwords; ++i)
  {
    a->array[i] = a->array[i + nwords];
  }
  for (; i < BN_ARRAY_SIZE; ++i)
  {
    a->array[i] = 0;
  }
}

static void _lshift_word(struct bn* a, int nwords)
{
 //require(a, "a is null");
 //require(nwords >= 0, "no negative shifts");

  int i;
  /* Shift whole words */
  for (i = (BN_ARRAY_SIZE - 1); i >= nwords; --i)
  {
    a->array[i] = a->array[i - nwords];
  }
  /* Zero pad shifted words. */
  for (; i >= 0; --i)
  {
    a->array[i] = 0;
  }  
}

/*
 * Count leading zero bits in a given integer
 */
static size_t mbedtls_clz( DTYPE x )
{
    size_t j;
    DTYPE mask = (DTYPE) 1 << (biL - 1);

    for( j = 0; j < biL; j++ )
    {
        if( x & mask ) break;

        mask >>= 1;
    }

    return j;
}

/*
 * Return the number of bits
 */
size_t bignum_bitlen( struct bn *X )
{
    size_t i, j;

    if( X->len == 0 )
        return( 0 );

    for( i = X->len - 1; i > 0; i-- )
        if( X->array[i] != 0 )
            break;

    j = biL - mbedtls_clz( X->array[i] );

    return( ( i * biL ) + j );
}


int main( int argc, char *argv[] ) {
  struct bn Bnum;
  char buffer[2048];
  char buff[2];
  int r=1;
  int rr=0;
  //  bignum_from_string(&Anum, "50", 3);
  
  bzero(buffer, 2048);
  while(r>0) {
    r=fread(buff, sizeof(char), 1, stdin);
    if(r<1) break;
    buffer[rr]=buff[0];
    rr++;
  }
  r=0;
  while(r<=rr) {
    buffer[2048-r]=buffer[rr-r];
    r++;
  }
  while(r<=2048) {
    buffer[2048-r]='0';
    r++;
  }

  bignum_init(&Bnum);
  bignum_from_string(&Bnum, buffer, 2048 );
  printf("%ld", bignum_bitlen(&Bnum) );
}
