#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/socket.h>
#include <netinet/in.h>

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
  printf ("accept\n");
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

char *misok(char *direc, int puert){
  int miSocket, nBytes, nBytez, r, leei, lee2,tcp_keepintvl=10;
  struct sockaddr_in serverAddr;
  socklen_t addr_size;
  char buffer[1024], myvar[1024];
  char *lee, *temporal;
  lee=calloc(1024, sizeof(char));
  memset(lee, 0, 1024);
  leei=1024;
  temporal=calloc(1024, sizeof(char));
  memset(temporal, 0, 1024);
  int tipo=SOCK_STREAM;
  miSocket = socket(AF_INET, tipo , 0);
  //fcntl (miSocket, F_SETFL, O_NONBLOCK);
  serverAddr.sin_family = AF_INET; 
  serverAddr.sin_port = htons(puert);
  serverAddr.sin_addr.s_addr = inet_addr(direc);  
  memset(serverAddr.sin_zero, '\0', sizeof serverAddr.sin_zero);
  addr_size = sizeof serverAddr;
  r=-1;
  while(r<0) {r=connect(miSocket, (struct sockaddr *)&serverAddr,addr_size);printf("(%i)", r);}
  printf("sock %i r %i error %i", miSocket, r, errno);
  if(errno==EINPROGRESS) printf("EINPROGRESS");
  nBytes=1;
  lee2=0;
  //while(nBytes=read(miSocket, buffer,1)) {
  while(nBytes>0) {
    //nBytes=recv(miSocket, buffer,1024,MSG_DONTWAIT);
    nBytes=recv(miSocket, buffer,1, 0);
    lee2+=nBytes;
    ///*
    while(lee2>leei-1) {
      free(temporal);
      temporal=calloc(leei, sizeof(char));
      strncpy(temporal, lee, leei);
      free(lee);
      lee=calloc(leei+1024, sizeof(char));
      strncpy(lee, temporal, leei);
      leei+=1024;
    }
    strncpy(lee+lee2-nBytes, buffer, nBytes);
    lee[lee2]='\0';
    //*/
  }
  close(miSocket);
  buffer[nBytes]='\0';
  return lee;
}

int main(int argc, char *argv[])
{
  char aejec[1024], ss[550], sss[6000];
  char lea[2];
  char *documento, *salida, *procesado, *temporal, *lee;
  int p,i,iri,ifi,i2, exito, hi, hi2, cols, colsp, procesi, leei, lee2;
  char sepcelda[]="<td>\0<td \0table:table-cell\0", sepceldaf[]="</td>\0</td>\0/table:table-cell\0", seprow[]={ "</tr>\0</tr>\0table:table-row\0" };

  temporal=calloc(20,sizeof(char));
  memset(temporal, 0, sizeof(temporal));
  procesado=calloc(20,sizeof(char));
  memset(procesado, 0, sizeof(documento));
  procesi=1025;
  documento=calloc(20,sizeof(char));
  memset(documento, 0, sizeof(documento));
  lee=calloc(1025, sizeof(char));
  leei=1025;
  salida=calloc(20,sizeof(char));
  memset(salida, 0, sizeof(salida));
  lee=calloc(1025, sizeof(char));
  leei=1025;

  lee=misok("127.0.0.1", strtol(argv[1], NULL, 10));
  leei=strlen(lee)+1;
  free(documento);
  documento=calloc(leei, sizeof(char));
  memcpy(documento, lee, leei);
  documento[leei]='\0';
  free(salida);
  salida=calloc(leei, sizeof(char));
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
	documento=strstr(documento, sepcelda+i);
	documento=strstr(documento, ">")+1;
	strncpy(procesado, documento, ((&(*strstr(documento, sepceldaf+ifi)))-(&(*(documento)))));
	procesado[((&(*strstr(documento, sepceldaf+ifi)))-(&(*(documento))))]='\0';
	documento+=(int)((&(*strstr(documento, sepceldaf+ifi)))-(&(*documento)));
	if(cols>0) {
	  sprintf(salida, "%s %04f;\n", salida, strtod(procesado, NULL));
	  cols=0;
	  documento+=(int)((&(*strstr(documento, seprow+iri)))-(&(*documento)));
	} else {
	  if(procesado && strlen(procesado)){
	    //printf("double %s=", procesado);
	    sprintf(salida, "%s\ndouble %s=", salida, procesado);
	    cols++;
	  }else {
	    documento+=(int)((&(*strstr(documento, sepceldaf+ifi)))-(&(*documento)));
	  }
	}
      }
      documento++;
      i2++;
    }
    i+=strlen(sepcelda+i)+1;
    iri+=strlen(seprow+i)+1;
    ifi+=strlen(sepceldaf+ifi)+1;
  }
  printf("----\n");
  ursok(salida, "127.0.0.1", strtol(argv[1], NULL, 10)+1);
  return  1;
}
