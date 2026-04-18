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



void bignum_dec(struct bn* n) {
 //require(n, "n is null");
  DTYPE tmp; /* copy of n */
  DTYPE res;

  int i;
  for (i = 0; i < n->len; ++i) {
    tmp = n->array[i];
    res = tmp - 1;
    n->array[i] = res;
    if (!(res > tmp)) {
      break;
    }
  }
}


void bignum_inc(struct bn* n) {
 //require(n, "n is null");
  DTYPE res;
  DTYPE_TMP tmp; /* copy of n */
  int i;
  for (i = 0; i < n->len; ++i) {
    tmp = n->array[i];
    res = tmp + 1;
    n->array[i] = res;

    if (res > tmp) {
      break;
    }
  }
}



void bignum_and(struct bn* a, struct bn* b, struct bn* c) {
  free(c->array);
  c->array=calloc(a->len, sizeof(DTYPE));
  int i;
  for (i = 0; i < c->len; ++i) {
    c->array[i] = (a->array[i] & b->array[i]);
  }
}


void bignum_or(struct bn* a, struct bn* b, struct bn* c) {
  free(c->array);
  c->array=calloc(a->len, sizeof(DTYPE));
  c->len=a->len;
  int i;
  for (i = 0; i < c->len; ++i) {
    c->array[i] = (a->array[i] | b->array[i]);
  }
}


