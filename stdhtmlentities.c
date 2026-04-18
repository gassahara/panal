#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

static const unsigned char letras[52]="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
static const unsigned char signos[10]={' ', '?','!',';','<','>','"','\'', '&'};
static const unsigned char *entitiessignos="&nbsp;&quest;&excl;&semi;&lt;&gt;&quot;&apos;&amper;";
static const unsigned char signosutf8[4]={0xBF/*¿*/, 0xA1/*¡*/,0xAB/*«*/,0xBB/*»*/}; //precedido por C2
static const unsigned char *entitiessignosutf8="&iquest;&iexcl;&laquo;&raquo;";
static const unsigned char letrasutf8[12]={0x81,0x89,0x8D,0x91,0x93,0x9A,0xA1,0xA9,0xAD,0xB1,0xB3,0xBA};  //precedido por C3
static const unsigned char *entitiesletrasutf8="&Aacute;&Eacute;&Iacute;&Ntilde;&Oacute;&Uacute;&aacute;&eacute;&iacute;&ntilde;&oacute;&uacute;";

int main(int argc, char *argv[]) {
  unsigned char lea[2];
  long p, n, m, l;
  lea[0]=0;
  lea[1]=0;
  n=0;
  p=0;
  while(read(fileno(stdin), lea, 1)>0) {
    if(lea[0]==0xC2) {
      read(fileno(stdin), lea, 1);
      p=0;
      while(p<sizeof(signosutf8)) {
	if(signosutf8[p]==lea[0]) {
	  n=-1;
	  m=0;
	  l=0;
	  while(n<p) {
	    if(entitiessignosutf8[m]==';') {
	      n++;
	      if(n<p) l=m+1;
	    }
	    m++;
	  }
	  while(l<m) {
	    printf("%c", entitiessignosutf8[l]);
	    l++;
	  }
	  break;
	}
	p++;
      }
      if(p<sizeof(signosutf8)) continue;
    }

    if(lea[0]==0xC3) {
      read(fileno(stdin), lea, 1);
      p=0;
      while(p<sizeof(letrasutf8)) {
	if(letrasutf8[p]==lea[0]) {
	  n=-1;
	  m=0;
	  l=0;
	  while(n<p) {
	    if(entitiesletrasutf8[m]==';') {
	      n++;
	      if(n<p) l=m+1;;
	    }
	    m++;
	  }
	  while(l<m) {
	    printf("%c", entitiesletrasutf8[l]);
	    l++;
	  }
	  break;
	}
	p++;
      }
      if(p<sizeof(letrasutf8)) continue;
    }

    p=0;
    while(p<sizeof(signos)) {
      if(signos[p]==lea[0]) {
	n=-1;
	m=0;
	l=0;
	while(n<p) {
	  if(entitiessignos[m]==';') {
	    n++;
	    if(n<p) l=m+1;;
	  }
	  m++;
	}
	while(l<m) {
	  printf("%c", entitiessignos[l]);
	  l++;
	}
	break;
      }
      p++;
    }
    if(p<sizeof(signos)) continue;
    
    if(lea[0]=='\n') {
      printf("<br>");
      continue;
    }
    
    printf("%c", lea[0]);
  }
  return  0;
}
