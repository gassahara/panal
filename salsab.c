/*
salsa20-merged.c version 20051118
D. J. Bernstein
Public domain.
*/
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <limits.h>

//#include "ecrypt-sync.h"

#if (UCHAR_MAX / 0xFU > 0xFU)
#ifndef I8T
#define I8T char
#define U8C(v) (v##U)

#if (UCHAR_MAX == 0xFFU)
#define ECRYPT_I8T_IS_BYTE
#endif

#endif

#if (UCHAR_MAX / 0xFFU > 0xFFU)
#ifndef I16T
#define I16T char
#define U16C(v) (v##U)
#endif

#if (UCHAR_MAX / 0xFFFFU > 0xFFFFU)
#ifndef I32T
#define I32T char
#define U32C(v) (v##U)
#endif

#if (UCHAR_MAX / 0xFFFFFFFFU > 0xFFFFFFFFU)
#ifndef I64T
#define I64T char
#define U64C(v) (v##U)
#define ECRYPT_NATIVE64
#endif

#endif
#endif
#endif
#endif

/* --- check short --- */

#if (USHRT_MAX / 0xFU > 0xFU)
#ifndef I8T
#define I8T short
#define U8C(v) (v##U)

#if (USHRT_MAX == 0xFFU)
#define ECRYPT_I8T_IS_BYTE
#endif

#endif

#if (USHRT_MAX / 0xFFU > 0xFFU)
#ifndef I16T
#define I16T short
#define U16C(v) (v##U)
#endif

#if (USHRT_MAX / 0xFFFFU > 0xFFFFU)
#ifndef I32T
#define I32T short
#define U32C(v) (v##U)
#endif

#if (USHRT_MAX / 0xFFFFFFFFU > 0xFFFFFFFFU)
#ifndef I64T
#define I64T short
#define U64C(v) (v##U)
#define ECRYPT_NATIVE64
#endif

#endif
#endif
#endif
#endif

/* --- check int --- */

#if (UINT_MAX / 0xFU > 0xFU)
#ifndef I8T
#define I8T int
#define U8C(v) (v##U)

#if (ULONG_MAX == 0xFFU)
#define ECRYPT_I8T_IS_BYTE
#endif

#endif

#if (UINT_MAX / 0xFFU > 0xFFU)
#ifndef I16T
#define I16T int
#define U16C(v) (v##U)
#endif

#if (UINT_MAX / 0xFFFFU > 0xFFFFU)
#ifndef I32T
#define I32T int
#define U32C(v) (v##U)
#endif

#if (UINT_MAX / 0xFFFFFFFFU > 0xFFFFFFFFU)
#ifndef I64T
#define I64T int
#define U64C(v) (v##U)
#define ECRYPT_NATIVE64
#endif

#endif
#endif
#endif
#endif

/* --- check long --- */

#if (ULONG_MAX / 0xFUL > 0xFUL)
#ifndef I8T
#define I8T long
#define U8C(v) (v##UL)

#if (ULONG_MAX == 0xFFUL)
#define ECRYPT_I8T_IS_BYTE
#endif

#endif

#if (ULONG_MAX / 0xFFUL > 0xFFUL)
#ifndef I16T
#define I16T long
#define U16C(v) (v##UL)
#endif

#if (ULONG_MAX / 0xFFFFUL > 0xFFFFUL)
#ifndef I32T
#define I32T long
#define U32C(v) (v##UL)
#endif

#if (ULONG_MAX / 0xFFFFFFFFUL > 0xFFFFFFFFUL)
#ifndef I64T
#define I64T long
#define U64C(v) (v##UL)
#define ECRYPT_NATIVE64
#endif

#endif
#endif
#endif
#endif

/* --- check long long --- */

#ifdef ULLONG_MAX

#if (ULLONG_MAX / 0xFULL > 0xFULL)
#ifndef I8T
#define I8T long long
#define U8C(v) (v##ULL)

#if (ULLONG_MAX == 0xFFULL)
#define ECRYPT_I8T_IS_BYTE
#endif

#endif

