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
static void _lshift_word(struct bn* a, int nwords);

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


void bignum_from_int(struct bn* n, DTYPE_TMP i, int len) {
 //require(n, "n is null");
  bignum_init(n);
  n->array=calloc(len, sizeof(DTYPE) );
  int li=0;
  while(li<len) {
    n->array[li]=0;
    li++;
  }
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


void bignum_mete_int(struct bn* n, DTYPE_TMP i, int indice) {
  /* Endianness issue if machine is not little-endian? */
#ifdef WORD_SIZE
 #if (WORD_SIZE == 1)
  n->array[indice+0] = (i & 0x000000ff);
  n->array[indice+1] = (i & 0x0000ff00) >> 8;
  n->array[indice+2] = (i & 0x00ff0000) >> 16;
  n->array[indice+3] = (i & 0xff000000) >> 24;
 #elif (WORD_SIZE == 2)
  n->array[indice+0] = (i & 0x0000ffff);
  n->array[indice+1] = (i & 0xffff0000) >> 16;
 #elif (WORD_SIZE == 4)
  n->array[indice] = i;
  DTYPE_TMP num_32 = 32;
  DTYPE_TMP tmp = i >> num_32; /* bit-shift with U64 operands to force 64-bit results */
  n->array[indice+1] = tmp;
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



void bignum_add(struct bn* a, struct bn* b, struct bn* c) {
  DTYPE_TMP tmp;
  int carry = 0;
  int i, ii;
  //for (i = BN_ARRAY_SIZE-1; i>=0; --i) {
  ii=c->len;
  while(a->array[ii]==0 && b->array[ii]==0) ii--;
  ii++;
  i=0;
  while(i<=ii && i<b->len && i<a->len ) {
    //  for (i = 0; i < BN_ARRAY_SIZE; ++i) {
    tmp = (DTYPE_TMP)a->array[i] + b->array[i] + carry;
    carry = (tmp > MAX_VAL);
    c->array[i] = (tmp & MAX_VAL);
    i++;
  }
}


void bignum_mul(struct bn* a, struct bn* b, struct bn* c) {
  struct bn row;
  struct bn row_tmp;
  struct bn bnmtmp;
  int mmi, j;
  DTYPE_TMP intermediate ;
  bignum_from_int(&bnmtmp, intermediate, c->len+2);
  int o=0;
  int ii=a->len;
  while(a->array[ii]==0) ii--;
  int iij=b->len;
  while(b->array[iij]==0) iij--;
  if (ii > 0 || iij > 0) {
    if(ii > (c->len/2) || iij > (c->len/2) ) {
      free(c->array);
      if(iij>ii) {
	c->array=calloc(iij*2, sizeof(DTYPE));
	c->len=iij*2;
      } else {
	c->array=calloc(ii*2, sizeof(DTYPE));
	c->len=ii*2;
      }
      bzero(c->array, c->len);
    }
  }
  //    printf("\n%d %d %d\n", c->len, ii, iij);
  //    fflush(stdout);
    bignum_init(&row_tmp);
    free(row_tmp.array);
    row_tmp.array=calloc(c->len, sizeof(DTYPE));
    bzero(row_tmp.array, c->len);
    bignum_init(&row);
    free(row.array);
    row.array=calloc(c->len, sizeof(DTYPE));
    bzero(row.array, c->len);

    mmi=0;
  int ti=0;
  while(mmi<=ii) {
    j=0;
    ti=0;
    while(ti< c->len) {
      row_tmp.array[ti]=0;
      ti++;
    }
    while(j<=iij){
      if ( (mmi + j) <= c->len ) {
	intermediate = ((DTYPE_TMP)a->array[mmi] * (DTYPE_TMP)b->array[j]);
	//	printf("\n ----------\n A[%d](%.8x)*B[%d](%.8x)=%16x \n", mmi, a->array[mmi] , j, b->array[j], intermediate);
	//	fflush(stdout);
	//       	printf("m");
	//		fflush(stdout);
	bignum_mete_int(&bnmtmp, intermediate, 0);
	//		printf("i");
	//		fflush(stdout);
	_lshift_word(&bnmtmp, mmi + j);
	//		printf("s");
	//		fflush(stdout);
	ti=0;
	while(ti< c->len) {
	  row_tmp.array[ti]=0;
	  ti++;
	}
	bignum_add(&bnmtmp, &row, &row_tmp);
	bignum_assign(&row, &row_tmp);
      }
      j=j+1;
    }
    //    printf(".");
    //    fflush(stdout);
    ti=0;
    while(ti< c->len) {
      row_tmp.array[ti]=0;
      ti++;
    }
    bignum_add(c, &row, &row_tmp);
    bignum_assign(c, &row_tmp);
    ti=0;
    while(ti< c->len) {
      row.array[ti]=0;
      ti++;
    }
    mmi=mmi+1;
  }
  bignum_free(&row_tmp);
  bignum_free(&bnmtmp);
  //  printf("MULTED\n");
  //  fflush(stdout);
}

void bignum_pow(struct bn* a, struct bn* b, struct bn* c) {
  struct bn tmp;
  bignum_init(c);
  bignum_init(&tmp);
  fflush(stdout);
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
      //            printf("%x%x \n", b->array[1], b->array[0] );
      //            fflush(stdout);
      bignum_mul(&tmp, a, c);
      // Decrement b by one 
      bignum_dec(b);
      bignum_assign(&tmp, c);
    }

    // c = tmp 
    bignum_assign(c, &tmp);
  }
}


/* Private / Static functions. */

static void _lshift_word(struct bn* a, int nwords)
{
 //require(a, "a is null");
 //require(nwords >= 0, "no negative shifts");

  int i;
  /* Shift whole words */
  for (i = (a->len - 1); i >= nwords; --i)
  {
    a->array[i] = a->array[i - nwords];
  }
  /* Zero pad shifted words. */
  for (; i >= 0; --i)
  {
    a->array[i] = 0;
  }  
}


int main(int argc, char *argv[] ) {
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
  
  if(argc>1) bignum_from_string(&Anum, argv[1], strlen(argv[1]) );
  else bignum_from_string(&Anum, "01", 2 );

  bzero(buf, sizeof(buf));
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
  bzero(buf, sizeof(buf));

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
  */
  bignum_pow(&Bnum, &Anum, &resulta);
  bignum_to_string(&resulta, buf, sizeof(buf));
  printf("%s", buf, strlen(buf));
  
  /*
  printf("\n PRIMALIDAD\n");
  printf("  %d ES PRIMO -_-_-_-_", isprime(&Bnum, 10));  
  */
}
