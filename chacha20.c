#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>

#define ROTL(a,b) (((a) << (b)) | ((a) >> (32 - (b))))
#define QR(a, b, c, d) (			\
	a += b,  d ^= a,  d = ROTL(d,16),	\
	c += d,  b ^= c,  b = ROTL(b,12),	\
	a += b,  d ^= a,  d = ROTL(d, 8),	\
	c += d,  b ^= c,  b = ROTL(b, 7))
#define ROUNDS 20
//nbytes numero de caracteres q representan un numero
int main( int argc, char *argv[] ) {
  static uint32_t out[16];
  uint32_t *in;
  static int i;
  static int j=0;
  static int k=0;
  static uint32_t x[16];

  static unsigned char buffer[16];
  static unsigned buff[1];
  static unsigned int r=1;
  static unsigned int rr=0;
  static unsigned int t=0;

  j=0;
  while(j<sizeof(buffer)) {
    buffer[j]=0;
    j++;
  }

  j=0;
  k=0;
  rr=0;
  while(r>0) {
    r=fread(buff, sizeof(char), 1, stdin);
    if(r<1) break;
    buffer[rr]=buff[0];
    rr++;
    if(rr>=16) {
      in = (uint32_t *)buffer;
      for (i = 0; i < 16; ++i) x[i] = in[i];
      // 10 loops × 2 rounds/loop = 20 rounds
      for (i = 0; i < ROUNDS; i += 2) {
	// Odd round
	QR(x[0], x[4], x[ 8], x[12]); // column 0
	QR(x[1], x[5], x[ 9], x[13]); // column 1
	QR(x[2], x[6], x[10], x[14]); // column 2
	QR(x[3], x[7], x[11], x[15]); // column 3
	// Even round
	QR(x[0], x[5], x[10], x[15]); // diagonal 1 (main diagonal)
	QR(x[1], x[6], x[11], x[12]); // diagonal 2
	QR(x[2], x[7], x[ 8], x[13]); // diagonal 3
	QR(x[3], x[4], x[ 9], x[14]); // diagonal 4
      }
      rr=0;
      j++;
      k++;
  for (i = 0; i < 16; ++i) {
    out[i] += x[i] + in[i];
  }
    }
  }
  if(rr>0) {
    j=0;
    in = (uint32_t *)buffer;
    for (i = 0; i < 16; ++i) x[i] = in[i];
    // 10 loops × 2 rounds/loop = 20 rounds
    for (i = 0; i < ROUNDS; i += 2) {
      // Odd round
      QR(x[0], x[4], x[ 8], x[12]); // column 0
      QR(x[1], x[5], x[ 9], x[13]); // column 1
      QR(x[2], x[6], x[10], x[14]); // column 2
      QR(x[3], x[7], x[11], x[15]); // column 3
      // Even round
      QR(x[0], x[5], x[10], x[15]); // diagonal 1 (main diagonal)
      QR(x[1], x[6], x[11], x[12]); // diagonal 2
      QR(x[2], x[7], x[ 8], x[13]); // diagonal 3
      QR(x[3], x[4], x[ 9], x[14]); // diagonal 4
    }
  }
  for (i = 0; i < 16; ++i) {
    printf("%08X", out[i]);
  }
}