#if (ULLONG_MAX / 0xFFULL > 0xFFULL)
#ifndef I16T
#define I16T long long
#define U16C(v) (v##ULL)
#endif

#if (ULLONG_MAX / 0xFFFFULL > 0xFFFFULL)
#ifndef I32T
#define I32T long long
#define U32C(v) (v##ULL)
#endif

#if (ULLONG_MAX / 0xFFFFFFFFULL > 0xFFFFFFFFULL)
#ifndef I64T
#define I64T long long
#define U64C(v) (v##ULL)
#endif

#endif
#endif
#endif
#endif

#endif

/* --- check __int64 --- */

#ifdef _UI64_MAX

#if (_UI64_MAX / 0xFFFFFFFFui64 > 0xFFFFFFFFui64)
#ifndef I64T
#define I64T __int64
#define U64C(v) (v##ui64)
#endif

#endif

#endif


#define ECRYPT_MAXKEYSIZE 256                 /* [edit] */
#define ECRYPT_KEYSIZE(i) (128 + (i)*128)     /* [edit] */

#define ECRYPT_MAXIVSIZE 64                   /* [edit] */
#define ECRYPT_IVSIZE(i) (64 + (i)*64)        /* [edit] */

/* ------------------------------------------------------------------------- */

/* Data structures */

/* 
 * ECRYPT_ctx is the structure containing the representation of the
 * internal state of your cipher. 
 */

typedef struct
{
  uint32_t input[16]; /* could be compressed */
  /* 
   * [edit]
   *
   * Put here all state variable needed during the encryption process.
   */
} ECRYPT_ctx;


#ifdef I8T
typedef signed I8T s8;
typedef unsigned I8T u8;
#endif

#ifdef I16T
typedef signed I16T s16;
typedef unsigned I16T u16;
#endif

#ifdef I32T
typedef signed I32T s32;
typedef unsigned I32T u32;
#endif

#ifdef I64T
typedef signed I64T s64;
typedef unsigned I64T u64;
#endif

/*
 * The following macros are used to obtain exact-width results.
 */

#define U8V(v) ((uint8_t)(v) & U8C(0xFF))
#define U16V(v) ((u16)(v) & U16C(0xFFFF))
#define U32V(v) ((uint32_t)(v) & U32C(0xFFFFFFFF))
#define U64V(v) ((u64)(v) & U64C(0xFFFFFFFFFFFFFFFF))

/* ------------------------------------------------------------------------- */

/*
 * The following macros return words with their bits rotated over n
 * positions to the left/right.
 */

#define ECRYPT_DEFAULT_ROT

#define ROTL8(v, n) \
  (U8V((v) << (n)) | ((v) >> (8 - (n))))

#define ROTL16(v, n) \
  (U16V((v) << (n)) | ((v) >> (16 - (n))))

#define ROTL32(v, n) \
  (U32V((v) << (n)) | ((v) >> (32 - (n))))

#define ROTL64(v, n) \
  (U64V((v) << (n)) | ((v) >> (64 - (n))))

#define ROTR8(v, n) ROTL8(v, 8 - (n))
#define ROTR16(v, n) ROTL16(v, 16 - (n))
#define ROTR32(v, n) ROTL32(v, 32 - (n))
#define ROTR64(v, n) ROTL64(v, 64 - (n))

#define ECRYPT_DEFAULT_SWAP

#define SWAP16(v) \
  ROTL16(v, 8)

#define SWAP32(v) \
  ((ROTL32(v,  8) & U32C(0x00FF00FF)) | \
   (ROTL32(v, 24) & U32C(0xFF00FF00)))

#ifdef ECRYPT_NATIVE64
#define SWAP64(v) \
  ((ROTL64(v,  8) & U64C(0x000000FF000000FF)) | \
   (ROTL64(v, 24) & U64C(0x0000FF000000FF00)) | \
   (ROTL64(v, 40) & U64C(0x00FF000000FF0000)) | \
   (ROTL64(v, 56) & U64C(0xFF000000FF000000)))
#else
#define SWAP64(v) \
  (((u64)SWAP32(U32V(v)) << 32) | (u64)SWAP32(U32V(v >> 32)))
