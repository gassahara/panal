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

void limpia(DTYPE *a) {
  int limpiai=0;
  while(limpiai<sizeof(a)) {
    a[limpiai]=0;
    limpiai++;
  }
}


void bignum_from_string(DTYPE *n, char* str, int ll, int nbytes) {
  limpia(n);
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
  int jj=0;
  int jjj=0;
  int jjjj=lenn*(WORD_SIZE*2)-1;
  int tmpc=0;
  while (j<lenn) {
    nj=n[j];
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
	if(jjjj<0) break; //return str;
	tmpc=0;
	jjj=0;
      }
      nj=nj>>1;
      jj++;
    }
    jj=0;
    j++;
  }
}


void bignum_add2(DTYPE *a, DTYPE *b, int lena, int lenb) {
  DTYPE_TMP tmp;
  int carry = 0;
  int i;
  int ii=0;
  int jt=0;
  if( lenb == lena) {
    if ( (b[lenb-1]+a[lena-1]) < b[lenb-1] || (b[lenb-1]+a[lena-1]) < a[lena-1]) {
      DTYPE temparray[lenb];
      jt=0;
      while(jt<lena) {
	temparray[jt]=a[jt];
	jt++;
      }
      limpia(temparray);
      a=temparray;
    }
  }
  if(lenb > lena) {
      DTYPE temparray[lenb];
      jt=0;
      while(jt<lena) {
	temparray[jt]=a[jt];
	jt++;
      }
      limpia(temparray);
      memset(temparray+jt, 0, lenb-lena*WORD_SIZE);
      a=temparray;
  }
  i=0;
  ii=lenb;
  while(i<=lenb) {
    tmp = carry+(DTYPE_TMP)b[i]+(DTYPE_TMP)a[i];
    carry = (tmp > MAX_VAL);
    a[i] = (tmp & MAX_VAL);
    i++;
  }
  if(carry>0) {
    tmp = carry + (DTYPE_TMP)a[i];
    a[i]=a[i]+carry;
  }
}


void _rshift_word(DTYPE *a, int nwords) {
  int i;
  if (nwords >= sizeof(a) ) {
    for (i = 0; i < sizeof(a); ++i) {
      a[i] = 0;
    }
    return;
  }

  for (i = 0; i < sizeof(a) - nwords; ++i) {
    a[i] = a[i + nwords];
  }
  for (; i < sizeof(a); ++i) {
    a[i] = 0;
  }
}

void bignum_rshift(DTYPE *a, int nbits) {
  const int nbits_pr_word = (WORD_SIZE * 8);
  int nwords = nbits / nbits_pr_word;
  if (nwords != 0)  {
    _rshift_word(a, nwords);
    nbits -= (nwords * nbits_pr_word);
  }

  if (nbits != 0) {
    int i;
    for (i = 0; i < (sizeof(a) - 1); ++i) {
      a[i] = (a[i] >> nbits) | (a[i + 1] << ((8 * WORD_SIZE) - nbits));
    }
    a[i] >>= nbits;
  }
  
}


static void _lshift_word(DTYPE *a, int lena, int nwords)
{
  int i=lena-1;
  while(i>=nwords){
    a[i] = a[i - nwords];
    i--;
  }
  for (; i >= 0; --i) {
    a[i] = 0;
  }  
}