void bignum_xor(struct bn* a, struct bn* b, struct bn* c) {
  free(c->array);
  c->array=calloc(a->len, sizeof(DTYPE));
  c->len=a->len;
  int i;
  for (i = 0; i < c->len; ++i) {
    c->array[i] = (a->array[i] ^ b->array[i]);
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


void bignum_add(struct bn* a, struct bn* b, struct bn* c) {
 //require(a, "a is null");
 //require(b, "b is null");
 //require(c, "c is null");
  DTYPE_TMP tmp;
  int carry = 0;
  int i, ii;
  bignum_init(c);
  free(c->array);
  if(a->len > b->len) {
    c->array=calloc(a->len, sizeof(DTYPE));
    c->len=a->len;
  }  else {
    c->array=calloc(b->len, sizeof(DTYPE));
    c->len=b->len;
  }
  //for (i = BN_ARRAY_SIZE-1; i>=0; --i) {
  ii=c->len;
  while(a->array[ii]==0 && b->array[ii]==0) ii--;
  ii++;
  i=0;
  while(i<=ii) {
    //  for (i = 0; i < BN_ARRAY_SIZE; ++i) {
    tmp = (DTYPE_TMP)a->array[i] + b->array[i] + carry;
    carry = (tmp > MAX_VAL);
    c->array[i] = (tmp & MAX_VAL);
    i++;
  }
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

  bignum_init(c);
  free(c->array);
  if(a->len > b->len) {
    c->array=calloc(a->len, sizeof(DTYPE));
    c->len=a->len;
  }  else {
    c->array=calloc(b->len, sizeof(DTYPE));
    c->len=b->len;
  }

  int ii=c->len-1;
  while(a->array[ii]<1) {
    ii--;
  }
  while(di < BN_ARRAY_SIZE && di<=ii) {
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
  fflush(stdout);
}


void bignum_mul(struct bn* a, struct bn* b, struct bn* c) {
  struct bn row;
  struct bn row_tmp;
  struct bn bnmtmp;
  int mmi, j;
  DTYPE_TMP intermediate ;
    printf("multing\n");
    fflush(stdout);
  bignum_init(c);
  bignum_init(&bnmtmp);
  int o=0;
  int ii=a->len;
  while(a->array[ii]==0) ii--;
  int iij=b->len;
  while(b->array[iij]==0) iij--;
  if(ii > (c->len/2) || iij > (c->len/2) ) {
    printf("realloc porque l %d ii %d ", c->len, ii);
    fflush(stdout);
    free(c->array);
    if(iij>ii) {
      c->array=calloc(iij*2, sizeof(DTYPE));
      c->len=iij*2;
    } else {
      c->array=calloc(ii*2, sizeof(DTYPE));
      c->len=ii*2;
    }
    printf("queda en %d ", c->len);
    fflush(stdout);
    bzero(c->array, c->len);
  }
    printf("A");
    fflush(stdout);
  mmi=0;
  while(mmi<=ii) {
    j=0;
    bignum_init(&row);
    bignum_init(&row_tmp);
    while(j<=iij){
      if ( (mmi + j) <= c->len) {
	//	printf("-");
	intermediate = ((DTYPE_TMP)a->array[mmi] * (DTYPE_TMP)b->array[j]);
	/*	printf("\n ----------\n A[%d](%.8x)*B[%d](%.8x)=%16x \n", mmi, a->array[mmi] , j, b->array[j], intermediate);
		fflush(stdout);*/
	bignum_free(&bnmtmp);
	bignum_from_int(&bnmtmp, intermediate);
        _lshift_word(&bnmtmp, mmi + j);
	bignum_free(&row_tmp);
        bignum_add(&bnmtmp, &row, &row_tmp);
	bignum_assign(&row, &row_tmp);
      }
      j=j+1;
    }
    bignum_free(&row_tmp);
    //    printf(" _________________\n ");
    fflush(stdout);
    bignum_add(c, &row, &row_tmp);
    bignum_assign(c, &row_tmp);
    fflush(stdout);
    bignum_free(&row);
    mmi=mmi+1;
  }
  printf("MULTED");
  fflush(stdout);
  bignum_free(&row_tmp);
  bignum_free(&bnmtmp);
}

void bignum_div(struct bn* a, struct bn* b, struct bn* c) {
  struct bn current;
  struct bn denom;
  struct bn tmp;
  bignum_init(&current);
  bignum_init(&denom);
  bignum_init(&tmp);
  current.array[0]=1;
  printf("F");

  bignum_init(c);
  free(c->array);
  if(a->len > b->len) {
    c->array=calloc(a->len, sizeof(DTYPE));
    c->len=a->len;
  }  else {
    c->array=calloc(b->len, sizeof(DTYPE));
    c->len=b->len;
  }

  bignum_assign(&denom, b);                   // denom = b
  bignum_assign(&tmp, a);                     // tmp   = a

  const DTYPE_TMP half_max = 1 + (DTYPE_TMP)(MAX_VAL / 2);
  int overflow = 0;
  
  while (bignum_cmp(&denom, a) != LARGER) {    // while (denom <= a) {
    if (denom.array[c->len -1 ] >= half_max) {
      overflow = 1;
      printf("!!!");
      break;
    }
    _lshift_one_bit(&current);                //   current <<= 1;
    _lshift_one_bit(&denom);                  //   denom <<= 1;
  }
  
  if (!overflow) {
    _rshift_one_bit(&denom);                  // denom >>= 1;
    _rshift_one_bit(&current);                // current >>= 1;
  }
  bignum_init(c);                             // int answer = 0;

  while (!bignum_is_zero(&current)) {          // while (current != 0)
    if (bignum_cmp(&tmp, &denom) != SMALLER) { //   if (dividend >= denom)
      bignum_sub(&tmp, &denom, &tmp);         //     dividend -= denom;
      bignum_or(c, &current, c);              //     answer |= current;
    }
    _rshift_one_bit(&current);                //   current >>= 1;
    _rshift_one_bit(&denom);                  //   denom >>= 1;

  }                                           // return answer;
  bignum_free(&current);
  bignum_free(&denom);
  bignum_free(&tmp);
}


void bignum_lshift(struct bn* a, struct bn* b, int nbits) {
  bignum_assign(b, a);
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


void bignum_rshift(struct bn* a, struct bn* b, int nbits)
{
 //require(a, "a is null");
 //require(b, "b is null");
 //require(nbits >= 0, "no negative shifts");
  
  bignum_assign(b, a);
  /* Handle shift in multiples of word-size */
  const int nbits_pr_word = (WORD_SIZE * 8);
  int nwords = nbits / nbits_pr_word;
  if (nwords != 0)
  {
    _rshift_word(b, nwords);
    nbits -= (nwords * nbits_pr_word);
  }

  if (nbits != 0)
  {
    int i;
    for (i = 0; i < (BN_ARRAY_SIZE - 1); ++i)
    {
      b->array[i] = (b->array[i] >> nbits) | (b->array[i + 1] << ((8 * WORD_SIZE) - nbits));
    }
    b->array[i] >>= nbits;
  }
  
}

void bignum_divmod(struct bn* a, struct bn* b, struct bn* c, struct bn* d) {
  /*
    Puts a%b in d
    and a/b in c

    mod(a,b) = a - ((a / b) * b)

    example:
      mod(8, 3) = 8 - ((8 / 3) * 3) = 2
  */
 //require(a, "a is null");
 //require(b, "b is null");
 //require(c, "c is null");

  struct bn tmp;

  /* c = (a / b) */
  bignum_div(a, b, c);

  /* tmp = (c * b) */
  bignum_mul(c, b, &tmp);

  /* c = a - tmp */
  bignum_sub(a, &tmp, d);
  bignum_free(&tmp);
}



void bignum_mod(struct bn* a, struct bn* b, struct bn* c)
{
  /*
    Take divmod and throw away div part
  */
 //require(a, "a is null");
 //require(b, "b is null");
 //require(c, "c is null");

  struct bn tmp;

  bignum_divmod(a,b,&tmp,c);
}



void bignum_pow(struct bn* a, struct bn* b, struct bn* c) {
 //require(a, "a is null");
 //require(b, "b is null");
 //require(c, "c is null");
  struct bn tmp;
  bignum_init(c);

  if (bignum_cmp(b, c) == EQUAL) {
    // Return 1 when exponent is 0 -- n^0 = 1
    bignum_inc(c);
  } else {
    // Copy a -> tmp 
    bignum_assign(&tmp, a);
    bignum_dec(b);
 
    // Begin summing products: 
    while (!bignum_is_zero(b)) {
      // c = tmp * tmp 
      bignum_mul(&tmp, a, c);
      // Decrement b by one 
      bignum_dec(b);

      bignum_assign(&tmp, c);
    }

    // c = tmp 
    bignum_assign(c, &tmp);
  }
}


void bignum_isqrt(struct bn *a, struct bn* b)
{
 //require(a, "a is null");
 //require(b, "b is null");

  struct bn low, high, mid, tmp;

  bignum_init(&low);
  bignum_assign(&high, a);
  bignum_rshift(&high, &mid, 1);
  bignum_inc(&mid);

  while (bignum_cmp(&high, &low) > 0) 
  {
    bignum_mul(&mid, &mid, &tmp);
    if (bignum_cmp(&tmp, a) > 0) 
    {
      bignum_assign(&high, &mid);
      bignum_dec(&high);
    }
    else 
    {
      bignum_assign(&low, &mid);
    }
    bignum_sub(&high,&low,&mid);
    _rshift_one_bit(&mid);
    bignum_add(&low,&mid,&mid);
    bignum_inc(&mid);
  }
  bignum_assign(b,&low);
}


/* Private / Static functions. */

static void _rshift_word(struct bn* a, int nwords)
{
  // Naive method: 
 //require(a, "a is null");
 //require(nwords >= 0, "no negative shifts");

  int i;
  if (nwords >= BN_ARRAY_SIZE)
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



static void _lshift_one_bit(struct bn* a) {
  //require(a, "a is null");
  int i;
  for (i = (BN_ARRAY_SIZE - 1); i > 0; --i) {
    a->array[i] = (a->array[i] << 1) | (a->array[i - 1] >> ((8 * WORD_SIZE) - 1));
  }
  a->array[0] <<= 1;
}


static void _rshift_one_bit(struct bn* a) {
 //require(a, "a is null");
  int i;
  for (i = 0; i < (BN_ARRAY_SIZE ); ++i) {
    a->array[i] = (a->array[i] >> 1) | (a->array[i + 1] << ((8 * WORD_SIZE) - 1));
  }
  a->array[BN_ARRAY_SIZE - 1] >>= 1;
}


static void pow_mod(struct bn* a, struct bn* x, struct bn* n, struct bn* result) {
  /*
   * Note that this code is sensitive to overflowing for testing
   * of large prime numbers.  The `a*r´ and `a*a´ operations can
   * overflow.  One easy way of solving this is to use 128-bit
   * precision for calculating a*b % n, since the mod operator
   * should always get us back to 64bits again.
   *
   * You can either use GCC's built-in __int128_t or use
   *
   * typedef unsigned int uint128_t __attribute__((mode(TI)));
   *
   * to create a 128-bit datatype.
   */
  struct bn r;
  struct bn tmp;
  struct bn tmp2;
  struct bn tmp3;
  char buff[2048];
  bignum_from_int(&r, 1);

  bignum_init(&tmp2);
  bignum_init(&tmp);
  
  bignum_to_string(a, buff, 2048);
  printf("\n a=%s\n", buff);
  bignum_to_string(x, buff, 2048);
  printf("\n x=%s\n", buff);
  bignum_to_string(n, buff, 2048);
  printf("\n n=%s\n", buff);
  
  while ( !bignum_is_zero(x) ) {
    bignum_free(&tmp);
    bignum_from_int(&tmp, 1);
    bignum_and(x, &tmp, &tmp2);
      
    if ( bignum_cmp(&tmp2, &tmp) == EQUAL ){
      printf("x1");
      fflush(stdout);
      //r = (__int128_t)a*r % n; // Slow
      bignum_free(&tmp);
      bignum_mul(&r, a, &tmp);
      
      bignum_to_string(&r, buff, 2048);
      printf("\n r(%s)", buff);
      bignum_to_string(a, buff, 2048);
      printf("*a(%s)=", buff);      
      bignum_assign(&r, &tmp);
      
      bignum_to_string(&r, buff, 2048);
      printf("%s\n", buff);
      
      printf("mul");
      fflush(stdout);

      if(bignum_cmp(&r, n) == LARGER ) {
	bignum_free(&tmp);
      	bignum_div(&r, n, &tmp);
	
	bignum_to_string(&tmp, buff, 2048);
	printf("\n c=(r/n)=%s\n", buff);
	fflush(stdout);
	bignum_free(&tmp2);
	bignum_mul(&tmp, n, &tmp2);
	
	bignum_to_string(&tmp2, buff, 2048);
	printf("\n c*n=%s\n", buff);
	fflush(stdout);
	
	bignum_free(&tmp);
	bignum_sub(&r, &tmp2, &tmp);
	printf("mod");
	fflush(stdout);
      } else {
	bignum_free(&r);
	bignum_init(&r);
	bignum_to_string(&tmp, buff, 2048);
	printf("\n r/n=%s\n", buff);
	fflush(stdout);
	
      }
      bignum_assign(&r, &tmp);
      
      bignum_to_string(&r, buff, 2048);
      printf("\n r=%s\n", buff);
      printf("assign");
      fflush(stdout);
      
      bignum_assign(result, &r);
      printf("result\n");
      fflush(stdout);
    }
    printf("x2");
    fflush(stdout);
    //      r = a*r % n;
    _rshift_one_bit(x);
    //x >>= 1;
    //a = (__int128_t)a*a % n; // SLow
      
    bignum_to_string(a, buff, 2048);
    printf("\n a(%s)*a=", buff);
    fflush(stdout);
    bignum_free(&tmp);
    bignum_mul(a, a, &tmp);
    bignum_assign(a, &tmp);
    
    bignum_to_string(a, buff, 2048);
    printf("%s\n", buff);
    fflush(stdout);
    
    bignum_free(&tmp);
    bignum_div(a, n, &tmp);
    
    bignum_to_string(&tmp, buff, 2048);
    printf("\n a/n=%s (%d)\n", buff, strlen(buff) );
    fflush(stdout);

    bignum_mul(&tmp, n, &tmp3);
    printf(">>>>>>>>>>>>>>>\n");
    fflush(stdout);
    bignum_free(&tmp3);
    
    bignum_to_string(&tmp3, buff, 2048);
    printf("\n (a/n)*n=%s\n", buff);
    fflush(stdout);

    bignum_free(&tmp);
    bignum_sub(a, &tmp3, &tmp);
    bignum_assign(a, &tmp);
    printf("a mod n = %x%x%x%x\n", a->array[3], a->array[2], a->array[1], a->array[0]);
    bignum_to_string(x, buff, 2048);
    //    if(strlen(buff)<1) break;
    printf("\nxxxxxxxxxxxxxxxxxxxx\n%s %d\nnnnnnnnnnnnnn\n\n", buff, strlen(buff));
    fflush(stdout);
    //a = a*a % n;      
    //  return r;
  }
}

int isprime(struct bn* n, int k) {
  // Must have ODD n greater than THREE
  struct bn cmp;
  struct bn tmp1;
  struct bn tmp2;
  struct bn m;
  struct bn t;
  struct bn d;
  struct bn a;
  struct bn x;
  int buff[128];
  int bff[2];
  char buffs[2049];
  char buff8[9];
  char bufffs[2048];
  char buffffs[2048];
  FILE *f;
  printf("||");
  bignum_init(&cmp);
  bignum_init(&tmp1);
  bignum_init(&tmp2);
  bignum_from_int(&cmp, 2);
  printf("<>");
  if ( bignum_cmp(n, &cmp) == EQUAL ) return 1;
  bignum_from_int(&cmp, 3);
  if ( bignum_cmp(n, &cmp) == EQUAL ) return 1;
  bignum_from_int(&cmp, 1);
  if ( bignum_cmp(n, &cmp) == SMALLER ) return 1;

  // Write n-1 as d*2^s by factoring powers of 2 from n-1
  int s = 0;
  bignum_init(&m);
  bignum_assign(&m, n);
  printf("0");
  bignum_free(&tmp1);
  bignum_init(&tmp1);
  bignum_sub(&m, &cmp, &tmp1);
  bignum_assign(&m, &tmp1);
  bignum_free(&cmp);
  bignum_from_int(&cmp, 1);
  printf("1");
  bignum_to_string(&m, bufffs, 2047);
  printf ("\nm %s \n", bufffs);
  fflush(stdout);
  bignum_and(&m, &cmp, &tmp1);
  bignum_init(&t);
  bignum_assign(&t, &tmp1);
  while(bignum_is_zero(&t)) {
    printf("s=%d\n ", s);
    s++;
    bignum_rshift(&m, &tmp1, 1);
    bignum_assign(&m, &tmp1);
    bignum_and(&m, &cmp, &tmp1);
    bignum_assign(&t, &tmp1);
  }
  bignum_free(&t);
  
  //  for ( uint64_t m = n-1; !(m & 1); ++s, m >>= 1 )
    ; // loop
  
  bignum_assign(&tmp1, n);
  bignum_free(&cmp);
  bignum_from_int(&cmp, 1);
  bignum_free(&tmp2);
  bignum_sub(&tmp1, &cmp, &tmp2);
  bignum_assign(&tmp1, &tmp2);
  bignum_free(&tmp2);
  bignum_from_int(&tmp2, 1<<s);
  bignum_div(&tmp1, &tmp2, &d);
  //  uint64_t d = (n-1) / (1<<s);
  
  for ( int i = 0; i < k; ++i ) {
    bignum_init(&a);
    bignum_from_int(&cmp, 2);
    bignum_assign(&tmp1, n);
    bignum_free(&tmp2);
    bignum_sub(&tmp1, &cmp, &tmp2);
    bignum_assign(&tmp1, &tmp2);
    
    while(bignum_cmp(&a, &cmp) != LARGER || bignum_cmp(&a, &tmp1) != SMALLER) {
      bignum_to_string(n, buffffs, 2049);
      f = fopen("/dev/urandom", "r");
      printf(" leyendo dev");
      int Wn=0;
      int o=strlen(buffffs)/8;
      bzero(buffs, sizeof(buffs) );
      while (Wn<o) {
	fread( bff, sizeof(int),1, f);
	buffs[Wn]=bff[0];
	bzero(bff, 2);
	Wn++;
      }
      fclose(f);
      bzero(bufffs, 2048 );
      bzero(buff8, 9 );
      Wn=0;
      
      int nn=0;
      printf("\n====\n");
      while(Wn<strlen(buffs)) {
	sprintf(buff8, "%.08x", buffs[Wn]);
	    printf("%.08x ", buffs[Wn]);
	nn=0;
	while(buff8[nn]!=0) {
	  bufffs[(Wn*8)+nn]= buff8[nn];
	  nn++;
	}
	printf("\n====\n");
	//    printf("\n %.08x (%d) %s", buff[n], n, buffs);
	Wn++;
      }
      printf("\nA deberia %s\n", bufffs);
      bignum_from_string(&a, bufffs, strlen(bufffs));
    }
    printf ("\n                          ESCOGIDO    \n");
    fflush(stdout);

    bignum_to_string(&a, bufffs, 2047);
    printf ("\na %s \n", bufffs);
    fflush(stdout);
    bignum_to_string(&d, bufffs, 2047);
    printf ("\nd %s \n", bufffs);
    fflush(stdout);
    bignum_to_string(n, bufffs, 2047);
    printf ("\nn %s \n", bufffs);
    fflush(stdout);
    
    
    bignum_init(&x);
    pow_mod(&a, &d, n, &x);

    bignum_to_string(&x, bufffs, 2047);
    printf ("\nx %d <<<<<<<<<<< %s \n", s, bufffs);
    fflush(stdout);
    

    //    uint64_t x = pow_mod(a,d,n);
    bignum_from_int(&tmp1, 1);
    bignum_assign(&tmp2, n);
    bignum_sub(&tmp2, &tmp1, &tmp2);
    if( bignum_cmp(&x, &tmp1) == EQUAL || bignum_cmp(&x, &tmp2) == EQUAL )  continue;

    for ( int rrr = 1; rrr <= s-1; ++rrr ) {
      bignum_from_int(&tmp1, 2);
      printf ("\npowmod2 %d \n", rrr);
      fflush(stdout);
      bignum_free(&tmp2);
      bignum_init(&tmp2);
      pow_mod(&x, &tmp1, n, &tmp2);
      bignum_assign(&x, &tmp2);
      printf ("\npowmod3\n");
      fflush(stdout);
      //      x = pow_mod(x, 2, n);
      bignum_from_int(&tmp1, 1);
      if( bignum_cmp(&x, &tmp1) == EQUAL  ) return 0;
      //if ( x == 1 ) return false;
      if( bignum_cmp(&x, &tmp2) == EQUAL  ) goto LOOP;
      //      if ( x == n - 1 ) goto LOOP;
    }

    return 0;
  LOOP:
    continue;        
  }
  // n is *probably* prime
  
  return 1;
}


#define Anums "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000"
int main() {
  struct bn Anum;
  struct bn Bnum;
  struct bn numero;
  struct bn resulta;
  struct bn resultb;
  char buf[8192];
  char buffer[2048];
  char buff[2];
  int r=1;
  int rr=0;
  //  bignum_from_string(&Anum, "50", 3);
  
  bignum_init(&Anum);
  bignum_from_string(&Anum, Anums, strlen(Anums));

  bzero(buf, sizeof(buf));
  bignum_to_string(&Anum, buf, sizeof(buf));
  printf("\n A %s ", buf);
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
    printf("%c ", buffer[2048-r]);
    r++;
  }
  printf("%d ..." , r);
  while(r<=2048) {
    buffer[2048-r]='0';
    r++;
  }

  bignum_init(&Bnum);
  bignum_from_string(&Bnum, buffer, 2048 );
  bzero(buf, sizeof(buf));
  bignum_to_string(&Bnum, buf, sizeof(buf));  
  printf(" B %s %d -_-_-_-_", buf);

  /*  
  bignum_free(&resulta);
  bignum_init(&resulta);
  bignum_add(&Bnum, &Anum, &resulta);
  bignum_to_string(&resulta, buf, sizeof(buf));
  printf("\n SUMA %s %d  -=-=-=-=-=-=-=-=-", buf);
  
  bignum_free(&resulta);
  bignum_init(&resulta);
  bignum_sub(&Bnum, &Anum, &resulta);
  bignum_to_string(&resulta, buf, sizeof(buf));
  printf("\n RESTA %s %d  -=-=-=-=-=-=-=-=-", buf);
  
  bignum_free(&resulta);
  bignum_init(&resulta);
  bignum_div(&Bnum, &Anum, &resulta);
  bignum_to_string(&resulta, buf, sizeof(buf));
  printf("\n COCIENTE %s ", buf);
  
  bignum_init(&resulta);
  bignum_mul(&Bnum, &Bnum, &resulta);
  bignum_to_string(&resulta, buf, sizeof(buf));
  printf("\n MUL %s %d  -=-=-=-=-=-=-=-=-", buf, strlen(buf));
  */
  
  printf("\n PRIMALIDAD\n");
  printf("  %d ES PRIMO -_-_-_-_", isprime(&Bnum, 10));  

}
