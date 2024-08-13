#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

int main(int argc, char *argv[])
{
  char aejec[1024], ss[550], sss[6000];
  char lea[2];
  char *documento, *procesado, *temporal, *lee;
  int p,i,iri,ifi,i2, exito, hi, hi2, cols, colsp, procesi, leei, lee2;
  char sepcelda[]="<td>\0table:table-cell\0", sepceldaf[]="</td>\0/table:table-cell\0", seprow[]={ "</tr>\0table:table-row\0" };

  temporal=calloc(20,sizeof(char));
  memset(temporal, 0, sizeof(temporal));
  procesado=calloc(20,sizeof(char));
  memset(procesado, 0, sizeof(documento));
  procesi=1025;
  documento=calloc(20,sizeof(char));
  memset(documento, 0, sizeof(documento));
  lee=calloc(1025, sizeof(char));
  leei=1025;

  if(argc<2) {
    memset(lee, 0, leei);
    lee2=0;
    p=1;
    while(fread(lea, sizeof(char), 1, stdin)>0) {
      lee[lee2]=lea[0];
      lee2+=1;
      while(lee2>leei-1) {
	free(temporal);
	temporal=calloc(leei, sizeof(char));
	strncpy(temporal, lee, leei);
	free(lee);
	lee=calloc(leei+1024, sizeof(char));
	strncpy(lee, temporal, leei);
	leei+=1024;
      }
    }
  }
  free(documento);
  documento=calloc(leei, sizeof(char));
  memcpy(documento, lee, leei);
  documento[leei]='\0';
  i=0;
  ifi=0;
  iri=0;
  while(i<sizeof(sepcelda)) {
    cols=0;
    colsp=0;
    procesado=calloc(leei, sizeof(char));
    memcpy(procesado, documento, leei);
    i2=0;
    while(i2<strlen(documento)) {
      if(strstr(documento,sepcelda+i) && strstr(documento,sepceldaf+ifi) && strstr(documento,seprow+iri)) {
	documento=documento+((&(*strstr(documento, sepcelda+i)))-(&(*documento)))+strlen(sepcelda+i);
	strncpy(procesado, documento, ((&(*strstr(documento, sepceldaf+ifi)))-(&(*(documento)))));
	procesado[((&(*strstr(documento, sepceldaf+ifi)))-(&(*(documento))))]='\0';
	documento+=(int)((&(*strstr(documento, sepceldaf+ifi)))-(&(*documento)));
	if(cols>0) {
	  printf("%06f;\n", strtod(procesado, NULL));
	  cols=0;
	  documento+=(int)((&(*strstr(documento, seprow+iri)))-(&(*documento)));
	} else {
	  printf("double %s=", procesado);
	  cols++;
	}
      }
      documento++;
      i2++;
    }
    i+=strlen(sepcelda+i)+1;
    iri+=strlen(seprow+i)+1;
    ifi+=strlen(sepceldaf+ifi)+1;
  }
  return  1;
}