void bignum_mul(DTYPE *a, DTYPE *b, DTYPE *c, int lena, int lenb) {
  int mmi, j;
  DTYPE_TMP intermediate ;
  int ii=lena-1;
  int iij=lenb-1;
  
  if(a[ii]==(DTYPE)0) {
    while(a[ii]==(DTYPE)0 && ii>=0) ii--;
    ii++;
  }
  if(b[iij]==(DTYPE)0) {
    while(b[iij]==(DTYPE)0 && iij>=0) iij--;
    iij++;
  }
  mmi=0;
  int lenj=( (ii+1)+(iij+1) )+1; //sizeof(a)+sizeof(b))+1;
  DTYPE row[lenj+1];
  DTYPE bnmtmp[lenj+1];
  int ik=0;
  int i;
  while(mmi<=ii) {
    j=0;
    ik=0;
    while(ik<lenj) {
      row[ik]=0;
      ik++;
    }
    while(j<=iij){
      intermediate = ((DTYPE_TMP)a[mmi] * (DTYPE_TMP)b[j]);
      ik=1;
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
      DTYPE_TMP num_32 = 32;
      DTYPE_TMP tmp = intermediate >> num_32; /* bit-shift with U64 operands to force 64-bit results */
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
}


DTYPE *bignum_to_bignum_desde_hasta(DTYPE *n, DTYPE *nsale, int desde, int hasta) {
  int j=(hasta-desde);
  if(hasta<=desde) return NULL;
  int desdeb=0;
  if(desde%(WORD_SIZE*8)!=0) {
    desdeb=(WORD_SIZE*8) - (desde%(WORD_SIZE*8));
    j+=desdeb;
  }
  desdeb=desde-desdeb;
  if(hasta%(WORD_SIZE*8)!=0) {
    j+=(WORD_SIZE*8) - hasta%(WORD_SIZE*8);
  }
  int desdei=0;
  while(desdei<sizeof(nsale)) {
    nsale[desdei]=0;
    desdei++;
  }
  memcpy(nsale, n+desdeb, (j/8));
  desdei=0;
  if( (desde%(WORD_SIZE*8)) !=0 ) {
    desdeb=(WORD_SIZE*8) - (desde%(WORD_SIZE*8));
    desdei=(int)floor(desdeb/8);
    desdeb-=desdei*8;
    n[desdeb]<<=desdeb;
    n[desdeb]>>=desdeb;
  }
  if( (hasta%(WORD_SIZE*8)) !=0 ) {
    desdei=(int)floor(desdeb/8);
    desdeb=(WORD_SIZE*8) - (hasta%(WORD_SIZE*8));
    bignum_rshift(nsale, desdeb);
  }
  return nsale;
}


void bignum_add_dtype(DTYPE *a, DTYPE b) {
  DTYPE_TMP tmp;
  int carry = 0;
  int ii=0;
  tmp = carry+b+(DTYPE_TMP)a[0];
  carry = (tmp > MAX_VAL);
  a[0] = (tmp & MAX_VAL);
  if(carry>0) {
    a[1]=a[1]+carry;
  }
}


void bignum_sub(DTYPE *a, DTYPE *b, DTYPE *c) {
  DTYPE_TMP res;
  DTYPE_TMP tmp1;
  DTYPE_TMP tmp2;
  int borrow = 0;
  int di=0;
  if(sizeof(a)<sizeof(b)) return;
  if(sizeof(c)<sizeof(a)) return;
  di=0;
  while(di<sizeof(c)) {
    c[di]=0;
    di++;
  }
  int ii;
  if(sizeof(a) > sizeof(b)) ii=sizeof(b)-1;
  else ii=sizeof(a)-1;
  //  if(ii==-1) ii=0;
  while(di<sizeof(a)) {
  // for (i = 0; i < BN_ARRAY_SIZE; ++i) {
  // for (i = BN_ARRAY_SIZE-1; i>=0; --i) {
    //    if(a[di] == 0 && b[di] == 0) break;
    tmp1 = a[di] + (MAX_VAL + 1); /* + number_base */
    tmp2 = b[di] + borrow;;
    res = (tmp1 - tmp2);
    c[di] = (DTYPE)(res & MAX_VAL); /* "modulo number_base" == "% (number_base - 1)" if number_base is 2^N */
    /*    printf("A%xB%x a %x b %08x i %x bo %d", a[di], b[di], tmp1, tmp2, di, borrow);
	  printf(">> %x <<<\n", res);*/
    borrow=0;
    borrow = (res <= MAX_VAL);
    di=di+1;
  }
  fflush(stdout);
}


int toom (DTYPE *a, DTYPE *b, DTYPE *c) {
  int r1=0;
  if (sizeof(b) > sizeof(a)) {
    r1=sizeof(b);
    while (b[r1] == 0)  r1--;
  } else {
    r1=sizeof(a);
    while (a[r1] == 0)  r1--;
  }
  r1=r1*(WORD_SIZE*8);
  int q[32], r[32], qq=4, RR=2, k=2;
  q[0]=4;q[1]=4;r[0]=4,r[1]=4;
  DTYPE U[ (int)ceil(r1/(WORD_SIZE*8))+1][r1];
  DTYPE V[ (int)ceil(r1/(WORD_SIZE*8))+1][r1];
  while ( (q[k-1]+q[k]) < r1) {
    if ( pow(RR+1,2) <= qq) RR++;
    k++;
    qq=qq+RR;
    q[k]=pow(2, qq);
    r[k]=pow(2,RR);
    printf("q[%d](%d)+q[%d](%d)=%d\n", k-1, q[k-1], k, q[k], q[k-1]+q[k]);
  }
  printf("r1=%d k=%08d q=%08d Q=%08d \n", r1, k, q[k], qq);
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
  coder=rf+1;
  int codes[coder];
  DTYPE Uj[coder][r1];
  DTYPE Vj[coder][r1];
  DTYPE Wj[coder][r1*2];
  coder--;
  printf("longitud de codes: %d", rf);
  //  codes[0]=1;
  //  coder++;
  while (k>=0) {
    if(k>0) {
      rf=r[k];
      qf=q[k];
      pf=q[k-1]+q[k];
    } 
      
    int pedazos=(sizeof(a)*(WORD_SIZE*8))/(rf+1);
    printf("\n\nq=%08d pf=%08d k=%08d rf=%08d ped=%06d\n", qf, pf, k, rf, pedazos);
    int rrr=0;//(rf+1);
    int rrin=0;
    int rrrp=0;
    while(rrr<=rf ) {
      bignum_to_bignum_desde_hasta(a, U[rrr], rrrp, (rrrp+pedazos)-1);
      bignum_to_bignum_desde_hasta(b, V[rrr], rrrp, (rrrp+pedazos)-1);
      rrrp=rrrp+pedazos;
      rrr++;
    }
    rrr--;
    printf("\n***********  %08d\n", (int)ceil(pedazos/(WORD_SIZE*8)));
    int erre=0;
    DTYPE Ujm[1];
    DTYPE Ujt[r1*2];
    limpia(Ujt);
    int j=0;
    k4=0;
    while(j<2*rrr) {
      erre=rrr;
      memset(&Uj[coder], 0, sizeof(Uj[coder]));
      memset(&Vj[coder], 0, sizeof(Vj[coder]));
      while(erre>=1) {
	Ujm[0]=j;
	bignum_mul(U[erre], Ujm, &Uj, sizeof(U[erre]), 1);
	bignum_add2(Uj, U[erre-1], sizeof(Uj), sizeof(U[erre-1]));
	bignum_add2(Uj[coder], Ujt, sizeof(Uj[coder]), sizeof(Ujt));
	
	bignum_mul(V[erre], Ujm, Ujt, sizeof(V[erre]), sizeof(Ujm));
	bignum_add2(Vj[coder], Ujt, sizeof(Vj[coder]), sizeof(Ujt));
	bignum_add2(Vj[coder], V[erre-1], sizeof(Vj[coder]), sizeof(V));
	erre--;
      }

      bignum_add_dtype(Ujm, (DTYPE)1);
      j++;
      codes[coder]=3;
      printf("code(%0d)=%d\n", coder, codes[coder]);
      coder--;
    }
    codes[coder+j]=2;
    printf("k=%04d    code((%0d))=%d\n", k, (coder+j), codes[coder+j]);
    k--;
  }
  coder++;
  int coder_dos=coder;
  DTYPE Wts;
  //r1 es j k es t
  while(coder<sizeof(codes)/sizeof(int)) {
    printf(" codes[%04d]=%04d", coder, codes[coder]);

    printf(" Uj[%04d](", coder);
    printf(")*(");
    fflush(stdout);


    printf(" Vj[%04d]=", coder);
    printf("=");
    fflush(stdout);


    printf("Wj[%04d](", coder);
    bignum_mul(Uj[coder], Vj[coder], Wj[coder], sizeof(Uj[coder]), sizeof(Vj[coder]) );
    printf(")\n");
    fflush(stdout);


    if(codes[coder]==2) {
      rf=r[1];
      qf=q[1];
      pf=q[1]+q[0];
      k=coder_dos;
      r1=coder;
      printf("\n\nq=%08d pf=%08d k=%08d rf=%08d r1=%04d coder_dos=%04d coder=%04d\n", qf, pf, k, rf, r1, coder_dos, coder);
      while(k<r1) {
	bignum_sub(Wj[k], Wj[k+1], Wts);
	printf("Wj[%04d] - Wj[%04d] = ", k, k+1);
	printf("\n");
	fflush(stdout);
	k++;
	//r1++;
      }
      coder_dos=coder+1;
    }
    coder++;
  }

  return 0;
} 



int main(int argc, char *argv[] ) {
  char *buffer;
  buffer=calloc(512, sizeof(char));
  char *temporal;
  temporal=calloc(512, sizeof(char));
  bzero(buffer, 512);
  bzero(temporal, 512);
  char buff[2];
  int r=1;
  int rr=0;
  int rt=512;
  int offset=0;
  

  while(r>0) {
    r=fread(buff, sizeof(char), 1, stdin);
    if(buff[0] == '*') break;
    if(r<1) break;
    buffer[rr]=buff[0];
    rr++;
    while(rr>rt-1) {
      free(temporal);
      temporal=calloc(rr, sizeof(char));
      memcpy(temporal, buffer, rr);
      free(buffer);
      buffer=calloc(rr+512, sizeof(char));
      bzero(buffer, 512);
      memcpy(buffer, temporal, rr);
      rt=rr+512;
    }
  }
  buffer[rr]=0;
  if(rr<=1) {
    buffer[0]='0';
    buffer[1]=0;
  }
  if(buff[0]!='*') {
    exit(1);
  }
  while(buffer[offset]=='0' && offset<rr-1) offset++;
  rr-=offset;
  int lena=rr/(WORD_SIZE*2)+1;
  DTYPE Anum[lena];
  bignum_from_string(Anum, buffer+offset, rr, lena );
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
      buffer=calloc(rr+512, sizeof(char));
      bzero(buffer, 512);
      memcpy(buffer, temporal, rr);
      rt=rr+512;
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
  int lenb=rr/(WORD_SIZE*2)+1;
  DTYPE Bnum[lenb];
  bignum_from_string(Bnum, buffer+offset, rr, lenb);

  DTYPE resulta[lena+lenb];
  memset(resulta, 0, sizeof(resulta));
  int efinal=toom(&Bnum, &Anum, &resulta);
  
  /* printf("<%s>\n", s1); */
  /* bignum_from_binstring(&Znum, s1, rr, (rr/8)+1 ); */
  /* bignum_to_string(&Anum, buf, resulta.len); */
  /* bignum_mul(&Bnum, &Anum, &resulta); */
  /* bzero(buf, rt); */
  /* bignum_to_string(&resulta, buf, resulta.len); */
  /* printf("%s", buf); */
}
