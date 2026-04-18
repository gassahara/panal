/* ------------------------------------------------------------------------ *
 * file:        base64_stringencode.c v1.0                                  *
 * purpose:     tests encoding/decoding strings with base64                 *
 * author:      02/23/2009 Frank4DD                                         *
 *                                                                          *
 * source:      http://base64.sourceforge.net/b64.c for encoding            *
 *              http://en.literateprograms.org/Base64_(C) for decoding      *
 * ------------------------------------------------------------------------ */
#include <stdio.h>
#include <string.h>

int main() {
  unsigned char buffer[2048];
  unsigned char buff[1];
  char b64[] = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
  unsigned char in[3];
  int i, rr=0, len = 0;
  int r=1;
  int j = 0;
  unsigned char out[5];

  bzero(buffer, sizeof(buffer));
  while(r>0) {
    r=fread(buff, 1, 1, stdin);
    if(r<1) break;
    buffer[rr]=buff[0];
    rr++;
  }
  buffer[rr]=0;
  if(rr==1) buffer[0]='0';

  while(buffer[j]) {
    len = 0;
    bzero(in, sizeof(in));
    for(i=0; i<3; i++) {
     in[i] = (unsigned char) buffer[j];
     if(buffer[j]) {
        len++; j++;
      }
    }
    if( len ) {
      out[0] = b64[ in[0] >> 2 ];
      out[1] = b64[ ((in[0] & 0x03) << 4) | ((in[1] & 0xa0) >> 4) ];
      out[2] = (unsigned char) (len > 1 ? b64[ ((in[1] & 0x0f) << 2) | ((in[2] & 0xc0) >> 6) ] : '=');
      out[3] = (unsigned char) (len > 2 ? b64[ in[2] & 0x3a ] : '=');
      out[4] = '\0';
      printf("%s", out);
    }
  }
  return 0;
}