#endif

#define ECRYPT_DEFAULT_WTOW
#define ECRYPT_LITTLE_ENDIAN

#ifdef ECRYPT_LITTLE_ENDIAN
#define U16TO16_LITTLE(v) (v)
#define U32TO32_LITTLE(v) (v)
#define U64TO64_LITTLE(v) (v)

#define U16TO16_BIG(v) SWAP16(v)
#define U32TO32_BIG(v) SWAP32(v)
#define U64TO64_BIG(v) SWAP64(v)
#endif

#ifdef ECRYPT_BIG_ENDIAN
#define U16TO16_LITTLE(v) SWAP16(v)
#define U32TO32_LITTLE(v) SWAP32(v)
#define U64TO64_LITTLE(v) SWAP64(v)

#define U16TO16_BIG(v) (v)
#define U32TO32_BIG(v) (v)
#define U64TO64_BIG(v) (v)
#endif

#define ECRYPT_DEFAULT_BTOW

#if (!defined(ECRYPT_UNKNOWN) && defined(ECRYPT_I8T_IS_BYTE))

#define U8TO16_LITTLE(p) U16TO16_LITTLE(((u16*)(p))[0])
#define U8TO32_LITTLE(p) U32TO32_LITTLE(((u32*)(p))[0])
#define U8TO64_LITTLE(p) U64TO64_LITTLE(((u64*)(p))[0])

#define U8TO16_BIG(p) U16TO16_BIG(((u16*)(p))[0])
#define U8TO32_BIG(p) U32TO32_BIG(((u32*)(p))[0])
#define U8TO64_BIG(p) U64TO64_BIG(((u64*)(p))[0])

#define U16TO8_LITTLE(p, v) (((u16*)(p))[0] = U16TO16_LITTLE(v))
#define U32TO8_LITTLE(p, v) (((u32*)(p))[0] = U32TO32_LITTLE(v))
#define U64TO8_LITTLE(p, v) (((u64*)(p))[0] = U64TO64_LITTLE(v))

#define U16TO8_BIG(p, v) (((u16*)(p))[0] = U16TO16_BIG(v))
#define U32TO8_BIG(p, v) (((u32*)(p))[0] = U32TO32_BIG(v))
#define U64TO8_BIG(p, v) (((u64*)(p))[0] = U64TO64_BIG(v))

#else

#define U8TO16_LITTLE(p) \
  (((u16)((p)[0])      ) | \
   ((u16)((p)[1]) <<  8))

#define U8TO32_LITTLE(p) \
  (((uint32_t)((p)[0])      ) | \
   ((uint32_t)((p)[1]) <<  8) | \
   ((uint32_t)((p)[2]) << 16) | \
   ((uint32_t)((p)[3]) << 24))

#ifdef ECRYPT_NATIVE64
#define U8TO64_LITTLE(p) \
  (((u64)((p)[0])      ) | \
   ((u64)((p)[1]) <<  8) | \
   ((u64)((p)[2]) << 16) | \
   ((u64)((p)[3]) << 24) | \
   ((u64)((p)[4]) << 32) | \
   ((u64)((p)[5]) << 40) | \
   ((u64)((p)[6]) << 48) | \
   ((u64)((p)[7]) << 56))
#else
#define U8TO64_LITTLE(p) \
  ((u64)U8TO32_LITTLE(p) | ((u64)U8TO32_LITTLE((p) + 4) << 32))
#endif

#define U8TO16_BIG(p) \
  (((u16)((p)[0]) <<  8) | \
   ((u16)((p)[1])      ))

#define U8TO32_BIG(p) \
  (((uint32_t)((p)[0]) << 24) | \
   ((uint32_t)((p)[1]) << 16) | \
   ((uint32_t)((p)[2]) <<  8) | \
   ((uint32_t)((p)[3])      ))

#ifdef ECRYPT_NATIVE64
#define U8TO64_BIG(p) \
  (((u64)((p)[0]) << 56) | \
   ((u64)((p)[1]) << 48) | \
   ((u64)((p)[2]) << 40) | \
   ((u64)((p)[3]) << 32) | \
   ((u64)((p)[4]) << 24) | \
   ((u64)((p)[5]) << 16) | \
   ((u64)((p)[6]) <<  8) | \
   ((u64)((p)[7])      ))
