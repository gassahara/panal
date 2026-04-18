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
  char b64[] = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
  unsigned char buffer[2048];
  unsigned char buff[1];
  int c, phase, i;
  unsigned char in[4];
  char *p;
  unsigned char out[4];
  int rr=0, r=1;

  bzero(buffer, sizeof(buffer));
  while(r>0) {
    r=fread(buff, 1, 1, stdin);
    if(r<1) break;
    buffer[rr]=buff[0];
    rr++;
  }
  buffer[rr]=0;
  if(rr==1) buffer[0]='0';

  phase = 0; i=0;
  bzero(in, sizeof(in));
  while(buffer[i]) {
    c = (int) buffer[i];
    p = strchr(b64, c);
    if(p) {
      in[phase] = p - b64;
      phase = (phase + 1) % 4;
      if(phase == 0) {
	out[0] = in[0] << 2 | in[1] >> 4;
	out[1] = in[1] << 4 | in[2] >> 2;
	out[2] = in[2] << 6 | in[3] >> 0;
	out[3] = '\0';
	printf("%s <%s>", out, in);
        //in[0]=in[1]=in[2]=in[3]=0;
      }
    }
    i++;
  }
  return 0;
}
