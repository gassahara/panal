#include <string.h>
#include <stdio.h>
#include <stdlib.h>
int main( int argc, char *argv[] ) {
char *buffer;
buffer=calloc(1048576, sizeof(char));
char *temporal;
temporal=calloc(1048576, sizeof(char));
bzero(buffer, 1048576);
bzero(temporal, 1048576);
char buff[2];
int r=1;
int rr=0;
int rt=1048576;
int offset=0;
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
buffer=calloc(rr+1048576, sizeof(char));
bzero(buffer, 1048576);
memcpy(buffer, temporal, rr);
rt=rr+1048576;
}
}
buffer[rr]=0;
if(rr<=1) {
buffer[0]='0';
buffer[1]=0;}
FILE *f1=fopen("./00004461.out", "a");
fwrite(buffer, 1,rr,f1);
fclose(f1);
FILE *f2=fopen("./00004461.in", "r");
while(fread(buffer,1,1,f2)) {
printf("%c",buffer[0]);
}
fclose(f2);
}