#else
#define U8TO64_BIG(p) \
  (((u64)U8TO32_BIG(p) << 32) | (u64)U8TO32_BIG((p) + 4))
#endif

#define U16TO8_LITTLE(p, v) \
  do { \
    (p)[0] = U8V((v)      ); \
    (p)[1] = U8V((v) >>  8); \
  } while (0)

#define U32TO8_LITTLE(p, v) \
  do { \
    (p)[0] = U8V((v)      ); \
    (p)[1] = U8V((v) >>  8); \
    (p)[2] = U8V((v) >> 16); \
    (p)[3] = U8V((v) >> 24); \
  } while (0)

#ifdef ECRYPT_NATIVE64
#define U64TO8_LITTLE(p, v) \
  do { \
    (p)[0] = U8V((v)      ); \
    (p)[1] = U8V((v) >>  8); \
    (p)[2] = U8V((v) >> 16); \
    (p)[3] = U8V((v) >> 24); \
    (p)[4] = U8V((v) >> 32); \
    (p)[5] = U8V((v) >> 40); \
    (p)[6] = U8V((v) >> 48); \
    (p)[7] = U8V((v) >> 56); \
  } while (0)
#else
#define U64TO8_LITTLE(p, v) \
  do { \
    U32TO8_LITTLE((p),     U32V((v)      )); \
    U32TO8_LITTLE((p) + 4, U32V((v) >> 32)); \
  } while (0)
#endif

#define U16TO8_BIG(p, v) \
  do { \
    (p)[0] = U8V((v)      ); \
    (p)[1] = U8V((v) >>  8); \
  } while (0)

#define U32TO8_BIG(p, v) \
  do { \
    (p)[0] = U8V((v) >> 24); \
    (p)[1] = U8V((v) >> 16); \
    (p)[2] = U8V((v) >>  8); \
    (p)[3] = U8V((v)      ); \
  } while (0)

#ifdef ECRYPT_NATIVE64
#define U64TO8_BIG(p, v) \
  do { \
    (p)[0] = U8V((v) >> 56); \
    (p)[1] = U8V((v) >> 48); \
    (p)[2] = U8V((v) >> 40); \
    (p)[3] = U8V((v) >> 32); \
    (p)[4] = U8V((v) >> 24); \
    (p)[5] = U8V((v) >> 16); \
    (p)[6] = U8V((v) >>  8); \
    (p)[7] = U8V((v)      ); \
  } while (0)
#else
#define U64TO8_BIG(p, v) \
  do { \
    U32TO8_BIG((p),     U32V((v) >> 32)); \
    U32TO8_BIG((p) + 4, U32V((v)      )); \
  } while (0)
#endif

#endif


#define ROTATE(v,c) (ROTL32(v,c))
#define XOR(v,w) ((v) ^ (w))
#define PLUS(v,w) (U32V((v) + (w)))
#define PLUSONE(v) (PLUS((v),1))

void ECRYPT_init(void)
{
  return;
}

static const char sigma[16] = "expand 32-byte k";
static const char tau[16] = "expand 16-byte k";

void ECRYPT_keysetup(ECRYPT_ctx *x,const uint8_t *k,uint32_t kbits,uint32_t ivbits)
{
  const char *constants;

  x->input[1] = U8TO32_LITTLE(k + 0);
  x->input[2] = U8TO32_LITTLE(k + 4);
  x->input[3] = U8TO32_LITTLE(k + 8);
  x->input[4] = U8TO32_LITTLE(k + 12);
  if (kbits == 256) { /* recommended */
    k += 16;
    constants = sigma;
  } else { /* kbits == 128 */
    constants = tau;
  }
  x->input[11] = U8TO32_LITTLE(k + 0);
  x->input[12] = U8TO32_LITTLE(k + 4);
  x->input[13] = U8TO32_LITTLE(k + 8);
  x->input[14] = U8TO32_LITTLE(k + 12);
  x->input[0] = U8TO32_LITTLE(constants + 0);
  x->input[5] = U8TO32_LITTLE(constants + 4);
  x->input[10] = U8TO32_LITTLE(constants + 8);
  x->input[15] = U8TO32_LITTLE(constants + 12);
}

