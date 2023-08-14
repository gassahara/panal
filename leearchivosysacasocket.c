#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>


char ursok(char *yega, char *direc, int puert){
  int miSocket,r, nBytes, nBytez=strlen(yega);
  struct sockaddr_in serverAddr,clientAddr;
  struct sockaddr_storage serverStorage;
  socklen_t addr_size, client_addr_size;
  int i;
  miSocket = socket(AF_INET, SOCK_STREAM, 0);
  serverAddr.sin_family = AF_INET; 
  serverAddr.sin_port = htons(puert);
  serverAddr.sin_addr.s_addr = inet_addr(direc);
  memset(serverAddr.sin_zero, '\0', sizeof serverAddr.sin_zero);
  while(bind(miSocket,(struct sockaddr *) &serverAddr, sizeof(serverAddr))==-1) {
    puert++;
    serverAddr.sin_port = htons(puert);
    printf ("error serving \n");
  }
  addr_size = sizeof serverStorage;
  listen(miSocket, 4);
  r=1;
  printf ("accept (%i) \n", puert); 
  while(r>-1){
    r=accept(miSocket, (struct sockaddr *)&serverAddr,(socklen_t *)&addr_size);
    printf("%i [%i]", errno, strlen(yega));
    sendto(r,yega,strlen(yega),0,(struct sockaddr *)&serverStorage, (socklen_t)addr_size);
    close(r);
    /*
    nBytes=0;
    while(nBytes<1)nBytes = recv(r,buffer,1024,0);
    buffer[nBytes]='\0';
    printf ("leidos %i cadena %s\n",nBytes, buffer);
    */
  }
  return 0;
} 

int main(int argc, char *argv[])
{
  char aejec[1024], ss[550], sss[6000];
  char lea[2];
  char *documento, *procesado, *temporal, *lee;
  int p,i,iri,ifi,i2, exito, hi, hi2, cols, colsp, procesi, leei, lee2;
  char sepcelda[]="void main\0int main\0", sepceldaf[]="}\0}\0", seprow[]={ "</tr>\0table:table-row\0" };

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
      if(strstr(documento,sepcelda+i) ) {
	documento[(&(*strstr(documento,sepcelda+i)))-(&(*documento))]='\0';
	ursok(documento, "127.0.0.1", 5001);
      }
    i+=strlen(sepcelda+i)+1;
    iri+=strlen(seprow+i)+1;
    ifi+=strlen(sepceldaf+ifi)+1;
  }
  return  1;
}