void ECRYPT_ivsetup(ECRYPT_ctx *x,const uint8_t *iv)
{
  x->input[6] = U8TO32_LITTLE(iv + 0);
  x->input[7] = U8TO32_LITTLE(iv + 4);
  x->input[8] = 0;
  x->input[9] = 0;
}

void ECRYPT_encrypt_bytes(ECRYPT_ctx *x,const uint8_t *m,uint8_t *c,uint32_t bytes)
{
  uint32_t x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15;
  uint32_t j0, j1, j2, j3, j4, j5, j6, j7, j8, j9, j10, j11, j12, j13, j14, j15;
  uint8_t *ctarget;
  uint8_t tmp[64];
  int i;

  if (!bytes) return;

  j0 = x->input[0];
  j1 = x->input[1];
  j2 = x->input[2];
  j3 = x->input[3];
  j4 = x->input[4];
  j5 = x->input[5];
  j6 = x->input[6];
  j7 = x->input[7];
  j8 = x->input[8];
  j9 = x->input[9];
  j10 = x->input[10];
  j11 = x->input[11];
  j12 = x->input[12];
  j13 = x->input[13];
  j14 = x->input[14];
  j15 = x->input[15];

  for (;;) {
    if (bytes < 64) {
      for (i = 0;i < bytes;++i) tmp[i] = m[i];
      m = tmp;
      ctarget = c;
      c = tmp;
    }
    x0 = j0;
    x1 = j1;
    x2 = j2;
    x3 = j3;
    x4 = j4;
    x5 = j5;
    x6 = j6;
    x7 = j7;
    x8 = j8;
    x9 = j9;
    x10 = j10;
    x11 = j11;
    x12 = j12;
    x13 = j13;
    x14 = j14;
    x15 = j15;
    for (i = 20;i > 0;i -= 2) {
       x4 = XOR( x4,ROTATE(PLUS( x0,x12), 7));
       x8 = XOR( x8,ROTATE(PLUS( x4, x0), 9));
      x12 = XOR(x12,ROTATE(PLUS( x8, x4),13));
       x0 = XOR( x0,ROTATE(PLUS(x12, x8),18));
       x9 = XOR( x9,ROTATE(PLUS( x5, x1), 7));
      x13 = XOR(x13,ROTATE(PLUS( x9, x5), 9));
       x1 = XOR( x1,ROTATE(PLUS(x13, x9),13));
       x5 = XOR( x5,ROTATE(PLUS( x1,x13),18));
      x14 = XOR(x14,ROTATE(PLUS(x10, x6), 7));
       x2 = XOR( x2,ROTATE(PLUS(x14,x10), 9));
       x6 = XOR( x6,ROTATE(PLUS( x2,x14),13));
      x10 = XOR(x10,ROTATE(PLUS( x6, x2),18));
       x3 = XOR( x3,ROTATE(PLUS(x15,x11), 7));
       x7 = XOR( x7,ROTATE(PLUS( x3,x15), 9));
      x11 = XOR(x11,ROTATE(PLUS( x7, x3),13));
      x15 = XOR(x15,ROTATE(PLUS(x11, x7),18));
       x1 = XOR( x1,ROTATE(PLUS( x0, x3), 7));
       x2 = XOR( x2,ROTATE(PLUS( x1, x0), 9));
       x3 = XOR( x3,ROTATE(PLUS( x2, x1),13));
       x0 = XOR( x0,ROTATE(PLUS( x3, x2),18));
       x6 = XOR( x6,ROTATE(PLUS( x5, x4), 7));
       x7 = XOR( x7,ROTATE(PLUS( x6, x5), 9));
       x4 = XOR( x4,ROTATE(PLUS( x7, x6),13));
       x5 = XOR( x5,ROTATE(PLUS( x4, x7),18));
      x11 = XOR(x11,ROTATE(PLUS(x10, x9), 7));
       x8 = XOR( x8,ROTATE(PLUS(x11,x10), 9));
       x9 = XOR( x9,ROTATE(PLUS( x8,x11),13));
      x10 = XOR(x10,ROTATE(PLUS( x9, x8),18));
      x12 = XOR(x12,ROTATE(PLUS(x15,x14), 7));
      x13 = XOR(x13,ROTATE(PLUS(x12,x15), 9));
      x14 = XOR(x14,ROTATE(PLUS(x13,x12),13));
      x15 = XOR(x15,ROTATE(PLUS(x14,x13),18));
    }
    x0 = PLUS(x0,j0);
    x1 = PLUS(x1,j1);
    x2 = PLUS(x2,j2);
    x3 = PLUS(x3,j3);
    x4 = PLUS(x4,j4);
    x5 = PLUS(x5,j5);
    x6 = PLUS(x6,j6);
    x7 = PLUS(x7,j7);
    x8 = PLUS(x8,j8);
    x9 = PLUS(x9,j9);
    x10 = PLUS(x10,j10);
    x11 = PLUS(x11,j11);
    x12 = PLUS(x12,j12);
    x13 = PLUS(x13,j13);
    x14 = PLUS(x14,j14);
    x15 = PLUS(x15,j15);

    x0 = XOR(x0,U8TO32_LITTLE(m + 0));
    x1 = XOR(x1,U8TO32_LITTLE(m + 4));
    x2 = XOR(x2,U8TO32_LITTLE(m + 8));
    x3 = XOR(x3,U8TO32_LITTLE(m + 12));
    x4 = XOR(x4,U8TO32_LITTLE(m + 16));
    x5 = XOR(x5,U8TO32_LITTLE(m + 20));
    x6 = XOR(x6,U8TO32_LITTLE(m + 24));
    x7 = XOR(x7,U8TO32_LITTLE(m + 28));
    x8 = XOR(x8,U8TO32_LITTLE(m + 32));
    x9 = XOR(x9,U8TO32_LITTLE(m + 36));
    x10 = XOR(x10,U8TO32_LITTLE(m + 40));
    x11 = XOR(x11,U8TO32_LITTLE(m + 44));
    x12 = XOR(x12,U8TO32_LITTLE(m + 48));
    x13 = XOR(x13,U8TO32_LITTLE(m + 52));
    x14 = XOR(x14,U8TO32_LITTLE(m + 56));
    x15 = XOR(x15,U8TO32_LITTLE(m + 60));

    j8 = PLUSONE(j8);
    if (!j8) {
      j9 = PLUSONE(j9);
      /* stopping at 2^70 bytes per nonce is user's responsibility */
    }

    U32TO8_LITTLE(c + 0,x0);
    U32TO8_LITTLE(c + 4,x1);
    U32TO8_LITTLE(c + 8,x2);
    U32TO8_LITTLE(c + 12,x3);
    U32TO8_LITTLE(c + 16,x4);
    U32TO8_LITTLE(c + 20,x5);
    U32TO8_LITTLE(c + 24,x6);
    U32TO8_LITTLE(c + 28,x7);
    U32TO8_LITTLE(c + 32,x8);
    U32TO8_LITTLE(c + 36,x9);
    U32TO8_LITTLE(c + 40,x10);
    U32TO8_LITTLE(c + 44,x11);
    U32TO8_LITTLE(c + 48,x12);
    U32TO8_LITTLE(c + 52,x13);
    U32TO8_LITTLE(c + 56,x14);
    U32TO8_LITTLE(c + 60,x15);

    if (bytes <= 64) {
      if (bytes < 64) {
        for (i = 0;i < bytes;++i) ctarget[i] = c[i];
      }
      x->input[8] = j8;
      x->input[9] = j9;
      return;
    }
    bytes -= 64;
    c += 64;
    m += 64;
  }
}

void ECRYPT_decrypt_bytes(ECRYPT_ctx *x,const uint8_t *c,uint8_t *m,uint32_t bytes)
{
  ECRYPT_encrypt_bytes(x,c,m,bytes);
}

void ECRYPT_keystream_bytes(ECRYPT_ctx *x,uint8_t *stream,uint32_t bytes)
{
  uint32_t i;
  for (i = 0;i < bytes;++i) stream[i] = 0;
  ECRYPT_encrypt_bytes(x,stream,stream,bytes);
}




uint8_t potencias[]={1,2,4,8,16,32,64,128};
uint8_t HEX_VALS[][16]={{0x0,0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9,0xA,0xB,0xC,0xD,0xE,0xF},{0,0x10,0x20,0x30,0x40,0x50,0x60,0x70,0x80,0x90,0xA0,0xB0,0xC0,0xD0,0xE0,0xF0}};
#define DTYPE uint8_t

void bytes_from_string(uint8_t *n, char* str, int ll, int nbytes) {
  uint8_t tmp;       
  int i = ll;
  int j = 0;
  int k=0;
  int kk=0;
  int tmpd;
  char tmpc;
  int pasa=0;

  k=0;
  while(k<nbytes) {
    n[k]=0;
    k++;
  }
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

void bytes_to_string(uint8_t *n, int lenn, char *str) {
  int j=0;
  uint8_t nj;
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







uint8_t m[4096];
uint8_t c[4096];
uint8_t d[4096];
uint8_t k[32];
uint8_t v[8];


int main(int argc, char *argv[] ) {
  char *buffer;
  int ssize=4096;
  buffer=calloc(ssize, sizeof(char));
  char buff[2];
  int r=1;
  int rr=0;
  

  r=0;
  while(r<sizeof(k)) {
    k[r]=0;
    r++;
  }
  r=1;
  while(r>0) {
    r=fread(buff, sizeof(char), 1, stdin);
    if(r<1) break;
    if(buff[0]>=0x30 && buff[0]<=0x46 && !(buff[0]>0x3A && buff[0]<0x41)) {
      buffer[rr]=buff[0];
      rr++;
    }
    if(rr>=(sizeof(k)*2)) break;
  }
  buffer[rr]=0;
  if(rr<sizeof(k)*2) {
    exit(1);
  }
  bytes_from_string(k, buffer, rr, sizeof(k) );

  printf("%06d b\n", rr);
  r=0;
  while(r<rr) {
    printf("%c", buffer[r]);
    r++;
  }
  printf("\nm\n");
  r=0;
  while(r<sizeof(k)) {
    printf("%02X", k[r]);
    r++;
  }
  r=1;
  fflush(stdout);
  
  r=0;
  while(r<sizeof(m)) {
    buffer[r]=0;
    m[r]=0;
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
    if(rr>=sizeof(m)*2) break;
  }
  buffer[rr]=0;
  if(rr<=1) {
    buffer[0]='0';
    buffer[1]=0;
  }
  r=0;
  bytes_from_string(m, buffer, rr, 4096);
 

  ECRYPT_ctx x;
  int i;
  int bytes;

  i=0;
  while(i<sizeof(m)) {
    m[i]=i%256;
    i++;
  }
  /*
  i=0;
  while(i<sizeof(k)) {
    k[i]=(i+i)%255;
    i++;
  }
  */
  i=0;
  ECRYPT_keysetup(&x,k,256,64);
  ECRYPT_ivsetup(&x,v);
  ECRYPT_encrypt_bytes(&x,m,c,sizeof(c)/*bytes*/);
  i=0;
  printf("\n_____\n");
  while(i<sizeof(c)) {
    printf("%02X", c[i]);
    i++;
  }
  ECRYPT_ivsetup(&x,v);
  ECRYPT_encrypt_bytes(&x,c,d,sizeof(c)/*bytes*/);
  //  ECRYPT_decrypt_bytes(&x,c,d,sizeof(c)/*bytes*/);
  printf("\n_____\n");
  i=0;
  while(i<sizeof(d)) {
    printf("%02X", d[i]);
    i++;
  }
  printf("\n_____\n");
  i=0;
  while(i<sizeof(m)) {
    printf("%02X", m[i]);
    i++;
  }
  return 0;
}
